import { PrismaClient } from '@primecare/database';
import { randomBytes, createHash } from 'node:crypto';
import { CurrencyService } from './CurrencyService';
import { TaxService } from './TaxService';
import { Prisma } from '@primecare/database';
import { Result } from '../utils/Result';
import { AuditService } from './AuditService';

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
    currency?: string;
    exchangeRate?: number; // Manual override
    region?: string; // For tax localization
    taxIncluded?: boolean; // Whether the amounts already include tax
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
    static async recordTransaction(prisma: any, input: RecordTransactionInput): Promise<Result<any>> {
        return Result.guard(async () => {
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

            // STEP 0: CURRENCY NORMALIZATION
            const conversionResult = await CurrencyService.convertToBase(
                prisma,
                totalDebit,
                input.currency || 'CAD',
                input.tenantId
            );
            const conversion = conversionResult.data;

            const exchangeRate = input.exchangeRate || conversion.rate;
            const baseAmount = new Prisma.Decimal(totalDebit).mul(exchangeRate);

            // STEP 0.1: TAX LOCALIZATION
            let taxLeg = null;
            if (input.region) {
                const taxDetailsResult = await TaxService.calculateTax(totalDebit, input.region, input.taxIncluded);
                const taxDetails = taxDetailsResult.data;
                if (taxDetails.taxAmount.gt(0)) {
                    taxLeg = {
                        accountId: 'tax-payable-2100',
                        amount: taxDetails.taxAmount,
                        description: `Automated Tax: ${taxDetails.description} (${(taxDetails.rate * 100).toFixed(1)}%)`
                    };
                }
            }


            return prisma.$transaction(async (tx: any) => {
                // STEP 1: CONCURRENCY CONTROL (Row-Level Locking)
                const uniqueAccountIds = [...new Set(input.entries.map(e => e.accountId))].sort();
                
                for (const accId of uniqueAccountIds) {
                    await tx.$executeRaw`SELECT id FROM financial_accounts WHERE id = ${accId} FOR UPDATE`;
                }

                // Create root Financial Transaction
                const transaction = await tx.financialTransaction.create({
                    data: {
                        tenantId: input.tenantId,
                        type: input.type,
                        referenceId: input.referenceId,
                        amount: totalDebit,
                        currency: input.currency || 'CAD',
                        exchangeRate: exchangeRate,
                        baseAmount: baseAmount,
                        status: 'posted',
                        metadata: {
                            actor: input.actorUserId,
                            ip: input.ipAddress,
                            baseCurrency: conversion.baseCurrency,
                            concurrency: 'locked_v1',
                            tax: taxLeg ? {
                                amount: taxLeg.amount,
                                description: taxLeg.description,
                                region: input.region
                            } : null
                        }
                    }
                });

                // Record Audit Log for Transaction Creation
                await AuditService.recordLog(tx, {
                    tenantId: input.tenantId,
                    actorUserId: input.actorUserId,
                    action: 'CREATE_FINANCIAL_TRANSACTION',
                    resourceType: 'FINANCIAL_TRANSACTION',
                    resourceId: transaction.id,
                    metadata: {
                        type: input.type,
                        amount: totalDebit,
                        currency: input.currency || 'CAD',
                        referenceId: input.referenceId
                    }
                });

                // STEP 2: ACCOUNT RESOLUTION & TAX ADJUSTMENT
                const taxAccount = await tx.chartOfAccount.findFirst({
                    where: { tenantId: input.tenantId, code: '2100' }
                });

                for (const entry of input.entries) {
                    const account = await tx.chartOfAccount.findUnique({
                        where: {
                            tenantId_code: {
                                tenantId: input.tenantId,
                                code: entry.accountId || ''
                            }
                        }
                    });

                    if (!account) {
                        throw new Error(`Invalid Account Code: ${entry.accountId}`);
                    }

                    let amountAdjustment = 0;
                    let entryDebit = entry.debit || 0;
                    let entryCredit = entry.credit || 0;

                    if (account.type === 'REVENUE' && taxLeg && input.taxIncluded) {
                        const taxResult = await TaxService.calculateTax(entryDebit || entryCredit, input.region!, true);
                        const basePortion = taxResult.data.baseAmount.toNumber();
                        if (entryDebit > 0) entryDebit = basePortion;
                        if (entryCredit > 0) entryCredit = basePortion;
                    }

                    if (['ASSET', 'EXPENSE'].includes(account.type)) {
                        amountAdjustment = entryDebit - entryCredit;
                    } else {
                        amountAdjustment = entryCredit - entryDebit;
                    }

                    const lastEntry = await tx.journalEntry.findFirst({
                        where: { accountId: account.id },
                        orderBy: { createdAt: 'desc' }
                    });

                    const balanceBefore = lastEntry ? Number(lastEntry.balanceAfter) : 0;
                    const balanceAfter = balanceBefore + amountAdjustment;

                    await tx.journalEntry.create({
                        data: {
                            transactionId: transaction.id,
                            accountId: account.id,
                            tenantId: input.tenantId,
                            debit: entryDebit,
                            paidOutAmount: entryCredit,
                            currency: input.currency || 'CAD',
                            exchangeRate: exchangeRate,
                            baseAmount: new Prisma.Decimal(entryDebit + entryCredit).mul(exchangeRate),
                            balanceBefore: balanceBefore,
                            balanceAfter: balanceAfter
                        }
                    });
                }

                // ADD TAX LEG IF IDENTIFIED
                if (taxLeg && taxAccount) {
                    const lastTaxEntry = await tx.journalEntry.findFirst({
                        where: { accountId: taxAccount.id },
                        orderBy: { createdAt: 'desc' }
                    });
                    const taxBalanceBefore = lastTaxEntry ? Number(lastTaxEntry.balanceAfter) : 0;
                    const taxAmount = taxLeg.amount.toNumber();

                    await tx.journalEntry.create({
                        data: {
                            transactionId: transaction.id,
                            accountId: taxAccount.id,
                            tenantId: input.tenantId,
                            debit: 0,
                            paidOutAmount: taxAmount,
                            currency: input.currency || 'CAD',
                            exchangeRate: exchangeRate,
                            baseAmount: taxLeg.amount.mul(exchangeRate),
                            balanceBefore: taxBalanceBefore,
                            balanceAfter: taxBalanceBefore + taxAmount
                        }
                    });
                }

                // Create Immutable Ledger Chain with Tail Lock
                const tailLock: any = await tx.$queryRaw`
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

                const checksum = LedgerService.generateHash(rawData, previousChecksum);

                const record = await tx.transactionLedger.create({
                    data: {
                        tenantId: input.tenantId,
                        transactionType: input.type,
                        referenceType: 'SYS', 
                        referenceId: transaction.id,
                        debitAccount: input.entries.find(e => e.debit)?.accountId || 'multi',
                        creditAccount: input.entries.find(e => e.credit)?.accountId || 'multi',
                        amount: totalDebit,
                        currency: input.currency || 'CAD',
                        exchangeRate: exchangeRate,
                        baseAmount: baseAmount,
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

                const duration = Date.now() - startTime;
                return {
                    success: true,
                    transactionId: transaction.id,
                    ledgerEntryId: record.id,
                    metrics: { durationMs: duration }
                };
            }, { timeout: 15000 });
        });
    }

    /**
     * Reverses a sealed transaction by building the matching inverse entries.
     */
    static async voidTransaction(prisma: any, transactionId: string, tenantId: string, actorUserId?: string): Promise<Result<any>> {
        return Result.guard(async () => {
            return prisma.$transaction(async (tx: any) => {
                const originalTx = await tx.financialTransaction.findUnique({
                    where: { id: transactionId, tenantId },
                    include: {
                        journalEntries: {
                            include: { account: true }
                        }
                    }
                });

                if (!originalTx) throw new Error('Transaction not found');
                if (originalTx.status === 'voided') throw new Error('Transaction already voided');

                const reversalEntries: any[] = originalTx.journalEntries.map((je: any) => ({
                    accountCode: je.account.code,
                    accountId: je.accountId,
                    debit: je.paidOutAmount ? Number(je.paidOutAmount) : 0, 
                    credit: je.debit ? Number(je.debit) : 0 
                }));

                // Mark origin voided
                await tx.financialTransaction.update({
                    where: { id: transactionId },
                    data: { status: 'voided' }
                });

                // Post Reversal
                const reversalResult = await LedgerService.recordTransaction(tx, {
                    tenantId: originalTx.tenantId,
                    type: 'REVERSAL',
                    referenceId: originalTx.id,
                    entries: reversalEntries,
                    description: `Reversal of ${originalTx.id}`,
                    actorUserId: actorUserId,
                    currency: originalTx.currency,
                    exchangeRate: Number(originalTx.exchangeRate)
                });

                if (reversalResult.isFailure) throw new Error(reversalResult.error);

                const reversalData = reversalResult.data;

                // Mark ledger origin voided
                const originalLedger = await tx.transactionLedger.findFirst({
                    where: { referenceId: originalTx.id }
                });

                if (originalLedger) {
                    await tx.transactionLedger.update({
                        where: { id: originalLedger.id },
                        data: {
                            status: 'voided',
                            voidedByEntryId: reversalData.ledgerEntryId
                        }
                    });
                }

                // Record Audit Log for Void Action
                await AuditService.recordLog(tx, {
                    tenantId: originalTx.tenantId,
                    actorUserId: actorUserId,
                    action: 'VOID_FINANCIAL_TRANSACTION',
                    resourceType: 'FINANCIAL_TRANSACTION',
                    resourceId: transactionId,
                    metadata: {
                        reversalTxId: reversalData.transactionId,
                        reason: 'User Requested Void'
                    }
                });

                return reversalData;
            }, { timeout: 15000 });
        });
    }

    /**
     * Reports calculated tax liabilities vs collected.
     */
    static async generateTaxFilingReport(prisma: any, tenantId: string, startDate?: Date, endDate?: Date): Promise<Result<any>> {
        return Result.guard(async () => {
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
                collectedOutputTax: totalOutputTax, // Total credits to 2100
                inputTaxCredits: totalInputTaxCredits, // Total debits to 2100
                netTaxRemittanceOwed: totalOutputTax - totalInputTaxCredits,
                currency: taxAccount.currency,
                period: {
                    start: startDate || 'inception',
                    end: endDate || new Date()
                },
                status: totalOutputTax - totalInputTaxCredits > 0 ? 'PAYABLE' : 'CREDIT_REFUND'
            };
        });
    }
}
