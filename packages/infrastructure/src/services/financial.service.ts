/**
 * Financial Service - Core Class (Skeleton)
 * Reporting methods extracted to financial-reporting.ts
 */
import { Decimal } from 'Decimal.js';
import type { PrismaClient } from '@primecare/database';
import { calculateBalance, getTradingAccount, getIncomeStatement, getBalanceSheet, generateDailySummary, generateTaxFilingReport } from './financial-reporting';

export class FinancialService {
    constructor(private prisma: PrismaClient) { }

    async initializeChartOfAccounts(tenantId: string) {
        const defaultAccounts = [
            { code: '1000', name: 'Cash', type: 'ASSET' },
            { code: '1100', name: 'Accounts Receivable', type: 'ASSET' },
            { code: '2000', name: 'Accounts Payable', type: 'LIABILITY' },
            { code: '2100', name: 'Sales Tax Payable (HST/GST)', type: 'LIABILITY' },
            { code: '3000', name: 'Owner Equity', type: 'EQUITY' },
            { code: '4000', name: 'Service Revenue', type: 'REVENUE' },
            { code: '5000', name: 'Caregiver Payroll (Direct)', type: 'EXPENSE' },
            { code: '5100', name: 'Admin Payroll (Indirect)', type: 'EXPENSE' },
            { code: '5200', name: 'Rent & Utilities', type: 'EXPENSE' },
            { code: '5300', name: 'Software & Technology', type: 'EXPENSE' },
        ];
        for (const account of defaultAccounts) {
            await this.prisma.chartOfAccount.upsert({ where: { tenantId_code: { tenantId, code: account.code } }, update: {}, create: { ...account, tenantId } });
        }
    }

    async recordTransaction(params: { tenantId: string; type: 'INVOICE' | 'PAYMENT' | 'PAYROLL' | 'EXPENSE'; referenceId: string; amount: number | Decimal; currency?: string; entries: { accountCode: string; debit?: number | Decimal; credit?: number | Decimal; }[]; }) {
        const { tenantId, type, referenceId, amount, currency = 'CAD', entries } = params;
        let totalDebit = new Decimal(0); let totalCredit = new Decimal(0);
        for (const entry of entries) { totalDebit = totalDebit.plus(new Decimal(entry.debit || 0)); totalCredit = totalCredit.plus(new Decimal(entry.credit || 0)); }
        if (!totalDebit.equals(totalCredit)) throw new Error(`Unbalanced Transaction: Debits (${totalDebit}) do not equal Credits (${totalCredit})`);
        return await (this.prisma as any).$transaction(async (tx: any) => {
            const transaction = await tx.financialTransaction.create({ data: { tenantId, type, referenceId, amount: new Decimal(amount), currency, status: 'posted' } });
            for (const entry of entries) {
                const account = await tx.chartOfAccount.findUnique({ where: { tenantId_code: { tenantId, code: entry.accountCode } }, include: { journalEntries: true } });
                if (!account) throw new Error(`Account code ${entry.accountCode} not found for tenant ${tenantId}`);
                const balanceBefore = calculateBalance(account.journalEntries, account.type);
                const debit = new Decimal(entry.debit || 0); const credit = new Decimal(entry.credit || 0);
                let balanceAfter = new Decimal(balanceBefore);
                if (['ASSET', 'EXPENSE'].includes(account.type)) { balanceAfter = balanceAfter.plus(debit).minus(credit); } else { balanceAfter = balanceAfter.plus(credit).minus(debit); }
                await tx.journalEntry.create({ data: { tenantId, transactionId: transaction.id, accountId: account.id, debit, paidOutAmount: credit, currency, balanceBefore, balanceAfter } });
            }
            return transaction;
        });
    }

    async recordInvoice(tenantId: string, invoiceId: string, subtotal: number | Decimal, taxAmount: number | Decimal) {
        const total = new Decimal(subtotal).plus(new Decimal(taxAmount));
        const entries: any[] = [{ accountCode: '1100', debit: total }, { accountCode: '4000', credit: subtotal }];
        if (new Decimal(taxAmount).gt(0)) entries.push({ accountCode: '2100', credit: taxAmount });
        return await this.recordTransaction({ tenantId, type: 'INVOICE', referenceId: invoiceId, amount: total, entries });
    }

    async recordPayment(tenantId: string, paymentId: string, amount: number | Decimal, invoiceId: string) {
        const tx = await this.recordTransaction({ tenantId, type: 'PAYMENT', referenceId: paymentId, amount, entries: [{ accountCode: '1000', debit: amount }, { accountCode: '1100', credit: amount }] });
        await this.prisma.financialReconciliation.create({ data: { tenantId, transactionId: tx.id, status: 'matched', matchedAt: new Date() } });
        return tx;
    }

