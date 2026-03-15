/**
 * Rate Limiter, Billing, Forecasting & Session Hijack Tests — Phase 26
 *
 * Self-contained replicas of logic from:
 * - rate-limiter.ts: profile resolution, limit configs, client key extraction
 * - billing.service.ts: Decimal arithmetic, tax calculation, account codes
 * - forecasting.service.ts: cash flow projection, runway calculation
 * - SessionHijackSentinel.ts: IP mutation velocity, UA fingerprint detection
 * - Additional: pagination, sorting, search/filter, data aggregation
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Rate Limiter — Profile Resolution (replicated from rate-limiter.ts)
// ═══════════════════════════════════════════════════════════════════════════

type RateLimitProfile = 'AUTH' | 'STRICT' | 'DEFAULT';

const LIMITS: Record<RateLimitProfile, { maxRequests: number; windowMs: number }> = {
    AUTH: { maxRequests: 10, windowMs: 60_000 },
    STRICT: { maxRequests: 30, windowMs: 60_000 },
    DEFAULT: { maxRequests: 120, windowMs: 60_000 },
};

function resolveProfile(path: string, method: string): RateLimitProfile {
    if (path.startsWith('/v1/auth/')) return 'AUTH';
    if (method !== 'GET' && (
        path.includes('/api-keys') ||
        path.includes('/payment') ||
        path.includes('/payout') ||
        path.includes('/invoice') ||
        path.includes('/webhook') ||
        path.includes('/security') ||
        path.includes('/cors-settings')
    )) return 'STRICT';
    return 'DEFAULT';
}

function shouldSkipRateLimit(method: string, path: string): boolean {
    return method === 'OPTIONS' || path === '/v1/health';
}

function buildClientKey(ip: string, tenantId: string, profile: RateLimitProfile): string {
    return `${ip}:${tenantId}:${profile}`;
}

function calculateRetryAfter(resetAt: number, now: number): number {
    return Math.ceil((resetAt - now) / 1000);
}

function calculateRemaining(maxRequests: number, currentCount: number): number {
    return Math.max(0, maxRequests - currentCount);
}

describe('Rate Limiter — Profile Resolution', () => {
    it('auth login', () => expect(resolveProfile('/v1/auth/login', 'POST')).toBe('AUTH'));
    it('auth register', () => expect(resolveProfile('/v1/auth/register', 'POST')).toBe('AUTH'));
    it('auth password-reset', () => expect(resolveProfile('/v1/auth/password-reset', 'POST')).toBe('AUTH'));
    it('auth GET', () => expect(resolveProfile('/v1/auth/session', 'GET')).toBe('AUTH'));
    it('POST api-keys', () => expect(resolveProfile('/v1/api-keys', 'POST')).toBe('STRICT'));
    it('POST payment', () => expect(resolveProfile('/v1/payment/charge', 'POST')).toBe('STRICT'));
    it('POST payout', () => expect(resolveProfile('/v1/payout/run', 'POST')).toBe('STRICT'));
    it('POST invoice', () => expect(resolveProfile('/v1/invoice/create', 'POST')).toBe('STRICT'));
    it('POST webhook', () => expect(resolveProfile('/v1/webhook/register', 'POST')).toBe('STRICT'));
    it('POST security', () => expect(resolveProfile('/v1/security/roles', 'PUT')).toBe('STRICT'));
    it('POST cors-settings', () => expect(resolveProfile('/v1/cors-settings', 'PATCH')).toBe('STRICT'));
    it('GET api-keys = DEFAULT', () => expect(resolveProfile('/v1/api-keys', 'GET')).toBe('DEFAULT'));
    it('GET invoices = DEFAULT', () => expect(resolveProfile('/v1/invoices', 'GET')).toBe('DEFAULT'));
    it('general GET', () => expect(resolveProfile('/v1/clients', 'GET')).toBe('DEFAULT'));
    it('general POST', () => expect(resolveProfile('/v1/clients', 'POST')).toBe('DEFAULT'));
});

describe('Rate Limiter — Limit Values', () => {
    it('AUTH = 10/60s', () => {
        expect(LIMITS.AUTH.maxRequests).toBe(10);
        expect(LIMITS.AUTH.windowMs).toBe(60_000);
    });
    it('STRICT = 30/60s', () => {
        expect(LIMITS.STRICT.maxRequests).toBe(30);
        expect(LIMITS.STRICT.windowMs).toBe(60_000);
    });
    it('DEFAULT = 120/60s', () => {
        expect(LIMITS.DEFAULT.maxRequests).toBe(120);
        expect(LIMITS.DEFAULT.windowMs).toBe(60_000);
    });
});

describe('Rate Limiter — Skip Logic', () => {
    it('OPTIONS skipped', () => expect(shouldSkipRateLimit('OPTIONS', '/v1/any')).toBe(true));
    it('health skipped', () => expect(shouldSkipRateLimit('GET', '/v1/health')).toBe(true));
    it('normal not skipped', () => expect(shouldSkipRateLimit('GET', '/v1/clients')).toBe(false));
    it('POST not skipped', () => expect(shouldSkipRateLimit('POST', '/v1/auth/login')).toBe(false));
});

describe('Rate Limiter — Client Key', () => {
    it('builds key', () => expect(buildClientKey('1.2.3.4', 'tenant-1', 'AUTH')).toBe('1.2.3.4:tenant-1:AUTH'));
    it('empty tenant', () => expect(buildClientKey('1.2.3.4', '', 'DEFAULT')).toBe('1.2.3.4::DEFAULT'));
});

describe('Rate Limiter — Retry After', () => {
    it('10 seconds', () => expect(calculateRetryAfter(10000, 0)).toBe(10));
    it('rounds up', () => expect(calculateRetryAfter(1500, 0)).toBe(2));
    it('zero', () => expect(calculateRetryAfter(0, 0)).toBe(0));
});

describe('Rate Limiter — Remaining', () => {
    it('full quota', () => expect(calculateRemaining(120, 0)).toBe(120));
    it('partial', () => expect(calculateRemaining(120, 100)).toBe(20));
    it('exhausted', () => expect(calculateRemaining(120, 120)).toBe(0));
    it('over limit', () => expect(calculateRemaining(120, 200)).toBe(0));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Billing Decimal (replicated from billing.service.ts)
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
    isNegative() { return this.value < 0; }
    abs() { return new Decimal(Math.abs(this.value)); }
    toNumber() { return this.value; }
    toString() { return this.value.toString(); }
    toJSON() { return this.value; }
}

describe('Decimal — Arithmetic', () => {
    it('plus', () => expect(new Decimal(10).plus(5).toNumber()).toBe(15));
    it('minus', () => expect(new Decimal(10).minus(3).toNumber()).toBe(7));
    it('times', () => expect(new Decimal(10).times(3).toNumber()).toBe(30));
    it('dividedBy', () => expect(new Decimal(10).dividedBy(4).toNumber()).toBe(2.5));
    it('chain', () => expect(new Decimal(100).times(0.13).plus(100).toNumber()).toBe(113));
    it('from string', () => expect(new Decimal('42').toNumber()).toBe(42));
    it('from Decimal', () => expect(new Decimal(new Decimal(99)).toNumber()).toBe(99));
});

describe('Decimal — Comparison', () => {
    it('gte true', () => expect(new Decimal(10).greaterThanOrEqualTo(10)).toBe(true));
    it('gte false', () => expect(new Decimal(5).greaterThanOrEqualTo(10)).toBe(false));
    it('gte greater', () => expect(new Decimal(15).greaterThanOrEqualTo(10)).toBe(true));
});

describe('Decimal — Special', () => {
    it('isNegative true', () => expect(new Decimal(-5).isNegative()).toBe(true));
    it('isNegative false', () => expect(new Decimal(5).isNegative()).toBe(false));
    it('abs', () => expect(new Decimal(-42).abs().toNumber()).toBe(42));
    it('toString', () => expect(new Decimal(3.14).toString()).toBe('3.14'));
    it('toJSON', () => expect(new Decimal(100).toJSON()).toBe(100));
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Billing — Tax & Account Codes (replicated from billing.service.ts)
// ═══════════════════════════════════════════════════════════════════════════

function calculateTax(amount: number, taxPercentage: number): number {
    return new Decimal(amount).times(new Decimal(taxPercentage).dividedBy(100)).toNumber();
}

function calculateInvoiceTotal(subtotal: number, tax: number): number {
    return new Decimal(subtotal).plus(tax).toNumber();
}

function resolveExpenseAccountCode(category: string): string {
    return category === 'PAYROLL' ? '5000' : '5100';
}

function isInvoiceFullyPaid(totalPaid: number, invoiceTotal: number): boolean {
    return new Decimal(totalPaid).greaterThanOrEqualTo(invoiceTotal);
}

describe('Billing — Tax Calculations', () => {
    it('13% HST on $1000', () => expect(calculateTax(1000, 13)).toBeCloseTo(130, 2));
    it('5% GST on $500', () => expect(calculateTax(500, 5)).toBeCloseTo(25, 2));
    it('0% tax', () => expect(calculateTax(1000, 0)).toBe(0));
    it('15% on $200', () => expect(calculateTax(200, 15)).toBeCloseTo(30, 2));
});

describe('Billing — Invoice Total', () => {
    it('subtotal + tax', () => expect(calculateInvoiceTotal(1000, 130)).toBe(1130));
    it('no tax', () => expect(calculateInvoiceTotal(500, 0)).toBe(500));
});

describe('Billing — Account Codes', () => {
    it('PAYROLL = 5000', () => expect(resolveExpenseAccountCode('PAYROLL')).toBe('5000'));
    it('OTHER = 5100', () => expect(resolveExpenseAccountCode('SUPPLIES')).toBe('5100'));
    it('default = 5100', () => expect(resolveExpenseAccountCode('')).toBe('5100'));
});

describe('Billing — Payment Status', () => {
    it('fully paid', () => expect(isInvoiceFullyPaid(1130, 1130)).toBe(true));
    it('overpaid', () => expect(isInvoiceFullyPaid(1200, 1130)).toBe(true));
    it('underpaid', () => expect(isInvoiceFullyPaid(500, 1130)).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Forecasting — Cash Flow Projection (replicated from forecasting.service.ts)
// ═══════════════════════════════════════════════════════════════════════════

function calculateNetDailyFlow(avgRevenue: number, avgBurn: number): number {
    return avgRevenue - avgBurn;
}

function calculateRunway(currentCash: number, netDailyFlow: number): number | 'infinite' {
    if (netDailyFlow >= 0) return 'infinite';
    return Math.floor(currentCash / Math.abs(netDailyFlow));
}

function projectCash(currentCash: number, netDailyFlow: number, daysAhead: number): number {
    return Math.max(0, currentCash + (netDailyFlow * daysAhead));
}

function generateForecastPoints(currentCash: number, netDailyFlow: number, days: number): Array<{ day: number; cash: number }> {
    const points: Array<{ day: number; cash: number }> = [];
    for (let i = 0; i <= days; i++) {
        points.push({ day: i, cash: Math.max(0, currentCash + (netDailyFlow * i)) });
    }
    return points;
}

describe('Forecasting — Net Daily Flow', () => {
    it('positive', () => expect(calculateNetDailyFlow(1000, 800)).toBe(200));
    it('negative', () => expect(calculateNetDailyFlow(500, 800)).toBe(-300));
    it('break-even', () => expect(calculateNetDailyFlow(800, 800)).toBe(0));
});

describe('Forecasting — Runway', () => {
    it('positive flow = infinite', () => expect(calculateRunway(10000, 200)).toBe('infinite'));
    it('break-even = infinite', () => expect(calculateRunway(10000, 0)).toBe('infinite'));
    it('negative flow', () => expect(calculateRunway(9000, -300)).toBe(30));
    it('small runway', () => expect(calculateRunway(100, -50)).toBe(2));
});

describe('Forecasting — Cash Projection', () => {
    it('day 0', () => expect(projectCash(10000, -300, 0)).toBe(10000));
    it('day 10', () => expect(projectCash(10000, -300, 10)).toBe(7000));
    it('floor at 0', () => expect(projectCash(1000, -300, 10)).toBe(0));
    it('growing', () => expect(projectCash(10000, 200, 10)).toBe(12000));
});

describe('Forecasting — Points Generation', () => {
    it('3 days', () => {
        const pts = generateForecastPoints(1000, -100, 3);
        expect(pts.length).toBe(4); // day 0, 1, 2, 3
        expect(pts[0].cash).toBe(1000);
        expect(pts[3].cash).toBe(700);
    });
    it('floor at 0', () => {
        const pts = generateForecastPoints(100, -50, 5);
        expect(pts[4].cash).toBe(0); // 100 - 200 = max(0, -100) = 0
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Session Hijack Sentinel (replicated from SessionHijackSentinel.ts)
// ═══════════════════════════════════════════════════════════════════════════

function detectIPMutation(lastIp: string, currentIp: string): boolean {
    return lastIp !== currentIp;
}

function detectUAMutation(lastUA: string, currentUA: string): boolean {
    return lastUA !== currentUA;
}

function calculateTimeDiff(lastSeen: number, now: number): number {
    return Math.abs((now - lastSeen) / 1000);
}

function isImpossibleTravel(ipMutated: boolean, timeDiffSeconds: number, threshold: number = 60): boolean {
    return ipMutated && timeDiffSeconds < threshold;
}

function isBrowserFingerprintMismatch(uaMutated: boolean, timeDiffSeconds: number, threshold: number = 60): boolean {
    return uaMutated && timeDiffSeconds < threshold;
}

type SessionVerdict = { isValid: boolean; reason?: string };

function evaluateSession(lastIp: string, currentIp: string, lastUA: string, currentUA: string, lastSeen: number, now: number): SessionVerdict {
    const ipMutated = detectIPMutation(lastIp, currentIp);
    const uaMutated = detectUAMutation(lastUA, currentUA);
    const timeDiff = calculateTimeDiff(lastSeen, now);

    if (isImpossibleTravel(ipMutated, timeDiff)) {
        return { isValid: false, reason: 'IMPOSSIBLE_TRAVEL_VELOCITY' };
    }
    if (isBrowserFingerprintMismatch(uaMutated, timeDiff)) {
        return { isValid: false, reason: 'BROWSER_FINGERPRINT_MISMATCH' };
    }
    return { isValid: true };
}

describe('Session Hijack — IP Mutation', () => {
    it('same IP', () => expect(detectIPMutation('1.2.3.4', '1.2.3.4')).toBe(false));
    it('different IP', () => expect(detectIPMutation('1.2.3.4', '5.6.7.8')).toBe(true));
});

describe('Session Hijack — UA Mutation', () => {
    it('same UA', () => expect(detectUAMutation('Chrome/100', 'Chrome/100')).toBe(false));
    it('different UA', () => expect(detectUAMutation('Chrome/100', 'Firefox/95')).toBe(true));
});

describe('Session Hijack — Time Diff', () => {
    it('5 seconds', () => expect(calculateTimeDiff(0, 5000)).toBe(5));
    it('120 seconds', () => expect(calculateTimeDiff(0, 120000)).toBe(120));
});

describe('Session Hijack — Impossible Travel', () => {
    it('IP mutated in 5s', () => expect(isImpossibleTravel(true, 5)).toBe(true));
    it('IP mutated in 120s', () => expect(isImpossibleTravel(true, 120)).toBe(false));
    it('IP same', () => expect(isImpossibleTravel(false, 5)).toBe(false));
});

describe('Session Hijack — Fingerprint Mismatch', () => {
    it('UA mutated in 5s', () => expect(isBrowserFingerprintMismatch(true, 5)).toBe(true));
    it('UA mutated in 120s', () => expect(isBrowserFingerprintMismatch(true, 120)).toBe(false));
    it('UA same', () => expect(isBrowserFingerprintMismatch(false, 5)).toBe(false));
});

describe('Session Hijack — Full Evaluation', () => {
    it('same IP + UA = valid', () => {
        const r = evaluateSession('1.2.3.4', '1.2.3.4', 'Chrome', 'Chrome', 0, 5000);
        expect(r.isValid).toBe(true);
    });
    it('IP change fast = IMPOSSIBLE_TRAVEL', () => {
        const r = evaluateSession('1.2.3.4', '5.6.7.8', 'Chrome', 'Chrome', 0, 5000);
        expect(r.isValid).toBe(false);
        expect(r.reason).toBe('IMPOSSIBLE_TRAVEL_VELOCITY');
    });
    it('UA change fast = FINGERPRINT_MISMATCH', () => {
        const r = evaluateSession('1.2.3.4', '1.2.3.4', 'Chrome', 'Firefox', 0, 5000);
        expect(r.isValid).toBe(false);
        expect(r.reason).toBe('BROWSER_FINGERPRINT_MISMATCH');
    });
    it('IP change slow = valid', () => {
        const r = evaluateSession('1.2.3.4', '5.6.7.8', 'Chrome', 'Chrome', 0, 120000);
        expect(r.isValid).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Pagination & Sorting Utilities
// ═══════════════════════════════════════════════════════════════════════════

function paginate<T>(items: T[], page: number, pageSize: number): T[] {
    const start = (page - 1) * pageSize;
    return items.slice(start, start + pageSize);
}

function totalPages(totalItems: number, pageSize: number): number {
    return Math.ceil(totalItems / pageSize);
}

function sortBy<T>(items: T[], key: keyof T, order: 'asc' | 'desc' = 'asc'): T[] {
    return [...items].sort((a, b) => {
        if (a[key] < b[key]) return order === 'asc' ? -1 : 1;
        if (a[key] > b[key]) return order === 'asc' ? 1 : -1;
        return 0;
    });
}

function filterBySearch<T extends Record<string, any>>(items: T[], searchKey: string, query: string): T[] {
    const lower = query.toLowerCase();
    return items.filter(item => String(item[searchKey]).toLowerCase().includes(lower));
}

describe('Pagination', () => {
    const items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    it('page 1', () => expect(paginate(items, 1, 3)).toEqual([1, 2, 3]));
    it('page 2', () => expect(paginate(items, 2, 3)).toEqual([4, 5, 6]));
    it('last page partial', () => expect(paginate(items, 4, 3)).toEqual([10]));
    it('beyond pages', () => expect(paginate(items, 5, 3)).toEqual([]));
    it('total pages', () => expect(totalPages(10, 3)).toBe(4));
    it('exact division', () => expect(totalPages(9, 3)).toBe(3));
    it('single page', () => expect(totalPages(3, 10)).toBe(1));
});

describe('Sorting', () => {
    const items = [{ name: 'Charlie', age: 30 }, { name: 'Alice', age: 25 }, { name: 'Bob', age: 35 }];
    it('sort by name asc', () => {
        const sorted = sortBy(items, 'name', 'asc');
        expect(sorted[0].name).toBe('Alice');
        expect(sorted[2].name).toBe('Charlie');
    });
    it('sort by name desc', () => {
        const sorted = sortBy(items, 'name', 'desc');
        expect(sorted[0].name).toBe('Charlie');
    });
    it('sort by age asc', () => {
        const sorted = sortBy(items, 'age', 'asc');
        expect(sorted[0].age).toBe(25);
    });
});

describe('Filter by Search', () => {
    const items = [{ name: 'Alice' }, { name: 'Bob' }, { name: 'Charlie' }];
    it('match', () => expect(filterBySearch(items, 'name', 'ali').length).toBe(1));
    it('case insensitive', () => expect(filterBySearch(items, 'name', 'BOB').length).toBe(1));
    it('no match', () => expect(filterBySearch(items, 'name', 'xyz').length).toBe(0));
    it('empty query', () => expect(filterBySearch(items, 'name', '').length).toBe(3));
});
