/**
 * Audit Chain, Location Auth & Data Validation Tests — Phase 30
 *
 * Self-contained replicas of logic from:
 * - audit-chain.ts: hash chain construction, genesis block, chain verification
 * - LocationGatedAuth.ts: role-based IP geofencing
 * - route_metadata.ts: route category resolution
 * - Additional: date range validation, enum guards, data mapping, batch ops
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Audit Chain — Hash Construction (replicated from audit-chain.ts)
// ═══════════════════════════════════════════════════════════════════════════

function buildHashInput(previousChecksum: string, operation: string, modelName: string, entityId: string, payload: string, timestamp: string): string {
    return [previousChecksum, operation, modelName, entityId, payload, timestamp].join('|');
}

function resolveGenesisChecksum(lastChecksum: string | null | undefined): string {
    return lastChecksum || 'GENESIS';
}

function serializePayload(payload: any): string {
    return payload ? JSON.stringify(payload) : '';
}

function isChainBroken(previousChecksum: string, expectedChecksum: string): boolean {
    return previousChecksum !== expectedChecksum;
}

describe('Audit Chain — Hash Input', () => {
    it('builds delimited input', () => {
        const result = buildHashInput('abc', 'CREATE', 'User', 'u-1', '{}', '2026-01-01');
        expect(result).toBe('abc|CREATE|User|u-1|{}|2026-01-01');
    });
    it('empty fields', () => {
        const result = buildHashInput('GENESIS', 'UPDATE', 'Visit', '', '', '2026-01-01');
        expect(result).toBe('GENESIS|UPDATE|Visit|||2026-01-01');
    });
});

describe('Audit Chain — Genesis', () => {
    it('returns checksum when present', () => expect(resolveGenesisChecksum('abc123')).toBe('abc123'));
    it('null = GENESIS', () => expect(resolveGenesisChecksum(null)).toBe('GENESIS'));
    it('undefined = GENESIS', () => expect(resolveGenesisChecksum(undefined)).toBe('GENESIS'));
    it('empty string = GENESIS', () => expect(resolveGenesisChecksum('')).toBe('GENESIS'));
});

describe('Audit Chain — Serialize Payload', () => {
    it('object', () => expect(serializePayload({ name: 'test' })).toBe('{"name":"test"}'));
    it('null = empty', () => expect(serializePayload(null)).toBe(''));
    it('undefined = empty', () => expect(serializePayload(undefined)).toBe(''));
    it('array', () => expect(serializePayload([1, 2])).toBe('[1,2]'));
});

describe('Audit Chain — Break Detection', () => {
    it('matching = not broken', () => expect(isChainBroken('abc', 'abc')).toBe(false));
    it('mismatch = broken', () => expect(isChainBroken('abc', 'xyz')).toBe(true));
    it('genesis match', () => expect(isChainBroken('GENESIS', 'GENESIS')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Audit Chain — Chain Verification (replicated from audit-chain.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface ChainEntry {
    id: string;
    checksum: string;
    previousChecksum: string;
}

function verifyChainIntegrity(entries: ChainEntry[]): { valid: boolean; brokenAt?: number } {
    if (entries.length === 0) return { valid: true };
    let expectedPrev = 'GENESIS';
    for (let i = 0; i < entries.length; i++) {
        if (!entries[i].checksum) { expectedPrev = entries[i].checksum || ''; continue; }
        if (entries[i].previousChecksum !== expectedPrev) {
            return { valid: false, brokenAt: i };
        }
        expectedPrev = entries[i].checksum;
    }
    return { valid: true };
}

describe('Chain Verification', () => {
    it('empty chain valid', () => {
        expect(verifyChainIntegrity([]).valid).toBe(true);
    });
    it('valid chain', () => {
        const entries: ChainEntry[] = [
            { id: '1', checksum: 'a', previousChecksum: 'GENESIS' },
            { id: '2', checksum: 'b', previousChecksum: 'a' },
            { id: '3', checksum: 'c', previousChecksum: 'b' },
        ];
        expect(verifyChainIntegrity(entries).valid).toBe(true);
    });
    it('broken chain', () => {
        const entries: ChainEntry[] = [
            { id: '1', checksum: 'a', previousChecksum: 'GENESIS' },
            { id: '2', checksum: 'b', previousChecksum: 'WRONG' },
        ];
        const result = verifyChainIntegrity(entries);
        expect(result.valid).toBe(false);
        expect(result.brokenAt).toBe(1);
    });
    it('single entry valid', () => {
        expect(verifyChainIntegrity([{ id: '1', checksum: 'a', previousChecksum: 'GENESIS' }]).valid).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Location-Gated Auth (replicated from LocationGatedAuth.ts)
// ═══════════════════════════════════════════════════════════════════════════

type AuthRole = 'PSW' | 'RN' | 'COORDINATOR' | 'MANAGER' | 'ADMIN' | 'FINANCE';

const HQ_ALLOWED_IPS = ['192.168.1.50', '203.0.113.42', '10.0.0.0/24'];

function isFieldRole(role: AuthRole): boolean {
    return ['PSW', 'RN', 'COORDINATOR', 'MANAGER'].includes(role);
}

function isHighPrivilegeRole(role: AuthRole): boolean {
    return ['ADMIN', 'FINANCE'].includes(role);
}

function enforceLocationPolicy(role: AuthRole, requestIp: string, allowedIps: string[]): boolean {
    if (isFieldRole(role)) return true;
    return allowedIps.includes(requestIp);
}

describe('Location Auth — Field Roles', () => {
    it('PSW allowed anywhere', () => expect(isFieldRole('PSW')).toBe(true));
    it('RN allowed anywhere', () => expect(isFieldRole('RN')).toBe(true));
    it('COORDINATOR allowed', () => expect(isFieldRole('COORDINATOR')).toBe(true));
    it('MANAGER allowed', () => expect(isFieldRole('MANAGER')).toBe(true));
    it('ADMIN not field', () => expect(isFieldRole('ADMIN')).toBe(false));
    it('FINANCE not field', () => expect(isFieldRole('FINANCE')).toBe(false));
});

describe('Location Auth — High Privilege', () => {
    it('ADMIN', () => expect(isHighPrivilegeRole('ADMIN')).toBe(true));
    it('FINANCE', () => expect(isHighPrivilegeRole('FINANCE')).toBe(true));
    it('PSW', () => expect(isHighPrivilegeRole('PSW')).toBe(false));
    it('MANAGER', () => expect(isHighPrivilegeRole('MANAGER')).toBe(false));
});

describe('Location Auth — Policy Enforcement', () => {
    it('PSW bypasses', () => expect(enforceLocationPolicy('PSW', '1.2.3.4', HQ_ALLOWED_IPS)).toBe(true));
    it('ADMIN allowed IP', () => expect(enforceLocationPolicy('ADMIN', '192.168.1.50', HQ_ALLOWED_IPS)).toBe(true));
    it('ADMIN denied IP', () => expect(enforceLocationPolicy('ADMIN', '1.2.3.4', HQ_ALLOWED_IPS)).toBe(false));
    it('FINANCE allowed IP', () => expect(enforceLocationPolicy('FINANCE', '203.0.113.42', HQ_ALLOWED_IPS)).toBe(true));
    it('FINANCE denied', () => expect(enforceLocationPolicy('FINANCE', '172.16.0.1', HQ_ALLOWED_IPS)).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Route Metadata Categories
// ═══════════════════════════════════════════════════════════════════════════

type RouteCategory = 'ADMIN' | 'AUTH' | 'USER' | 'MANAGER' | 'PSW' | 'SYSTEM' | 'STAFF' | 'RN' | 'CLIENT' | 'COORDINATOR';

function resolveRouteCategory(path: string): RouteCategory {
    if (path.startsWith('/v1/auth/')) return 'AUTH';
    if (path.startsWith('/v1/admin/')) return 'ADMIN';
    if (path.includes('/manager/')) return 'MANAGER';
    if (path.includes('/psw/')) return 'PSW';
    if (path.includes('/staff/')) return 'STAFF';
    if (path.includes('/rn/')) return 'RN';
    if (path.includes('/client/')) return 'CLIENT';
    if (path.includes('/coordinator/')) return 'COORDINATOR';
    if (path.includes('/system/')) return 'SYSTEM';
    return 'USER';
}

function isProtectedRoute(path: string): boolean {
    return !path.startsWith('/v1/auth/') && !path.startsWith('/v1/public/') && path !== '/v1/health';
}

describe('Route Category', () => {
    it('auth', () => expect(resolveRouteCategory('/v1/auth/login')).toBe('AUTH'));
    it('admin', () => expect(resolveRouteCategory('/v1/admin/users')).toBe('ADMIN'));
    it('manager', () => expect(resolveRouteCategory('/v1/manager/home')).toBe('MANAGER'));
    it('psw', () => expect(resolveRouteCategory('/v1/psw/schedule')).toBe('PSW'));
    it('staff', () => expect(resolveRouteCategory('/v1/staff/list')).toBe('STAFF'));
    it('rn', () => expect(resolveRouteCategory('/v1/rn/clinical')).toBe('RN'));
    it('client', () => expect(resolveRouteCategory('/v1/client/profile')).toBe('CLIENT'));
    it('coordinator', () => expect(resolveRouteCategory('/v1/coordinator/visits')).toBe('COORDINATOR'));
    it('system', () => expect(resolveRouteCategory('/v1/system/events')).toBe('SYSTEM'));
    it('default user', () => expect(resolveRouteCategory('/v1/users/me')).toBe('USER'));
});

describe('Route Protection', () => {
    it('auth not protected', () => expect(isProtectedRoute('/v1/auth/login')).toBe(false));
    it('public not protected', () => expect(isProtectedRoute('/v1/public/info')).toBe(false));
    it('health not protected', () => expect(isProtectedRoute('/v1/health')).toBe(false));
    it('admin protected', () => expect(isProtectedRoute('/v1/admin/users')).toBe(true));
    it('clients protected', () => expect(isProtectedRoute('/v1/clients')).toBe(true));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Date Range & Period Validation
// ═══════════════════════════════════════════════════════════════════════════

function isValidDateRange(start: Date, end: Date): boolean {
    return start <= end;
}

function daysBetween(start: Date, end: Date): number {
    return Math.floor((end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24));
}

function isWithinMaxRange(start: Date, end: Date, maxDays: number): boolean {
    return daysBetween(start, end) <= maxDays;
}

function getQuarter(date: Date): number {
    return Math.ceil((date.getMonth() + 1) / 3);
}

function getStartOfDay(date: Date): Date {
    const d = new Date(date);
    d.setHours(0, 0, 0, 0);
    return d;
}

function getEndOfDay(date: Date): Date {
    const d = new Date(date);
    d.setHours(23, 59, 59, 999);
    return d;
}

describe('Date Range Validation', () => {
    it('valid range', () => expect(isValidDateRange(new Date('2026-01-01'), new Date('2026-12-31'))).toBe(true));
    it('same day', () => expect(isValidDateRange(new Date('2026-06-15'), new Date('2026-06-15'))).toBe(true));
    it('invalid range', () => expect(isValidDateRange(new Date('2026-12-31'), new Date('2026-01-01'))).toBe(false));
});

describe('Days Between', () => {
    it('30 days', () => expect(daysBetween(new Date('2026-01-01'), new Date('2026-01-31'))).toBe(30));
    it('0 days', () => expect(daysBetween(new Date('2026-01-01'), new Date('2026-01-01'))).toBe(0));
    it('365 days', () => expect(daysBetween(new Date('2026-01-01'), new Date('2027-01-01'))).toBe(365));
});

describe('Within Max Range', () => {
    it('within', () => expect(isWithinMaxRange(new Date('2026-01-01'), new Date('2026-01-31'), 90)).toBe(true));
    it('exceeds', () => expect(isWithinMaxRange(new Date('2026-01-01'), new Date('2027-01-01'), 90)).toBe(false));
});

describe('Quarter', () => {
    it('Jan = Q1', () => expect(getQuarter(new Date('2026-01-15'))).toBe(1));
    it('Apr = Q2', () => expect(getQuarter(new Date('2026-04-15'))).toBe(2));
    it('Jul = Q3', () => expect(getQuarter(new Date('2026-07-15'))).toBe(3));
    it('Oct = Q4', () => expect(getQuarter(new Date('2026-10-15'))).toBe(4));
    it('Dec = Q4', () => expect(getQuarter(new Date('2026-12-31'))).toBe(4));
});

describe('Start/End of Day', () => {
    it('start of day', () => {
        const d = getStartOfDay(new Date('2026-06-15T14:30:00'));
        expect(d.getHours()).toBe(0);
        expect(d.getMinutes()).toBe(0);
    });
    it('end of day', () => {
        const d = getEndOfDay(new Date('2026-06-15T14:30:00'));
        expect(d.getHours()).toBe(23);
        expect(d.getMinutes()).toBe(59);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Enum Guards & Type Validation
// ═══════════════════════════════════════════════════════════════════════════

const VALID_OPERATIONS = ['CREATE', 'UPDATE', 'DELETE', 'UPSERT'] as const;
type Operation = typeof VALID_OPERATIONS[number];

function isValidOperation(op: string): op is Operation {
    return (VALID_OPERATIONS as readonly string[]).includes(op);
}

const VALID_ACCOUNT_TYPES = ['ASSET', 'LIABILITY', 'EQUITY', 'REVENUE', 'EXPENSE'] as const;

function isValidAccountType(type: string): boolean {
    return (VALID_ACCOUNT_TYPES as readonly string[]).includes(type);
}

const VALID_STATUSES = ['draft', 'posted', 'paid', 'cancelled', 'void'] as const;

function isValidInvoiceStatus(status: string): boolean {
    return (VALID_STATUSES as readonly string[]).includes(status);
}

function canTransition(from: string, to: string): boolean {
    const transitions: Record<string, string[]> = {
        draft: ['posted', 'cancelled'],
        posted: ['paid', 'void'],
        paid: [],
        cancelled: [],
        void: [],
    };
    return transitions[from]?.includes(to) ?? false;
}

describe('Enum — Operations', () => {
    it('CREATE', () => expect(isValidOperation('CREATE')).toBe(true));
    it('UPDATE', () => expect(isValidOperation('UPDATE')).toBe(true));
    it('DELETE', () => expect(isValidOperation('DELETE')).toBe(true));
    it('UPSERT', () => expect(isValidOperation('UPSERT')).toBe(true));
    it('READ invalid', () => expect(isValidOperation('READ')).toBe(false));
});

describe('Enum — Account Types', () => {
    it('ASSET', () => expect(isValidAccountType('ASSET')).toBe(true));
    it('REVENUE', () => expect(isValidAccountType('REVENUE')).toBe(true));
    it('UNKNOWN', () => expect(isValidAccountType('UNKNOWN')).toBe(false));
});

describe('Enum — Invoice Status', () => {
    it('draft', () => expect(isValidInvoiceStatus('draft')).toBe(true));
    it('posted', () => expect(isValidInvoiceStatus('posted')).toBe(true));
    it('paid', () => expect(isValidInvoiceStatus('paid')).toBe(true));
    it('cancelled', () => expect(isValidInvoiceStatus('cancelled')).toBe(true));
    it('void', () => expect(isValidInvoiceStatus('void')).toBe(true));
    it('invalid', () => expect(isValidInvoiceStatus('pending')).toBe(false));
});

describe('Status Transitions', () => {
    it('draft -> posted', () => expect(canTransition('draft', 'posted')).toBe(true));
    it('draft -> cancelled', () => expect(canTransition('draft', 'cancelled')).toBe(true));
    it('posted -> paid', () => expect(canTransition('posted', 'paid')).toBe(true));
    it('posted -> void', () => expect(canTransition('posted', 'void')).toBe(true));
    it('paid -> void denied', () => expect(canTransition('paid', 'void')).toBe(false));
    it('cancelled -> posted denied', () => expect(canTransition('cancelled', 'posted')).toBe(false));
    it('unknown status', () => expect(canTransition('unknown', 'posted')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 7. Batch Operations & Data Mapping
// ═══════════════════════════════════════════════════════════════════════════

function chunkArray<T>(arr: T[], size: number): T[][] {
    const chunks: T[][] = [];
    for (let i = 0; i < arr.length; i += size) {
        chunks.push(arr.slice(i, i + size));
    }
    return chunks;
}

function uniqueBy<T>(arr: T[], key: keyof T): T[] {
    const seen = new Set();
    return arr.filter(item => {
        const val = item[key];
        if (seen.has(val)) return false;
        seen.add(val);
        return true;
    });
}

function groupBy<T>(arr: T[], key: keyof T): Record<string, T[]> {
    return arr.reduce((acc, item) => {
        const group = String(item[key]);
        (acc[group] = acc[group] || []).push(item);
        return acc;
    }, {} as Record<string, T[]>);
}

function sumBy<T>(arr: T[], key: keyof T): number {
    return arr.reduce((sum, item) => sum + Number(item[key]), 0);
}

describe('Batch — Chunk Array', () => {
    it('even split', () => expect(chunkArray([1,2,3,4], 2)).toEqual([[1,2],[3,4]]));
    it('uneven split', () => expect(chunkArray([1,2,3,4,5], 2)).toEqual([[1,2],[3,4],[5]]));
    it('single chunk', () => expect(chunkArray([1,2], 5)).toEqual([[1,2]]));
    it('empty', () => expect(chunkArray([], 2)).toEqual([]));
});

describe('Batch — Unique By', () => {
    it('deduplicates', () => {
        const items = [{ id: 1, name: 'A' }, { id: 2, name: 'B' }, { id: 1, name: 'C' }];
        expect(uniqueBy(items, 'id').length).toBe(2);
    });
    it('all unique', () => {
        const items = [{ id: 1 }, { id: 2 }, { id: 3 }];
        expect(uniqueBy(items, 'id').length).toBe(3);
    });
});

describe('Batch — Group By', () => {
    it('groups', () => {
        const items = [{ type: 'A', val: 1 }, { type: 'B', val: 2 }, { type: 'A', val: 3 }];
        const groups = groupBy(items, 'type');
        expect(groups['A'].length).toBe(2);
        expect(groups['B'].length).toBe(1);
    });
});

describe('Batch — Sum By', () => {
    it('sums values', () => {
        const items = [{ amount: 100 }, { amount: 200 }, { amount: 50 }];
        expect(sumBy(items, 'amount')).toBe(350);
    });
    it('empty', () => expect(sumBy([], 'amount' as any)).toBe(0));
});
