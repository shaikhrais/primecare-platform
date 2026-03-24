/**
 * CORS, Tenant Isolation & Complete Route Metadata Tests — Phase 22
 *
 * Self-contained replicas of logic from:
 * - errors.ts: CORS origin validation with preview subdomain regex
 * - tenant.extension.ts: per-operation tenant injection, global model bypass
 * - audit.extension.ts: device ID injection for audit entries
 * - client.ts, coordinator.ts, staff_rn.ts, user_manager.ts: route metadata contracts
 * - Additional: string formatting, date range, version parsing, email masking
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. CORS Origin Validation (replicated from errors.ts)
// ═══════════════════════════════════════════════════════════════════════════

const ALLOWED_ORIGINS = ['https://primecare-admin.pages.dev', 'http://localhost:5173', 'http://localhost:8787'];
const PREVIEW_RE = /^https:\/\/[a-z0-9]+\.primecare-admin\.pages\.dev$/;

function isAllowedOrigin(origin: string): boolean {
    return ALLOWED_ORIGINS.includes(origin);
}

function isPreviewOrigin(origin: string): boolean {
    return PREVIEW_RE.test(origin);
}

function resolveSafeOrigin(origin: string): string {
    if (isAllowedOrigin(origin) || isPreviewOrigin(origin)) return origin;
    return ALLOWED_ORIGINS[0]; // fallback to production
}

describe('CORS — Allowed Origins', () => {
    it('production', () => expect(isAllowedOrigin('https://primecare-admin.pages.dev')).toBe(true));
    it('localhost 5173', () => expect(isAllowedOrigin('http://localhost:5173')).toBe(true));
    it('localhost 8787', () => expect(isAllowedOrigin('http://localhost:8787')).toBe(true));
    it('random domain denied', () => expect(isAllowedOrigin('https://evil.com')).toBe(false));
    it('empty denied', () => expect(isAllowedOrigin('')).toBe(false));
});

describe('CORS — Preview Origins', () => {
    it('valid preview subdomain', () => expect(isPreviewOrigin('https://abc123.primecare-admin.pages.dev')).toBe(true));
    it('valid preview hex', () => expect(isPreviewOrigin('https://f1a2b3c4.primecare-admin.pages.dev')).toBe(true));
    it('invalid uppercase', () => expect(isPreviewOrigin('https://ABC123.primecare-admin.pages.dev')).toBe(false));
    it('invalid extra path', () => expect(isPreviewOrigin('https://abc123.primecare-admin.pages.dev/path')).toBe(false));
    it('invalid different domain', () => expect(isPreviewOrigin('https://abc123.evil-admin.pages.dev')).toBe(false));
    it('http rejected', () => expect(isPreviewOrigin('http://abc123.primecare-admin.pages.dev')).toBe(false));
});

describe('CORS — Safe Origin Resolution', () => {
    it('allowed origin returned', () => expect(resolveSafeOrigin('http://localhost:5173')).toBe('http://localhost:5173'));
    it('preview returned', () => expect(resolveSafeOrigin('https://abc123.primecare-admin.pages.dev')).toBe('https://abc123.primecare-admin.pages.dev'));
    it('unknown falls back to production', () => expect(resolveSafeOrigin('https://evil.com')).toBe('https://primecare-admin.pages.dev'));
    it('empty falls back', () => expect(resolveSafeOrigin('')).toBe('https://primecare-admin.pages.dev'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Tenant Extension Logic (replicated from tenant.extension.ts)
// ═══════════════════════════════════════════════════════════════════════════

const GLOBAL_MODELS = ['Tenant', 'FAQ', 'Lead', 'BlogPost', 'SystemEvent', 'UserDevice'];

function isGlobalModel(model: string): boolean {
    return GLOBAL_MODELS.includes(model);
}

type TenantOp = 'findUnique' | 'findFirst' | 'findMany' | 'count' | 'create' | 'createMany' | 'update' | 'delete' | 'upsert' | 'updateMany' | 'deleteMany';

function getInjectionStrategy(op: TenantOp): 'skip' | 'post-fetch-verify' | 'pre-verify' | 'where-inject' | 'data-inject' {
    if (['findUnique', 'findUniqueOrThrow'].includes(op)) return 'post-fetch-verify';
    if (['update', 'delete', 'upsert'].includes(op)) return 'pre-verify';
    if (['findFirst', 'findMany', 'count', 'updateMany', 'deleteMany'].includes(op)) return 'where-inject';
    if (['create', 'createMany'].includes(op)) return 'data-inject';
    return 'skip';
}

function injectTenantIntoWhere(where: Record<string, any>, tenantId: string): Record<string, any> {
    return { ...where, tenantId };
}

function injectTenantIntoData(data: Record<string, any> | Record<string, any>[], tenantId: string): Record<string, any> | Record<string, any>[] {
    if (Array.isArray(data)) return data.map(item => ({ ...item, tenantId }));
    return { ...data, tenantId };
}

function postFetchVerify(result: { tenantId?: string } | null, tenantId: string, throwOnFail: boolean): any {
    if (result && result.tenantId && result.tenantId !== tenantId) {
        if (throwOnFail) throw new Error('Record not found');
        return null;
    }
    return result;
}

describe('Tenant — Global Models', () => {
    it('Tenant is global', () => expect(isGlobalModel('Tenant')).toBe(true));
    it('FAQ is global', () => expect(isGlobalModel('FAQ')).toBe(true));
    it('Lead is global', () => expect(isGlobalModel('Lead')).toBe(true));
    it('BlogPost is global', () => expect(isGlobalModel('BlogPost')).toBe(true));
    it('SystemEvent is global', () => expect(isGlobalModel('SystemEvent')).toBe(true));
    it('UserDevice is global', () => expect(isGlobalModel('UserDevice')).toBe(true));
    it('User is NOT global', () => expect(isGlobalModel('User')).toBe(false));
    it('Visit is NOT global', () => expect(isGlobalModel('Visit')).toBe(false));
    it('Invoice is NOT global', () => expect(isGlobalModel('Invoice')).toBe(false));
    it('ClientProfile is NOT global', () => expect(isGlobalModel('ClientProfile')).toBe(false));
});

describe('Tenant — Injection Strategy', () => {
    it('findUnique → post-fetch-verify', () => expect(getInjectionStrategy('findUnique')).toBe('post-fetch-verify'));
    it('findFirst → where-inject', () => expect(getInjectionStrategy('findFirst')).toBe('where-inject'));
    it('findMany → where-inject', () => expect(getInjectionStrategy('findMany')).toBe('where-inject'));
    it('count → where-inject', () => expect(getInjectionStrategy('count')).toBe('where-inject'));
    it('create → data-inject', () => expect(getInjectionStrategy('create')).toBe('data-inject'));
    it('createMany → data-inject', () => expect(getInjectionStrategy('createMany')).toBe('data-inject'));
    it('update → pre-verify', () => expect(getInjectionStrategy('update')).toBe('pre-verify'));
    it('delete → pre-verify', () => expect(getInjectionStrategy('delete')).toBe('pre-verify'));
    it('upsert → pre-verify', () => expect(getInjectionStrategy('upsert')).toBe('pre-verify'));
    it('updateMany → where-inject', () => expect(getInjectionStrategy('updateMany')).toBe('where-inject'));
    it('deleteMany → where-inject', () => expect(getInjectionStrategy('deleteMany')).toBe('where-inject'));
});

describe('Tenant — Where Injection', () => {
    it('adds tenantId', () => {
        expect(injectTenantIntoWhere({ id: '123' }, 't-1')).toEqual({ id: '123', tenantId: 't-1' });
    });
    it('empty where', () => {
        expect(injectTenantIntoWhere({}, 't-1')).toEqual({ tenantId: 't-1' });
    });
    it('preserves existing', () => {
        expect(injectTenantIntoWhere({ status: 'active', id: '5' }, 't-2').tenantId).toBe('t-2');
    });
});

describe('Tenant — Data Injection', () => {
    it('single object', () => {
        expect(injectTenantIntoData({ name: 'Test' }, 't-1')).toEqual({ name: 'Test', tenantId: 't-1' });
    });
    it('array of objects', () => {
        const result = injectTenantIntoData([{ name: 'A' }, { name: 'B' }], 't-1');
        expect(result).toEqual([{ name: 'A', tenantId: 't-1' }, { name: 'B', tenantId: 't-1' }]);
    });
});

describe('Tenant — Post-Fetch Verify', () => {
    it('matching tenant passes', () => {
        expect(postFetchVerify({ tenantId: 't-1' }, 't-1', false)).toEqual({ tenantId: 't-1' });
    });
    it('mismatched tenant returns null (findUnique)', () => {
        expect(postFetchVerify({ tenantId: 't-2' }, 't-1', false)).toBeNull();
    });
    it('mismatched tenant throws (findUniqueOrThrow)', () => {
        expect(() => postFetchVerify({ tenantId: 't-2' }, 't-1', true)).toThrow('Record not found');
    });
    it('null result passes', () => {
        expect(postFetchVerify(null, 't-1', false)).toBeNull();
    });
    it('no tenantId in result passes', () => {
        expect(postFetchVerify({}, 't-1', false)).toEqual({});
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Audit Extension — Device ID Injection (replicated from audit.extension.ts)
// ═══════════════════════════════════════════════════════════════════════════

function injectDeviceId(data: Record<string, any>, deviceId: string | null): Record<string, any> {
    if (deviceId && !data.deviceId) return { ...data, deviceId };
    return data;
}

function injectDeviceIdMany(items: Record<string, any>[], deviceId: string | null): Record<string, any>[] {
    if (!deviceId) return items;
    return items.map(item => ({ ...item, deviceId: item.deviceId || deviceId }));
}

describe('Audit — Device ID Injection', () => {
    it('injects when missing', () => {
        expect(injectDeviceId({ action: 'CREATE' }, 'dev-1')).toEqual({ action: 'CREATE', deviceId: 'dev-1' });
    });
    it('preserves existing', () => {
        expect(injectDeviceId({ deviceId: 'original' }, 'dev-1')).toEqual({ deviceId: 'original' });
    });
    it('null deviceId skips', () => {
        expect(injectDeviceId({ action: 'X' }, null)).toEqual({ action: 'X' });
    });
    it('many items injection', () => {
        const items = [{ a: 1 }, { a: 2, deviceId: 'existing' }];
        const result = injectDeviceIdMany(items, 'dev-1');
        expect(result[0].deviceId).toBe('dev-1');
        expect(result[1].deviceId).toBe('existing');
    });
    it('many items null deviceId', () => {
        const items = [{ a: 1 }];
        expect(injectDeviceIdMany(items, null)).toEqual([{ a: 1 }]);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Client Route Metadata (replicated from client.ts)
// ═══════════════════════════════════════════════════════════════════════════

const CLIENT_METADATA: Record<string, { summary: string; tags: string[] }> = {
    INVOICES: { summary: 'List Client Invoices', tags: ['Client Services'] },
    SERVICES: { summary: 'List Available Services', tags: ['Client Services'] },
    CARE_PLAN_CREATE: { summary: 'Create Care Plan', tags: ['Client Care Plan'] },
    CARE_PLAN_UPDATE: { summary: 'Update Care Plan', tags: ['Client Care Plan'] },
    GET_PROFILE: { summary: 'Get Client Profile', tags: ['Client Home'] },
    UPDATE_PROFILE: { summary: 'Update Client Profile', tags: ['Client Home'] },
    STATS: { summary: 'Get Client Home Statistics', tags: ['Client Home'] },
    LIST_BOOKINGS: { summary: 'List Client Bookings', tags: ['Client Bookings'] },
    CREATE_BOOKING: { summary: 'Create Booking', tags: ['Client Bookings'] },
    UPDATE_BOOKING: { summary: 'Update Booking', tags: ['Client Bookings'] },
    TEAM_ROSTER: { summary: 'Get Care Team Roster', tags: ['Client Relationship'] },
    FEEDBACK_SUBMIT: { summary: 'Submit Care Feedback', tags: ['Client Relationship'] },
    FAMILY_FEED: { summary: 'Retrieve Family Engagement Feed', tags: ['Client Engagement'] },
    INVOICE_PAY: { summary: 'Initiate Invoice Payment', tags: ['Client Services'] },
    BOOKING_REQUESTS: { summary: 'Submit Service Booking Request', tags: ['Client Bookings'] },
};

describe('Client Metadata', () => {
    it('has 15 operations', () => expect(Object.keys(CLIENT_METADATA).length).toBe(15));
    it('INVOICES', () => expect(CLIENT_METADATA.INVOICES.summary).toBe('List Client Invoices'));
    it('CARE_PLAN_CREATE', () => expect(CLIENT_METADATA.CARE_PLAN_CREATE.tags).toContain('Client Care Plan'));
    it('STATS', () => expect(CLIENT_METADATA.STATS.summary).toBe('Get Client Home Statistics'));
    it('TEAM_ROSTER', () => expect(CLIENT_METADATA.TEAM_ROSTER.tags).toContain('Client Relationship'));
    it('FAMILY_FEED', () => expect(CLIENT_METADATA.FAMILY_FEED.tags).toContain('Client Engagement'));
    it('INVOICE_PAY', () => expect(CLIENT_METADATA.INVOICE_PAY.summary).toBe('Initiate Invoice Payment'));
    it('BOOKING_REQUESTS', () => expect(CLIENT_METADATA.BOOKING_REQUESTS.summary).toBe('Submit Service Booking Request'));
    it('all have summary', () => {
        for (const op of Object.values(CLIENT_METADATA)) expect(op.summary).toBeTruthy();
    });
    it('all have tags', () => {
        for (const op of Object.values(CLIENT_METADATA)) expect(op.tags.length).toBeGreaterThan(0);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Coordinator Route Metadata (replicated from coordinator.ts)
// ═══════════════════════════════════════════════════════════════════════════

const COORDINATOR_METADATA: Record<string, { summary: string; tags: string[] }> = {
    MATCH_OVERRIDE: { summary: 'Override PSW Match', tags: ['Coordinator Logistics'] },
    WAITLIST_SYNC: { summary: 'Sync Waitlist Priorities', tags: ['Coordinator Logistics'] },
    SOS_ACK: { summary: 'Acknowledge SOS Alert', tags: ['Coordinator Logistics'] },
    HOME_STATS: { summary: 'Get Coordinator Home Statistics', tags: ['Coordinator Home'] },
    SOS_DISPATCH: { summary: 'Dispatch Emergency Replacement', tags: ['Coordinator Dispatch'] },
    DISPATCH_MAP: { summary: 'Get Live Dispatch Map', tags: ['Coordinator Logistics'] },
    MATCHING_ENGINE: { summary: 'Run AI Shift Match', tags: ['Coordinator Logistics'] },
    MASTER_SCHEDULE: { summary: 'Get Master Schedule', tags: ['Coordinator Logistics'] },
    SHIFT_BROADCAST: { summary: 'Broadcast Shift Offer', tags: ['Coordinator Dispatch'] },
};

describe('Coordinator Metadata', () => {
    it('has 9 operations', () => expect(Object.keys(COORDINATOR_METADATA).length).toBe(9));
    it('SOS_DISPATCH', () => expect(COORDINATOR_METADATA.SOS_DISPATCH.summary).toBe('Dispatch Emergency Replacement'));
    it('DISPATCH_MAP', () => expect(COORDINATOR_METADATA.DISPATCH_MAP.tags).toContain('Coordinator Logistics'));
    it('MATCHING_ENGINE', () => expect(COORDINATOR_METADATA.MATCHING_ENGINE.summary).toBe('Run AI Shift Match'));
    it('SHIFT_BROADCAST', () => expect(COORDINATOR_METADATA.SHIFT_BROADCAST.tags).toContain('Coordinator Dispatch'));
    it('all have summary', () => {
        for (const op of Object.values(COORDINATOR_METADATA)) expect(op.summary).toBeTruthy();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Staff & RN Route Metadata (replicated from staff_rn.ts)
// ═══════════════════════════════════════════════════════════════════════════

const STAFF_METADATA: Record<string, { summary: string; tags: string[] }> = {
    SUPPORT_LIST: { summary: 'List Support Tickets', tags: ['Staff Support'] },
    SUPPORT_MESSAGES: { summary: 'Get Ticket Messages', tags: ['Staff Support'] },
    SUPPORT_REPLY: { summary: 'Reply to Ticket', tags: ['Staff Support'] },
    SCHEDULING_CREATE: { summary: 'Create Visit (Staff)', tags: ['Staff Scheduling'] },
    HOME_STATS: { summary: 'Get Staff Home Statistics', tags: ['Staff Home'] },
    TASKS: { summary: 'List Staff Tasks', tags: ['Staff Operations'] },
    INCIDENT_SUBMIT: { summary: 'Submit Incident Report', tags: ['Staff Operations'] },
    COMPLIANCE_SCAN: { summary: 'Scan Branch Compliance', tags: ['Staff Operations'] },
    MESSAGES: { summary: 'Staff Message Hub', tags: ['Staff Support'] },
};

const RN_METADATA: Record<string, { summary: string; tags: string[] }> = {
    SUPERVISION_OVERVIEW: { summary: 'Get PSW Supervision Overview', tags: ['RN Supervision'] },
    HOME_STATS: { summary: 'Get RN Home Statistics', tags: ['RN Home'] },
    DAILY_REVIEW: { summary: 'Review Daily Entry', tags: ['RN Daily Review'] },
    CARE_PLAN_LIST: { summary: 'List Care Plans', tags: ['RN Clinical'] },
    CARE_PLAN_REVIEW: { summary: 'Review/Update Care Plan', tags: ['RN Clinical'] },
    CLINICAL_ASSESS: { summary: 'Submit Clinical Assessment', tags: ['RN Clinical'] },
    MEDICATION_RECON: { summary: 'Sync Medication Reconciliation', tags: ['RN Clinical'] },
    SUPERVISION_LOG: { summary: 'Record Supervision Log', tags: ['RN Supervision'] },
    DAILY_AUDIT_SIGN_OFF: { summary: 'Professional Clinical Sign-off', tags: ['RN Clinical Audit'] },
};

describe('Staff Metadata', () => {
    it('has 9 operations', () => expect(Object.keys(STAFF_METADATA).length).toBe(9));
    it('SUPPORT_LIST', () => expect(STAFF_METADATA.SUPPORT_LIST.summary).toBe('List Support Tickets'));
    it('COMPLIANCE_SCAN', () => expect(STAFF_METADATA.COMPLIANCE_SCAN.summary).toBe('Scan Branch Compliance'));
    it('MESSAGES', () => expect(STAFF_METADATA.MESSAGES.tags).toContain('Staff Support'));
    it('all have summary', () => {
        for (const op of Object.values(STAFF_METADATA)) expect(op.summary).toBeTruthy();
    });
});

describe('RN Metadata', () => {
    it('has 9 operations', () => expect(Object.keys(RN_METADATA).length).toBe(9));
    it('SUPERVISION_OVERVIEW', () => expect(RN_METADATA.SUPERVISION_OVERVIEW.tags).toContain('RN Supervision'));
    it('CLINICAL_ASSESS', () => expect(RN_METADATA.CLINICAL_ASSESS.summary).toBe('Submit Clinical Assessment'));
    it('MEDICATION_RECON', () => expect(RN_METADATA.MEDICATION_RECON.summary).toBe('Sync Medication Reconciliation'));
    it('DAILY_AUDIT_SIGN_OFF', () => expect(RN_METADATA.DAILY_AUDIT_SIGN_OFF.tags).toContain('RN Clinical Audit'));
    it('all have summary', () => {
        for (const op of Object.values(RN_METADATA)) expect(op.summary).toBeTruthy();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 7. User & Manager Route Metadata (replicated from user_manager.ts)
// ═══════════════════════════════════════════════════════════════════════════

const USER_METADATA: Record<string, { summary: string; tags: string[] }> = {
    GET_PROFILE: { summary: 'Get User Profile', tags: ['User Profile'] },
    UPDATE_PROFILE: { summary: 'Update User Profile', tags: ['User Profile'] },
};

const MANAGER_METADATA: Record<string, { summary: string; tags: string[] }> = {
    STATS: { summary: 'Get Manager Home Statistics', tags: ['Manager Home'] },
    PAYROLL_AUDIT: { summary: 'Run Payroll Audit', tags: ['Manager Finance'] },
    OPS_STATS: { summary: 'Get Regional Ops Stats', tags: ['Manager Operations'] },
    BRANCH_HEALTH: { summary: 'Get Branch Health Status', tags: ['Manager Operations'] },
    COMPLIANCE_SYNC: { summary: 'Sync Branch Compliance', tags: ['Manager Operations'] },
    FEEDBACK_TRIAGE: { summary: 'Triage Feedback', tags: ['Manager Operations'] },
};

describe('User Metadata', () => {
    it('has 2 operations', () => expect(Object.keys(USER_METADATA).length).toBe(2));
    it('GET_PROFILE', () => expect(USER_METADATA.GET_PROFILE.summary).toBe('Get User Profile'));
    it('UPDATE_PROFILE', () => expect(USER_METADATA.UPDATE_PROFILE.tags).toContain('User Profile'));
});

describe('Manager Metadata', () => {
    it('has 6 operations', () => expect(Object.keys(MANAGER_METADATA).length).toBe(6));
    it('STATS', () => expect(MANAGER_METADATA.STATS.summary).toBe('Get Manager Home Statistics'));
    it('PAYROLL_AUDIT', () => expect(MANAGER_METADATA.PAYROLL_AUDIT.tags).toContain('Manager Finance'));
    it('OPS_STATS', () => expect(MANAGER_METADATA.OPS_STATS.summary).toBe('Get Regional Ops Stats'));
    it('BRANCH_HEALTH', () => expect(MANAGER_METADATA.BRANCH_HEALTH.tags).toContain('Manager Operations'));
    it('COMPLIANCE_SYNC', () => expect(MANAGER_METADATA.COMPLIANCE_SYNC.summary).toBe('Sync Branch Compliance'));
    it('FEEDBACK_TRIAGE', () => expect(MANAGER_METADATA.FEEDBACK_TRIAGE.summary).toBe('Triage Feedback'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 8. Route Metadata — Cross-Cutting Aggregate
// ═══════════════════════════════════════════════════════════════════════════

const ALL_METADATA = { ...CLIENT_METADATA, ...COORDINATOR_METADATA, ...STAFF_METADATA, ...RN_METADATA, ...USER_METADATA, ...MANAGER_METADATA };

function getAllTags(metadata: Record<string, { tags: string[] }>): string[] {
    const tags = new Set<string>();
    for (const op of Object.values(metadata)) for (const t of op.tags) tags.add(t);
    return [...tags].sort();
}

describe('Route Metadata — Aggregate', () => {
    it('total operations count', () => expect(Object.keys(ALL_METADATA).length).toBeGreaterThan(40));
    it('all have summary', () => {
        for (const op of Object.values(ALL_METADATA)) expect(op.summary).toBeTruthy();
    });
    it('all have at least one tag', () => {
        for (const op of Object.values(ALL_METADATA)) expect(op.tags.length).toBeGreaterThan(0);
    });
    it('unique tags exist', () => {
        const tags = getAllTags(ALL_METADATA);
        expect(tags.length).toBeGreaterThan(10);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 9. String Formatting & Masking Utilities
// ═══════════════════════════════════════════════════════════════════════════

function maskEmail(email: string): string {
    const [user, domain] = email.split('@');
    if (!domain) return '***';
    const visible = user.slice(0, 2);
    return `${visible}***@${domain}`;
}

function maskPhone(phone: string): string {
    if (phone.length < 4) return '***';
    return '***' + phone.slice(-4);
}

function capitalize(str: string): string {
    return str.charAt(0).toUpperCase() + str.slice(1);
}

function titleCase(str: string): string {
    return str.split(' ').map(capitalize).join(' ');
}

function truncate(str: string, maxLen: number): string {
    return str.length > maxLen ? str.slice(0, maxLen) + '...' : str;
}

describe('Email Masking', () => {
    it('basic', () => expect(maskEmail('john@example.com')).toBe('jo***@example.com'));
    it('short user', () => expect(maskEmail('j@example.com')).toBe('j***@example.com'));
    it('no domain', () => expect(maskEmail('invalid')).toBe('***'));
});

describe('Phone Masking', () => {
    it('basic', () => expect(maskPhone('5551234567')).toBe('***4567'));
    it('short', () => expect(maskPhone('12')).toBe('***'));
});

describe('String Capitalize', () => {
    it('basic', () => expect(capitalize('hello')).toBe('Hello'));
    it('already capitalized', () => expect(capitalize('Hello')).toBe('Hello'));
    it('single char', () => expect(capitalize('h')).toBe('H'));
});

describe('Title Case', () => {
    it('basic', () => expect(titleCase('hello world')).toBe('Hello World'));
    it('three words', () => expect(titleCase('john doe smith')).toBe('John Doe Smith'));
});

describe('Truncate', () => {
    it('short enough', () => expect(truncate('hello', 10)).toBe('hello'));
    it('truncated', () => expect(truncate('hello world this is long', 10)).toBe('hello worl...'));
    it('exact length', () => expect(truncate('12345', 5)).toBe('12345'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 10. Version Parsing & Comparison
// ═══════════════════════════════════════════════════════════════════════════

function parseVersion(v: string): { major: number; minor: number; patch: number } {
    const [major = 0, minor = 0, patch = 0] = v.replace(/^v/, '').split('.').map(Number);
    return { major, minor, patch };
}

function compareVersions(a: string, b: string): number {
    const va = parseVersion(a);
    const vb = parseVersion(b);
    if (va.major !== vb.major) return va.major - vb.major;
    if (va.minor !== vb.minor) return va.minor - vb.minor;
    return va.patch - vb.patch;
}

function isVersionNewer(current: string, required: string): boolean {
    return compareVersions(current, required) >= 0;
}

describe('Version Parsing', () => {
    it('1.2.3', () => expect(parseVersion('1.2.3')).toEqual({ major: 1, minor: 2, patch: 3 }));
    it('v1.0.0', () => expect(parseVersion('v1.0.0')).toEqual({ major: 1, minor: 0, patch: 0 }));
    it('0.0.1', () => expect(parseVersion('0.0.1')).toEqual({ major: 0, minor: 0, patch: 1 }));
});

describe('Version Comparison', () => {
    it('equal', () => expect(compareVersions('1.0.0', '1.0.0')).toBe(0));
    it('major higher', () => expect(compareVersions('2.0.0', '1.0.0')).toBeGreaterThan(0));
    it('major lower', () => expect(compareVersions('1.0.0', '2.0.0')).toBeLessThan(0));
    it('minor higher', () => expect(compareVersions('1.1.0', '1.0.0')).toBeGreaterThan(0));
    it('patch higher', () => expect(compareVersions('1.0.1', '1.0.0')).toBeGreaterThan(0));
});

describe('Version Newer Check', () => {
    it('newer', () => expect(isVersionNewer('2.0.0', '1.0.0')).toBe(true));
    it('equal', () => expect(isVersionNewer('1.0.0', '1.0.0')).toBe(true));
    it('older', () => expect(isVersionNewer('0.9.0', '1.0.0')).toBe(false));
});
