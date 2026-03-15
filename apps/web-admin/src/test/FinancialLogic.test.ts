/**
 * Financial Logic Deep Tests
 *
 * Self-contained replicas of logic from:
 * - financial-reporting.ts: calculateBalance, account type categorization
 * - forecasting.service.ts: Runway calculation, forecast generation
 * - billing.service.ts: Invoice calculations, tax computations
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Calculate Balance (replicated from financial-reporting.ts)
// ═══════════════════════════════════════════════════════════════════════════

function calculateBalance(entries: Array<{ debit: number; paidOutAmount?: number }>, accountType: string): number {
    let balance = 0;
    for (const entry of entries) {
        if (['ASSET', 'EXPENSE'].includes(accountType)) {
            balance = balance + entry.debit - (entry.paidOutAmount || 0);
        } else {
            balance = balance + (entry.paidOutAmount || 0) - entry.debit;
        }
    }
    return balance;
}

describe('Calculate Balance — ASSET/EXPENSE', () => {
    it('single debit entry', () => {
        expect(calculateBalance([{ debit: 100 }], 'ASSET')).toBe(100);
    });

    it('debit minus paidOut', () => {
        expect(calculateBalance([{ debit: 100, paidOutAmount: 30 }], 'ASSET')).toBe(70);
    });

    it('multiple entries', () => {
        expect(calculateBalance([
            { debit: 100, paidOutAmount: 30 },
            { debit: 50, paidOutAmount: 10 },
        ], 'ASSET')).toBe(110);
    });

    it('empty entries = 0', () => {
        expect(calculateBalance([], 'ASSET')).toBe(0);
    });

    it('EXPENSE same as ASSET', () => {
        expect(calculateBalance([{ debit: 100, paidOutAmount: 20 }], 'EXPENSE')).toBe(80);
    });

    it('no paidOut defaults to 0', () => {
        expect(calculateBalance([{ debit: 50 }], 'EXPENSE')).toBe(50);
    });
});

describe('Calculate Balance — REVENUE/LIABILITY/EQUITY', () => {
    it('credits increase balance', () => {
        expect(calculateBalance([{ debit: 0, paidOutAmount: 100 }], 'REVENUE')).toBe(100);
    });

    it('debits decrease balance', () => {
        expect(calculateBalance([{ debit: 30, paidOutAmount: 100 }], 'REVENUE')).toBe(70);
    });

    it('LIABILITY type', () => {
        expect(calculateBalance([{ debit: 20, paidOutAmount: 80 }], 'LIABILITY')).toBe(60);
    });

    it('EQUITY type', () => {
        expect(calculateBalance([{ debit: 10, paidOutAmount: 50 }], 'EQUITY')).toBe(40);
    });

    it('multiple revenue entries', () => {
        expect(calculateBalance([
            { debit: 10, paidOutAmount: 100 },
            { debit: 20, paidOutAmount: 200 },
        ], 'REVENUE')).toBe(270);
    });

    it('empty = 0', () => {
        expect(calculateBalance([], 'REVENUE')).toBe(0);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Runway Calculation (replicated from forecasting.service.ts)
// ═══════════════════════════════════════════════════════════════════════════

function calculateRunway(currentCash: number, netDailyFlow: number): number | 'infinite' {
    if (netDailyFlow >= 0) return 'infinite';
    const burnRate = Math.abs(netDailyFlow);
    return Math.floor(currentCash / burnRate);
}

describe('Runway Calculation', () => {
    it('positive net flow = infinite', () => {
        expect(calculateRunway(10000, 100)).toBe('infinite');
    });

    it('zero net flow = infinite', () => {
        expect(calculateRunway(10000, 0)).toBe('infinite');
    });

    it('negative $100/day with $10,000 = 100 days', () => {
        expect(calculateRunway(10000, -100)).toBe(100);
    });

    it('negative $50/day with $10,000 = 200 days', () => {
        expect(calculateRunway(10000, -50)).toBe(200);
    });

    it('negative $333/day with $10,000 = 30 days', () => {
        expect(calculateRunway(10000, -333)).toBe(30);
    });

    it('zero cash = 0 days', () => {
        expect(calculateRunway(0, -100)).toBe(0);
    });

    it('fractional runway floors down', () => {
        expect(calculateRunway(10, -3)).toBe(3);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Forecast Point Generation (replicated from forecasting.service.ts)
// ═══════════════════════════════════════════════════════════════════════════

function generateForecastPoints(currentCash: number, netDailyFlow: number, daysAhead: number): Array<{ day: number; projectedCash: number }> {
    const points: Array<{ day: number; projectedCash: number }> = [];
    for (let i = 0; i <= daysAhead; i++) {
        const projected = currentCash + (netDailyFlow * i);
        points.push({ day: i, projectedCash: Math.max(0, projected) });
    }
    return points;
}

describe('Forecast Point Generation', () => {
    it('day 0 = current cash', () => {
        const pts = generateForecastPoints(10000, -100, 5);
        expect(pts[0].projectedCash).toBe(10000);
    });

    it('day 1 = current + netFlow', () => {
        const pts = generateForecastPoints(10000, -100, 5);
        expect(pts[1].projectedCash).toBe(9900);
    });

    it('generates correct number of points', () => {
        const pts = generateForecastPoints(10000, -100, 90);
        expect(pts.length).toBe(91); // 0 through 90
    });

    it('never goes below 0', () => {
        const pts = generateForecastPoints(100, -200, 5);
        expect(pts[2].projectedCash).toBe(0);
    });

    it('positive flow grows cash', () => {
        const pts = generateForecastPoints(10000, 50, 5);
        expect(pts[5].projectedCash).toBe(10250);
    });

    it('zero flow stays flat', () => {
        const pts = generateForecastPoints(10000, 0, 10);
        pts.forEach(pt => expect(pt.projectedCash).toBe(10000));
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Gross Profit Margin (replicated from financial-reporting.ts)
// ═══════════════════════════════════════════════════════════════════════════

function calculateGrossProfitMargin(revenue: number, directCosts: number): number {
    if (revenue === 0) return 0;
    return ((revenue - directCosts) / revenue) * 100;
}

describe('Gross Profit Margin', () => {
    it('100% margin when no costs', () => {
        expect(calculateGrossProfitMargin(10000, 0)).toBe(100);
    });

    it('0% margin when costs = revenue', () => {
        expect(calculateGrossProfitMargin(10000, 10000)).toBe(0);
    });

    it('50% margin when costs = half revenue', () => {
        expect(calculateGrossProfitMargin(10000, 5000)).toBe(50);
    });

    it('negative margin when costs > revenue', () => {
        expect(calculateGrossProfitMargin(10000, 15000)).toBe(-50);
    });

    it('zero revenue = 0', () => {
        expect(calculateGrossProfitMargin(0, 0)).toBe(0);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Account Type Categorization (replicated from financial-reporting.ts)
// ═══════════════════════════════════════════════════════════════════════════

function categorizeAccount(accountType: string): string {
    switch (accountType) {
        case 'ASSET': return 'assets';
        case 'LIABILITY': return 'liabilities';
        case 'EQUITY': return 'equity';
        case 'REVENUE': return 'equity'; // Revenue added to retained earnings
        case 'EXPENSE': return 'equity'; // Expenses subtracted from retained earnings
        default: return 'unknown';
    }
}

describe('Account Type Categorization', () => {
    it('ASSET → assets', () => {
        expect(categorizeAccount('ASSET')).toBe('assets');
    });

    it('LIABILITY → liabilities', () => {
        expect(categorizeAccount('LIABILITY')).toBe('liabilities');
    });

    it('EQUITY → equity', () => {
        expect(categorizeAccount('EQUITY')).toBe('equity');
    });

    it('REVENUE → equity', () => {
        expect(categorizeAccount('REVENUE')).toBe('equity');
    });

    it('EXPENSE → equity', () => {
        expect(categorizeAccount('EXPENSE')).toBe('equity');
    });

    it('unknown type → unknown', () => {
        expect(categorizeAccount('OTHER')).toBe('unknown');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Daily Summary Aggregation (replicated from financial-reporting.ts)
// ═══════════════════════════════════════════════════════════════════════════

function aggregateTransactionTypes(transactions: Array<{ type: string }>): Record<string, number> {
    const types: Record<string, number> = {};
    for (const tx of transactions) {
        types[tx.type] = (types[tx.type] || 0) + 1;
    }
    return types;
}

function calculateTotalVolume(transactions: Array<{ amount: number }>): number {
    return transactions.reduce((sum, tx) => sum + tx.amount, 0);
}

describe('Daily Summary Aggregation', () => {
    it('counts by type', () => {
        const types = aggregateTransactionTypes([
            { type: 'PAYMENT' }, { type: 'PAYMENT' }, { type: 'REFUND' }
        ]);
        expect(types.PAYMENT).toBe(2);
        expect(types.REFUND).toBe(1);
    });

    it('empty transactions', () => {
        expect(aggregateTransactionTypes([])).toEqual({});
    });

    it('single type', () => {
        const types = aggregateTransactionTypes([{ type: 'INVOICE' }]);
        expect(types.INVOICE).toBe(1);
    });

    it('total volume sum', () => {
        expect(calculateTotalVolume([{ amount: 100 }, { amount: 200 }, { amount: 50 }])).toBe(350);
    });

    it('total volume empty', () => {
        expect(calculateTotalVolume([])).toBe(0);
    });

    it('total volume single', () => {
        expect(calculateTotalVolume([{ amount: 999 }])).toBe(999);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Tax Filing Helpers (replicated from financial-reporting.ts)
// ═══════════════════════════════════════════════════════════════════════════

function calculateNetTaxOwed(totalCollected: number, totalInputCredits: number): number {
    return totalCollected - totalInputCredits;
}

function formatPeriod(date: Date): string {
    return date.toISOString().split('T')[0];
}

describe('Tax Filing Helpers', () => {
    it('net tax owed positive', () => {
        expect(calculateNetTaxOwed(5000, 3000)).toBe(2000);
    });

    it('net tax owed negative (refund)', () => {
        expect(calculateNetTaxOwed(3000, 5000)).toBe(-2000);
    });

    it('net tax owed zero', () => {
        expect(calculateNetTaxOwed(5000, 5000)).toBe(0);
    });

    it('format period', () => {
        expect(formatPeriod(new Date('2026-01-15T00:00:00Z'))).toBe('2026-01-15');
    });

    it('format period different date', () => {
        expect(formatPeriod(new Date('2026-06-30T12:00:00Z'))).toBe('2026-06-30');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Invoice Line Item Calculation
// ═══════════════════════════════════════════════════════════════════════════

function calculateLineTotal(quantity: number, unitPrice: number, taxRate: number = 0): { subtotal: number; tax: number; total: number } {
    const subtotal = quantity * unitPrice;
    const tax = subtotal * taxRate;
    return { subtotal, tax, total: subtotal + tax };
}

function calculateInvoiceTotal(lines: Array<{ subtotal: number; tax: number; total: number }>): { subtotal: number; totalTax: number; grandTotal: number } {
    const subtotal = lines.reduce((sum, l) => sum + l.subtotal, 0);
    const totalTax = lines.reduce((sum, l) => sum + l.tax, 0);
    const grandTotal = lines.reduce((sum, l) => sum + l.total, 0);
    return { subtotal, totalTax, grandTotal };
}

describe('Invoice Line Item Calculation', () => {
    it('simple quantity x price', () => {
        const result = calculateLineTotal(5, 100);
        expect(result.subtotal).toBe(500);
        expect(result.tax).toBe(0);
        expect(result.total).toBe(500);
    });

    it('with 13% HST', () => {
        const result = calculateLineTotal(2, 50, 0.13);
        expect(result.subtotal).toBe(100);
        expect(result.tax).toBeCloseTo(13);
        expect(result.total).toBeCloseTo(113);
    });

    it('zero quantity = zero line', () => {
        const result = calculateLineTotal(0, 100, 0.13);
        expect(result.total).toBe(0);
    });

    it('high quantity', () => {
        const result = calculateLineTotal(1000, 9.99, 0.05);
        expect(result.subtotal).toBeCloseTo(9990);
    });
});

describe('Invoice Total Calculation', () => {
    it('single line', () => {
        const lines = [calculateLineTotal(1, 100, 0.13)];
        const result = calculateInvoiceTotal(lines);
        expect(result.subtotal).toBe(100);
        expect(result.totalTax).toBeCloseTo(13);
        expect(result.grandTotal).toBeCloseTo(113);
    });

    it('multiple lines', () => {
        const lines = [
            calculateLineTotal(2, 50, 0.13),
            calculateLineTotal(1, 200, 0.13),
        ];
        const result = calculateInvoiceTotal(lines);
        expect(result.subtotal).toBe(300);
        expect(result.totalTax).toBeCloseTo(39);
        expect(result.grandTotal).toBeCloseTo(339);
    });

    it('empty lines = 0', () => {
        expect(calculateInvoiceTotal([]).grandTotal).toBe(0);
    });
});
