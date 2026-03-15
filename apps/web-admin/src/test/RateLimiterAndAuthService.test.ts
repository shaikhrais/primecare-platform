/**
 * Rate Limiter, JWT Auth, Token Generation & Multi-Tenant Billing — Phase 36
 *
 * Self-contained replicas of logic from:
 * - rate-limiter.ts: profiles (AUTH/STRICT/DEFAULT), sliding window, client key, cleanup
 * - auth.ts: JWT validation, issuer/audience claims, token type, denylist
 * - auth.service.ts: parseRoles, generateToken payload, refresh token structure
 * - Multi-tenant billing: invoice generation, tax calculation, payment processing
 * - Data transformation: CSV export, table sorting, filtering pipelines
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Rate Limiter — Profiles & Sliding Window (replicated from rate-limiter.ts)
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
        path.includes('/api-keys') || path.includes('/payment') ||
        path.includes('/payout') || path.includes('/invoice') ||
        path.includes('/webhook') || path.includes('/security') ||
        path.includes('/cors-settings')
    )) return 'STRICT';
    return 'DEFAULT';
}

function getClientKey(ip: string, tenantId: string): string {
    return `${ip}:${tenantId}`;
}

function shouldSkipRateLimit(method: string, path: string): boolean {
    return method === 'OPTIONS' || path === '/v1/health';
}

function checkRateLimit(count: number, maxRequests: number): { allowed: boolean; remaining: number } {
    if (count > maxRequests) return { allowed: false, remaining: 0 };
    return { allowed: true, remaining: Math.max(0, maxRequests - count) };
}

function calculateRetryAfter(resetAt: number, now: number): number {
    return Math.ceil((resetAt - now) / 1000);
}

function shouldCleanup(counter: number): boolean {
    return counter % 100 === 0;
}

describe('Rate Limiter — Profile Resolution', () => {
    it('auth login', () => expect(resolveProfile('/v1/auth/login', 'POST')).toBe('AUTH'));
    it('auth register', () => expect(resolveProfile('/v1/auth/register', 'POST')).toBe('AUTH'));
    it('auth callback', () => expect(resolveProfile('/v1/auth/callback', 'GET')).toBe('AUTH'));
    it('payment POST', () => expect(resolveProfile('/v1/payment/charge', 'POST')).toBe('STRICT'));
    it('invoice POST', () => expect(resolveProfile('/v1/invoice/create', 'POST')).toBe('STRICT'));
    it('api-keys DELETE', () => expect(resolveProfile('/v1/api-keys/1', 'DELETE')).toBe('STRICT'));
    it('webhook PUT', () => expect(resolveProfile('/v1/webhook/config', 'PUT')).toBe('STRICT'));
    it('security PATCH', () => expect(resolveProfile('/v1/security/settings', 'PATCH')).toBe('STRICT'));
    it('payment GET (not strict)', () => expect(resolveProfile('/v1/payment/list', 'GET')).toBe('DEFAULT'));
    it('users GET', () => expect(resolveProfile('/v1/users', 'GET')).toBe('DEFAULT'));
    it('visits POST', () => expect(resolveProfile('/v1/visits', 'POST')).toBe('DEFAULT'));
});

describe('Rate Limiter — Limits', () => {
    it('AUTH max', () => expect(LIMITS.AUTH.maxRequests).toBe(10));
    it('STRICT max', () => expect(LIMITS.STRICT.maxRequests).toBe(30));
    it('DEFAULT max', () => expect(LIMITS.DEFAULT.maxRequests).toBe(120));
    it('all 60s window', () => {
        expect(LIMITS.AUTH.windowMs).toBe(60_000);
        expect(LIMITS.STRICT.windowMs).toBe(60_000);
        expect(LIMITS.DEFAULT.windowMs).toBe(60_000);
    });
});

describe('Rate Limiter — Client Key', () => {
    it('builds key', () => expect(getClientKey('1.2.3.4', 't-1')).toBe('1.2.3.4:t-1'));
    it('empty tenant', () => expect(getClientKey('1.2.3.4', '')).toBe('1.2.3.4:'));
});

describe('Rate Limiter — Skip', () => {
    it('OPTIONS', () => expect(shouldSkipRateLimit('OPTIONS', '/v1/users')).toBe(true));
    it('health', () => expect(shouldSkipRateLimit('GET', '/v1/health')).toBe(true));
    it('normal', () => expect(shouldSkipRateLimit('GET', '/v1/users')).toBe(false));
});

describe('Rate Limiter — Check', () => {
    it('under limit', () => expect(checkRateLimit(5, 10).allowed).toBe(true));
    it('at limit', () => expect(checkRateLimit(10, 10).allowed).toBe(true));
    it('over limit', () => expect(checkRateLimit(11, 10).allowed).toBe(false));
    it('remaining', () => expect(checkRateLimit(7, 10).remaining).toBe(3));
    it('zero remaining', () => expect(checkRateLimit(11, 10).remaining).toBe(0));
});

describe('Rate Limiter — Retry After', () => {
    it('30s', () => expect(calculateRetryAfter(130000, 100000)).toBe(30));
    it('1s', () => expect(calculateRetryAfter(101000, 100000)).toBe(1));
});

describe('Rate Limiter — Cleanup', () => {
    it('at 100', () => expect(shouldCleanup(100)).toBe(true));
    it('at 200', () => expect(shouldCleanup(200)).toBe(true));
    it('at 50', () => expect(shouldCleanup(50)).toBe(false));
    it('at 1', () => expect(shouldCleanup(1)).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. JWT Auth — Claims Validation (replicated from auth.ts)
// ═══════════════════════════════════════════════════════════════════════════

function validateJwtClaims(payload: { iss?: string; aud?: string; type?: string }): { valid: boolean; error?: string } {
    if (payload.iss !== 'primecare-api' || payload.aud !== 'primecare-web') {
        return { valid: false, error: 'Invalid token claims' };
    }
    if (payload.type === 'refresh') {
        return { valid: false, error: 'Invalid token type' };
    }
    return { valid: true };
}

function isTokenDenied(jti: string | undefined, denylist: Set<string>): boolean {
    if (!jti) return false;
    return denylist.has(`deny:${jti}`);
}

function resolveActiveRole(activeRole: string | undefined, roles: string[]): string {
    return activeRole || roles[0] || 'client';
}

function extractUserFromPayload(payload: { sub: string; roles: string[]; activeRole?: string }): { id: string; role: string } {
    return {
        id: payload.sub,
        role: resolveActiveRole(payload.activeRole, payload.roles),
    };
}

describe('JWT — Claims Validation', () => {
    it('valid', () => expect(validateJwtClaims({ iss: 'primecare-api', aud: 'primecare-web' }).valid).toBe(true));
    it('bad issuer', () => {
        const r = validateJwtClaims({ iss: 'other', aud: 'primecare-web' });
        expect(r.valid).toBe(false);
        expect(r.error).toBe('Invalid token claims');
    });
    it('bad audience', () => {
        const r = validateJwtClaims({ iss: 'primecare-api', aud: 'other' });
        expect(r.valid).toBe(false);
    });
    it('refresh token blocked', () => {
        const r = validateJwtClaims({ iss: 'primecare-api', aud: 'primecare-web', type: 'refresh' });
        expect(r.valid).toBe(false);
        expect(r.error).toBe('Invalid token type');
    });
    it('access token OK', () => {
        const r = validateJwtClaims({ iss: 'primecare-api', aud: 'primecare-web', type: 'access' });
        expect(r.valid).toBe(true);
    });
});

describe('JWT — Token Denylist', () => {
    const denylist = new Set(['deny:abc-123', 'deny:def-456']);
    it('denied', () => expect(isTokenDenied('abc-123', denylist)).toBe(true));
    it('not denied', () => expect(isTokenDenied('ghi-789', denylist)).toBe(false));
    it('no jti', () => expect(isTokenDenied(undefined, denylist)).toBe(false));
});

describe('JWT — Active Role', () => {
    it('explicit', () => expect(resolveActiveRole('admin', ['admin', 'staff'])).toBe('admin'));
    it('first fallback', () => expect(resolveActiveRole(undefined, ['staff', 'psw'])).toBe('staff'));
    it('empty fallback', () => expect(resolveActiveRole(undefined, [])).toBe('client'));
});

describe('JWT — User Extraction', () => {
    it('with activeRole', () => {
        const u = extractUserFromPayload({ sub: 'u-1', roles: ['admin', 'staff'], activeRole: 'staff' });
        expect(u.id).toBe('u-1');
        expect(u.role).toBe('staff');
    });
    it('without activeRole', () => {
        const u = extractUserFromPayload({ sub: 'u-2', roles: ['psw'] });
        expect(u.id).toBe('u-2');
        expect(u.role).toBe('psw');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Auth Service — Token Generation (replicated from auth.service.ts)
// ═══════════════════════════════════════════════════════════════════════════

function parseRoles(roles: any): string[] {
    if (Array.isArray(roles)) return roles;
    if (typeof roles === 'string') return roles.split(',').map(r => r.trim()).filter(Boolean);
    return ['client'];
}

function buildTokenPayload(user: { id: string; roles: any; tenantId: string }, options: { activeRole?: string; expiresInMinutes?: number; type?: string } = {}) {
    const { activeRole, expiresInMinutes = 60, type } = options;
    const now = Math.floor(Date.now() / 1000);
    const parsedRoles = parseRoles(user.roles);
    const payload: any = {
        sub: user.id,
        roles: parsedRoles,
        activeRole: activeRole || parsedRoles[0],
        tenantId: user.tenantId,
        jti: 'mock-uuid',
        iat: now,
        exp: now + (expiresInMinutes * 60),
        iss: 'primecare-api',
        aud: 'primecare-web',
    };
    if (type) payload.type = type;
    return payload;
}

function buildRefreshPayload(userId: string) {
    const now = Math.floor(Date.now() / 1000);
    return {
        sub: userId,
        type: 'refresh',
        jti: 'mock-uuid',
        iat: now,
        exp: now + 60 * 60 * 24 * 7,
        iss: 'primecare-api',
        aud: 'primecare-web',
    };
}

describe('Auth — Parse Roles', () => {
    it('array', () => expect(parseRoles(['admin', 'staff'])).toEqual(['admin', 'staff']));
    it('csv string', () => expect(parseRoles('admin,staff')).toEqual(['admin', 'staff']));
    it('csv with spaces', () => expect(parseRoles('admin , staff , psw')).toEqual(['admin', 'staff', 'psw']));
    it('empty string', () => expect(parseRoles('')).toEqual([]));
    it('null fallback', () => expect(parseRoles(null)).toEqual(['client']));
    it('number fallback', () => expect(parseRoles(42)).toEqual(['client']));
    it('undefined fallback', () => expect(parseRoles(undefined)).toEqual(['client']));
});

describe('Auth — Token Payload', () => {
    it('basic payload', () => {
        const p = buildTokenPayload({ id: 'u-1', roles: ['admin'], tenantId: 't-1' });
        expect(p.sub).toBe('u-1');
        expect(p.roles).toEqual(['admin']);
        expect(p.activeRole).toBe('admin');
        expect(p.tenantId).toBe('t-1');
        expect(p.iss).toBe('primecare-api');
        expect(p.aud).toBe('primecare-web');
    });
    it('explicit activeRole', () => {
        const p = buildTokenPayload({ id: 'u-1', roles: ['admin', 'staff'], tenantId: 't-1' }, { activeRole: 'staff' });
        expect(p.activeRole).toBe('staff');
    });
    it('custom expiry', () => {
        const p = buildTokenPayload({ id: 'u-1', roles: ['admin'], tenantId: 't-1' }, { expiresInMinutes: 120 });
        expect(p.exp - p.iat).toBe(7200);
    });
    it('default expiry 1h', () => {
        const p = buildTokenPayload({ id: 'u-1', roles: ['admin'], tenantId: 't-1' });
        expect(p.exp - p.iat).toBe(3600);
    });
    it('with type', () => {
        const p = buildTokenPayload({ id: 'u-1', roles: ['admin'], tenantId: 't-1' }, { type: 'access' });
        expect(p.type).toBe('access');
    });
    it('no type', () => {
        const p = buildTokenPayload({ id: 'u-1', roles: ['admin'], tenantId: 't-1' });
        expect(p.type).toBeUndefined();
    });
    it('string roles parsed', () => {
        const p = buildTokenPayload({ id: 'u-1', roles: 'admin,staff', tenantId: 't-1' });
        expect(p.roles).toEqual(['admin', 'staff']);
    });
});

describe('Auth — Refresh Payload', () => {
    it('has type refresh', () => expect(buildRefreshPayload('u-1').type).toBe('refresh'));
    it('7 day expiry', () => {
        const p = buildRefreshPayload('u-1');
        expect(p.exp - p.iat).toBe(604800);
    });
    it('has iss/aud', () => {
        const p = buildRefreshPayload('u-1');
        expect(p.iss).toBe('primecare-api');
        expect(p.aud).toBe('primecare-web');
    });
    it('sub set', () => expect(buildRefreshPayload('u-1').sub).toBe('u-1'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Multi-Tenant Billing — Invoice & Tax Calculations
// ═══════════════════════════════════════════════════════════════════════════

function calculateSubtotal(items: Array<{ quantity: number; rate: number }>): number {
    return items.reduce((sum, item) => sum + item.quantity * item.rate, 0);
}

function calculateTax(subtotal: number, taxRate: number): number {
    return Math.round(subtotal * taxRate * 100) / 100;
}

function calculateTotal(subtotal: number, taxRate: number): number {
    return subtotal + calculateTax(subtotal, taxRate);
}

function getHSTRate(province: string): number {
    const rates: Record<string, number> = { ON: 0.13, NS: 0.15, NB: 0.15, NL: 0.15, PE: 0.15, BC: 0.12, AB: 0.05, SK: 0.11, MB: 0.12, QC: 0.14975 };
    return rates[province] ?? 0.13;
}

function generateInvoiceNumber(tenantId: string, sequence: number): string {
    const prefix = tenantId.substring(0, 4).toUpperCase();
    return `INV-${prefix}-${String(sequence).padStart(6, '0')}`;
}

function isOverdue(dueDate: string, now: string): boolean {
    return new Date(now) > new Date(dueDate);
}

describe('Billing — Subtotal', () => {
    it('single item', () => expect(calculateSubtotal([{ quantity: 2, rate: 50 }])).toBe(100));
    it('multiple', () => expect(calculateSubtotal([{ quantity: 1, rate: 100 }, { quantity: 3, rate: 25 }])).toBe(175));
    it('empty', () => expect(calculateSubtotal([])).toBe(0));
});

describe('Billing — Tax', () => {
    it('ON 13%', () => expect(calculateTax(100, 0.13)).toBe(13));
    it('AB 5%', () => expect(calculateTax(200, 0.05)).toBe(10));
    it('zero subtotal', () => expect(calculateTax(0, 0.13)).toBe(0));
});

describe('Billing — Total', () => {
    it('100 + ON tax', () => expect(calculateTotal(100, 0.13)).toBe(113));
    it('200 + AB tax', () => expect(calculateTotal(200, 0.05)).toBe(210));
});

describe('Billing — HST Rates', () => {
    it('ON', () => expect(getHSTRate('ON')).toBe(0.13));
    it('BC', () => expect(getHSTRate('BC')).toBe(0.12));
    it('AB', () => expect(getHSTRate('AB')).toBe(0.05));
    it('NS', () => expect(getHSTRate('NS')).toBe(0.15));
    it('QC', () => expect(getHSTRate('QC')).toBe(0.14975));
    it('unknown default', () => expect(getHSTRate('XX')).toBe(0.13));
});

describe('Billing — Invoice Number', () => {
    it('generates', () => expect(generateInvoiceNumber('tenant-abc', 1)).toBe('INV-TENA-000001'));
    it('large seq', () => expect(generateInvoiceNumber('xyz-co', 12345)).toBe('INV-XYZ--012345'));
});

describe('Billing — Overdue', () => {
    it('overdue', () => expect(isOverdue('2026-01-01', '2026-01-15')).toBe(true));
    it('not overdue', () => expect(isOverdue('2026-03-01', '2026-01-15')).toBe(false));
    it('same day', () => expect(isOverdue('2026-01-15', '2026-01-15')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Data Transformation — CSV Export & Sorting
// ═══════════════════════════════════════════════════════════════════════════

function toCsvRow(values: (string | number)[]): string {
    return values.map(v => {
        const str = String(v);
        return str.includes(',') || str.includes('"') ? `"${str.replace(/"/g, '""')}"` : str;
    }).join(',');
}

function toCsv(headers: string[], rows: Array<(string | number)[]>): string {
    return [toCsvRow(headers), ...rows.map(toCsvRow)].join('\n');
}

function sortBy<T>(arr: T[], key: keyof T, direction: 'asc' | 'desc' = 'asc'): T[] {
    return [...arr].sort((a, b) => {
        const va = a[key], vb = b[key];
        const cmp = va < vb ? -1 : va > vb ? 1 : 0;
        return direction === 'asc' ? cmp : -cmp;
    });
}

function filterBySearch<T extends Record<string, any>>(items: T[], query: string, fields: (keyof T)[]): T[] {
    const q = query.toLowerCase();
    return items.filter(item => fields.some(f => String(item[f]).toLowerCase().includes(q)));
}

function paginate<T>(items: T[], page: number, pageSize: number): { data: T[]; total: number; totalPages: number } {
    const start = (page - 1) * pageSize;
    return { data: items.slice(start, start + pageSize), total: items.length, totalPages: Math.ceil(items.length / pageSize) };
}

describe('CSV — Row', () => {
    it('simple', () => expect(toCsvRow(['a', 'b', 'c'])).toBe('a,b,c'));
    it('with comma', () => expect(toCsvRow(['hello, world'])).toBe('"hello, world"'));
    it('with quotes', () => expect(toCsvRow(['say "hi"'])).toBe('"say ""hi"""'));
    it('numbers', () => expect(toCsvRow([1, 2, 3])).toBe('1,2,3'));
});

describe('CSV — Full', () => {
    it('builds csv', () => {
        const csv = toCsv(['Name', 'Age'], [['Alice', 30], ['Bob', 25]]);
        expect(csv).toBe('Name,Age\nAlice,30\nBob,25');
    });
});

describe('Sorting', () => {
    const items = [{ name: 'Charlie', age: 30 }, { name: 'Alice', age: 25 }, { name: 'Bob', age: 35 }];
    it('asc by name', () => expect(sortBy(items, 'name')[0].name).toBe('Alice'));
    it('desc by name', () => expect(sortBy(items, 'name', 'desc')[0].name).toBe('Charlie'));
    it('asc by age', () => expect(sortBy(items, 'age')[0].age).toBe(25));
    it('desc by age', () => expect(sortBy(items, 'age', 'desc')[0].age).toBe(35));
});

describe('Filtering', () => {
    const items = [{ name: 'Alice Smith', email: 'alice@test.com' }, { name: 'Bob Jones', email: 'bob@test.com' }];
    it('by name', () => expect(filterBySearch(items, 'alice', ['name']).length).toBe(1));
    it('by email', () => expect(filterBySearch(items, 'bob@', ['email']).length).toBe(1));
    it('no match', () => expect(filterBySearch(items, 'charlie', ['name']).length).toBe(0));
    it('case insensitive', () => expect(filterBySearch(items, 'ALICE', ['name']).length).toBe(1));
});

describe('Pagination', () => {
    const items = Array.from({ length: 25 }, (_, i) => i);
    it('page 1', () => {
        const r = paginate(items, 1, 10);
        expect(r.data.length).toBe(10);
        expect(r.totalPages).toBe(3);
    });
    it('page 3', () => {
        const r = paginate(items, 3, 10);
        expect(r.data.length).toBe(5);
    });
    it('single page', () => {
        const r = paginate([1, 2, 3], 1, 10);
        expect(r.totalPages).toBe(1);
    });
});
