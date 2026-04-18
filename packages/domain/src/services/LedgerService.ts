import { PrismaClient } from '@primecare/database';
import { randomBytes, createHash } from 'crypto';

const prisma = new PrismaClient();

export class LedgerImbalanceError extends Error {
    constructor(message: string) {
        super(message);
        this.name = 'LedgerImbalanceError';
    }
}

export type JournalEntryInput = {
    accountId: string;
    debit?: number;
    credit?: number;
};

export type RecordTransactionInput = {
    tenantId: string;
    type: string;
    referenceId?: string;
    entries: JournalEntryInput[];
    description?: string;
    actorUserId?: string;
    ipAddress?: string;
};

export class LedgerService {
    /**
     * Generates a deterministic SHA-256 hash for the immutable ledger tracking
     */
    private static generateHash(data: string, prevHash: string | null): string {
        const hash = createHash('sha256');
        hash.update(data + (prevHash || ''));
        return hash.digest('hex');
    }

    /**
     * Enforces the Double-Entry Balance Rule (Debits == Credits).
     * If valid, commits the transaction and ledger to PostgreSQL atomically.
     */
    static async recordTransaction(input: RecordTransactionInput) {
        const startTime = Date.now();
        let totalDebit = 0;
        let totalCredit = 0;

        // Ensure all amounts are formatted correctly
        for (const entry of input.entries) {
            if (entry.debit) totalDebit += entry.debit;
            if (entry.credit) totalCredit += entry.credit;
        }

        // Must balance out
        if (Math.abs(totalDebit - totalCredit) > 0.001) {
            throw new LedgerImbalanceError(`Transaction is unbalanced. Debits: ${totalDebit}, Credits: ${totalCredit}`);
        }

        return prisma.$transaction(async (tx: any) => {
            // STEP 1: CONCURRENCY CONTROL (Row-Level Locking)
            // Sort account IDs to prevent deadlocks when multiple transactions hit the same accounts in different orders
            const uniqueAccountIds = [...new Set(input.entries.map(e => e.accountId))].sort();
            
            for (const accId of uniqueAccountIds) {
                // Lock the account row in the database
                await tx.$executeRaw`SELECT id FROM financial_accounts WHERE id = ${accId} FOR UPDATE`;
            }

            // Create root Financial Transaction
            const transaction = await tx.financialTransaction.create({
                data: {
                    tenantId: input.tenantId,
                    type: input.type,
                    referenceId: input.referenceId,
                    amount: totalDebit, 
                    status: 'posted',
                    metadata: {
                        actor: input.actorUserId,
                        ip: input.ipAddress,
                        concurrency: 'locked_v1'
                    }
                }
            });

            // Iterate over legs and build Journal Entries
            for (const entry of input.entries) {
                const account = await tx.chartOfAccount.findUnique({
                    where: { id: entry.accountId }
                });

                if (!account) {
                    throw new Error(`Invalid Account ID: ${entry.accountId}`);
                }

                let amountAdjustment = 0;
                if (['ASSET', 'EXPENSE'].includes(account.type)) {
                    amountAdjustment = (entry.debit || 0) - (entry.credit || 0);
                } else {
                    amountAdjustment = (entry.credit || 0) - (entry.debit || 0);
                }

                // Fetch last balance within the locked transaction
                const lastEntry = await tx.journalEntry.findFirst({
                    where: { accountId: entry.accountId },
                    orderBy: { createdAt: 'desc' }
                });

                const balanceBefore = lastEntry ? Number(lastEntry.balanceAfter) : 0;
                const balanceAfter = balanceBefore + amountAdjustment;

                await tx.journalEntry.create({
                    data: {
                        transactionId: transaction.id,
                        accountId: entry.accountId,
                        tenantId: input.tenantId,
                        debit: entry.debit || 0,
                        paidOutAmount: entry.credit || 0,
                        balanceBefore: balanceBefore,
                        balanceAfter: balanceAfter
                    }
                });
            }

            // Create Immutable Ledger Chain with Tail Lock
            // We use a raw lock on the last ledger entry for this tenant to prevent hash forks
            const tailLock = await tx.$queryRaw`
                SELECT id, checksum 
                FROM transaction_ledger 
                WHERE tenant_id = ${input.tenantId} 
                ORDER BY created_at DESC 
                LIMIT 1 
                FOR UPDATE
            `;

            const previousChecksum = tailLock?.[0]?.checksum || null;
            
            const rawData = JSON.stringify({
                txId: transaction.id,
                tenant: input.tenantId,
                amount: totalDebit,
                ts: new Date().toISOString()
            });

            const checksum = this.generateHash(rawData, previousChecksum);

            const record = await tx.transactionLedger.create({
                data: {
                    tenantId: input.tenantId,
                    transactionType: input.type,
                    referenceType: 'SYS', 
                    referenceId: transaction.id,
                    debitAccount: input.entries.find(e => e.debit)?.accountId || 'multi',
                    creditAccount: input.entries.find(e => e.credit)?.accountId || 'multi',
                    amount: totalDebit,
                    description: input.description || '',
                    actorUserId: input.actorUserId,
                    ipAddress: input.ipAddress,
                    checksum: checksum,
                    previousChecksum: previousChecksum,
                    status: 'sealed',
                    metadata: {
                        hashChain: 'sha256',
                        prevHash: previousChecksum
                    }
                }
            });

            // STEP 3: TELEMETRY (ExecutionGate Integration)
            const duration = Date.now() - startTime;
            await tx.implementationEvent.create({
                data: {
                    featureName: 'LedgerHardening',
                    version: '1.0.0',
                    status: 'OPTIMIZED',
                    payload: {
                        operation: 'recordTransaction',
                        durationMs: duration,
                        tenantId: input.tenantId,
                        actor: input.actorUserId,
                        concurrency: 'row_locking_v1'
                    }
                }
            });

            return {
                success: true,
                transactionId: transaction.id,
                ledgerEntryId: record.id,
                metrics: {
                    durationMs: duration
                }
            };
        }, { timeout: 15000 });
    }

