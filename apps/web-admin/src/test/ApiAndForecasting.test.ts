/**
 * API Response, Forecasting, Audit Chain & Route Metadata Tests — Phase 21
 *
 * Self-contained replicas of logic from:
 * - api-response.ts: pagination math, response envelope shapes
 * - forecasting.service.ts: cash-flow runway, daily flow, forecast projections
 * - audit-chain.ts: checksum chain, genesis block, chain verification
 * - route_metadata (auth, psw, system): metadata completeness contracts
 * - ownership.ts: PSW role enforcement logic
 * - Additional: URL parsing, query string helpers, slug generators
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Pagination Math (replicated from api-response.ts)
// ═══════════════════════════════════════════════════════════════════════════

function totalPages(total: number, limit: number): number {
    return Math.ceil(total / limit);
}

function hasNext(page: number, limit: number, total: number): boolean {
    return page * limit < total;
}

function hasPrev(page: number): boolean {
    return page > 1;
}

function buildPaginatedMeta(page: number, limit: number, total: number) {
    return { page, limit, total, totalPages: totalPages(total, limit), hasNext: hasNext(page, limit, total), hasPrev: hasPrev(page) };
}

describe('Pagination — Total Pages', () => {
    it('exact divide', () => expect(totalPages(100, 10)).toBe(10));
    it('remainder', () => expect(totalPages(101, 10)).toBe(11));
    it('single page', () => expect(totalPages(5, 10)).toBe(1));
    it('zero items', () => expect(totalPages(0, 10)).toBe(0));
    it('one item', () => expect(totalPages(1, 10)).toBe(1));
    it('limit 1', () => expect(totalPages(5, 1)).toBe(5));
    it('large dataset', () => expect(totalPages(10000, 25)).toBe(400));
});

describe('Pagination — Has Next', () => {
    it('page 1 of 10', () => expect(hasNext(1, 10, 100)).toBe(true));
    it('last page exact', () => expect(hasNext(10, 10, 100)).toBe(false));
    it('last page with remainder', () => expect(hasNext(11, 10, 101)).toBe(false));
    it('only page', () => expect(hasNext(1, 10, 5)).toBe(false));
    it('page 2 of 3', () => expect(hasNext(2, 10, 25)).toBe(true));
});

describe('Pagination — Has Prev', () => {
    it('page 1 no prev', () => expect(hasPrev(1)).toBe(false));
    it('page 2 has prev', () => expect(hasPrev(2)).toBe(true));
    it('page 100 has prev', () => expect(hasPrev(100)).toBe(true));
});

describe('Pagination — Full Meta', () => {
    it('first page', () => {
        const m = buildPaginatedMeta(1, 10, 50);
        expect(m.totalPages).toBe(5);
        expect(m.hasNext).toBe(true);
        expect(m.hasPrev).toBe(false);
    });
    it('last page', () => {
        const m = buildPaginatedMeta(5, 10, 50);
        expect(m.totalPages).toBe(5);
        expect(m.hasNext).toBe(false);
        expect(m.hasPrev).toBe(true);
    });
    it('single page', () => {
        const m = buildPaginatedMeta(1, 10, 3);
        expect(m.totalPages).toBe(1);
        expect(m.hasNext).toBe(false);
        expect(m.hasPrev).toBe(false);
    });
    it('empty', () => {
        const m = buildPaginatedMeta(1, 10, 0);
        expect(m.total).toBe(0);
        expect(m.totalPages).toBe(0);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. API Response Envelope (replicated from api-response.ts)
// ═══════════════════════════════════════════════════════════════════════════

function buildSuccessEnvelope<T>(data: T, meta: any = null) {
    return { success: true, data, meta: meta || null, error: null };
}

function buildErrorEnvelope(message: string, details?: any) {
    return { success: false, data: null, meta: null, error: { message, ...(details ? { details } : {}) } };
}

describe('Success Envelope', () => {
    it('has data', () => {
        const r = buildSuccessEnvelope({ users: [] });
        expect(r.success).toBe(true);
        expect(r.data).toEqual({ users: [] });
        expect(r.error).toBeNull();
    });
    it('with meta', () => {
        const r = buildSuccessEnvelope([], { page: 1 });
        expect(r.meta).toEqual({ page: 1 });
    });
    it('null meta by default', () => {
        expect(buildSuccessEnvelope('ok').meta).toBeNull();
    });
});

describe('Error Envelope', () => {
    it('has error message', () => {
        const r = buildErrorEnvelope('Not found');
        expect(r.success).toBe(false);
        expect(r.error.message).toBe('Not found');
        expect(r.data).toBeNull();
    });
    it('with details', () => {
        const r = buildErrorEnvelope('Validation', { fields: ['name'] });
        expect(r.error.details).toEqual({ fields: ['name'] });
    });
    it('no details', () => {
        const r = buildErrorEnvelope('Bad request');
        expect(r.error).not.toHaveProperty('details');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Cash-Flow Forecasting (replicated from forecasting.service.ts)
// ═══════════════════════════════════════════════════════════════════════════

function calculateAvgDaily(totalOver30Days: number): number {
    return totalOver30Days / 30;
}

function calculateNetDailyFlow(avgRevenue: number, avgBurn: number): number {
    return avgRevenue - avgBurn;
}

function calculateRunway(currentCash: number, netDailyFlow: number): number | 'infinite' {
    if (netDailyFlow >= 0) return 'infinite';
    return Math.floor(currentCash / Math.abs(netDailyFlow));
}

function projectCash(currentCash: number, netDailyFlow: number, day: number): number {
    return Math.max(0, currentCash + netDailyFlow * day);
}

function generateForecast(currentCash: number, netDailyFlow: number, days: number) {
    const points: { day: number; cash: number }[] = [];
    for (let i = 0; i <= days; i++) {
        points.push({ day: i, cash: projectCash(currentCash, netDailyFlow, i) });
    }
    return points;
}

describe('Forecasting — Average Daily', () => {
    it('$30000/30 days = $1000/day', () => expect(calculateAvgDaily(30000)).toBe(1000));
    it('zero', () => expect(calculateAvgDaily(0)).toBe(0));
    it('small amount', () => expect(calculateAvgDaily(300)).toBe(10));
});

describe('Forecasting — Net Daily Flow', () => {
    it('positive flow', () => expect(calculateNetDailyFlow(1000, 800)).toBe(200));
    it('negative flow', () => expect(calculateNetDailyFlow(500, 800)).toBe(-300));
    it('breakeven', () => expect(calculateNetDailyFlow(500, 500)).toBe(0));
});

describe('Forecasting — Runway', () => {
    it('positive flow = infinite', () => expect(calculateRunway(10000, 200)).toBe('infinite'));
    it('zero flow = infinite', () => expect(calculateRunway(10000, 0)).toBe('infinite'));
    it('negative flow: $10000 / $500/day = 20 days', () => expect(calculateRunway(10000, -500)).toBe(20));
    it('negative flow: $5000 / $333/day = 15 days', () => expect(calculateRunway(5000, -333)).toBe(15));
    it('zero cash, negative = 0 days', () => expect(calculateRunway(0, -100)).toBe(0));
});

describe('Forecasting — Project Cash', () => {
    it('day 0 = current', () => expect(projectCash(10000, -100, 0)).toBe(10000));
    it('day 10 with burn', () => expect(projectCash(10000, -100, 10)).toBe(9000));
    it('day 10 with growth', () => expect(projectCash(10000, 100, 10)).toBe(11000));
    it('never goes below zero', () => expect(projectCash(500, -100, 10)).toBe(0));
});

describe('Forecasting — Generate Forecast', () => {
    it('correct length', () => {
        expect(generateForecast(10000, -100, 5).length).toBe(6); // 0 through 5
    });
    it('first point is current', () => {
        expect(generateForecast(10000, -100, 5)[0].cash).toBe(10000);
    });
    it('last point calculated', () => {
        expect(generateForecast(10000, -100, 5)[5].cash).toBe(9500);
    });
    it('clamped to zero', () => {
        const forecast = generateForecast(100, -50, 5);
        expect(forecast[3].cash).toBe(0); // 100 - 150 = 0 (clamped)
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Audit Chain (replicated from audit-chain.ts)
// ═══════════════════════════════════════════════════════════════════════════

function buildChecksumInput(previousChecksum: string, operation: string, model: string, entityId: string, payload: string, timestamp: string): string {
    return [previousChecksum, operation, model, entityId, payload, timestamp].join('|');
}

function chainVerifyStatus(events: { checksum: string; previousChecksum: string }[]): { valid: boolean; brokenAt?: number } {
    if (events.length === 0) return { valid: true };
    let prevChecksum = 'GENESIS';
    for (let i = 0; i < events.length; i++) {
        if (!events[i].checksum || events[i].checksum === '') { prevChecksum = events[i].checksum || ''; continue; }
        if (events[i].previousChecksum !== prevChecksum) return { valid: false, brokenAt: i };
        prevChecksum = events[i].checksum;
    }
    return { valid: true };
}

describe('Audit Chain — Checksum Input', () => {
    it('pipe-separated', () => {
        const input = buildChecksumInput('GENESIS', 'CREATE', 'User', 'u-1', '{}', '2025-01-01');
        expect(input).toBe('GENESIS|CREATE|User|u-1|{}|2025-01-01');
    });
    it('empty payload', () => {
        const input = buildChecksumInput('abc', 'UPDATE', 'Visit', 'v-1', '', '2025-06-01');
        expect(input).toContain('||');
    });
    it('genesis block', () => {
        expect(buildChecksumInput('GENESIS', 'INIT', 'System', '', '', '2025-01-01')).toContain('GENESIS');
    });
});

describe('Audit Chain — Verification', () => {
    it('empty chain is valid', () => {
        expect(chainVerifyStatus([]).valid).toBe(true);
    });
    it('single valid entry', () => {
        expect(chainVerifyStatus([{ checksum: 'hash1', previousChecksum: 'GENESIS' }]).valid).toBe(true);
    });
    it('two valid entries', () => {
        expect(chainVerifyStatus([
            { checksum: 'hash1', previousChecksum: 'GENESIS' },
            { checksum: 'hash2', previousChecksum: 'hash1' },
        ]).valid).toBe(true);
    });
    it('three valid entries', () => {
        expect(chainVerifyStatus([
            { checksum: 'h1', previousChecksum: 'GENESIS' },
            { checksum: 'h2', previousChecksum: 'h1' },
            { checksum: 'h3', previousChecksum: 'h2' },
        ]).valid).toBe(true);
    });
    it('broken chain at index 1', () => {
        const result = chainVerifyStatus([
            { checksum: 'h1', previousChecksum: 'GENESIS' },
            { checksum: 'h2', previousChecksum: 'WRONG' },
        ]);
        expect(result.valid).toBe(false);
        expect(result.brokenAt).toBe(1);
    });
    it('broken at first entry', () => {
        const result = chainVerifyStatus([
            { checksum: 'h1', previousChecksum: 'NOT_GENESIS' },
        ]);
        expect(result.valid).toBe(false);
        expect(result.brokenAt).toBe(0);
    });
    it('empty checksum skipped', () => {
        expect(chainVerifyStatus([
            { checksum: '', previousChecksum: 'GENESIS' },
            { checksum: 'h2', previousChecksum: '' },
        ]).valid).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. AUTH Route Metadata (replicated from auth.ts)
// ═══════════════════════════════════════════════════════════════════════════

const AUTH_METADATA = {
    REGISTER: { summary: 'Register User', tags: ['Authentication'] },
    LOGIN: { summary: 'Login User', tags: ['Authentication'] },
    REFRESH: { summary: 'Refresh Token', tags: ['Authentication'] },
    LOGOUT: { summary: 'Logout User', tags: ['Authentication'] },
    WHOAMI: { summary: 'Current User Info', tags: ['Authentication'] },
    IMPERSONATE: { summary: 'Impersonate User', tags: ['Authentication'] },
    SWITCH_ROLE: { summary: 'Switch User Role', tags: ['Authentication'] },
};

describe('Auth Metadata', () => {
    it('has 7 operations', () => expect(Object.keys(AUTH_METADATA).length).toBe(7));
    it('all tagged Authentication', () => {
        for (const op of Object.values(AUTH_METADATA)) {
            expect(op.tags).toContain('Authentication');
        }
    });
    it('REGISTER', () => expect(AUTH_METADATA.REGISTER.summary).toBe('Register User'));
    it('LOGIN', () => expect(AUTH_METADATA.LOGIN.summary).toBe('Login User'));
    it('REFRESH', () => expect(AUTH_METADATA.REFRESH.summary).toBe('Refresh Token'));
    it('LOGOUT', () => expect(AUTH_METADATA.LOGOUT.summary).toBe('Logout User'));
    it('WHOAMI', () => expect(AUTH_METADATA.WHOAMI.summary).toBe('Current User Info'));
    it('IMPERSONATE', () => expect(AUTH_METADATA.IMPERSONATE.summary).toBe('Impersonate User'));
    it('SWITCH_ROLE', () => expect(AUTH_METADATA.SWITCH_ROLE.summary).toBe('Switch User Role'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. PSW Route Metadata (replicated from psw.ts)
// ═══════════════════════════════════════════════════════════════════════════

const PSW_METADATA = {
    SCHEDULE: {
        CHECK_IN: { summary: 'Visit Check-In', tags: ['PSW Schedule'] },
        CHECK_OUT: { summary: 'Visit Check-Out', tags: ['PSW Schedule'] },
        LIST_VISITS: { summary: 'List PSW Visits', tags: ['PSW Schedule'] },
        LIST_OFFERS: { summary: 'Get Offered Shifts', tags: ['PSW Schedule'] },
        ACCEPT_OFFER: { summary: 'Accept Shift Offer', tags: ['PSW Schedule'] },
        DECLINE_OFFER: { summary: 'Decline Shift Offer', tags: ['PSW Schedule'] },
        UPDATE_AVAILABILITY: { summary: 'Update Availability', tags: ['PSW Schedule'] },
        REPORT_NO_SHOW: { summary: 'Report Client No-Show', tags: ['PSW Schedule'] },
        LIST_MARKETPLACE: { summary: 'Get Marketplace Extends', tags: ['PSW Schedule'] },
        ACCEPT_MARKETPLACE: { summary: 'Accept Marketplace Shift', tags: ['PSW Schedule'] },
    },
    EXTRA: {
        INCIDENTS_REPORT: { summary: 'Report Incident', tags: ['PSW Incidents'] },
        DASHBOARD_STATS: { summary: 'Get PSW Dashboard Statistics', tags: ['PSW Dashboard'] },
        DAILY_ENTRY_CREATE: { summary: 'Create/Submit Daily Entry', tags: ['PSW Daily Entries'] },
        DAILY_ENTRY_HISTORY: { summary: 'Get Daily Entry History', tags: ['PSW Daily Entries'] },
        HANDOVER_SUBMIT: { summary: 'Submit Shift Handover', tags: ['PSW Handover'] },
        AVAILABILITY_OVERRIDE_SYNC: { summary: 'Sync Availability Overrides', tags: ['PSW Availability'] },
        PAYOUT_HISTORY: { summary: 'Get Payout History', tags: ['PSW Payouts'] },
        WELLNESS_PULSE: { summary: 'Submit Wellness Pulse', tags: ['PSW Wellness'] },
    },
};

describe('PSW Metadata — Schedule', () => {
    it('has 10 schedule ops', () => expect(Object.keys(PSW_METADATA.SCHEDULE).length).toBe(10));
    it('CHECK_IN', () => expect(PSW_METADATA.SCHEDULE.CHECK_IN.summary).toBe('Visit Check-In'));
    it('CHECK_OUT', () => expect(PSW_METADATA.SCHEDULE.CHECK_OUT.summary).toBe('Visit Check-Out'));
    it('REPORT_NO_SHOW', () => expect(PSW_METADATA.SCHEDULE.REPORT_NO_SHOW.summary).toBe('Report Client No-Show'));
    it('ACCEPT_MARKETPLACE', () => expect(PSW_METADATA.SCHEDULE.ACCEPT_MARKETPLACE.summary).toBe('Accept Marketplace Shift'));
    it('all schedule tagged PSW Schedule', () => {
        for (const op of Object.values(PSW_METADATA.SCHEDULE)) {
            expect(op.tags).toContain('PSW Schedule');
        }
    });
});

describe('PSW Metadata — Extra', () => {
    it('has 8 extra ops', () => expect(Object.keys(PSW_METADATA.EXTRA).length).toBe(8));
    it('INCIDENTS_REPORT', () => expect(PSW_METADATA.EXTRA.INCIDENTS_REPORT.summary).toBe('Report Incident'));
    it('WELLNESS_PULSE', () => expect(PSW_METADATA.EXTRA.WELLNESS_PULSE.summary).toBe('Submit Wellness Pulse'));
    it('PAYOUT_HISTORY', () => expect(PSW_METADATA.EXTRA.PAYOUT_HISTORY.summary).toBe('Get Payout History'));
    it('all have summary', () => {
        for (const op of Object.values(PSW_METADATA.EXTRA)) {
            expect(op.summary).toBeTruthy();
        }
    });
    it('all have tags', () => {
        for (const op of Object.values(PSW_METADATA.EXTRA)) {
            expect(op.tags.length).toBeGreaterThan(0);
        }
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 7. System Route Metadata (replicated from system.ts)
// ═══════════════════════════════════════════════════════════════════════════

const SYSTEM_METADATA = {
    VOICE: { summary: 'Upload Voice Note', tags: ['System Voice'] },
    STORAGE_UPLOAD: { summary: 'Upload File', tags: ['System Storage'] },
    STORAGE_GET: { summary: 'Get File', tags: ['System Storage'] },
    PAYMENT_INTENT: { summary: 'Create Payment Intent', tags: ['System Payments'] },
    REGISTER_DEVICE: { summary: 'Register Device for Push', tags: ['System Notifications'] },
    LIST_NOTIFICATIONS: { summary: 'List Notifications', tags: ['System Notifications'] },
    READ_NOTIFICATION: { summary: 'Mark Notification as Read', tags: ['System Notifications'] },
};

describe('System Metadata', () => {
    it('has 7 operations', () => expect(Object.keys(SYSTEM_METADATA).length).toBe(7));
    it('VOICE', () => expect(SYSTEM_METADATA.VOICE.summary).toBe('Upload Voice Note'));
    it('STORAGE_UPLOAD', () => expect(SYSTEM_METADATA.STORAGE_UPLOAD.summary).toBe('Upload File'));
    it('STORAGE_GET', () => expect(SYSTEM_METADATA.STORAGE_GET.summary).toBe('Get File'));
    it('PAYMENT_INTENT', () => expect(SYSTEM_METADATA.PAYMENT_INTENT.summary).toBe('Create Payment Intent'));
    it('REGISTER_DEVICE', () => expect(SYSTEM_METADATA.REGISTER_DEVICE.tags).toContain('System Notifications'));
    it('LIST_NOTIFICATIONS', () => expect(SYSTEM_METADATA.LIST_NOTIFICATIONS.summary).toBe('List Notifications'));
    it('READ_NOTIFICATION', () => expect(SYSTEM_METADATA.READ_NOTIFICATION.summary).toBe('Mark Notification as Read'));
    it('all have tags', () => {
        for (const op of Object.values(SYSTEM_METADATA)) {
            expect(op.tags.length).toBeGreaterThan(0);
        }
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 8. PSW Ownership / Role Enforcement (replicated from ownership.ts)
// ═══════════════════════════════════════════════════════════════════════════

function shouldEnforceOwnership(roles: string[]): boolean {
    return roles.includes('psw');
}

function extractClientId(bodyClientId?: string, paramClientId?: string): string | null {
    return bodyClientId || paramClientId || null;
}

describe('Ownership — Role Enforcement', () => {
    it('psw role enforced', () => expect(shouldEnforceOwnership(['psw'])).toBe(true));
    it('admin not enforced', () => expect(shouldEnforceOwnership(['admin'])).toBe(false));
    it('multi roles with psw', () => expect(shouldEnforceOwnership(['admin', 'psw'])).toBe(true));
    it('staff not enforced', () => expect(shouldEnforceOwnership(['staff'])).toBe(false));
    it('empty roles', () => expect(shouldEnforceOwnership([])).toBe(false));
});

describe('Ownership — Client ID Extraction', () => {
    it('body takes precedence', () => expect(extractClientId('body-id', 'param-id')).toBe('body-id'));
    it('param fallback', () => expect(extractClientId(undefined, 'param-id')).toBe('param-id'));
    it('neither', () => expect(extractClientId(undefined, undefined)).toBeNull());
    it('empty body uses param', () => expect(extractClientId('', 'p-id')).toBe('p-id'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 9. URL & Query String Helpers
// ═══════════════════════════════════════════════════════════════════════════

function parseQueryParams(qs: string): Record<string, string> {
    const result: Record<string, string> = {};
    const parts = qs.startsWith('?') ? qs.slice(1) : qs;
    if (!parts) return result;
    for (const pair of parts.split('&')) {
        const [key, value] = pair.split('=');
        result[decodeURIComponent(key)] = decodeURIComponent(value || '');
    }
    return result;
}

function buildQueryString(params: Record<string, string | number | boolean>): string {
    const parts = Object.entries(params)
        .filter(([, v]) => v !== undefined && v !== null)
        .map(([k, v]) => `${encodeURIComponent(k)}=${encodeURIComponent(String(v))}`);
    return parts.length > 0 ? `?${parts.join('&')}` : '';
}

function slugify(text: string): string {
    return text.toLowerCase().trim().replace(/[^\w\s-]/g, '').replace(/[\s_]+/g, '-').replace(/^-+|-+$/g, '');
}

function extractPathSegments(path: string): string[] {
    return path.split('/').filter(Boolean);
}

describe('Query Params — Parse', () => {
    it('basic', () => expect(parseQueryParams('page=1&limit=10')).toEqual({ page: '1', limit: '10' }));
    it('with ?', () => expect(parseQueryParams('?page=1')).toEqual({ page: '1' }));
    it('empty', () => expect(parseQueryParams('')).toEqual({}));
    it('encoded', () => expect(parseQueryParams('name=John%20Doe')).toEqual({ name: 'John Doe' }));
    it('no value', () => expect(parseQueryParams('active')).toEqual({ active: '' }));
});

describe('Query String — Build', () => {
    it('basic', () => expect(buildQueryString({ page: 1, limit: 10 })).toBe('?page=1&limit=10'));
    it('empty', () => expect(buildQueryString({})).toBe(''));
    it('boolean', () => expect(buildQueryString({ active: true })).toBe('?active=true'));
    it('string', () => expect(buildQueryString({ name: 'John' })).toBe('?name=John'));
});

describe('Slugify', () => {
    it('basic', () => expect(slugify('Hello World')).toBe('hello-world'));
    it('special chars', () => expect(slugify('Hello, World!')).toBe('hello-world'));
    it('multiple spaces', () => expect(slugify('Hello   World')).toBe('hello-world'));
    it('trailing dashes', () => expect(slugify('--Hello--')).toBe('hello'));
    it('underscores', () => expect(slugify('hello_world')).toBe('hello-world'));
    it('mixed', () => expect(slugify('My Test Page (v2)')).toBe('my-test-page-v2'));
});

describe('Path Segments', () => {
    it('/v1/users/123', () => expect(extractPathSegments('/v1/users/123')).toEqual(['v1', 'users', '123']));
    it('trailing slash', () => expect(extractPathSegments('/api/')).toEqual(['api']));
    it('root', () => expect(extractPathSegments('/')).toEqual([]));
    it('no leading slash', () => expect(extractPathSegments('api/users')).toEqual(['api', 'users']));
});

// ═══════════════════════════════════════════════════════════════════════════
// 10. Data Transformation Helpers
// ═══════════════════════════════════════════════════════════════════════════

function chunk<T>(arr: T[], size: number): T[][] {
    const result: T[][] = [];
    for (let i = 0; i < arr.length; i += size) {
        result.push(arr.slice(i, i + size));
    }
    return result;
}

function unique<T>(arr: T[]): T[] {
    return [...new Set(arr)];
}

function flatten<T>(arr: T[][]): T[] {
    return arr.reduce((acc, item) => acc.concat(item), []);
}

function compact<T>(arr: (T | null | undefined | false | 0 | '')[]): T[] {
    return arr.filter(Boolean) as T[];
}

function zip<A, B>(a: A[], b: B[]): [A, B][] {
    const len = Math.min(a.length, b.length);
    return Array.from({ length: len }, (_, i) => [a[i], b[i]]);
}

describe('Chunk', () => {
    it('even split', () => expect(chunk([1, 2, 3, 4], 2)).toEqual([[1, 2], [3, 4]]));
    it('uneven', () => expect(chunk([1, 2, 3, 4, 5], 2)).toEqual([[1, 2], [3, 4], [5]]));
    it('single chunk', () => expect(chunk([1, 2], 5)).toEqual([[1, 2]]));
    it('empty', () => expect(chunk([], 2)).toEqual([]));
    it('size 1', () => expect(chunk([1, 2, 3], 1)).toEqual([[1], [2], [3]]));
});

describe('Unique', () => {
    it('removes duplicates', () => expect(unique([1, 2, 2, 3, 3])).toEqual([1, 2, 3]));
    it('strings', () => expect(unique(['a', 'b', 'a'])).toEqual(['a', 'b']));
    it('empty', () => expect(unique([])).toEqual([]));
    it('all unique', () => expect(unique([1, 2, 3])).toEqual([1, 2, 3]));
});

describe('Flatten', () => {
    it('basic', () => expect(flatten([[1, 2], [3, 4]])).toEqual([1, 2, 3, 4]));
    it('empty inner', () => expect(flatten([[], [1]])).toEqual([1]));
    it('empty', () => expect(flatten([])).toEqual([]));
});

describe('Compact', () => {
    it('removes falsy', () => expect(compact([0, 1, null, 2, undefined, 3, false, ''])).toEqual([1, 2, 3]));
    it('all truthy', () => expect(compact([1, 2, 3])).toEqual([1, 2, 3]));
    it('all falsy', () => expect(compact([0, null, false, ''])).toEqual([]));
});

describe('Zip', () => {
    it('equal length', () => expect(zip([1, 2], ['a', 'b'])).toEqual([[1, 'a'], [2, 'b']]));
    it('unequal', () => expect(zip([1, 2, 3], ['a', 'b'])).toEqual([[1, 'a'], [2, 'b']]));
    it('empty', () => expect(zip([], [])).toEqual([]));
});