    async recordPayroll(tenantId: string, payoutId: string, amount: number | Decimal) {
        return await this.recordTransaction({ tenantId, type: 'PAYROLL', referenceId: payoutId, amount, entries: [{ accountCode: '5000', debit: amount }, { accountCode: '1000', credit: amount }] });
    }

    async matchInvoiceWithPayment(tenantId: string, invoiceTxId: string, paymentTxId: string) {
        return await (this.prisma as any).$transaction(async (tx: any) => {
            await tx.financialReconciliation.create({ data: { tenantId, transactionId: invoiceTxId, status: 'matched', matchedAt: new Date() } });
            await tx.financialTransaction.update({ where: { id: invoiceTxId }, data: { status: 'matched' } });
            await tx.financialTransaction.update({ where: { id: paymentTxId }, data: { status: 'matched' } });
            return { success: true };
        });
    }

    async importBankFeed(tenantId: string, transactions: Record<string, any>[]) {
        for (const bt of transactions) { await this.prisma.bankTransaction.create({ data: { tenantId, bankDate: new Date(bt.date), description: bt.description, amount: new Decimal(bt.amount), externalRef: bt.ref, status: 'unreconciled' } }); }
        return await this.autoMatchBankFeed(tenantId);
    }

    async autoMatchBankFeed(tenantId: string) {
        const unreconciledBank = await this.prisma.bankTransaction.findMany({ where: { tenantId, status: 'unreconciled' } });
        let matchedCount = 0;
        for (const bt of unreconciledBank) {
            const threeDaysMs = 3 * 24 * 60 * 60 * 1000;
            const match = await this.prisma.financialTransaction.findFirst({ where: { tenantId, amount: { gte: new Decimal(bt.amount).minus(0.01), lte: new Decimal(bt.amount).plus(0.01) }, createdAt: { gte: new Date(bt.bankDate.getTime() - threeDaysMs), lte: new Date(bt.bankDate.getTime() + threeDaysMs) }, status: 'posted' } });
            if (match) {
                await (this.prisma as any).$transaction([
                    this.prisma.financialReconciliation.create({ data: { tenantId, transactionId: match.id, bankTransactionId: bt.id, status: 'reconciled', matchedAt: new Date() } }),
                    this.prisma.financialTransaction.update({ where: { id: match.id }, data: { status: 'reconciled' } }),
                    this.prisma.bankTransaction.update({ where: { id: bt.id }, data: { status: 'reconciled' } })
                ]);
                matchedCount++;
            }
        }
        return matchedCount;
    }

    async getAccountBalances(tenantId: string) {
        const accounts = await (this.prisma as any).chartOfAccount.findMany({ where: { tenantId }, include: { journalEntries: true } });
        return accounts.map((acc: any) => ({ id: acc.id, code: acc.code, name: acc.name, type: acc.type, balance: calculateBalance(acc.journalEntries, acc.type).toNumber() }));
    }

    async getAccountBalanceAtDate(tenantId: string, accountCode: string, date: Date) {
        const account = await (this.prisma as any).chartOfAccount.findUnique({ where: { tenantId_code: { tenantId, code: accountCode } }, include: { journalEntries: { where: { createdAt: { lt: date } } } } });
        if (!account) return 0;
        return calculateBalance(account.journalEntries, account.type).toNumber();
    }

    async getTradingAccount(tenantId: string, startDate: Date, endDate: Date) { return getTradingAccount(this.prisma, tenantId, startDate, endDate); }
    async getIncomeStatement(tenantId: string, startDate: Date, endDate: Date) { return getIncomeStatement(this.prisma, tenantId, startDate, endDate); }
    async getBalanceSheet(tenantId: string, date: Date = new Date()) { return getBalanceSheet(this.prisma, tenantId, date); }
    async generateDailySummary(tenantId: string, date: Date = new Date()) { return generateDailySummary(this.prisma, tenantId, date); }
    async generateTaxFilingReport(tenantId: string, startDate: Date, endDate: Date) { return generateTaxFilingReport(this.prisma, tenantId, startDate, endDate); }

    async recordTaxRemittance(tenantId: string, amount: number | Decimal, reference: string) {
        return await this.recordTransaction({ tenantId, type: 'EXPENSE', referenceId: reference, amount, entries: [{ accountCode: '2100', debit: amount }, { accountCode: '1000', credit: amount }] });
    }
}
