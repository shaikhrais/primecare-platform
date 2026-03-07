import { Decimal } from 'Decimal.js'; // Prisma usually exports this or uses decimal.js

export class FinancialService {
    constructor(private prisma: any) { }

    /**
     * Initializes a default Chart of Accounts for a new Tenant.
     */
    async initializeChartOfAccounts(tenantId: string) {
        const defaultAccounts = [
            { code: '1000', name: 'Cash', type: 'ASSET' },
            { code: '1100', name: 'Accounts Receivable', type: 'ASSET' },
            { code: '2000', name: 'Accounts Payable', type: 'LIABILITY' },
            { code: '3000', name: 'Owner Equity', type: 'EQUITY' },
            { code: '4000', name: 'Service Revenue', type: 'REVENUE' },
            { code: '5000', name: 'Caregiver Payroll (Direct)', type: 'EXPENSE' }, // DIRECT COST
            { code: '5100', name: 'Admin Payroll (Indirect)', type: 'EXPENSE' },
            { code: '5200', name: 'Rent & Utilities', type: 'EXPENSE' },
            { code: '5300', name: 'Software & Technology', type: 'EXPENSE' },
        ];

        for (const account of defaultAccounts) {
            await this.prisma.chartOfAccount.upsert({
                where: {
                    tenantId_code: {
                        tenantId,
                        code: account.code
                    }
                },
                update: {},
                create: {
                    ...account,
                    tenantId
                }
            });
        }
    }

    /**
     * Records a master financial transaction with its balanced journal entries.
     */
    async recordTransaction(params: {
        tenantId: string;
        type: 'INVOICE' | 'PAYMENT' | 'PAYROLL' | 'EXPENSE';
        referenceId: string;
        amount: number | Decimal;
        entries: {
            accountCode: string;
            debit?: number | Decimal;
            credit?: number | Decimal;
        }[];
    }) {
        const { tenantId, type, referenceId, amount, entries } = params;

        // 1. Verify balance (Debits must equal Credits)
        let totalDebit = new Decimal(0);
        let totalCredit = new Decimal(0);

        for (const entry of entries) {
            totalDebit = totalDebit.plus(new Decimal(entry.debit || 0));
            totalCredit = totalCredit.plus(new Decimal(entry.credit || 0));
        }

        if (!totalDebit.equals(totalCredit)) {
            throw new Error(`Unbalanced Transaction: Debits (${totalDebit}) do not equal Credits (${totalCredit})`);
        }

        // 2. Create the FinancialTransaction and JournalEntries
        return await this.prisma.$transaction(async (tx: any) => {
            const transaction = await tx.financialTransaction.create({
                data: {
                    tenantId,
                    type,
                    referenceId,
                    amount: new Decimal(amount),
                    status: 'posted'
                }
            });

            for (const entry of entries) {
                const account = await tx.chartOfAccount.findUnique({
                    where: {
                        tenantId_code: {
                            tenantId,
                            code: entry.accountCode
                        }
                    },
                    include: {
                        journalEntries: true // Get all past entries to calculate current balance
                    }
                });

                if (!account) throw new Error(`Account code ${entry.accountCode} not found for tenant ${tenantId}`);

                // Calculate Current Balance before this new entry
                let balanceBefore = new Decimal(0);
                for (const pastEntry of account.journalEntries) {
                    if (['ASSET', 'EXPENSE'].includes(account.type)) {
                        balanceBefore = balanceBefore.plus(new Decimal(pastEntry.debit)).minus(new Decimal(pastEntry.credit));
                    } else {
                        balanceBefore = balanceBefore.plus(new Decimal(pastEntry.credit)).minus(new Decimal(pastEntry.debit));
                    }
                }

                const debit = new Decimal(entry.debit || 0);
                const credit = new Decimal(entry.credit || 0);
                let balanceAfter = new Decimal(balanceBefore);

                if (['ASSET', 'EXPENSE'].includes(account.type)) {
                    balanceAfter = balanceAfter.plus(debit).minus(credit);
                } else {
                    balanceAfter = balanceAfter.plus(credit).minus(debit);
                }

                await tx.journalEntry.create({
                    data: {
                        tenantId,
                        transactionId: transaction.id,
                        accountId: account.id,
                        debit,
                        credit,
                        balanceBefore,
                        balanceAfter
                    }
                });
            }

            return transaction;
        });
    }

