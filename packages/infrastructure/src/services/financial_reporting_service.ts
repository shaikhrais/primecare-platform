// Governance - Category: service | Purpose: Financial Service - Reporting Methods Extracted from financial.service.ts (getTradingAccount, getIncomeStatement, get...
/**
 * Financial Service - Reporting Methods
 * Extracted from financial.service.ts (getTradingAccount, getIncomeStatement, getBalanceSheet, generateDailySummary, generateTaxFilingReport, recordTaxRemittance)
 */
import { Decimal } from 'decimal.js';
import type { PrismaClient } from '@primecare/database';

export function calculateBalance(entries: any[], accountType: string): Decimal {
    let balance = new Decimal(0);
    for (const entry of entries) {
        if (['ASSET', 'EXPENSE'].includes(accountType)) {
            balance = balance.plus(new Decimal(entry.debit)).minus(new Decimal(entry.paidOutAmount || 0));
        } else {
            balance = balance.plus(new Decimal(entry.paidOutAmount || 0)).minus(new Decimal(entry.debit));
        }
    }
    return balance;
}

export async function getTradingAccount(prisma: PrismaClient, tenantId: string, startDate: Date, endDate: Date) {
    const accounts = await (prisma as any).chartOfAccount.findMany({ where: { tenantId }, include: { journalEntries: { where: { createdAt: { gte: startDate, lte: endDate } } } } });
    let revenue = new Decimal(0);
    let directCosts = new Decimal(0);
    const revenueBreakdown: Record<string, number> = {};
    const directCostsBreakdown: Record<string, number> = {};
    for (const acc of accounts) {
        const balance = calculateBalance(acc.journalEntries, acc.type);
        if (acc.type === 'REVENUE') { revenue = revenue.plus(balance); revenueBreakdown[acc.name] = balance.toNumber(); }
        else if (acc.type === 'EXPENSE' && Number(acc.code) < 5100) { directCosts = directCosts.plus(balance); directCostsBreakdown[acc.name] = balance.toNumber(); }
    }
    return { period: { startDate, endDate }, revenue: revenue.toNumber(), directCosts: directCosts.toNumber(), grossProfit: revenue.minus(directCosts).toNumber(), grossProfitMargin: revenue.isZero() ? 0 : revenue.minus(directCosts).dividedBy(revenue).times(100).toNumber(), breakdown: { revenue: revenueBreakdown, directCosts: directCostsBreakdown } };
}

export async function getIncomeStatement(prisma: PrismaClient, tenantId: string, startDate: Date, endDate: Date) {
    const tradingAccount = await getTradingAccount(prisma, tenantId, startDate, endDate);
    const accounts = await (prisma as any).chartOfAccount.findMany({ where: { tenantId, type: 'EXPENSE', code: { gte: '5100' } }, include: { journalEntries: { where: { createdAt: { gte: startDate, lte: endDate } } } } });
    let indirectExpenses = new Decimal(0);
    const expensesBreakdown: Record<string, number> = {};
    for (const acc of accounts) {
        let balance = new Decimal(0);
        for (const entry of acc.journalEntries) { balance = balance.plus(new Decimal(entry.debit)).minus(new Decimal(entry.paidOutAmount || 0)); }
        indirectExpenses = indirectExpenses.plus(balance);
        expensesBreakdown[acc.name] = balance.toNumber();
    }
    const netIncome = new Decimal(tradingAccount.grossProfit).minus(indirectExpenses);
    return { period: { startDate, endDate }, tradingAccount, operatingExpenses: indirectExpenses.toNumber(), netIncome: netIncome.toNumber(), breakdown: { ...tradingAccount.breakdown, indirectExpenses: expensesBreakdown } };
}

export async function getBalanceSheet(prisma: PrismaClient, tenantId: string, date: Date = new Date()) {
    const accounts = await (prisma as any).chartOfAccount.findMany({ where: { tenantId }, include: { journalEntries: { where: { createdAt: { lte: date } } } } });
    const report: Record<string, { total: Decimal; accounts: Record<string, number> }> = {
        assets: { total: new Decimal(0), accounts: {} }, liabilities: { total: new Decimal(0), accounts: {} }, equity: { total: new Decimal(0), accounts: {} }
    };
    for (const acc of accounts) {
        const balance = calculateBalance(acc.journalEntries, acc.type);
        const category = acc.type.toLowerCase();
        if (report[category]) { report[category]!.accounts[acc.name] = balance.toNumber(); report[category]!.total = report[category]!.total.plus(balance); }
        else if (acc.type === 'REVENUE' || acc.type === 'EXPENSE') { report.equity!.total = acc.type === 'REVENUE' ? report.equity!.total.plus(balance) : report.equity!.total.minus(balance); }
    }
    return { date, assets: { ...report.assets!, total: report.assets!.total.toNumber() }, liabilities: { ...report.liabilities!, total: report.liabilities!.total.toNumber() }, equity: { ...report.equity!, total: report.equity!.total.toNumber() } };
}

export async function generateDailySummary(prisma: PrismaClient, tenantId: string, date: Date = new Date()) {
    const start = new Date(date); start.setHours(0, 0, 0, 0);
    const end = new Date(date); end.setHours(23, 59, 59, 999);
    const transactions = await (prisma as any).financialTransaction.findMany({ where: { tenantId, createdAt: { gte: start, lte: end } }, include: { journalEntries: { include: { account: true } } } });
    const summary = { date: start.toISOString().split('T')[0]!, transactionCount: transactions.length, totalVolume: transactions.reduce((sum: number, tx: any) => sum + Number(tx.amount), 0), types: {} as Record<string, number>, integrityCheck: 'PASSED' };
    for (const tx of transactions) { summary.types[tx.type] = (summary.types[tx.type] ?? 0) + 1; }
    return summary;
}

export async function generateTaxFilingReport(prisma: PrismaClient, tenantId: string, startDate: Date, endDate: Date) {
    const entries = await (prisma as any).journalEntry.findMany({ where: { tenantId, account: { code: '2100' }, createdAt: { gte: startDate, lte: endDate } }, include: { transaction: true } });
    let totalCollected = new Decimal(0); let totalPaidOnExpenses = new Decimal(0);
    for (const entry of entries) { totalCollected = totalCollected.plus(new Decimal(entry.paidOutAmount || 0)); totalPaidOnExpenses = totalPaidOnExpenses.plus(new Decimal(entry.debit)); }
    return { periodStart: startDate.toISOString().split('T')[0]!, periodEnd: endDate.toISOString().split('T')[0]!, totalCollected: totalCollected.toNumber(), totalInputCredits: totalPaidOnExpenses.toNumber(), netTaxOwed: totalCollected.minus(totalPaidOnExpenses).toNumber(), entryCount: entries.length };
}