    /**
     * Reverses a sealed transaction by building the matching inverse entries.
     */
    static async voidTransaction(transactionId: string, actorUserId?: string) {
        return prisma.$transaction(async (tx: any) => {
            const originalTx = await tx.financialTransaction.findUnique({
                where: { id: transactionId },
                include: { journalEntries: true }
            });

            if (!originalTx) throw new Error('Transaction not found');
            if (originalTx.status === 'voided') throw new Error('Transaction already voided');

            const reversalEntries: JournalEntryInput[] = originalTx.journalEntries.map((je: { accountId: string; paidOutAmount: any; debit: any; }) => ({
                accountId: je.accountId,
                debit: je.paidOutAmount ? Number(je.paidOutAmount) : 0, // Swap credits to debits
                credit: je.debit ? Number(je.debit) : 0 // Swap debits to credits
            }));

            // Mark origin voided
            await tx.financialTransaction.update({
                where: { id: transactionId },
                data: { status: 'voided' }
            });

            // Post Reversal
            const reversalTx = await this.recordTransaction({
                tenantId: originalTx.tenantId,
                type: 'REVERSAL',
                referenceId: originalTx.id,
                entries: reversalEntries,
                description: `Reversal of ${originalTx.id}`,
                actorUserId: actorUserId
            });

            // Mark ledger origin voided
            const originalLedger = await tx.transactionLedger.findFirst({
                where: { referenceId: originalTx.id }
            });

            if(originalLedger) {
                await tx.transactionLedger.update({
                    where: { id: originalLedger.id },
                    data: {
                        status: 'voided',
                        voidedByEntryId: reversalTx.record.id
                    }
                });
            }

            return reversalTx;
        });
    }

    /**
     * Reports calculated tax liabilities vs collected.
     */
    static async generateTaxFilingReport(tenantId: string, startDate?: Date, endDate?: Date) {
        // Find the Sales Tax Payable Account (2100)
        const taxAccount = await prisma.chartOfAccount.findFirst({
            where: { tenantId, code: '2100' }
        });

        if (!taxAccount) throw new Error('Tax account 2100 not mapped for tenant.');

        const accountId = taxAccount.id;

        const whereClause: any = { tenantId, accountId };
        if (startDate || endDate) {
            whereClause.createdAt = {};
            if (startDate) whereClause.createdAt.gte = startDate;
            if (endDate) whereClause.createdAt.lte = endDate;
        }

        const entries = await prisma.journalEntry.findMany({
            where: whereClause
        });

        let totalOutputTax = 0; // Credits (Amounts collected from customers)
        let totalInputTaxCredits = 0; // Debits (Amounts paid to vendors)

        for (const entry of entries) {
            totalOutputTax += Number(entry.paidOutAmount || 0); // Credit
            totalInputTaxCredits += Number(entry.debit || 0); // Debit
        }

        return {
            tenantId,
            taxAccountId: accountId,
            collectedOutputTax: totalOutputTax,
            inputTaxCredits: totalInputTaxCredits,
            netTaxRemittanceOwed: totalOutputTax - totalInputTaxCredits,
            period: {
                start: startDate || 'inception',
                end: endDate || new Date()
            }
        };
    }
}