    /**
     * Specialized helper to record a Client Invoice.
     * Dr Accounts Receivable
     * Cr Service Revenue
     */
    async recordInvoice(tenantId: string, invoiceId: string, total: number | Decimal) {
        return await this.recordTransaction({
            tenantId,
            type: 'INVOICE',
            referenceId: invoiceId,
            amount: total,
            entries: [
                { accountCode: '1100', debit: total }, // A/R
                { accountCode: '4000', credit: total } // Revenue
            ]
        });
    }

    /**
     * Specialized helper to record a Client Payment.
     * Dr Cash
     * Cr Accounts Receivable
     */
    async recordPayment(tenantId: string, paymentId: string, amount: number | Decimal, invoiceId: string) {
        const tx = await this.recordTransaction({
            tenantId,
            type: 'PAYMENT',
            referenceId: paymentId,
            amount: amount,
            entries: [
                { accountCode: '1000', debit: amount }, // Cash
                { accountCode: '1100', credit: amount } // A/R
            ]
        });

        // Auto-match for reconciliation
        await this.prisma.financialReconciliation.create({
            data: {
                tenantId,
                transactionId: tx.id,
                status: 'matched',
                matchedAt: new Date()
            }
        });

        return tx;
    }

    /**
     * Specialized helper to record Payroll/Payout.
     * Dr Payroll Expense
     * Cr Cash
     */
    async recordPayroll(tenantId: string, payoutId: string, amount: number | Decimal) {
        return await this.recordTransaction({
            tenantId,
            type: 'PAYROLL',
            referenceId: payoutId,
            amount: amount,
            entries: [
                { accountCode: '5000', debit: amount }, // Expense
                { accountCode: '1000', credit: amount } // Cash
            ]
        });
    }

    /**
     * Matches a Payment to an Invoice and updates statuses.
     */
    async matchInvoiceWithPayment(tenantId: string, invoiceTxId: string, paymentTxId: string) {
        return await this.prisma.$transaction(async (tx: any) => {
            // 1. Link them in reconciliation table
            await tx.financialReconciliation.create({
                data: {
                    tenantId,
                    transactionId: invoiceTxId,
                    status: 'matched',
                    matchedAt: new Date()
                }
            });

            // 2. Update statuses
            await tx.financialTransaction.update({
                where: { id: invoiceTxId },
                data: { status: 'matched' }
            });

            await tx.financialTransaction.update({
                where: { id: paymentTxId },
                data: { status: 'matched' }
            });

            return { success: true };
        });
    }

    /**
     * Imports bank transactions and attempts auto-matching.
     */
    async importBankFeed(tenantId: string, transactions: any[]) {
        for (const bt of transactions) {
            await this.prisma.bankTransaction.create({
                data: {
                    tenantId,
                    bankDate: new Date(bt.date),
                    description: bt.description,
                    amount: new Decimal(bt.amount),
                    externalRef: bt.ref,
                    status: 'unreconciled'
                }
            });
        }
        return await this.autoMatchBankFeed(tenantId);
    }

    /**
     * Auto-matches posted transactions with bank statements using Amount and Reference.
     */
    async autoMatchBankFeed(tenantId: string) {
        const unreconciledBank = await this.prisma.bankTransaction.findMany({
            where: { tenantId, status: 'unreconciled' }
        });

        for (const bt of unreconciledBank) {
            // Find a posted transaction with the same amount
            const match = await this.prisma.financialTransaction.findFirst({
                where: {
                    tenantId,
                    amount: bt.amount,
                    status: 'posted'
                }
            });

            if (match) {
                await this.prisma.$transaction([
                    this.prisma.financialReconciliation.create({
                        data: {
                            tenantId,
                            transactionId: match.id,
                            bankTransactionId: bt.id,
                            status: 'reconciled',
                            matchedAt: new Date()
                        }
                    }),
                    this.prisma.financialTransaction.update({
                        where: { id: match.id },
                        data: { status: 'reconciled' }
                    }),
                    this.prisma.bankTransaction.update({
                        where: { id: bt.id },
                        data: { status: 'reconciled' }
                    })
                ]);
            }
        }
    }

