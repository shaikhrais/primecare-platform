/**
 * Governance, Session Security & Financial Reporting Tests — Phase 20
 *
 * Self-contained replicas of logic from:
 * - governance.ts: VPN enforcement with CIDR/prefix matching, device status checks
 * - SessionHijackSentinel.ts: impossible travel velocity, browser fingerprint detection
 * - observability.ts: correlation ID, structured log format
 * - financial-reporting.ts: gross profit, net income, tax filing report math
 * - Additional: advanced validation patterns, encoding, metrics helpers
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. VPN Enforcement (replicated from governance.ts)
// ═══════════════════════════════════════════════════════════════════════════

function isIpAllowed(clientIp: string, allowedRanges: string[]): boolean {
    return allowedRanges.some(range => {
        if (range.endsWith('*')) {
            return clientIp.startsWith(range.slice(0, -1));
        }
        return clientIp === range;
    });
}

describe('VPN Enforcement — IP Matching', () => {
    it('exact match', () => expect(isIpAllowed('10.0.0.1', ['10.0.0.1'])).toBe(true));
    it('exact mismatch', () => expect(isIpAllowed('10.0.0.2', ['10.0.0.1'])).toBe(false));
    it('prefix wildcard match', () => expect(isIpAllowed('192.168.1.50', ['192.168.1.*'])).toBe(true));
    it('prefix wildcard mismatch', () => expect(isIpAllowed('192.168.2.50', ['192.168.1.*'])).toBe(false));
    it('broader prefix', () => expect(isIpAllowed('10.0.5.1', ['10.0.*'])).toBe(true));
    it('multiple ranges first match', () => expect(isIpAllowed('10.0.0.1', ['192.168.*', '10.0.0.1'])).toBe(true));
    it('multiple ranges second match', () => expect(isIpAllowed('192.168.1.5', ['10.0.*', '192.168.*'])).toBe(true));
    it('empty ranges', () => expect(isIpAllowed('10.0.0.1', [])).toBe(false));
    it('localhost exact', () => expect(isIpAllowed('127.0.0.1', ['127.0.0.1'])).toBe(true));
    it('IPv6 loopback', () => expect(isIpAllowed('::1', ['::1'])).toBe(true));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Device Status Checks (replicated from governance.ts)
// ═══════════════════════════════════════════════════════════════════════════

type DeviceStatus = 'active' | 'blocked' | 'revoked' | 'pending';

function isDeviceBlocked(status: DeviceStatus): boolean {
    return status === 'blocked' || status === 'revoked';
}

function isDevicePendingApproval(requireApproval: boolean, isAuthorized: boolean): boolean {
    return requireApproval && !isAuthorized;
}

function isTemporaryAccessExpired(isTemporary: boolean, expiresAt: Date | null, now: Date): boolean {
    return isTemporary && expiresAt !== null && now > expiresAt;
}

describe('Device Status', () => {
    it('active not blocked', () => expect(isDeviceBlocked('active')).toBe(false));
    it('blocked is blocked', () => expect(isDeviceBlocked('blocked')).toBe(true));
    it('revoked is blocked', () => expect(isDeviceBlocked('revoked')).toBe(true));
    it('pending not blocked', () => expect(isDeviceBlocked('pending')).toBe(false));
});

describe('Device Approval', () => {
    it('requires approval and not authorized', () => expect(isDevicePendingApproval(true, false)).toBe(true));
    it('requires approval but authorized', () => expect(isDevicePendingApproval(true, true)).toBe(false));
    it('no approval required', () => expect(isDevicePendingApproval(false, false)).toBe(false));
    it('no approval, authorized', () => expect(isDevicePendingApproval(false, true)).toBe(false));
});

describe('Temporary Access Expiration', () => {
    it('expired', () => {
        expect(isTemporaryAccessExpired(true, new Date('2025-01-01T00:00:00Z'), new Date('2025-06-01T00:00:00Z'))).toBe(true);
    });
    it('not expired', () => {
        expect(isTemporaryAccessExpired(true, new Date('2030-01-01T00:00:00Z'), new Date('2025-06-01T00:00:00Z'))).toBe(false);
    });
    it('not temporary', () => {
        expect(isTemporaryAccessExpired(false, new Date('2020-01-01T00:00:00Z'), new Date('2025-06-01T00:00:00Z'))).toBe(false);
    });
    it('null expiry', () => {
        expect(isTemporaryAccessExpired(true, null, new Date('2025-06-01T00:00:00Z'))).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Session Hijack Sentinel (replicated from SessionHijackSentinel.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface SessionRequest {
    jwtId: string;
    requestIp: string;
    userAgent: string;
    timestamp: number;
}

interface ActiveSessionData {
    lastIp: string;
    lastUserAgent: string;
    lastSeen: number;
}

function detectHijack(prev: ActiveSessionData | null, req: SessionRequest): { isValid: boolean; reason?: string } {
    if (!prev) return { isValid: true }; // New session

    const ipMutated = prev.lastIp !== req.requestIp;
    const agentMutated = prev.lastUserAgent !== req.userAgent;
    const timeDiffSeconds = Math.abs((req.timestamp - prev.lastSeen) / 1000);

    if (ipMutated && timeDiffSeconds < 60) {
        return { isValid: false, reason: 'IMPOSSIBLE_TRAVEL_VELOCITY' };
    }

    if (agentMutated && timeDiffSeconds < 60) {
        return { isValid: false, reason: 'BROWSER_FINGERPRINT_MISMATCH' };
    }

    return { isValid: true };
}

describe('Session Hijack — New Session', () => {
    it('null cache is valid', () => {
        const r = detectHijack(null, { jwtId: 'j1', requestIp: '1.2.3.4', userAgent: 'Chrome', timestamp: 1000 });
        expect(r.isValid).toBe(true);
    });
    it('no reason for new session', () => {
        const r = detectHijack(null, { jwtId: 'j1', requestIp: '1.2.3.4', userAgent: 'Chrome', timestamp: 1000 });
        expect(r.reason).toBeUndefined();
    });
});

describe('Session Hijack — IP Mutation', () => {
    const prev: ActiveSessionData = { lastIp: '1.2.3.4', lastUserAgent: 'Chrome', lastSeen: 0 };

    it('IP change <60s → IMPOSSIBLE_TRAVEL', () => {
        const r = detectHijack(prev, { jwtId: 'j1', requestIp: '5.6.7.8', userAgent: 'Chrome', timestamp: 30000 });
        expect(r.isValid).toBe(false);
        expect(r.reason).toBe('IMPOSSIBLE_TRAVEL_VELOCITY');
    });

    it('IP change at exactly 60s → valid', () => {
        const r = detectHijack(prev, { jwtId: 'j1', requestIp: '5.6.7.8', userAgent: 'Chrome', timestamp: 60000 });
        expect(r.isValid).toBe(true);
    });

    it('IP change >60s → valid', () => {
        const r = detectHijack(prev, { jwtId: 'j1', requestIp: '5.6.7.8', userAgent: 'Chrome', timestamp: 120000 });
        expect(r.isValid).toBe(true);
    });

    it('same IP rapid request → valid', () => {
        const r = detectHijack(prev, { jwtId: 'j1', requestIp: '1.2.3.4', userAgent: 'Chrome', timestamp: 5000 });
        expect(r.isValid).toBe(true);
    });
});

describe('Session Hijack — User Agent Mutation', () => {
    const prev: ActiveSessionData = { lastIp: '1.2.3.4', lastUserAgent: 'Chrome/100', lastSeen: 0 };

    it('agent change <60s → FINGERPRINT_MISMATCH', () => {
        const r = detectHijack(prev, { jwtId: 'j1', requestIp: '1.2.3.4', userAgent: 'Firefox/99', timestamp: 10000 });
        expect(r.isValid).toBe(false);
        expect(r.reason).toBe('BROWSER_FINGERPRINT_MISMATCH');
    });

    it('agent change at 60s → valid', () => {
        const r = detectHijack(prev, { jwtId: 'j1', requestIp: '1.2.3.4', userAgent: 'Firefox/99', timestamp: 60000 });
        expect(r.isValid).toBe(true);
    });

    it('same agent rapid → valid', () => {
        const r = detectHijack(prev, { jwtId: 'j1', requestIp: '1.2.3.4', userAgent: 'Chrome/100', timestamp: 5000 });
        expect(r.isValid).toBe(true);
    });
});

describe('Session Hijack — Both Mutated', () => {
    const prev: ActiveSessionData = { lastIp: '1.2.3.4', lastUserAgent: 'Chrome', lastSeen: 0 };

    it('both change <60s → IP check triggers first', () => {
        const r = detectHijack(prev, { jwtId: 'j1', requestIp: '9.9.9.9', userAgent: 'Safari', timestamp: 5000 });
        expect(r.isValid).toBe(false);
        expect(r.reason).toBe('IMPOSSIBLE_TRAVEL_VELOCITY');
    });

    it('both change >60s → valid', () => {
        const r = detectHijack(prev, { jwtId: 'j1', requestIp: '9.9.9.9', userAgent: 'Safari', timestamp: 120000 });
        expect(r.isValid).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Observability — Structured Logging (replicated from observability.ts)
// ═══════════════════════════════════════════════════════════════════════════

function buildLogEntry(reqId: string, method: string, path: string, status: number, durationMs: number) {
    return {
        ts: new Date().toISOString(),
        reqId,
        method,
        path,
        status,
        ms: durationMs,
        ...(status >= 400 ? { level: 'warn' } : { level: 'info' }),
    };
}

function resolveCorrelationId(headerValue: string | undefined): string {
    return headerValue || 'generated-uuid';
}

describe('Structured Logging', () => {
    it('info for 200', () => expect(buildLogEntry('r1', 'GET', '/users', 200, 50).level).toBe('info'));
    it('info for 201', () => expect(buildLogEntry('r1', 'POST', '/users', 201, 100).level).toBe('info'));
    it('info for 304', () => expect(buildLogEntry('r1', 'GET', '/cached', 304, 5).level).toBe('info'));
    it('warn for 400', () => expect(buildLogEntry('r1', 'POST', '/bad', 400, 10).level).toBe('warn'));
    it('warn for 401', () => expect(buildLogEntry('r1', 'GET', '/auth', 401, 5).level).toBe('warn'));
    it('warn for 403', () => expect(buildLogEntry('r1', 'GET', '/forbidden', 403, 5).level).toBe('warn'));
    it('warn for 404', () => expect(buildLogEntry('r1', 'GET', '/missing', 404, 5).level).toBe('warn'));
    it('warn for 429', () => expect(buildLogEntry('r1', 'POST', '/limit', 429, 5).level).toBe('warn'));
    it('warn for 500', () => expect(buildLogEntry('r1', 'GET', '/crash', 500, 5).level).toBe('warn'));
    it('reqId preserved', () => expect(buildLogEntry('abc', 'GET', '/', 200, 1).reqId).toBe('abc'));
    it('method preserved', () => expect(buildLogEntry('r1', 'POST', '/x', 200, 1).method).toBe('POST'));
    it('path preserved', () => expect(buildLogEntry('r1', 'GET', '/users/123', 200, 1).path).toBe('/users/123'));
    it('ms preserved', () => expect(buildLogEntry('r1', 'GET', '/', 200, 42).ms).toBe(42));
    it('has ts', () => expect(buildLogEntry('r1', 'GET', '/', 200, 1).ts).toBeTruthy());
});

describe('Correlation ID', () => {
    it('uses header when present', () => expect(resolveCorrelationId('req-abc')).toBe('req-abc'));
    it('generates when absent', () => expect(resolveCorrelationId(undefined)).toBe('generated-uuid'));
    it('empty string treated as truthy', () => expect(resolveCorrelationId('')).toBe('generated-uuid'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Financial Reporting Math (replicated from financial-reporting.ts)
// ═══════════════════════════════════════════════════════════════════════════

function calculateGrossProfit(revenue: number, directCosts: number): number {
    return revenue - directCosts;
}

function calculateGrossProfitMargin(revenue: number, directCosts: number): number {
    if (revenue === 0) return 0;
    return ((revenue - directCosts) / revenue) * 100;
}

function calculateNetIncome(grossProfit: number, operatingExpenses: number): number {
    return grossProfit - operatingExpenses;
}

function calculateNetTaxOwed(totalCollected: number, inputCredits: number): number {
    return totalCollected - inputCredits;
}

function isDirectExpense(code: string): boolean {
    return Number(code) < 5100;
}

function isIndirectExpense(code: string): boolean {
    return Number(code) >= 5100;
}

describe('Gross Profit', () => {
    it('basic calculation', () => expect(calculateGrossProfit(1000, 400)).toBe(600));
    it('zero revenue', () => expect(calculateGrossProfit(0, 0)).toBe(0));
    it('loss', () => expect(calculateGrossProfit(500, 800)).toBe(-300));
    it('no costs', () => expect(calculateGrossProfit(1000, 0)).toBe(1000));
});

describe('Gross Profit Margin', () => {
    it('60% margin', () => expect(calculateGrossProfitMargin(1000, 400)).toBe(60));
    it('100% margin', () => expect(calculateGrossProfitMargin(1000, 0)).toBe(100));
    it('0% margin', () => expect(calculateGrossProfitMargin(1000, 1000)).toBe(0));
    it('negative margin', () => expect(calculateGrossProfitMargin(500, 800)).toBe(-60));
    it('zero revenue → 0', () => expect(calculateGrossProfitMargin(0, 0)).toBe(0));
});

describe('Net Income', () => {
    it('positive', () => expect(calculateNetIncome(600, 200)).toBe(400));
    it('breakeven', () => expect(calculateNetIncome(300, 300)).toBe(0));
    it('loss', () => expect(calculateNetIncome(200, 500)).toBe(-300));
});

describe('Tax Filing — Net Tax Owed', () => {
    it('collected > credits', () => expect(calculateNetTaxOwed(1000, 300)).toBe(700));
    it('collected = credits', () => expect(calculateNetTaxOwed(500, 500)).toBe(0));
    it('credits > collected → refund', () => expect(calculateNetTaxOwed(200, 500)).toBe(-300));
});

describe('Expense Classification', () => {
    it('5000 is direct', () => expect(isDirectExpense('5000')).toBe(true));
    it('5099 is direct', () => expect(isDirectExpense('5099')).toBe(true));
    it('5100 is indirect', () => expect(isDirectExpense('5100')).toBe(false));
    it('5100 is indirect (fn)', () => expect(isIndirectExpense('5100')).toBe(true));
    it('5200 is indirect', () => expect(isIndirectExpense('5200')).toBe(true));
    it('5000 not indirect', () => expect(isIndirectExpense('5000')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Input Sanitization Methods (replicated from security.ts extended)
// ═══════════════════════════════════════════════════════════════════════════

function needsSanitization(method: string): boolean {
    return ['POST', 'PUT', 'PATCH'].includes(method);
}

function isJsonContentType(ct: string): boolean {
    return ct.includes('application/json');
}

describe('Sanitization Method Check', () => {
    it('POST needs sanitization', () => expect(needsSanitization('POST')).toBe(true));
    it('PUT needs sanitization', () => expect(needsSanitization('PUT')).toBe(true));
    it('PATCH needs sanitization', () => expect(needsSanitization('PATCH')).toBe(true));
    it('GET skips', () => expect(needsSanitization('GET')).toBe(false));
    it('DELETE skips', () => expect(needsSanitization('DELETE')).toBe(false));
    it('HEAD skips', () => expect(needsSanitization('HEAD')).toBe(false));
    it('OPTIONS skips', () => expect(needsSanitization('OPTIONS')).toBe(false));
});

describe('JSON Content Type Detection', () => {
    it('exact', () => expect(isJsonContentType('application/json')).toBe(true));
    it('with charset', () => expect(isJsonContentType('application/json; charset=utf-8')).toBe(true));
    it('text/plain', () => expect(isJsonContentType('text/plain')).toBe(false));
    it('multipart', () => expect(isJsonContentType('multipart/form-data')).toBe(false));
    it('empty', () => expect(isJsonContentType('')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 7. Advanced Encoding & Data Helpers
// ═══════════════════════════════════════════════════════════════════════════

function base64Encode(str: string): string {
    return btoa(str);
}

function base64Decode(encoded: string): string {
    return atob(encoded);
}

function safeParseJSON(str: string): any | null {
    try { return JSON.parse(str); }
    catch { return null; }
}

function deepClone<T>(obj: T): T {
    return JSON.parse(JSON.stringify(obj));
}

function omitKeys<T extends Record<string, any>>(obj: T, keys: string[]): Partial<T> {
    const result: any = {};
    for (const [k, v] of Object.entries(obj)) {
        if (!keys.includes(k)) result[k] = v;
    }
    return result;
}

function pickKeys<T extends Record<string, any>>(obj: T, keys: string[]): Partial<T> {
    const result: any = {};
    for (const k of keys) {
        if (k in obj) result[k] = obj[k];
    }
    return result;
}

describe('Base64 Encoding', () => {
    it('encode', () => expect(base64Encode('hello')).toBe('aGVsbG8='));
    it('decode', () => expect(base64Decode('aGVsbG8=')).toBe('hello'));
    it('roundtrip', () => expect(base64Decode(base64Encode('test123'))).toBe('test123'));
    it('empty string', () => expect(base64Encode('')).toBe(''));
});

describe('Safe JSON Parse', () => {
    it('valid JSON', () => expect(safeParseJSON('{"a":1}')).toEqual({ a: 1 }));
    it('invalid JSON returns null', () => expect(safeParseJSON('not json')).toBeNull());
    it('empty string returns null', () => expect(safeParseJSON('')).toBeNull());
    it('array JSON', () => expect(safeParseJSON('[1,2,3]')).toEqual([1, 2, 3]));
    it('number', () => expect(safeParseJSON('42')).toBe(42));
});

describe('Deep Clone', () => {
    it('clones object', () => {
        const orig = { a: 1, b: { c: 2 } };
        const clone = deepClone(orig);
        clone.b.c = 99;
        expect(orig.b.c).toBe(2);
    });
    it('clones array', () => {
        const orig = [1, [2, 3]];
        const clone = deepClone(orig);
        (clone[1] as number[])[0] = 99;
        expect((orig[1] as number[])[0]).toBe(2);
    });
});

describe('Object Key Utilities', () => {
    const obj = { name: 'John', email: 'j@t.com', password: 'secret', role: 'admin' };

    it('omit password', () => {
        const result = omitKeys(obj, ['password']);
        expect(result).not.toHaveProperty('password');
        expect(result).toHaveProperty('name');
    });
    it('omit multiple', () => {
        const result = omitKeys(obj, ['password', 'email']);
        expect(Object.keys(result)).toEqual(['name', 'role']);
    });
    it('pick name', () => {
        const result = pickKeys(obj, ['name']);
        expect(result).toEqual({ name: 'John' });
    });
    it('pick multiple', () => {
        const result = pickKeys(obj, ['name', 'role']);
        expect(result).toEqual({ name: 'John', role: 'admin' });
    });
    it('pick non-existent', () => {
        const result = pickKeys(obj, ['nonexistent']);
        expect(result).toEqual({});
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 8. Metrics & Aggregation Helpers
// ═══════════════════════════════════════════════════════════════════════════

function average(nums: number[]): number {
    if (nums.length === 0) return 0;
    return nums.reduce((a, b) => a + b, 0) / nums.length;
}

function median(nums: number[]): number {
    if (nums.length === 0) return 0;
    const sorted = [...nums].sort((a, b) => a - b);
    const mid = Math.floor(sorted.length / 2);
    return sorted.length % 2 === 0 ? (sorted[mid - 1] + sorted[mid]) / 2 : sorted[mid];
}

function percentile(nums: number[], p: number): number {
    if (nums.length === 0) return 0;
    const sorted = [...nums].sort((a, b) => a - b);
    const idx = Math.ceil((p / 100) * sorted.length) - 1;
    return sorted[Math.max(0, idx)];
}

function groupBy<T>(items: T[], key: keyof T): Record<string, T[]> {
    const result: Record<string, T[]> = {};
    for (const item of items) {
        const k = String(item[key]);
        (result[k] = result[k] || []).push(item);
    }
    return result;
}

function countBy<T>(items: T[], key: keyof T): Record<string, number> {
    const result: Record<string, number> = {};
    for (const item of items) {
        const k = String(item[key]);
        result[k] = (result[k] || 0) + 1;
    }
    return result;
}

describe('Average', () => {
    it('basic', () => expect(average([2, 4, 6])).toBe(4));
    it('single', () => expect(average([5])).toBe(5));
    it('empty', () => expect(average([])).toBe(0));
    it('decimals', () => expect(average([1, 2])).toBe(1.5));
});

describe('Median', () => {
    it('odd count', () => expect(median([1, 3, 5])).toBe(3));
    it('even count', () => expect(median([1, 2, 3, 4])).toBe(2.5));
    it('single', () => expect(median([7])).toBe(7));
    it('empty', () => expect(median([])).toBe(0));
    it('unsorted input', () => expect(median([5, 1, 3])).toBe(3));
});

describe('Percentile', () => {
    it('50th — median', () => expect(percentile([10, 20, 30, 40, 50], 50)).toBe(30));
    it('90th', () => expect(percentile([10, 20, 30, 40, 50, 60, 70, 80, 90, 100], 90)).toBe(90));
    it('100th', () => expect(percentile([10, 20, 30], 100)).toBe(30));
    it('empty', () => expect(percentile([], 50)).toBe(0));
});

describe('Group By', () => {
    const items = [
        { type: 'INVOICE', amount: 100 },
        { type: 'PAYMENT', amount: 50 },
        { type: 'INVOICE', amount: 200 },
    ];
    it('groups correctly', () => {
        const grouped = groupBy(items, 'type');
        expect(grouped['INVOICE'].length).toBe(2);
        expect(grouped['PAYMENT'].length).toBe(1);
    });
    it('empty', () => {
        expect(groupBy([], 'type' as any)).toEqual({});
    });
});

describe('Count By', () => {
    const items = [
        { status: 'active' }, { status: 'active' }, { status: 'blocked' },
    ];
    it('counts correctly', () => {
        const counts = countBy(items, 'status');
        expect(counts['active']).toBe(2);
        expect(counts['blocked']).toBe(1);
    });
    it('empty', () => {
        expect(countBy([], 'status' as any)).toEqual({});
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 9. Caching & TTL Helpers
// ═══════════════════════════════════════════════════════════════════════════

interface CacheEntry<T> { data: T; expiresAt: number; }

function isCacheValid<T>(entry: CacheEntry<T> | null, now: number): boolean {
    return entry !== null && entry.expiresAt > now;
}

function calculateExpirationTtl(windowSecs: number, bufferSecs: number = 10): number {
    return windowSecs + bufferSecs;
}

function buildCacheKey(...parts: string[]): string {
    return parts.join(':');
}

describe('Cache TTL', () => {
    it('valid cache', () => {
        expect(isCacheValid({ data: 'x', expiresAt: 2000 }, 1000)).toBe(true);
    });
    it('expired cache', () => {
        expect(isCacheValid({ data: 'x', expiresAt: 500 }, 1000)).toBe(false);
    });
    it('null cache', () => {
        expect(isCacheValid(null, 1000)).toBe(false);
    });
    it('exact expiry', () => {
        expect(isCacheValid({ data: 'x', expiresAt: 1000 }, 1000)).toBe(false);
    });
});

describe('TTL Calculation', () => {
    it('default buffer', () => expect(calculateExpirationTtl(60)).toBe(70));
    it('custom buffer', () => expect(calculateExpirationTtl(60, 5)).toBe(65));
    it('zero buffer', () => expect(calculateExpirationTtl(60, 0)).toBe(60));
});

describe('Cache Key Builder', () => {
    it('two parts', () => expect(buildCacheKey('rl', '1.2.3.4')).toBe('rl:1.2.3.4'));
    it('three parts', () => expect(buildCacheKey('tenant', 't-1', 'users')).toBe('tenant:t-1:users'));
    it('single part', () => expect(buildCacheKey('key')).toBe('key'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 10. HTTP Status Code Classification
// ═══════════════════════════════════════════════════════════════════════════

function isSuccessStatus(status: number): boolean { return status >= 200 && status < 300; }
function isClientError(status: number): boolean { return status >= 400 && status < 500; }
function isServerError(status: number): boolean { return status >= 500 && status < 600; }
function isRedirect(status: number): boolean { return status >= 300 && status < 400; }

describe('HTTP Status Classification', () => {
    it('200 is success', () => expect(isSuccessStatus(200)).toBe(true));
    it('201 is success', () => expect(isSuccessStatus(201)).toBe(true));
    it('204 is success', () => expect(isSuccessStatus(204)).toBe(true));
    it('299 is success', () => expect(isSuccessStatus(299)).toBe(true));
    it('300 not success', () => expect(isSuccessStatus(300)).toBe(false));
    it('400 is client error', () => expect(isClientError(400)).toBe(true));
    it('401 is client error', () => expect(isClientError(401)).toBe(true));
    it('403 is client error', () => expect(isClientError(403)).toBe(true));
    it('404 is client error', () => expect(isClientError(404)).toBe(true));
    it('429 is client error', () => expect(isClientError(429)).toBe(true));
    it('499 is client error', () => expect(isClientError(499)).toBe(true));
    it('500 is server error', () => expect(isServerError(500)).toBe(true));
    it('502 is server error', () => expect(isServerError(502)).toBe(true));
    it('503 is server error', () => expect(isServerError(503)).toBe(true));
    it('301 is redirect', () => expect(isRedirect(301)).toBe(true));
    it('302 is redirect', () => expect(isRedirect(302)).toBe(true));
    it('304 is redirect', () => expect(isRedirect(304)).toBe(true));
    it('200 not redirect', () => expect(isRedirect(200)).toBe(false));
    it('200 not client error', () => expect(isClientError(200)).toBe(false));
    it('200 not server error', () => expect(isServerError(200)).toBe(false));
});
