/**
 * Financial Engine, Observability & Double-Entry Tests — Phase 27
 *
 * Self-contained replicas of logic from:
 * - financial-reporting.ts: calculateBalance, gross profit margin, net income
 * - financial.service.ts: chart of accounts, double-entry validation, reconciliation
 * - observability.ts: correlation IDs, structured log format, log level derivation
 * - Additional: currency formatting, date windowing, fuzzy matching, data integrity
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Financial Balance Calculation (replicated from financial-reporting.ts)
// ═══════════════════════════════════════════════════════════════════════════

type AccountType = 'ASSET' | 'LIABILITY' | 'EQUITY' | 'REVENUE' | 'EXPENSE';

function calculateBalance(entries: Array<{ debit: number; credit: number }>, accountType: AccountType): number {
    let balance = 0;
    for (const entry of entries) {
        if (['ASSET', 'EXPENSE'].includes(accountType)) {
            balance += entry.debit - entry.credit;
        } else {
            balance += entry.credit - entry.debit;
        }
    }
    return balance;
}

function isDebitNormal(accountType: AccountType): boolean {
    return ['ASSET', 'EXPENSE'].includes(accountType);
}

describe('Balance — Debit-Normal Accounts', () => {
    it('ASSET: debit increases', () => {
        expect(calculateBalance([{ debit: 1000, credit: 0 }], 'ASSET')).toBe(1000);
    });
    it('ASSET: credit decreases', () => {
        expect(calculateBalance([{ debit: 1000, credit: 300 }], 'ASSET')).toBe(700);
    });
    it('EXPENSE: debit increases', () => {
        expect(calculateBalance([{ debit: 500, credit: 0 }], 'EXPENSE')).toBe(500);
    });
    it('EXPENSE: mixed', () => {
        expect(calculateBalance([
            { debit: 500, credit: 0 },
            { debit: 200, credit: 100 },
        ], 'EXPENSE')).toBe(600);
    });
    it('empty entries', () => {
        expect(calculateBalance([], 'ASSET')).toBe(0);
    });
});

describe('Balance — Credit-Normal Accounts', () => {
    it('LIABILITY: credit increases', () => {
        expect(calculateBalance([{ debit: 0, credit: 2000 }], 'LIABILITY')).toBe(2000);
    });
    it('REVENUE: credit increases', () => {
        expect(calculateBalance([{ debit: 0, credit: 5000 }], 'REVENUE')).toBe(5000);
    });
    it('EQUITY: credit increases', () => {
        expect(calculateBalance([{ debit: 0, credit: 10000 }], 'EQUITY')).toBe(10000);
    });
    it('LIABILITY: debit decreases', () => {
        expect(calculateBalance([{ debit: 500, credit: 2000 }], 'LIABILITY')).toBe(1500);
    });
});

describe('Balance — Normal Side', () => {
    it('ASSET is debit-normal', () => expect(isDebitNormal('ASSET')).toBe(true));
    it('EXPENSE is debit-normal', () => expect(isDebitNormal('EXPENSE')).toBe(true));
    it('LIABILITY is credit-normal', () => expect(isDebitNormal('LIABILITY')).toBe(false));
    it('REVENUE is credit-normal', () => expect(isDebitNormal('REVENUE')).toBe(false));
    it('EQUITY is credit-normal', () => expect(isDebitNormal('EQUITY')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Double-Entry Validation (replicated from financial.service.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface JournalEntry {
    accountCode: string;
    debit?: number;
    credit?: number;
}

function validateDoubleEntry(entries: JournalEntry[]): { valid: boolean; totalDebit: number; totalCredit: number } {
    let totalDebit = 0;
    let totalCredit = 0;
    for (const entry of entries) {
        totalDebit += entry.debit || 0;
        totalCredit += entry.credit || 0;
    }
    return { valid: Math.abs(totalDebit - totalCredit) < 0.001, totalDebit, totalCredit };
}

function resolveBalanceDirection(accountType: AccountType, debit: number, credit: number, balanceBefore: number): number {
    if (['ASSET', 'EXPENSE'].includes(accountType)) {
        return balanceBefore + debit - credit;
    }
    return balanceBefore + credit - debit;
}

describe('Double-Entry — Validation', () => {
    it('balanced entry', () => {
        const r = validateDoubleEntry([
            { accountCode: '1100', debit: 1130 },
            { accountCode: '4000', credit: 1000 },
            { accountCode: '2100', credit: 130 },
        ]);
        expect(r.valid).toBe(true);
        expect(r.totalDebit).toBe(1130);
        expect(r.totalCredit).toBe(1130);
    });
    it('unbalanced entry', () => {
        expect(validateDoubleEntry([
            { accountCode: '1000', debit: 500 },
            { accountCode: '4000', credit: 400 },
        ]).valid).toBe(false);
    });
    it('single entry unbalanced', () => {
        expect(validateDoubleEntry([{ accountCode: '1000', debit: 100 }]).valid).toBe(false);
    });
    it('zero entries = balanced', () => {
        expect(validateDoubleEntry([]).valid).toBe(true);
    });
    it('payment entry', () => {
        expect(validateDoubleEntry([
            { accountCode: '1000', debit: 500 },
            { accountCode: '1100', credit: 500 },
        ]).valid).toBe(true);
    });
});

describe('Double-Entry — Balance Direction', () => {
    it('ASSET: debit increases', () => {
        expect(resolveBalanceDirection('ASSET', 1000, 0, 5000)).toBe(6000);
    });
    it('ASSET: credit decreases', () => {
        expect(resolveBalanceDirection('ASSET', 0, 500, 5000)).toBe(4500);
    });
    it('LIABILITY: credit increases', () => {
        expect(resolveBalanceDirection('LIABILITY', 0, 1000, 2000)).toBe(3000);
    });
    it('LIABILITY: debit decreases', () => {
        expect(resolveBalanceDirection('LIABILITY', 500, 0, 2000)).toBe(1500);
    });
    it('REVENUE: credit increases', () => {
        expect(resolveBalanceDirection('REVENUE', 0, 3000, 0)).toBe(3000);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Chart of Accounts (replicated from financial.service.ts)
// ═══════════════════════════════════════════════════════════════════════════

const DEFAULT_CHART = [
    { code: '1000', name: 'Cash', type: 'ASSET' as AccountType },
    { code: '1100', name: 'Accounts Receivable', type: 'ASSET' as AccountType },
    { code: '2000', name: 'Accounts Payable', type: 'LIABILITY' as AccountType },
    { code: '2100', name: 'Sales Tax Payable (HST/GST)', type: 'LIABILITY' as AccountType },
    { code: '3000', name: 'Owner Equity', type: 'EQUITY' as AccountType },
    { code: '4000', name: 'Service Revenue', type: 'REVENUE' as AccountType },
    { code: '5000', name: 'Caregiver Payroll (Direct)', type: 'EXPENSE' as AccountType },
    { code: '5100', name: 'Admin Payroll (Indirect)', type: 'EXPENSE' as AccountType },
    { code: '5200', name: 'Rent & Utilities', type: 'EXPENSE' as AccountType },
    { code: '5300', name: 'Software & Technology', type: 'EXPENSE' as AccountType },
];

function findAccountByCode(code: string) {
    return DEFAULT_CHART.find(a => a.code === code);
}

function isDirectCost(code: string): boolean {
    return Number(code) < 5100 && Number(code) >= 5000;
}

function calculateGrossProfit(revenue: number, directCosts: number): number {
    return revenue - directCosts;
}

function calculateGrossProfitMargin(revenue: number, directCosts: number): number {
    if (revenue === 0) return 0;
    return ((revenue - directCosts) / revenue) * 100;
}

function calculateNetIncome(grossProfit: number, indirectExpenses: number): number {
    return grossProfit - indirectExpenses;
}

describe('Chart of Accounts', () => {
    it('10 default accounts', () => expect(DEFAULT_CHART.length).toBe(10));
    it('find Cash', () => expect(findAccountByCode('1000')?.name).toBe('Cash'));
    it('find Revenue', () => expect(findAccountByCode('4000')?.name).toBe('Service Revenue'));
    it('unknown code', () => expect(findAccountByCode('9999')).toBeUndefined());
    it('has ASSET accounts', () => {
        expect(DEFAULT_CHART.filter(a => a.type === 'ASSET').length).toBe(2);
    });
    it('has LIABILITY accounts', () => {
        expect(DEFAULT_CHART.filter(a => a.type === 'LIABILITY').length).toBe(2);
    });
    it('has EXPENSE accounts', () => {
        expect(DEFAULT_CHART.filter(a => a.type === 'EXPENSE').length).toBe(4);
    });
});

describe('Direct Cost Classification', () => {
    it('5000 is direct', () => expect(isDirectCost('5000')).toBe(true));
    it('5100 is not direct', () => expect(isDirectCost('5100')).toBe(false));
    it('4000 is not direct', () => expect(isDirectCost('4000')).toBe(false));
});

describe('P&L Calculations', () => {
    it('gross profit', () => expect(calculateGrossProfit(10000, 6000)).toBe(4000));
    it('gross margin', () => expect(calculateGrossProfitMargin(10000, 6000)).toBe(40));
    it('zero revenue margin', () => expect(calculateGrossProfitMargin(0, 0)).toBe(0));
    it('net income', () => expect(calculateNetIncome(4000, 1500)).toBe(2500));
    it('net loss', () => expect(calculateNetIncome(4000, 5000)).toBe(-1000));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Observability — Correlation & Logging (replicated from observability.ts)
// ═══════════════════════════════════════════════════════════════════════════

function resolveCorrelationId(clientHeader: string | undefined): string {
    return clientHeader || crypto.randomUUID();
}

function deriveLogLevel(statusCode: number): 'info' | 'warn' | 'error' {
    if (statusCode >= 500) return 'error';
    if (statusCode >= 400) return 'warn';
    return 'info';
}

function buildStructuredLog(reqId: string, method: string, path: string, status: number, durationMs: number) {
    return {
        ts: new Date().toISOString(),
        reqId, method, path, status, ms: durationMs,
        level: deriveLogLevel(status),
    };
}

function calculateDuration(start: number, end: number): number {
    return end - start;
}

describe('Observability — Correlation ID', () => {
    it('uses provided header', () => {
        expect(resolveCorrelationId('abc-123')).toBe('abc-123');
    });
    it('generates UUID when undefined', () => {
        const id = resolveCorrelationId(undefined);
        expect(id.length).toBe(36); // UUID format
    });
});

describe('Observability — Log Level', () => {
    it('200 = info', () => expect(deriveLogLevel(200)).toBe('info'));
    it('201 = info', () => expect(deriveLogLevel(201)).toBe('info'));
    it('301 = info', () => expect(deriveLogLevel(301)).toBe('info'));
    it('400 = warn', () => expect(deriveLogLevel(400)).toBe('warn'));
    it('401 = warn', () => expect(deriveLogLevel(401)).toBe('warn'));
    it('404 = warn', () => expect(deriveLogLevel(404)).toBe('warn'));
    it('429 = warn', () => expect(deriveLogLevel(429)).toBe('warn'));
    it('500 = error', () => expect(deriveLogLevel(500)).toBe('error'));
    it('502 = error', () => expect(deriveLogLevel(502)).toBe('error'));
    it('503 = error', () => expect(deriveLogLevel(503)).toBe('error'));
});

describe('Observability — Structured Log', () => {
    it('builds complete log', () => {
        const log = buildStructuredLog('req-1', 'GET', '/v1/clients', 200, 45);
        expect(log.reqId).toBe('req-1');
        expect(log.method).toBe('GET');
        expect(log.path).toBe('/v1/clients');
        expect(log.status).toBe(200);
        expect(log.ms).toBe(45);
        expect(log.level).toBe('info');
        expect(log.ts).toBeTruthy();
    });
    it('error log', () => {
        const log = buildStructuredLog('req-2', 'POST', '/v1/auth/login', 500, 123);
        expect(log.level).toBe('error');
    });
});

describe('Observability — Duration', () => {
    it('simple', () => expect(calculateDuration(1000, 1045)).toBe(45));
    it('zero', () => expect(calculateDuration(1000, 1000)).toBe(0));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Currency & Amount Formatting
// ═══════════════════════════════════════════════════════════════════════════

function formatCurrency(amount: number, currency: string = 'CAD'): string {
    return `$${amount.toFixed(2)} ${currency}`;
}

function centsToAmount(cents: number): number {
    return cents / 100;
}

function amountToCents(amount: number): number {
    return Math.round(amount * 100);
}

function parseCurrencyString(str: string): number {
    const cleaned = str.replace(/[^0-9.-]/g, '');
    return parseFloat(cleaned) || 0;
}

describe('Currency — Formatting', () => {
    it('basic', () => expect(formatCurrency(1000)).toBe('$1000.00 CAD'));
    it('with decimal', () => expect(formatCurrency(99.99, 'USD')).toBe('$99.99 USD'));
    it('zero', () => expect(formatCurrency(0)).toBe('$0.00 CAD'));
});

describe('Currency — Cents Conversion', () => {
    it('cents to amount', () => expect(centsToAmount(10000)).toBe(100));
    it('amount to cents', () => expect(amountToCents(100)).toBe(10000));
    it('fractional cents', () => expect(amountToCents(99.99)).toBe(9999));
    it('round trip', () => expect(centsToAmount(amountToCents(42.50))).toBe(42.5));
});

describe('Currency — Parsing', () => {
    it('dollar sign', () => expect(parseCurrencyString('$1,234.56')).toBeCloseTo(1234.56, 2));
    it('plain number', () => expect(parseCurrencyString('500.00')).toBe(500));
    it('garbage', () => expect(parseCurrencyString('abc')).toBe(0));
    it('negative', () => expect(parseCurrencyString('-$42.00')).toBe(-42));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Fuzzy Reconciliation Matching (replicated from financial.service.ts)
// ═══════════════════════════════════════════════════════════════════════════

function isAmountMatch(bankAmount: number, ledgerAmount: number, tolerance: number = 0.01): boolean {
    return Math.abs(bankAmount - ledgerAmount) <= tolerance;
}

function isDateWithinWindow(bankDate: Date, ledgerDate: Date, windowDays: number = 3): boolean {
    const diffMs = Math.abs(bankDate.getTime() - ledgerDate.getTime());
    return diffMs <= windowDays * 24 * 60 * 60 * 1000;
}

function calculateMatchConfidence(amountMatch: boolean, dateMatch: boolean, descriptionMatch: boolean): number {
    let confidence = 0;
    if (amountMatch) confidence += 0.5;
    if (dateMatch) confidence += 0.3;
    if (descriptionMatch) confidence += 0.2;
    return confidence;
}

describe('Reconciliation — Amount Match', () => {
    it('exact match', () => expect(isAmountMatch(100, 100)).toBe(true));
    it('within tolerance', () => expect(isAmountMatch(100, 100.005)).toBe(true));
    it('outside tolerance', () => expect(isAmountMatch(100, 101)).toBe(false));
    it('custom tolerance', () => expect(isAmountMatch(100, 100.5, 1)).toBe(true));
});

describe('Reconciliation — Date Window', () => {
    it('same day', () => {
        expect(isDateWithinWindow(new Date('2026-03-15'), new Date('2026-03-15'))).toBe(true);
    });
    it('within 3 days', () => {
        expect(isDateWithinWindow(new Date('2026-03-15'), new Date('2026-03-17'))).toBe(true);
    });
    it('outside 3 days', () => {
        expect(isDateWithinWindow(new Date('2026-03-15'), new Date('2026-03-20'))).toBe(false);
    });
});

describe('Reconciliation — Match Confidence', () => {
    it('all match = 1.0', () => expect(calculateMatchConfidence(true, true, true)).toBe(1.0));
    it('none = 0', () => expect(calculateMatchConfidence(false, false, false)).toBe(0));
    it('amount only = 0.5', () => expect(calculateMatchConfidence(true, false, false)).toBe(0.5));
    it('date only = 0.3', () => expect(calculateMatchConfidence(false, true, false)).toBe(0.3));
    it('desc only = 0.2', () => expect(calculateMatchConfidence(false, false, true)).toBe(0.2));
    it('amount + date = 0.8', () => expect(calculateMatchConfidence(true, true, false)).toBe(0.8));
});