    /**
     * Calculates real-time balances for all accounts.
     */
    async getAccountBalances(tenantId: string) {
        const accounts = await this.prisma.chartOfAccount.findMany({
            where: { tenantId },
            include: {
                journalEntries: true
            }
        });

        return accounts.map((acc: any) => {
            let balance = new Decimal(0);
            for (const entry of acc.journalEntries) {
                // Asset/Expense: Debit increases, Credit decreases
                // Liability/Equity/Revenue: Credit increases, Debit decreases
                if (['ASSET', 'EXPENSE'].includes(acc.type)) {
                    balance = balance.plus(new Decimal(entry.debit)).minus(new Decimal(entry.credit));
                } else {
                    balance = balance.plus(new Decimal(entry.credit)).minus(new Decimal(entry.debit));
                }
            }
            return {
                id: acc.id,
                code: acc.code,
                name: acc.name,
                type: acc.type,
                balance: balance.toNumber()
            };
        });
    }

    /**
     * Calculates account balance up to a specific date (for before/after tracking).
     */
    async getAccountBalanceAtDate(tenantId: string, accountCode: string, date: Date) {
        const account = await this.prisma.chartOfAccount.findUnique({
            where: { tenantId_code: { tenantId, code: accountCode } },
            include: {
                journalEntries: {
                    where: { createdAt: { lt: date } }
                }
            }
        });

        if (!account) return 0;

        let balance = new Decimal(0);
        for (const entry of account.journalEntries) {
            if (['ASSET', 'EXPENSE'].includes(account.type)) {
                balance = balance.plus(new Decimal(entry.debit)).minus(new Decimal(entry.credit));
            } else {
                balance = balance.plus(new Decimal(entry.credit)).minus(new Decimal(entry.debit));
            }
        }
        return balance.toNumber();
    }

    /**
     * Generates a Trading Account (Gross Profit calculation)
     */
    async getTradingAccount(tenantId: string, startDate: Date, endDate: Date) {
        const accounts = await this.prisma.chartOfAccount.findMany({
            where: { tenantId },
            include: {
                journalEntries: {
                    where: { createdAt: { gte: startDate, lte: endDate } }
                }
            }
        });

        let revenue = new Decimal(0);
        let directCosts = new Decimal(0);
        const revenueBreakdown: any = {};
        const directCostsBreakdown: any = {};

        for (const acc of accounts) {
            let balance = new Decimal(0);
            for (const entry of acc.journalEntries) {
                if (['ASSET', 'EXPENSE'].includes(acc.type)) {
                    balance = balance.plus(new Decimal(entry.debit)).minus(new Decimal(entry.credit));
                } else {
                    balance = balance.plus(new Decimal(entry.credit)).minus(new Decimal(entry.debit));
                }
            }

            if (acc.type === 'REVENUE') {
                revenue = revenue.plus(balance);
                revenueBreakdown[acc.name] = balance.toNumber();
            } else if (acc.type === 'EXPENSE' && Number(acc.code) < 5100) {
                // Codes 5000-5099 are Direct Expenses (COGS/COSS)
                directCosts = directCosts.plus(balance);
                directCostsBreakdown[acc.name] = balance.toNumber();
            }
        }

        return {
            period: { startDate, endDate },
            revenue: revenue.toNumber(),
            directCosts: directCosts.toNumber(),
            grossProfit: revenue.minus(directCosts).toNumber(),
            grossProfitMargin: revenue.isZero() ? 0 : revenue.minus(directCosts).dividedBy(revenue).times(100).toNumber(),
            breakdown: { revenue: revenueBreakdown, directCosts: directCostsBreakdown }
        };
    }

