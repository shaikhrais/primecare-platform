/**
 * Platform Utilities Deep Tests — Phase 18
 *
 * Self-contained replicas of logic from:
 * - api-response.ts: envelope structure, pagination math
 * - notifications.ts: channel routing, option defaults
 * - feature-flags.ts: DEFAULT_FLAGS, flag lookup, key parsing
 * - audit.ts: metadata serialization, audit entry shapes
 * - Additional: date formatting, slug generation, RBAC helpers
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// API Response Envelope (replicated from api-response.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface ApiMeta {
    page?: number;
    limit?: number;
    total?: number;
    totalPages?: number;
    hasNext?: boolean;
    hasPrev?: boolean;
    [key: string]: any;
}

function buildSuccessEnvelope<T>(data: T, meta?: ApiMeta) {
    return { success: true, data, meta: meta || null, error: null };
}

function buildErrorEnvelope(message: string, details?: any) {
    return { success: false, data: null, meta: null, error: { message, ...(details ? { details } : {}) } };
}

function buildPaginatedMeta(page: number, limit: number, total: number): ApiMeta {
    return {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
        hasNext: page * limit < total,
        hasPrev: page > 1,
    };
}

describe('API Response — Success Envelope', () => {
    it('success is true', () => {
        const env = buildSuccessEnvelope({ id: '1' });
        expect(env.success).toBe(true);
    });

    it('error is null', () => {
        const env = buildSuccessEnvelope([]);
        expect(env.error).toBeNull();
    });

    it('data is preserved', () => {
        const env = buildSuccessEnvelope({ name: 'test' });
        expect(env.data.name).toBe('test');
    });

    it('meta defaults to null', () => {
        const env = buildSuccessEnvelope('x');
        expect(env.meta).toBeNull();
    });

    it('meta is passed through', () => {
        const env = buildSuccessEnvelope('x', { page: 1 });
        expect(env.meta!.page).toBe(1);
    });
});

describe('API Response — Error Envelope', () => {
    it('success is false', () => {
        const env = buildErrorEnvelope('Bad request');
        expect(env.success).toBe(false);
    });

    it('data is null', () => {
        const env = buildErrorEnvelope('error');
        expect(env.data).toBeNull();
    });

    it('error message', () => {
        const env = buildErrorEnvelope('Not found');
        expect(env.error.message).toBe('Not found');
    });

    it('with details', () => {
        const env = buildErrorEnvelope('Validation', { field: 'email' });
        expect(env.error.details.field).toBe('email');
    });

    it('without details', () => {
        const env = buildErrorEnvelope('Server error');
        expect(env.error).not.toHaveProperty('details');
    });
});

describe('API Response — Paginated Meta', () => {
    it('page 1', () => {
        const meta = buildPaginatedMeta(1, 10, 50);
        expect(meta.page).toBe(1);
        expect(meta.totalPages).toBe(5);
    });

    it('hasNext on first page', () => {
        const meta = buildPaginatedMeta(1, 10, 50);
        expect(meta.hasNext).toBe(true);
    });

    it('hasPrev false on page 1', () => {
        const meta = buildPaginatedMeta(1, 10, 50);
        expect(meta.hasPrev).toBe(false);
    });

    it('middle page has both', () => {
        const meta = buildPaginatedMeta(3, 10, 50);
        expect(meta.hasNext).toBe(true);
        expect(meta.hasPrev).toBe(true);
    });

    it('last page hasNext false', () => {
        const meta = buildPaginatedMeta(5, 10, 50);
        expect(meta.hasNext).toBe(false);
    });

    it('last page hasPrev true', () => {
        const meta = buildPaginatedMeta(5, 10, 50);
        expect(meta.hasPrev).toBe(true);
    });

    it('single page', () => {
        const meta = buildPaginatedMeta(1, 10, 5);
        expect(meta.totalPages).toBe(1);
        expect(meta.hasNext).toBe(false);
        expect(meta.hasPrev).toBe(false);
    });

    it('exact fit', () => {
        const meta = buildPaginatedMeta(1, 10, 10);
        expect(meta.totalPages).toBe(1);
    });

    it('one extra item', () => {
        const meta = buildPaginatedMeta(1, 10, 11);
        expect(meta.totalPages).toBe(2);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Notification Channel Routing (replicated from notifications.ts)
// ═══════════════════════════════════════════════════════════════════════════

type NotificationChannel = 'in_app' | 'email' | 'push';

function resolveChannels(channels?: NotificationChannel[]): NotificationChannel[] {
    return channels || ['in_app'];
}

function shouldSendEmail(channels: NotificationChannel[]): boolean {
    return channels.includes('email');
}

function shouldSendPush(channels: NotificationChannel[]): boolean {
    return channels.includes('push');
}

describe('Notification Channel Routing', () => {
    it('defaults to in_app', () => {
        expect(resolveChannels()).toEqual(['in_app']);
    });

    it('preserves explicit channels', () => {
        expect(resolveChannels(['email', 'push'])).toEqual(['email', 'push']);
    });

    it('shouldSendEmail true', () => {
        expect(shouldSendEmail(['email', 'in_app'])).toBe(true);
    });

    it('shouldSendEmail false', () => {
        expect(shouldSendEmail(['in_app'])).toBe(false);
    });

    it('shouldSendPush true', () => {
        expect(shouldSendPush(['push'])).toBe(true);
    });

    it('shouldSendPush false', () => {
        expect(shouldSendPush(['in_app', 'email'])).toBe(false);
    });

    it('all channels', () => {
        const ch: NotificationChannel[] = ['in_app', 'email', 'push'];
        expect(shouldSendEmail(ch)).toBe(true);
        expect(shouldSendPush(ch)).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Feature Flags (replicated from feature-flags.ts)
// ═══════════════════════════════════════════════════════════════════════════

const DEFAULT_FLAGS: Record<string, boolean> = {
    real_time_chat: true,
    telehealth: true,
    billing: true,
    compliance_home: true,
    sos_alerts: true,
    dispatch_map: true,
    knowledge_base: true,
    training_modules: true,
    advanced_reporting: true,
    api_webhooks: false,
    multi_currency: false,
    data_export: true,
    impersonation: true,
    digital_property_manager: true,
};

function resolveFlag(key: string, overrides?: Record<string, boolean>): boolean {
    if (overrides && key in overrides) return overrides[key];
    return DEFAULT_FLAGS[key] ?? true;
}

function parseFeatureKey(fullKey: string): string {
    return fullKey.replace('feature:', '');
}

function buildFeatureKey(featureName: string): string {
    return `feature:${featureName}`;
}

function parseFlagValue(value: string): boolean {
    return value === 'true' || value === '1';
}

describe('Feature Flags — Defaults', () => {
    it('has 14 default flags', () => {
        expect(Object.keys(DEFAULT_FLAGS).length).toBe(14);
    });

    it('real_time_chat enabled by default', () => {
        expect(DEFAULT_FLAGS.real_time_chat).toBe(true);
    });

    it('telehealth enabled', () => {
        expect(DEFAULT_FLAGS.telehealth).toBe(true);
    });

    it('api_webhooks disabled', () => {
        expect(DEFAULT_FLAGS.api_webhooks).toBe(false);
    });

    it('multi_currency disabled', () => {
        expect(DEFAULT_FLAGS.multi_currency).toBe(false);
    });

    it('compliance_home enabled', () => {
        expect(DEFAULT_FLAGS.compliance_home).toBe(true);
    });

    it('sos_alerts enabled', () => {
        expect(DEFAULT_FLAGS.sos_alerts).toBe(true);
    });

    it('data_export enabled', () => {
        expect(DEFAULT_FLAGS.data_export).toBe(true);
    });

    it('impersonation enabled', () => {
        expect(DEFAULT_FLAGS.impersonation).toBe(true);
    });

    it('digital_property_manager enabled', () => {
        expect(DEFAULT_FLAGS.digital_property_manager).toBe(true);
    });
});

describe('Feature Flags — resolveFlag', () => {
    it('returns default when no override', () => {
        expect(resolveFlag('telehealth')).toBe(true);
    });

    it('respects override true', () => {
        expect(resolveFlag('api_webhooks', { api_webhooks: true })).toBe(true);
    });

    it('respects override false', () => {
        expect(resolveFlag('telehealth', { telehealth: false })).toBe(false);
    });

    it('unknown flag defaults to true', () => {
        expect(resolveFlag('unknown_flag')).toBe(true);
    });

    it('override absent key falls to default', () => {
        expect(resolveFlag('billing', { api_webhooks: true })).toBe(true);
    });
});

describe('Feature Flags — Key Parsing', () => {
    it('parseFeatureKey strips prefix', () => {
        expect(parseFeatureKey('feature:telehealth')).toBe('telehealth');
    });

    it('parseFeatureKey no prefix', () => {
        expect(parseFeatureKey('billing')).toBe('billing');
    });

    it('buildFeatureKey adds prefix', () => {
        expect(buildFeatureKey('telehealth')).toBe('feature:telehealth');
    });

    it('roundtrip', () => {
        expect(parseFeatureKey(buildFeatureKey('sos_alerts'))).toBe('sos_alerts');
    });

    it('parseFlagValue true string', () => {
        expect(parseFlagValue('true')).toBe(true);
    });

    it('parseFlagValue 1 string', () => {
        expect(parseFlagValue('1')).toBe(true);
    });

    it('parseFlagValue false string', () => {
        expect(parseFlagValue('false')).toBe(false);
    });

    it('parseFlagValue 0 string', () => {
        expect(parseFlagValue('0')).toBe(false);
    });

    it('parseFlagValue random', () => {
        expect(parseFlagValue('yes')).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Audit Entry Serialization (replicated from audit.ts)
// ═══════════════════════════════════════════════════════════════════════════

function serializeAuditMetadata(metadata: any): string {
    if (typeof metadata === 'string') return metadata;
    return JSON.stringify(metadata);
}

function buildAuditEntry(userId: string | null, action: string, resourceType: string, resourceId: string | null, metadata: any = {}) {
    return {
        tenantId: metadata.tenantId || 'system',
        actorUserId: userId,
        action,
        resourceType,
        resourceId,
        metadata: serializeAuditMetadata(metadata),
        createdAt: new Date(),
    };
}

describe('Audit Entry Serialization', () => {
    it('string metadata returned as-is', () => {
        expect(serializeAuditMetadata('raw')).toBe('raw');
    });

    it('object metadata JSON-stringified', () => {
        expect(serializeAuditMetadata({ a: 1 })).toBe('{"a":1}');
    });

    it('empty object', () => {
        expect(serializeAuditMetadata({})).toBe('{}');
    });

    it('array metadata', () => {
        expect(serializeAuditMetadata([1, 2])).toBe('[1,2]');
    });

    it('null metadata', () => {
        expect(serializeAuditMetadata(null)).toBe('null');
    });
});

describe('Audit Entry Builder', () => {
    it('basic entry', () => {
        const entry = buildAuditEntry('user-1', 'LOGIN', 'AUTH', null);
        expect(entry.actorUserId).toBe('user-1');
        expect(entry.action).toBe('LOGIN');
        expect(entry.resourceType).toBe('AUTH');
    });

    it('default tenantId is system', () => {
        const entry = buildAuditEntry('u1', 'VIEW', 'PAGE', null);
        expect(entry.tenantId).toBe('system');
    });

    it('tenant from metadata', () => {
        const entry = buildAuditEntry('u1', 'VIEW', 'PAGE', null, { tenantId: 't-123' });
        expect(entry.tenantId).toBe('t-123');
    });

    it('resourceId null when not provided', () => {
        const entry = buildAuditEntry('u1', 'VIEW', 'PAGE', null);
        expect(entry.resourceId).toBeNull();
    });

    it('resourceId populated', () => {
        const entry = buildAuditEntry('u1', 'UPDATE', 'USER', 'user-42');
        expect(entry.resourceId).toBe('user-42');
    });

    it('null userId (system action)', () => {
        const entry = buildAuditEntry(null, 'CRON', 'SYSTEM', null);
        expect(entry.actorUserId).toBeNull();
    });

    it('createdAt is a Date', () => {
        const entry = buildAuditEntry('u1', 'X', 'Y', null);
        expect(entry.createdAt).toBeInstanceOf(Date);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Slug / URL Utility Helpers
// ═══════════════════════════════════════════════════════════════════════════

function slugify(text: string): string {
    return text.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
}

function buildApiPath(version: string, ...segments: string[]): string {
    return `/${version}/${segments.join('/')}`;
}

function extractTenantFromSubdomain(host: string): string | null {
    const parts = host.split('.');
    if (parts.length >= 3) return parts[0];
    return null;
}

describe('Slug Utility', () => {
    it('simple text', () => {
        expect(slugify('Hello World')).toBe('hello-world');
    });

    it('special characters', () => {
        expect(slugify('Test & Demo!')).toBe('test-demo');
    });

    it('leading/trailing hyphens removed', () => {
        expect(slugify(' trim me ')).toBe('trim-me');
    });

    it('numbers preserved', () => {
        expect(slugify('Version 2.0')).toBe('version-2-0');
    });

    it('already slug', () => {
        expect(slugify('already-slug')).toBe('already-slug');
    });

    it('empty string', () => {
        expect(slugify('')).toBe('');
    });

    it('all special', () => {
        expect(slugify('!@#$%')).toBe('');
    });
});

describe('API Path Builder', () => {
    it('basic path', () => {
        expect(buildApiPath('v1', 'users')).toBe('/v1/users');
    });

    it('nested path', () => {
        expect(buildApiPath('v1', 'users', '123', 'visits')).toBe('/v1/users/123/visits');
    });

    it('v2 path', () => {
        expect(buildApiPath('v2', 'admin', 'stats')).toBe('/v2/admin/stats');
    });
});

describe('Tenant Subdomain Extraction', () => {
    it('extracts from 3-part host', () => {
        expect(extractTenantFromSubdomain('acme.primecare.com')).toBe('acme');
    });

    it('extracts from 4-part host', () => {
        expect(extractTenantFromSubdomain('acme.api.primecare.com')).toBe('acme');
    });

    it('null for bare domain', () => {
        expect(extractTenantFromSubdomain('primecare.com')).toBeNull();
    });

    it('null for localhost', () => {
        expect(extractTenantFromSubdomain('localhost')).toBeNull();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Role & Permission Helpers
// ═══════════════════════════════════════════════════════════════════════════

const ROLE_HIERARCHY: Record<string, number> = {
    admin: 100,
    manager: 80,
    coordinator: 70,
    finance: 60,
    rn: 50,
    psw: 30,
    staff: 20,
    client: 10,
};

function hasMinimumRole(userRole: string, requiredRole: string): boolean {
    const userLevel = ROLE_HIERARCHY[userRole] ?? 0;
    const requiredLevel = ROLE_HIERARCHY[requiredRole] ?? 0;
    return userLevel >= requiredLevel;
}

function isAdminRole(role: string): boolean {
    return role === 'admin';
}

function canManage(managerRole: string, targetRole: string): boolean {
    return (ROLE_HIERARCHY[managerRole] ?? 0) > (ROLE_HIERARCHY[targetRole] ?? 0);
}

describe('Role Hierarchy', () => {
    it('admin has highest level', () => {
        expect(ROLE_HIERARCHY.admin).toBe(100);
    });

    it('client has lowest level', () => {
        expect(ROLE_HIERARCHY.client).toBe(10);
    });

    it('manager > coordinator', () => {
        expect(ROLE_HIERARCHY.manager).toBeGreaterThan(ROLE_HIERARCHY.coordinator);
    });

    it('coordinator > finance', () => {
        expect(ROLE_HIERARCHY.coordinator).toBeGreaterThan(ROLE_HIERARCHY.finance);
    });

    it('finance > rn', () => {
        expect(ROLE_HIERARCHY.finance).toBeGreaterThan(ROLE_HIERARCHY.rn);
    });

    it('rn > psw', () => {
        expect(ROLE_HIERARCHY.rn).toBeGreaterThan(ROLE_HIERARCHY.psw);
    });

    it('psw > staff', () => {
        expect(ROLE_HIERARCHY.psw).toBeGreaterThan(ROLE_HIERARCHY.staff);
    });
});

describe('hasMinimumRole', () => {
    it('admin meets admin', () => {
        expect(hasMinimumRole('admin', 'admin')).toBe(true);
    });

    it('admin meets psw', () => {
        expect(hasMinimumRole('admin', 'psw')).toBe(true);
    });

    it('psw does not meet admin', () => {
        expect(hasMinimumRole('psw', 'admin')).toBe(false);
    });

    it('manager meets coordinator', () => {
        expect(hasMinimumRole('manager', 'coordinator')).toBe(true);
    });

    it('coordinator does not meet manager', () => {
        expect(hasMinimumRole('coordinator', 'manager')).toBe(false);
    });

    it('unknown role defaults to 0', () => {
        expect(hasMinimumRole('guest', 'client')).toBe(false);
    });

    it('same role meets itself', () => {
        expect(hasMinimumRole('rn', 'rn')).toBe(true);
    });
});

describe('isAdminRole', () => {
    it('admin is admin', () => {
        expect(isAdminRole('admin')).toBe(true);
    });

    it('manager is not admin', () => {
        expect(isAdminRole('manager')).toBe(false);
    });

    it('empty is not admin', () => {
        expect(isAdminRole('')).toBe(false);
    });
});

describe('canManage', () => {
    it('admin can manage manager', () => {
        expect(canManage('admin', 'manager')).toBe(true);
    });

    it('manager cannot manage admin', () => {
        expect(canManage('manager', 'admin')).toBe(false);
    });

    it('same role cannot manage itself', () => {
        expect(canManage('coordinator', 'coordinator')).toBe(false);
    });

    it('manager can manage psw', () => {
        expect(canManage('manager', 'psw')).toBe(true);
    });

    it('psw cannot manage rn', () => {
        expect(canManage('psw', 'rn')).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Date / Time Formatting Helpers
// ═══════════════════════════════════════════════════════════════════════════

function formatISODate(date: Date): string {
    return date.toISOString().split('T')[0];
}

function addDays(date: Date, days: number): Date {
    const result = new Date(date);
    result.setDate(result.getDate() + days);
    return result;
}

function daysBetween(start: Date, end: Date): number {
    const ms = end.getTime() - start.getTime();
    return Math.floor(ms / (1000 * 60 * 60 * 24));
}

function isWeekendUTC(date: Date): boolean {
    const day = date.getUTCDay();
    return day === 0 || day === 6;
}

function businessDaysBetweenUTC(start: Date, end: Date): number {
    let count = 0;
    const current = new Date(start);
    while (current < end) {
        if (!isWeekendUTC(current)) count++;
        current.setUTCDate(current.getUTCDate() + 1);
    }
    return count;
}

describe('Date Formatting', () => {
    it('formatISODate', () => {
        expect(formatISODate(new Date('2025-06-15T10:00:00Z'))).toBe('2025-06-15');
    });

    it('addDays forward', () => {
        const d = addDays(new Date('2025-01-01T12:00:00Z'), 10);
        expect(formatISODate(d)).toBe('2025-01-11');
    });

    it('addDays backward', () => {
        const d = addDays(new Date('2025-01-10T12:00:00Z'), -5);
        expect(formatISODate(d)).toBe('2025-01-05');
    });

    it('daysBetween same day', () => {
        const d = new Date('2025-01-01T12:00:00Z');
        expect(daysBetween(d, d)).toBe(0);
    });

    it('daysBetween one week', () => {
        expect(daysBetween(new Date('2025-01-01T00:00:00Z'), new Date('2025-01-08T00:00:00Z'))).toBe(7);
    });

    it('isWeekend Saturday', () => {
        expect(isWeekendUTC(new Date('2025-03-15T12:00:00Z'))).toBe(true); // Saturday
    });

    it('isWeekend Sunday', () => {
        expect(isWeekendUTC(new Date('2025-03-16T12:00:00Z'))).toBe(true); // Sunday
    });

    it('isWeekend Monday', () => {
        expect(isWeekendUTC(new Date('2025-03-17T12:00:00Z'))).toBe(false);
    });

    it('businessDaysBetween full week', () => {
        // Mon March 17 → Sat March 22 (5 business days: Mon-Fri)
        expect(businessDaysBetweenUTC(new Date('2025-03-17T12:00:00Z'), new Date('2025-03-22T12:00:00Z'))).toBe(5);
    });

    it('businessDaysBetween same day', () => {
        const d = new Date('2025-03-17T12:00:00Z');
        expect(businessDaysBetweenUTC(d, d)).toBe(0);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// String / Validation Helpers
// ═══════════════════════════════════════════════════════════════════════════

function isValidEmail(email: string): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function isValidUUID(id: string): boolean {
    return /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(id);
}

function maskEmail(email: string): string {
    const [user, domain] = email.split('@');
    if (!domain) return '***';
    const masked = user.length <= 2 ? '*'.repeat(user.length) : user[0] + '*'.repeat(user.length - 2) + user[user.length - 1];
    return `${masked}@${domain}`;
}

function truncate(text: string, maxLen: number): string {
    if (text.length <= maxLen) return text;
    return text.slice(0, maxLen - 3) + '...';
}

function capitalize(text: string): string {
    if (!text) return '';
    return text[0].toUpperCase() + text.slice(1);
}

describe('Email Validation', () => {
    it('valid email', () => {
        expect(isValidEmail('user@example.com')).toBe(true);
    });

    it('missing @', () => {
        expect(isValidEmail('userexample.com')).toBe(false);
    });

    it('missing domain', () => {
        expect(isValidEmail('user@')).toBe(false);
    });

    it('spaces', () => {
        expect(isValidEmail('user @example.com')).toBe(false);
    });

    it('subdomain email', () => {
        expect(isValidEmail('admin@sub.example.com')).toBe(true);
    });
});

describe('UUID Validation', () => {
    it('valid UUID', () => {
        expect(isValidUUID('550e8400-e29b-41d4-a716-446655440000')).toBe(true);
    });

    it('invalid format', () => {
        expect(isValidUUID('not-a-uuid')).toBe(false);
    });

    it('too short', () => {
        expect(isValidUUID('550e8400')).toBe(false);
    });

    it('uppercase valid', () => {
        expect(isValidUUID('550E8400-E29B-41D4-A716-446655440000')).toBe(true);
    });
});

describe('Email Masking', () => {
    it('masks middle characters', () => {
        expect(maskEmail('john@example.com')).toBe('j**n@example.com');
    });

    it('short user', () => {
        expect(maskEmail('ab@test.com')).toBe('**@test.com');
    });

    it('single char user', () => {
        expect(maskEmail('a@test.com')).toBe('*@test.com');
    });

    it('no domain', () => {
        expect(maskEmail('nope')).toBe('***');
    });
});

describe('String Truncation', () => {
    it('short text unchanged', () => {
        expect(truncate('hi', 10)).toBe('hi');
    });

    it('exact length', () => {
        expect(truncate('hello', 5)).toBe('hello');
    });

    it('truncated with ellipsis', () => {
        expect(truncate('Hello World!', 8)).toBe('Hello...');
    });
});

describe('Capitalize', () => {
    it('lowercase word', () => {
        expect(capitalize('hello')).toBe('Hello');
    });

    it('already capitalized', () => {
        expect(capitalize('Hello')).toBe('Hello');
    });

    it('empty string', () => {
        expect(capitalize('')).toBe('');
    });

    it('single char', () => {
        expect(capitalize('a')).toBe('A');
    });
});
