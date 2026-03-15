/**
 * Security, Finance & RBAC Deep Tests — Phase 19
 *
 * Self-contained replicas of logic from:
 * - billing.service.ts: Decimal class, invoice calc, expense code mapping
 * - financial.service.ts: Chart of Accounts, double-entry balance logic
 * - security.ts: tenant isolation, CSRF safe methods, XSS sanitization, prototype pollution
 * - rbac.ts: role hierarchy, umbrella groups, super_admin bypass
 * - auth.validation.ts: password policy regex, schema contracts
 * - rate-limit.ts: key generation, window math, rate-limit entry lifecycle
 * - route_metadata/admin.ts: metadata structure contracts
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Decimal Class (replicated from billing.service.ts)
// ═══════════════════════════════════════════════════════════════════════════

class Decimal {
    private value: number;
    constructor(v: number | string | Decimal) {
        this.value = typeof v === 'object' && v instanceof Decimal ? v.toNumber() : Number(v);
    }
    times(other: number | string | Decimal) { return new Decimal(this.value * new Decimal(other).toNumber()); }
    dividedBy(other: number | string | Decimal) { return new Decimal(this.value / new Decimal(other).toNumber()); }
    plus(other: number | string | Decimal) { return new Decimal(this.value + new Decimal(other).toNumber()); }
    minus(other: number | string | Decimal) { return new Decimal(this.value - new Decimal(other).toNumber()); }
    greaterThanOrEqualTo(other: number | string | Decimal) { return this.value >= new Decimal(other).toNumber(); }
    gt(other: number | string | Decimal) { return this.value > new Decimal(other).toNumber(); }
    equals(other: number | string | Decimal) { return this.value === new Decimal(other).toNumber(); }
    toNumber() { return this.value; }
    toString() { return this.value.toString(); }
    toJSON() { return this.value; }
}

describe('Decimal — Construction', () => {
    it('from number', () => expect(new Decimal(42).toNumber()).toBe(42));
    it('from string', () => expect(new Decimal('100.5').toNumber()).toBe(100.5));
    it('from another Decimal', () => expect(new Decimal(new Decimal(7)).toNumber()).toBe(7));
    it('zero', () => expect(new Decimal(0).toNumber()).toBe(0));
    it('negative', () => expect(new Decimal(-50).toNumber()).toBe(-50));
    it('toString', () => expect(new Decimal(42).toString()).toBe('42'));
    it('toJSON', () => expect(new Decimal(9.99).toJSON()).toBe(9.99));
});

describe('Decimal — Arithmetic', () => {
    it('plus numbers', () => expect(new Decimal(10).plus(5).toNumber()).toBe(15));
    it('plus strings', () => expect(new Decimal('10').plus('5').toNumber()).toBe(15));
    it('plus Decimal', () => expect(new Decimal(10).plus(new Decimal(5)).toNumber()).toBe(15));
    it('minus', () => expect(new Decimal(100).minus(30).toNumber()).toBe(70));
    it('minus negative result', () => expect(new Decimal(5).minus(10).toNumber()).toBe(-5));
    it('times', () => expect(new Decimal(10).times(3).toNumber()).toBe(30));
    it('times decimal', () => expect(new Decimal(100).times(0.13).toNumber()).toBeCloseTo(13, 10));
    it('dividedBy', () => expect(new Decimal(100).dividedBy(4).toNumber()).toBe(25));
    it('dividedBy decimal', () => expect(new Decimal(100).dividedBy(3).toNumber()).toBeCloseTo(33.333, 2));
    it('chained: (100 * 0.13) + 100', () => {
        const base = new Decimal(100);
        const tax = base.times(0.13);
        const total = base.plus(tax);
        expect(total.toNumber()).toBeCloseTo(113, 10);
    });
});

describe('Decimal — Comparison', () => {
    it('greaterThanOrEqualTo — greater', () => expect(new Decimal(10).greaterThanOrEqualTo(5)).toBe(true));
    it('greaterThanOrEqualTo — equal', () => expect(new Decimal(5).greaterThanOrEqualTo(5)).toBe(true));
    it('greaterThanOrEqualTo — less', () => expect(new Decimal(3).greaterThanOrEqualTo(5)).toBe(false));
    it('gt — greater', () => expect(new Decimal(10).gt(5)).toBe(true));
    it('gt — equal', () => expect(new Decimal(5).gt(5)).toBe(false));
    it('gt — less', () => expect(new Decimal(3).gt(5)).toBe(false));
    it('equals — true', () => expect(new Decimal(42).equals(42)).toBe(true));
    it('equals — false', () => expect(new Decimal(42).equals(43)).toBe(false));
    it('equals string', () => expect(new Decimal(42).equals('42')).toBe(true));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Chart of Accounts (replicated from financial.service.ts)
// ═══════════════════════════════════════════════════════════════════════════

const DEFAULT_ACCOUNTS = [
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

function calculateBalance(entries: { debit?: number; paidOutAmount?: number }[], accountType: string): number {
    let balance = 0;
    for (const entry of entries) {
        const debit = entry.debit || 0;
        const credit = entry.paidOutAmount || 0;
        if (['ASSET', 'EXPENSE'].includes(accountType)) {
            balance += debit - credit;
        } else {
            balance += credit - debit;
        }
    }
    return balance;
}

function mapExpenseCategory(category: string): string {
    return category === 'PAYROLL' ? '5000' : '5100';
}

describe('Chart of Accounts — Structure', () => {
    it('has 10 default accounts', () => expect(DEFAULT_ACCOUNTS.length).toBe(10));
    it('Cash is 1000', () => expect(DEFAULT_ACCOUNTS.find(a => a.code === '1000')?.name).toBe('Cash'));
    it('AR is 1100', () => expect(DEFAULT_ACCOUNTS.find(a => a.code === '1100')?.type).toBe('ASSET'));
    it('AP is LIABILITY', () => expect(DEFAULT_ACCOUNTS.find(a => a.code === '2000')?.type).toBe('LIABILITY'));
    it('HST is LIABILITY', () => expect(DEFAULT_ACCOUNTS.find(a => a.code === '2100')?.type).toBe('LIABILITY'));
    it('Equity is 3000', () => expect(DEFAULT_ACCOUNTS.find(a => a.code === '3000')?.type).toBe('EQUITY'));
    it('Revenue is 4000', () => expect(DEFAULT_ACCOUNTS.find(a => a.code === '4000')?.type).toBe('REVENUE'));
    it('Direct payroll is 5000', () => expect(DEFAULT_ACCOUNTS.find(a => a.code === '5000')?.type).toBe('EXPENSE'));
    it('Indirect payroll is 5100', () => expect(DEFAULT_ACCOUNTS.find(a => a.code === '5100')?.type).toBe('EXPENSE'));
    it('Rent is 5200', () => expect(DEFAULT_ACCOUNTS.find(a => a.code === '5200')?.type).toBe('EXPENSE'));
    it('Software is 5300', () => expect(DEFAULT_ACCOUNTS.find(a => a.code === '5300')?.type).toBe('EXPENSE'));
    it('codes are unique', () => {
        const codes = DEFAULT_ACCOUNTS.map(a => a.code);
        expect(new Set(codes).size).toBe(codes.length);
    });
    it('2 asset accounts', () => expect(DEFAULT_ACCOUNTS.filter(a => a.type === 'ASSET').length).toBe(2));
    it('2 liability accounts', () => expect(DEFAULT_ACCOUNTS.filter(a => a.type === 'LIABILITY').length).toBe(2));
    it('1 equity account', () => expect(DEFAULT_ACCOUNTS.filter(a => a.type === 'EQUITY').length).toBe(1));
    it('1 revenue account', () => expect(DEFAULT_ACCOUNTS.filter(a => a.type === 'REVENUE').length).toBe(1));
    it('4 expense accounts', () => expect(DEFAULT_ACCOUNTS.filter(a => a.type === 'EXPENSE').length).toBe(4));
});

describe('Double-Entry Balance Calculation', () => {
    it('ASSET: debit increases', () => {
        expect(calculateBalance([{ debit: 100 }], 'ASSET')).toBe(100);
    });
    it('ASSET: credit decreases', () => {
        expect(calculateBalance([{ paidOutAmount: 50 }], 'ASSET')).toBe(-50);
    });
    it('ASSET: net balance', () => {
        expect(calculateBalance([{ debit: 100 }, { paidOutAmount: 30 }], 'ASSET')).toBe(70);
    });
    it('LIABILITY: credit increases', () => {
        expect(calculateBalance([{ paidOutAmount: 100 }], 'LIABILITY')).toBe(100);
    });
    it('LIABILITY: debit decreases', () => {
        expect(calculateBalance([{ debit: 50 }], 'LIABILITY')).toBe(-50);
    });
    it('REVENUE: credit increases', () => {
        expect(calculateBalance([{ paidOutAmount: 200 }], 'REVENUE')).toBe(200);
    });
    it('EQUITY: credit increases', () => {
        expect(calculateBalance([{ paidOutAmount: 500 }], 'EQUITY')).toBe(500);
    });
    it('EXPENSE: debit increases', () => {
        expect(calculateBalance([{ debit: 75 }], 'EXPENSE')).toBe(75);
    });
    it('empty entries', () => {
        expect(calculateBalance([], 'ASSET')).toBe(0);
    });
    it('multiple entries', () => {
        const entries = [{ debit: 100 }, { debit: 50 }, { paidOutAmount: 25 }];
        expect(calculateBalance(entries, 'ASSET')).toBe(125);
    });
});

describe('Expense Category Mapping', () => {
    it('PAYROLL maps to 5000', () => expect(mapExpenseCategory('PAYROLL')).toBe('5000'));
    it('other maps to 5100', () => expect(mapExpenseCategory('SUPPLIES')).toBe('5100'));
    it('RENT maps to 5100', () => expect(mapExpenseCategory('RENT')).toBe('5100'));
    it('empty maps to 5100', () => expect(mapExpenseCategory('')).toBe('5100'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Invoice & Tax Calculation (replicated from billing.service.ts)
// ═══════════════════════════════════════════════════════════════════════════

function calculateTax(amount: number, taxPercentage: number): number {
    return new Decimal(amount).times(new Decimal(taxPercentage).dividedBy(100)).toNumber();
}

function calculateInvoiceTotal(subtotal: number, tax: number): number {
    return new Decimal(subtotal).plus(new Decimal(tax)).toNumber();
}

function isFullyPaid(totalPaid: number, invoiceTotal: number): boolean {
    return new Decimal(totalPaid).greaterThanOrEqualTo(invoiceTotal);
}

function buildInvoiceLedgerEntries(subtotal: number, tax: number) {
    const total = new Decimal(subtotal).plus(new Decimal(tax));
    const entries: { accountCode: string; debit?: number; credit?: number }[] = [
        { accountCode: '1100', debit: total.toNumber() },
        { accountCode: '4000', credit: subtotal },
    ];
    if (new Decimal(tax).gt(0)) {
        entries.push({ accountCode: '2100', credit: tax });
    }
    return entries;
}

function validateDoubleEntry(entries: { debit?: number; credit?: number }[]): boolean {
    let totalDebit = 0, totalCredit = 0;
    for (const e of entries) {
        totalDebit += e.debit || 0;
        totalCredit += e.credit || 0;
    }
    return Math.abs(totalDebit - totalCredit) < 0.001;
}

describe('Invoice Tax Calculation', () => {
    it('13% HST on $100', () => expect(calculateTax(100, 13)).toBeCloseTo(13, 10));
    it('0% tax', () => expect(calculateTax(100, 0)).toBe(0));
    it('5% GST on $200', () => expect(calculateTax(200, 5)).toBe(10));
    it('small amount', () => expect(calculateTax(1, 13)).toBeCloseTo(0.13, 10));
});

describe('Invoice Total', () => {
    it('subtotal + tax', () => expect(calculateInvoiceTotal(100, 13)).toBe(113));
    it('zero tax', () => expect(calculateInvoiceTotal(100, 0)).toBe(100));
    it('large amounts', () => expect(calculateInvoiceTotal(5000, 650)).toBe(5650));
});

describe('Payment Status', () => {
    it('fully paid', () => expect(isFullyPaid(113, 113)).toBe(true));
    it('overpaid', () => expect(isFullyPaid(120, 113)).toBe(true));
    it('underpaid', () => expect(isFullyPaid(100, 113)).toBe(false));
    it('zero', () => expect(isFullyPaid(0, 113)).toBe(false));
});

describe('Invoice Ledger Entries', () => {
    it('3 entries with tax', () => {
        const entries = buildInvoiceLedgerEntries(100, 13);
        expect(entries.length).toBe(3);
    });
    it('2 entries without tax', () => {
        const entries = buildInvoiceLedgerEntries(100, 0);
        expect(entries.length).toBe(2);
    });
    it('AR debit = total', () => {
        const entries = buildInvoiceLedgerEntries(100, 13);
        expect(entries[0].debit).toBe(113);
    });
    it('Revenue credit = subtotal', () => {
        const entries = buildInvoiceLedgerEntries(100, 13);
        expect(entries[1].credit).toBe(100);
    });
    it('Tax credit = tax', () => {
        const entries = buildInvoiceLedgerEntries(100, 13);
        expect(entries[2].credit).toBe(13);
    });
    it('balanced with tax', () => {
        expect(validateDoubleEntry(buildInvoiceLedgerEntries(100, 13))).toBe(true);
    });
    it('balanced without tax', () => {
        expect(validateDoubleEntry(buildInvoiceLedgerEntries(100, 0))).toBe(true);
    });
});

describe('Double-Entry Validation', () => {
    it('balanced', () => {
        expect(validateDoubleEntry([{ debit: 100 }, { credit: 100 }])).toBe(true);
    });
    it('unbalanced', () => {
        expect(validateDoubleEntry([{ debit: 100 }, { credit: 90 }])).toBe(false);
    });
    it('multiple entries balanced', () => {
        expect(validateDoubleEntry([{ debit: 100 }, { credit: 70 }, { credit: 30 }])).toBe(true);
    });
    it('empty', () => {
        expect(validateDoubleEntry([])).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Security — XSS Sanitization (replicated from security.ts)
// ═══════════════════════════════════════════════════════════════════════════

const SCRIPT_RE = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi;
const EVENT_RE = /\bon\w+\s*=/gi;
const HREF_JS_RE = /javascript\s*:/gi;
const PROTO_KEYS = ['__proto__', 'constructor', 'prototype'];

function sanitize(val: any): any {
    if (typeof val === 'string') {
        return val.replace(SCRIPT_RE, '').replace(EVENT_RE, '').replace(HREF_JS_RE, '');
    }
    if (Array.isArray(val)) return val.map(sanitize);
    if (val && typeof val === 'object') {
        const clean: any = {};
        for (const [k, v] of Object.entries(val)) {
            if (PROTO_KEYS.includes(k)) continue;
            clean[k] = sanitize(v);
        }
        return clean;
    }
    return val;
}

describe('XSS Sanitization — Script Tags', () => {
    it('removes script tags', () => {
        expect(sanitize('<script>alert("xss")</script>')).toBe('');
    });
    it('removes script with attrs', () => {
        expect(sanitize('<script src="evil.js"></script>')).toBe('');
    });
    it('preserves non-script HTML', () => {
        expect(sanitize('<b>Bold</b>')).toBe('<b>Bold</b>');
    });
    it('removes inline script in mixed content', () => {
        expect(sanitize('Hello <script>evil()</script> World')).toBe('Hello  World');
    });
});

describe('XSS Sanitization — Event Handlers', () => {
    it('removes onclick=', () => {
        expect(sanitize('onclick= alert(1)')).toBe(' alert(1)');
    });
    it('removes onload=', () => {
        expect(sanitize('onload= hack()')).toBe(' hack()');
    });
    it('removes onerror=', () => {
        expect(sanitize('onerror= x()')).toBe(' x()');
    });
    it('preserves text with "on" in words', () => {
        expect(sanitize('I am on vacation')).toBe('I am on vacation');
    });
});

describe('XSS Sanitization — JavaScript URLs', () => {
    it('removes javascript:', () => {
        expect(sanitize('javascript:alert(1)')).toBe('alert(1)');
    });
    it('removes javascript with spaces', () => {
        expect(sanitize('javascript :void(0)')).toBe('void(0)');
    });
    it('preserves normal URLs', () => {
        expect(sanitize('https://example.com')).toBe('https://example.com');
    });
});

describe('XSS Sanitization — Objects', () => {
    it('sanitizes nested object values', () => {
        const result = sanitize({ name: '<script>x</script>John' });
        expect(result.name).toBe('John');
    });
    it('sanitizes arrays', () => {
        const result = sanitize(['<script>x</script>', 'safe']);
        expect(result).toEqual(['', 'safe']);
    });
    it('preserves numbers', () => {
        expect(sanitize(42)).toBe(42);
    });
    it('preserves null', () => {
        expect(sanitize(null)).toBeNull();
    });
    it('preserves boolean', () => {
        expect(sanitize(true)).toBe(true);
    });
});

describe('Prototype Pollution Protection', () => {
    it('blocks __proto__', () => {
        const result = sanitize({ __proto__: { admin: true }, name: 'test' });
        expect(result).not.toHaveProperty('__proto__');
        expect(result.name).toBe('test');
    });
    it('blocks constructor', () => {
        const result = sanitize({ constructor: 'evil', data: 'ok' });
        expect(result).not.toHaveProperty('constructor');
    });
    it('blocks prototype', () => {
        const result = sanitize({ prototype: {}, safe: 1 });
        expect(result).not.toHaveProperty('prototype');
        expect(result.safe).toBe(1);
    });
    it('deeply nested pollution blocked', () => {
        const result = sanitize({ nested: { __proto__: { hack: true } } });
        expect(result.nested).not.toHaveProperty('__proto__');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. CSRF Safe Methods (replicated from security.ts)
// ═══════════════════════════════════════════════════════════════════════════

const SAFE_METHODS = ['GET', 'HEAD', 'OPTIONS'];

function isSafeMethod(method: string): boolean {
    return SAFE_METHODS.includes(method);
}

function requiresCSRFHeader(method: string): boolean {
    return !isSafeMethod(method);
}

describe('CSRF — Safe Methods', () => {
    it('GET is safe', () => expect(isSafeMethod('GET')).toBe(true));
    it('HEAD is safe', () => expect(isSafeMethod('HEAD')).toBe(true));
    it('OPTIONS is safe', () => expect(isSafeMethod('OPTIONS')).toBe(true));
    it('POST is unsafe', () => expect(isSafeMethod('POST')).toBe(false));
    it('PUT is unsafe', () => expect(isSafeMethod('PUT')).toBe(false));
    it('PATCH is unsafe', () => expect(isSafeMethod('PATCH')).toBe(false));
    it('DELETE is unsafe', () => expect(isSafeMethod('DELETE')).toBe(false));
});

describe('CSRF — Header Required', () => {
    it('GET does not require', () => expect(requiresCSRFHeader('GET')).toBe(false));
    it('POST requires', () => expect(requiresCSRFHeader('POST')).toBe(true));
    it('PUT requires', () => expect(requiresCSRFHeader('PUT')).toBe(true));
    it('DELETE requires', () => expect(requiresCSRFHeader('DELETE')).toBe(true));
    it('PATCH requires', () => expect(requiresCSRFHeader('PATCH')).toBe(true));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Tenant Isolation (replicated from security.ts)
// ═══════════════════════════════════════════════════════════════════════════

function resolveTenantId(headerTenantId?: string, jwtTenantId?: string): { tenantId: string | null; error: string | null } {
    if (headerTenantId && jwtTenantId && headerTenantId !== jwtTenantId) {
        return { tenantId: null, error: 'Tenant Mismatch' };
    }
    return { tenantId: jwtTenantId || headerTenantId || null, error: null };
}

function isPublicPath(path: string): boolean {
    return path.startsWith('/v1/public/') || path.startsWith('/v1/auth/') || path.startsWith('/v1/debug/') || path === '/v1/health';
}

function requiresTenantContext(path: string, hasJwt: boolean, tenantId: string | null): boolean {
    return !tenantId && hasJwt && !isPublicPath(path);
}

describe('Tenant Isolation — ID Resolution', () => {
    it('JWT wins when both match', () => {
        const r = resolveTenantId('t-1', 't-1');
        expect(r.tenantId).toBe('t-1');
        expect(r.error).toBeNull();
    });
    it('mismatch returns error', () => {
        const r = resolveTenantId('t-1', 't-2');
        expect(r.error).toBe('Tenant Mismatch');
    });
    it('JWT only', () => {
        expect(resolveTenantId(undefined, 't-jwt').tenantId).toBe('t-jwt');
    });
    it('header only', () => {
        expect(resolveTenantId('t-header', undefined).tenantId).toBe('t-header');
    });
    it('neither', () => {
        expect(resolveTenantId(undefined, undefined).tenantId).toBeNull();
    });
});

describe('Tenant Isolation — Public Paths', () => {
    it('/v1/public/ is public', () => expect(isPublicPath('/v1/public/config')).toBe(true));
    it('/v1/auth/ is public', () => expect(isPublicPath('/v1/auth/login')).toBe(true));
    it('/v1/debug/ is public', () => expect(isPublicPath('/v1/debug/status')).toBe(true));
    it('/v1/health is public', () => expect(isPublicPath('/v1/health')).toBe(true));
    it('/v1/users is not public', () => expect(isPublicPath('/v1/users')).toBe(false));
    it('/v1/admin is not public', () => expect(isPublicPath('/v1/admin/stats')).toBe(false));
});

describe('Tenant Context Required', () => {
    it('authenticated non-public needs tenant', () => {
        expect(requiresTenantContext('/v1/users', true, null)).toBe(true);
    });
    it('authenticated public path ok', () => {
        expect(requiresTenantContext('/v1/auth/login', true, null)).toBe(false);
    });
    it('with tenant id ok', () => {
        expect(requiresTenantContext('/v1/users', true, 't-1')).toBe(false);
    });
    it('unauthenticated ok', () => {
        expect(requiresTenantContext('/v1/users', false, null)).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 7. RBAC — Role Hierarchy (replicated from rbac.ts)
// ═══════════════════════════════════════════════════════════════════════════

const SERVICE_PROVIDERS = ['psw', 'rn', 'rmt', 'rpt', 'rch'];
const STAFF_SUBROLES = ['staff', 'finance', 'hr', 'compliance', 'finance_manager', 'hr_manager'];
const MANAGER_SUBROLES = ['manager', 'marketing_manager', 'operations_manager', 'clinical_manager', 'regional_manager', 'recruiting_manager', 'coordinator', 'crm', 'training'];

function hasRoleAccess(userRoles: string[], allowedRoles: string[]): boolean {
    return userRoles.some(role => {
        const lower = role.toLowerCase();
        if (lower === 'super_admin' || lower === 'scrum_master') return true;
        if (allowedRoles.includes(role)) return true;
        if (allowedRoles.includes('manager') && MANAGER_SUBROLES.includes(lower)) return true;
        if (allowedRoles.includes('service_provider') && SERVICE_PROVIDERS.includes(lower)) return true;
        if (allowedRoles.includes('staff') && STAFF_SUBROLES.includes(lower)) return true;
        return false;
    });
}

describe('RBAC — Direct Role Match', () => {
    it('admin matches admin', () => expect(hasRoleAccess(['admin'], ['admin'])).toBe(true));
    it('psw matches psw', () => expect(hasRoleAccess(['psw'], ['psw'])).toBe(true));
    it('psw does not match admin', () => expect(hasRoleAccess(['psw'], ['admin'])).toBe(false));
    it('multiple roles, one matches', () => expect(hasRoleAccess(['psw', 'admin'], ['admin'])).toBe(true));
});

describe('RBAC — Super Admin Bypass', () => {
    it('super_admin bypasses any', () => expect(hasRoleAccess(['super_admin'], ['admin', 'manager'])).toBe(true));
    it('scrum_master bypasses any', () => expect(hasRoleAccess(['scrum_master'], ['finance'])).toBe(true));
    it('super_admin with other roles', () => expect(hasRoleAccess(['psw', 'super_admin'], ['admin'])).toBe(true));
});

describe('RBAC — Manager Umbrella', () => {
    it('marketing_manager matches manager', () => expect(hasRoleAccess(['marketing_manager'], ['manager'])).toBe(true));
    it('operations_manager matches manager', () => expect(hasRoleAccess(['operations_manager'], ['manager'])).toBe(true));
    it('clinical_manager matches', () => expect(hasRoleAccess(['clinical_manager'], ['manager'])).toBe(true));
    it('regional_manager matches', () => expect(hasRoleAccess(['regional_manager'], ['manager'])).toBe(true));
    it('recruiting_manager matches', () => expect(hasRoleAccess(['recruiting_manager'], ['manager'])).toBe(true));
    it('coordinator matches manager', () => expect(hasRoleAccess(['coordinator'], ['manager'])).toBe(true));
    it('crm matches manager', () => expect(hasRoleAccess(['crm'], ['manager'])).toBe(true));
    it('training matches manager', () => expect(hasRoleAccess(['training'], ['manager'])).toBe(true));
    it('psw does not match manager', () => expect(hasRoleAccess(['psw'], ['manager'])).toBe(false));
});

describe('RBAC — Service Provider Umbrella', () => {
    it('psw matches service_provider', () => expect(hasRoleAccess(['psw'], ['service_provider'])).toBe(true));
    it('rn matches service_provider', () => expect(hasRoleAccess(['rn'], ['service_provider'])).toBe(true));
    it('rmt matches service_provider', () => expect(hasRoleAccess(['rmt'], ['service_provider'])).toBe(true));
    it('rpt matches service_provider', () => expect(hasRoleAccess(['rpt'], ['service_provider'])).toBe(true));
    it('rch matches service_provider', () => expect(hasRoleAccess(['rch'], ['service_provider'])).toBe(true));
    it('admin does not match service_provider', () => expect(hasRoleAccess(['admin'], ['service_provider'])).toBe(false));
});

describe('RBAC — Staff Umbrella', () => {
    it('finance matches staff', () => expect(hasRoleAccess(['finance'], ['staff'])).toBe(true));
    it('hr matches staff', () => expect(hasRoleAccess(['hr'], ['staff'])).toBe(true));
    it('compliance matches staff', () => expect(hasRoleAccess(['compliance'], ['staff'])).toBe(true));
    it('finance_manager matches staff', () => expect(hasRoleAccess(['finance_manager'], ['staff'])).toBe(true));
    it('hr_manager matches staff', () => expect(hasRoleAccess(['hr_manager'], ['staff'])).toBe(true));
    it('psw does not match staff', () => expect(hasRoleAccess(['psw'], ['staff'])).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 8. Password Policy (replicated from auth.validation.ts)
// ═══════════════════════════════════════════════════════════════════════════

function validatePassword(password: string): { valid: boolean; errors: string[] } {
    const errors: string[] = [];
    if (password.length < 8) errors.push('min 8 chars');
    if (password.length > 128) errors.push('max 128 chars');
    if (!/[A-Z]/.test(password)) errors.push('needs uppercase');
    if (!/[a-z]/.test(password)) errors.push('needs lowercase');
    if (!/[0-9]/.test(password)) errors.push('needs digit');
    if (!/[^A-Za-z0-9]/.test(password)) errors.push('needs special char');
    return { valid: errors.length === 0, errors };
}

function validateEmail(email: string): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

const VALID_ROLES = ['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'rn', 'manager'];

describe('Password Policy', () => {
    it('valid complex password', () => {
        expect(validatePassword('MyP@ss1234').valid).toBe(true);
    });
    it('too short', () => {
        const r = validatePassword('Ab1!');
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('min 8 chars');
    });
    it('no uppercase', () => {
        const r = validatePassword('mypass1234!');
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('needs uppercase');
    });
    it('no lowercase', () => {
        const r = validatePassword('MYPASS1234!');
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('needs lowercase');
    });
    it('no digit', () => {
        const r = validatePassword('MyPassWord!');
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('needs digit');
    });
    it('no special char', () => {
        const r = validatePassword('MyPass1234');
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('needs special char');
    });
    it('multiple errors', () => {
        const r = validatePassword('abc');
        expect(r.errors.length).toBeGreaterThan(1);
    });
    it('exactly 8 chars valid', () => {
        expect(validatePassword('Ab1!xxxx').valid).toBe(true);
    });
    it('128 chars valid', () => {
        const pw = 'Ab1!' + 'x'.repeat(124);
        expect(validatePassword(pw).valid).toBe(true);
    });
    it('129 chars invalid', () => {
        const pw = 'Ab1!' + 'x'.repeat(125);
        expect(validatePassword(pw).valid).toBe(false);
    });
});

describe('Email Validation (Auth)', () => {
    it('valid', () => expect(validateEmail('user@example.com')).toBe(true));
    it('invalid no @', () => expect(validateEmail('userexample.com')).toBe(false));
    it('invalid no domain', () => expect(validateEmail('user@')).toBe(false));
    it('invalid spaces', () => expect(validateEmail('user @test.com')).toBe(false));
});

describe('Valid Roles', () => {
    it('has 8 valid roles', () => expect(VALID_ROLES.length).toBe(8));
    it('includes client', () => expect(VALID_ROLES).toContain('client'));
    it('includes psw', () => expect(VALID_ROLES).toContain('psw'));
    it('includes admin', () => expect(VALID_ROLES).toContain('admin'));
    it('includes coordinator', () => expect(VALID_ROLES).toContain('coordinator'));
    it('includes finance', () => expect(VALID_ROLES).toContain('finance'));
    it('includes rn', () => expect(VALID_ROLES).toContain('rn'));
    it('includes manager', () => expect(VALID_ROLES).toContain('manager'));
    it('includes staff', () => expect(VALID_ROLES).toContain('staff'));
    it('does not include super_admin', () => expect(VALID_ROLES).not.toContain('super_admin'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 9. Rate Limiting — Key Generation & Window Math
// ═══════════════════════════════════════════════════════════════════════════

function buildRateLimitKey(prefix: string, ip: string): string {
    return `${prefix}:${ip}`;
}

function windowMsToSecs(windowMs: number): number {
    return Math.ceil(windowMs / 1000);
}

function isRateLimited(count: number, max: number): boolean {
    return count >= max;
}

function calculateRetryAfter(resetAt: number, now: number): number {
    return Math.ceil((resetAt - now) / 1000);
}

function remainingRequests(max: number, count: number): number {
    return Math.max(0, max - count);
}

interface RateLimitEntry { count: number; resetAt: number; }

function shouldResetWindow(entry: RateLimitEntry | null, now: number): boolean {
    return !entry || entry.resetAt < now;
}

describe('Rate Limit — Key Generation', () => {
    it('standard key', () => expect(buildRateLimitKey('rl', '1.2.3.4')).toBe('rl:1.2.3.4'));
    it('auth key', () => expect(buildRateLimitKey('auth', '10.0.0.1')).toBe('auth:10.0.0.1'));
    it('reset key', () => expect(buildRateLimitKey('reset', '::1')).toBe('reset:::1'));
});

describe('Rate Limit — Window Math', () => {
    it('60000ms = 60s', () => expect(windowMsToSecs(60000)).toBe(60));
    it('600000ms = 600s', () => expect(windowMsToSecs(600000)).toBe(600));
    it('1500ms = 2s (ceil)', () => expect(windowMsToSecs(1500)).toBe(2));
    it('999ms = 1s (ceil)', () => expect(windowMsToSecs(999)).toBe(1));
});

describe('Rate Limit — isRateLimited', () => {
    it('at limit', () => expect(isRateLimited(10, 10)).toBe(true));
    it('over limit', () => expect(isRateLimited(11, 10)).toBe(true));
    it('under limit', () => expect(isRateLimited(5, 10)).toBe(false));
    it('zero', () => expect(isRateLimited(0, 10)).toBe(false));
});

describe('Rate Limit — Retry After', () => {
    it('30 seconds remaining', () => expect(calculateRetryAfter(30000, 0)).toBe(30));
    it('0 seconds', () => expect(calculateRetryAfter(1000, 1000)).toBe(0));
    it('fractional rounds up', () => expect(calculateRetryAfter(1500, 0)).toBe(2));
});

describe('Rate Limit — Remaining', () => {
    it('9 of 10', () => expect(remainingRequests(10, 1)).toBe(9));
    it('0 of 10', () => expect(remainingRequests(10, 10)).toBe(0));
    it('negative clamped to 0', () => expect(remainingRequests(10, 15)).toBe(0));
});

describe('Rate Limit — Window Reset', () => {
    it('null entry resets', () => expect(shouldResetWindow(null, 1000)).toBe(true));
    it('expired entry resets', () => expect(shouldResetWindow({ count: 5, resetAt: 500 }, 1000)).toBe(true));
    it('active entry no reset', () => expect(shouldResetWindow({ count: 5, resetAt: 2000 }, 1000)).toBe(false));
});

describe('Rate Limit — Presets', () => {
    // Auth: 5 req / 60s
    it('auth: 5 max', () => expect(isRateLimited(5, 5)).toBe(true));
    it('auth: 4 ok', () => expect(isRateLimited(4, 5)).toBe(false));
    // API: 100 req / 60s
    it('api: 100 max', () => expect(isRateLimited(100, 100)).toBe(true));
    it('api: 99 ok', () => expect(isRateLimited(99, 100)).toBe(false));
    // Reset: 3 req / 600s
    it('reset: 3 max', () => expect(isRateLimited(3, 3)).toBe(true));
    it('reset: 2 ok', () => expect(isRateLimited(2, 3)).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 10. Route Metadata Structure (replicated from route_metadata/admin.ts)
// ═══════════════════════════════════════════════════════════════════════════

const ADMIN_METADATA = {
    VISITS: {
        LIST: { summary: 'List All Visits', tags: ['Admin Visits'] },
        CREATE: { summary: 'Create Visit', tags: ['Admin Visits'] },
        UPDATE: { summary: 'Update Visit', tags: ['Admin Visits'] },
        DELETE: { summary: 'Delete Visit', tags: ['Admin Visits'] },
        POST_SHIFT: { summary: 'Post Shift', tags: ['Admin Visits'] },
        OFFER_SHIFT: { summary: 'Offer Shift to PSWs', tags: ['Admin Visits'] },
        SUGGEST_PSWS: { summary: 'Suggest PSWs', tags: ['Admin Visits'] },
        ASSIGN_PSW: { summary: 'Assign PSW', tags: ['Admin Visits'] },
        CANCEL_VISIT: { summary: 'Cancel Visit', tags: ['Admin Visits'] },
        SURGE_SHIFT: { summary: 'Apply Surge Pricing', tags: ['Admin Visits'] },
    },
    EXTRA: {
        LEADS_LIST: { summary: 'List All Leads', tags: ['Admin Leads'] },
        LEADS_UPDATE: { summary: 'Update Lead Status', tags: ['Admin Leads'] },
        USERS_LIST: { summary: 'List All Users', tags: ['Admin Users'] },
        USERS_CREATE: { summary: 'Create New User', tags: ['Admin Users'] },
        USERS_VERIFY: { summary: 'Verify User', tags: ['Admin Users'] },
        USERS_ROLES: { summary: 'Update User Roles', tags: ['Admin Users'] },
        USERS_ELEVATE: { summary: 'Elevate User to Super User', tags: ['Admin Users'] },
        TIMESHEETS_LIST: { summary: 'List All Timesheets', tags: ['Admin Timesheets'] },
        TIMESHEETS_UPDATE: { summary: 'Update Timesheet Status', tags: ['Admin Timesheets'] },
    },
};

describe('Admin Metadata — Visits', () => {
    it('has 10 visit operations', () => expect(Object.keys(ADMIN_METADATA.VISITS).length).toBe(10));
    it('LIST summary', () => expect(ADMIN_METADATA.VISITS.LIST.summary).toBe('List All Visits'));
    it('CREATE has tags', () => expect(ADMIN_METADATA.VISITS.CREATE.tags).toContain('Admin Visits'));
    it('POST_SHIFT exists', () => expect(ADMIN_METADATA.VISITS.POST_SHIFT.summary).toBe('Post Shift'));
    it('SURGE_SHIFT exists', () => expect(ADMIN_METADATA.VISITS.SURGE_SHIFT.summary).toBe('Apply Surge Pricing'));
    it('all have summary', () => {
        for (const op of Object.values(ADMIN_METADATA.VISITS)) {
            expect(op.summary).toBeTruthy();
        }
    });
    it('all have tags', () => {
        for (const op of Object.values(ADMIN_METADATA.VISITS)) {
            expect(op.tags.length).toBeGreaterThan(0);
        }
    });
});

describe('Admin Metadata — Extra', () => {
    it('has 9 extra operations', () => expect(Object.keys(ADMIN_METADATA.EXTRA).length).toBe(9));
    it('LEADS_LIST', () => expect(ADMIN_METADATA.EXTRA.LEADS_LIST.tags).toContain('Admin Leads'));
    it('USERS_CREATE', () => expect(ADMIN_METADATA.EXTRA.USERS_CREATE.summary).toBe('Create New User'));
    it('USERS_ELEVATE', () => expect(ADMIN_METADATA.EXTRA.USERS_ELEVATE.summary).toBe('Elevate User to Super User'));
    it('TIMESHEETS_LIST', () => expect(ADMIN_METADATA.EXTRA.TIMESHEETS_LIST.tags).toContain('Admin Timesheets'));
    it('all have summary', () => {
        for (const op of Object.values(ADMIN_METADATA.EXTRA)) {
            expect(op.summary).toBeTruthy();
        }
    });
});