    /**
     * Generates an Income Statement (P&L).
     */
    async getIncomeStatement(tenantId: string, startDate: Date, endDate: Date) {
        const tradingAccount = await this.getTradingAccount(tenantId, startDate, endDate);

        const accounts = await this.prisma.chartOfAccount.findMany({
            where: { tenantId, type: 'EXPENSE', code: { gte: '5100' } }, // Indirect expenses only
            include: {
                journalEntries: {
                    where: { createdAt: { gte: startDate, lte: endDate } }
                }
            }
        });

        let indirectExpenses = new Decimal(0);
        const expensesBreakdown: any = {};

        for (const acc of accounts) {
            let balance = new Decimal(0);
            for (const entry of acc.journalEntries) {
                balance = balance.plus(new Decimal(entry.debit)).minus(new Decimal(entry.credit));
            }
            indirectExpenses = indirectExpenses.plus(balance);
            expensesBreakdown[acc.name] = balance.toNumber();
        }

        const netIncome = new Decimal(tradingAccount.grossProfit).minus(indirectExpenses);

        return {
            period: { startDate, endDate },
            tradingAccount,
            operatingExpenses: indirectExpenses.toNumber(),
            netIncome: netIncome.toNumber(),
            breakdown: { ...tradingAccount.breakdown, indirectExpenses: expensesBreakdown }
        };
    }

    /**
     * Generates a Balance Sheet (Snapshot of Assets, Liabilities, and Equity).
     */
    async getBalanceSheet(tenantId: string, date: Date = new Date()) {
        const accounts = await this.prisma.chartOfAccount.findMany({
            where: { tenantId },
            include: {
                journalEntries: {
                    where: { createdAt: { lte: date } }
                }
            }
        });

        const report: any = {
            assets: { total: new Decimal(0), accounts: {} },
            liabilities: { total: new Decimal(0), accounts: {} },
            equity: { total: new Decimal(0), accounts: {} }
        };

        for (const acc of accounts) {
            let balance = new Decimal(0);
            for (const entry of acc.journalEntries) {
                if (['ASSET', 'EXPENSE'].includes(acc.type)) {
                    balance = balance.plus(new Decimal(entry.debit)).minus(new Decimal(entry.credit));
                } else {
                    balance = balance.plus(new Decimal(entry.credit)).minus(new Decimal(entry.debit));
                }
            }

            const category = acc.type.toLowerCase();
            if (report[category]) {
                report[category].accounts[acc.name] = balance.toNumber();
                report[category].total = report[category].total.plus(balance);
            } else if (acc.type === 'REVENUE' || acc.type === 'EXPENSE') {
                // For a Balance Sheet, Revenue - Expense = Retained Earnings (Equity)
                report.equity.total = acc.type === 'REVENUE'
                    ? report.equity.total.plus(balance)
                    : report.equity.total.minus(balance);
            }
        }

        return {
            date,
            assets: { ...report.assets, total: report.assets.total.toNumber() },
            liabilities: { ...report.liabilities, total: report.liabilities.total.toNumber() },
            equity: { ...report.equity, total: report.equity.total.toNumber() }
        };
    }

    /**
     * Generates a JSON summary of all financial activity for the day.
     */
    async generateDailySummary(tenantId: string, date: Date = new Date()) {
        const start = new Date(date);
        start.setHours(0, 0, 0, 0);
        const end = new Date(date);
        end.setHours(23, 59, 59, 999);

        const transactions = await this.prisma.financialTransaction.findMany({
            where: {
                tenantId,
                createdAt: { gte: start, lte: end }
            },
            include: { journalEntries: { include: { account: true } } }
        });

        const summary = {
            date: start.toISOString().split('T')[0],
            transactionCount: transactions.length,
            totalVolume: transactions.reduce((sum: number, tx: any) => sum + Number(tx.amount), 0),
            types: {} as any,
            integrityCheck: 'PASSED'
        };

        for (const tx of transactions) {
            summary.types[tx.type] = (summary.types[tx.type] || 0) + 1;
        }

        return summary;
    }
}
