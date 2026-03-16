/**
 * Financial Reporting — Behavioral Tests
 *
 * Tests the actual source functions from financial-reporting.ts:
 * - calculateBalance (pure, Decimal-based)
 * - getTradingAccount (with mock Prisma)
 * - generateDailySummary (with mock Prisma)
 * - generateTaxFilingReport (with mock Prisma)
 */
import { describe, it, expect, vi } from 'vitest';
import { Decimal } from 'Decimal.js';
import { calculateBalance, getTradingAccount, generateDailySummary, generateTaxFilingReport } from '../_shared/services/financial-reporting';
import { buildChartOfAccount, buildJournalEntry, buildFinancialTransaction } from './helpers/test-factories';
import { createMockPrisma } from './helpers/test-utils';

// ═══════════════════════════════════════════════════════════════════════════
// calculateBalance — Pure Function (Decimal-based)
// ═══════════════════════════════════════════════════════════════════════════

describe('calculateBalance (source)', () => {
    describe('ASSET / EXPENSE accounts (debit-normal)', () => {
        it('single debit entry', () => {
            const result = calculateBalance([{ debit: 100, paidOutAmount: 0 }], 'ASSET');
            expect(result.toNumber()).toBe(100);
        });

        it('debit minus paidOut', () => {
            const result = calculateBalance([{ debit: 100, paidOutAmount: 30 }], 'ASSET');
            expect(result.toNumber()).toBe(70);
        });

        it('multiple entries accumulate', () => {
            const result = calculateBalance([
                { debit: 100, paidOutAmount: 30 },
                { debit: 50, paidOutAmount: 10 },
            ], 'ASSET');
            expect(result.toNumber()).toBe(110);
        });

        it('empty entries = 0', () => {
            expect(calculateBalance([], 'ASSET').toNumber()).toBe(0);
        });

        it('EXPENSE behaves same as ASSET', () => {
            const result = calculateBalance([{ debit: 100, paidOutAmount: 20 }], 'EXPENSE');
            expect(result.toNumber()).toBe(80);
        });

        it('missing paidOutAmount defaults to 0', () => {
            const result = calculateBalance([{ debit: 50 }], 'ASSET');
            expect(result.toNumber()).toBe(50);
        });

        it('handles Decimal precision', () => {
            const result = calculateBalance([
                { debit: 0.1, paidOutAmount: 0 },
                { debit: 0.2, paidOutAmount: 0 },
            ], 'ASSET');
            // Decimal.js avoids float imprecision: 0.1 + 0.2 = 0.3 exactly
            expect(result.toNumber()).toBeCloseTo(0.3);
        });
    });

    describe('REVENUE / LIABILITY / EQUITY accounts (credit-normal)', () => {
        it('credits increase balance', () => {
            const result = calculateBalance([{ debit: 0, paidOutAmount: 100 }], 'REVENUE');
            expect(result.toNumber()).toBe(100);
        });

        it('debits decrease balance', () => {
            const result = calculateBalance([{ debit: 30, paidOutAmount: 100 }], 'REVENUE');
            expect(result.toNumber()).toBe(70);
        });

        it('LIABILITY type', () => {
            const result = calculateBalance([{ debit: 20, paidOutAmount: 80 }], 'LIABILITY');
            expect(result.toNumber()).toBe(60);
        });

        it('EQUITY type', () => {
            const result = calculateBalance([{ debit: 10, paidOutAmount: 50 }], 'EQUITY');
            expect(result.toNumber()).toBe(40);
        });

        it('multiple revenue entries', () => {
            const result = calculateBalance([
                { debit: 10, paidOutAmount: 100 },
                { debit: 20, paidOutAmount: 200 },
            ], 'REVENUE');
            expect(result.toNumber()).toBe(270);
        });

        it('empty = 0', () => {
            expect(calculateBalance([], 'REVENUE').toNumber()).toBe(0);
        });
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// getTradingAccount — Integration with Mock Prisma
// ═══════════════════════════════════════════════════════════════════════════

describe('getTradingAccount (source)', () => {
    it('calculates gross profit from revenue and direct costs', async () => {
        const revenueAccount = buildChartOfAccount({
            type: 'REVENUE',
            name: 'Sales Revenue',
            code: '4000',
            journalEntries: [
                buildJournalEntry({ debit: 0, paidOutAmount: 1000 }),
            ],
        });
        const directCostAccount = buildChartOfAccount({
            type: 'EXPENSE',
            name: 'Supplies',
            code: '5000', // < 5100 = direct costs
            journalEntries: [
                buildJournalEntry({ debit: 400, paidOutAmount: 0 }),
            ],
        });

        const prisma = createMockPrisma({
            chartOfAccount: {
                findMany: vi.fn().mockResolvedValue([revenueAccount, directCostAccount]),
            },
        });

        const result = await getTradingAccount(prisma, 'tenant-1', new Date('2026-01-01'), new Date('2026-03-31'));

        expect(result.revenue).toBe(1000);
        expect(result.directCosts).toBe(400);
        expect(result.grossProfit).toBe(600);
        expect(result.grossProfitMargin).toBeCloseTo(60);
    });

    it('returns 0 margin when revenue is zero', async () => {
        const prisma = createMockPrisma({
            chartOfAccount: { findMany: vi.fn().mockResolvedValue([]) },
        });

        const result = await getTradingAccount(prisma, 'tenant-1', new Date(), new Date());
        expect(result.revenue).toBe(0);
        expect(result.grossProfitMargin).toBe(0);
    });

    it('excludes indirect expenses (code >= 5100)', async () => {
        const indirectExpense = buildChartOfAccount({
            type: 'EXPENSE',
            name: 'Office Rent',
            code: '5200', // >= 5100 = indirect
            journalEntries: [buildJournalEntry({ debit: 500, paidOutAmount: 0 })],
        });

        const prisma = createMockPrisma({
            chartOfAccount: { findMany: vi.fn().mockResolvedValue([indirectExpense]) },
        });

        const result = await getTradingAccount(prisma, 'tenant-1', new Date(), new Date());
        expect(result.directCosts).toBe(0); // indirect costs excluded
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// generateDailySummary — Integration with Mock Prisma
// ═══════════════════════════════════════════════════════════════════════════

describe('generateDailySummary (source)', () => {
    it('aggregates transaction types and volume', async () => {
        const transactions = [
            buildFinancialTransaction({ type: 'PAYMENT', amount: 100 }),
            buildFinancialTransaction({ type: 'PAYMENT', amount: 200 }),
            buildFinancialTransaction({ type: 'REFUND', amount: 50 }),
        ];

        const prisma = createMockPrisma({
            financialTransaction: {
                findMany: vi.fn().mockResolvedValue(transactions),
            },
        });

        const result = await generateDailySummary(prisma, 'tenant-1');
        expect(result.transactionCount).toBe(3);
        expect(result.totalVolume).toBe(350);
        expect(result.types).toEqual({ PAYMENT: 2, REFUND: 1 });
        expect(result.integrityCheck).toBe('PASSED');
    });

    it('handles no transactions', async () => {
        const prisma = createMockPrisma({
            financialTransaction: {
                findMany: vi.fn().mockResolvedValue([]),
            },
        });

        const result = await generateDailySummary(prisma, 'tenant-1');
        expect(result.transactionCount).toBe(0);
        expect(result.totalVolume).toBe(0);
        expect(result.types).toEqual({});
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// generateTaxFilingReport — Integration with Mock Prisma
// ═══════════════════════════════════════════════════════════════════════════

describe('generateTaxFilingReport (source)', () => {
    it('calculates net tax owed', async () => {
        const entries = [
            buildJournalEntry({ debit: 100, paidOutAmount: 500 }),
            buildJournalEntry({ debit: 200, paidOutAmount: 1000 }),
        ];

        const prisma = createMockPrisma({
            journalEntry: {
                findMany: vi.fn().mockResolvedValue(entries),
            },
        });

        const start = new Date('2026-01-01');
        const end = new Date('2026-03-31');
        const result = await generateTaxFilingReport(prisma, 'tenant-1', start, end);

        expect(result.totalCollected).toBe(1500);
        expect(result.totalInputCredits).toBe(300);
        expect(result.netTaxOwed).toBe(1200);
        expect(result.periodStart).toBe('2026-01-01');
        expect(result.periodEnd).toBe('2026-03-31');
        expect(result.entryCount).toBe(2);
    });

    it('handles negative net tax (refund scenario)', async () => {
        const entries = [
            buildJournalEntry({ debit: 800, paidOutAmount: 100 }),
        ];

        const prisma = createMockPrisma({
            journalEntry: { findMany: vi.fn().mockResolvedValue(entries) },
        });

        const result = await generateTaxFilingReport(prisma, 'tenant-1', new Date(), new Date());
        expect(result.netTaxOwed).toBe(-700); // refund
    });

    it('handles no entries', async () => {
        const prisma = createMockPrisma({
            journalEntry: { findMany: vi.fn().mockResolvedValue([]) },
        });

        const result = await generateTaxFilingReport(prisma, 'tenant-1', new Date(), new Date());
        expect(result.totalCollected).toBe(0);
        expect(result.totalInputCredits).toBe(0);
        expect(result.netTaxOwed).toBe(0);
        expect(result.entryCount).toBe(0);
    });
});
