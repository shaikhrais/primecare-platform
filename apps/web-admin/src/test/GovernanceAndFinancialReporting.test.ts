/**
 * Governance, Route Metadata, Financial Reporting & Advanced Analytics — Phase 38
 *
 * Self-contained replicas covering:
 * - Governance middleware: tenant config, compliance rules, data retention
 * - Route metadata: endpoint categorization, versioning, deprecation
 * - Financial reporting: P&L, balance sheet, journal entries, reconciliation
 * - Analytics: KPI calculation, trend analysis, aggregation pipelines
 * - Notification templates: channel routing, priority escalation, template rendering
 * - Webhook delivery: signature verification, retry logic, event filtering
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Governance — Tenant Config & Compliance
// ═══════════════════════════════════════════════════════════════════════════

type ComplianceLevel = 'basic' | 'standard' | 'strict' | 'hipaa';

function getRequiredFields(level: ComplianceLevel): string[] {
    const base = ['name', 'email'];
    if (level === 'basic') return base;
    if (level === 'standard') return [...base, 'phone', 'address'];
    if (level === 'strict') return [...base, 'phone', 'address', 'sin', 'dateOfBirth'];
    if (level === 'hipaa') return [...base, 'phone', 'address', 'sin', 'dateOfBirth', 'healthCardNumber', 'emergencyContact'];
    return base;
}

function getRetentionDays(level: ComplianceLevel): number {
    const map: Record<ComplianceLevel, number> = { basic: 365, standard: 730, strict: 2555, hipaa: 2555 };
    return map[level];
}

function isDataExpired(createdAt: string, retentionDays: number, now: string): boolean {
    const created = new Date(createdAt).getTime();
    const cutoff = new Date(now).getTime() - retentionDays * 86400000;
    return created < cutoff;
}

function validateTenantConfig(config: { name: string; slug: string; plan: string }): { valid: boolean; errors: string[] } {
    const errors: string[] = [];
    if (!config.name || config.name.length < 2) errors.push('Name too short');
    if (!config.slug || !/^[a-z0-9-]+$/.test(config.slug)) errors.push('Invalid slug');
    if (!['free', 'starter', 'pro', 'enterprise'].includes(config.plan)) errors.push('Invalid plan');
    return { valid: errors.length === 0, errors };
}

describe('Governance — Required Fields', () => {
    it('basic', () => expect(getRequiredFields('basic')).toEqual(['name', 'email']));
    it('standard', () => expect(getRequiredFields('standard')).toContain('phone'));
    it('strict has SIN', () => expect(getRequiredFields('strict')).toContain('sin'));
    it('hipaa has healthCard', () => expect(getRequiredFields('hipaa')).toContain('healthCardNumber'));
    it('hipaa has emergency', () => expect(getRequiredFields('hipaa')).toContain('emergencyContact'));
});

describe('Governance — Retention', () => {
    it('basic 1yr', () => expect(getRetentionDays('basic')).toBe(365));
    it('standard 2yr', () => expect(getRetentionDays('standard')).toBe(730));
    it('strict 7yr', () => expect(getRetentionDays('strict')).toBe(2555));
    it('hipaa 7yr', () => expect(getRetentionDays('hipaa')).toBe(2555));
});

describe('Governance — Data Expiry', () => {
    it('expired', () => expect(isDataExpired('2020-01-01', 365, '2026-03-15')).toBe(true));
    it('not expired', () => expect(isDataExpired('2026-01-01', 365, '2026-03-15')).toBe(false));
    it('edge', () => expect(isDataExpired('2025-03-14', 365, '2026-03-15')).toBe(true));
});

describe('Governance — Tenant Config', () => {
    it('valid', () => expect(validateTenantConfig({ name: 'Acme', slug: 'acme-co', plan: 'pro' }).valid).toBe(true));
    it('short name', () => {
        const r = validateTenantConfig({ name: 'A', slug: 'a', plan: 'pro' });
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('Name too short');
    });
    it('bad slug', () => expect(validateTenantConfig({ name: 'Acme', slug: 'Acme Co!', plan: 'pro' }).valid).toBe(false));
    it('bad plan', () => expect(validateTenantConfig({ name: 'Acme', slug: 'acme', plan: 'ultra' }).valid).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Route Metadata — Endpoint Categorization
// ═══════════════════════════════════════════════════════════════════════════

type RouteCategory = 'auth' | 'admin' | 'client' | 'staff' | 'public' | 'system';

function categorizeRoute(path: string): RouteCategory {
    if (path.startsWith('/v1/auth/')) return 'auth';
    if (path.startsWith('/v1/admin/')) return 'admin';
    if (path.startsWith('/v1/client/') || path.startsWith('/v1/clients/')) return 'client';
    if (path.startsWith('/v1/staff/') || path.startsWith('/v1/psw/')) return 'staff';
    if (path.startsWith('/v1/public/') || path === '/v1/health') return 'public';
    return 'system';
}

function extractVersion(path: string): string | null {
    const match = path.match(/^\/v(\d+)\//);
    return match ? `v${match[1]}` : null;
}

function isDeprecated(version: string, currentVersion: string): boolean {
    return parseInt(version.slice(1)) < parseInt(currentVersion.slice(1));
}

function buildResourcePath(resource: string, id?: string, subResource?: string): string {
    let path = `/v1/${resource}`;
    if (id) path += `/${id}`;
    if (subResource) path += `/${subResource}`;
    return path;
}

describe('Route — Categorization', () => {
    it('auth', () => expect(categorizeRoute('/v1/auth/login')).toBe('auth'));
    it('admin', () => expect(categorizeRoute('/v1/admin/users')).toBe('admin'));
    it('client', () => expect(categorizeRoute('/v1/clients/123')).toBe('client'));
    it('staff', () => expect(categorizeRoute('/v1/staff/shifts')).toBe('staff'));
    it('psw as staff', () => expect(categorizeRoute('/v1/psw/schedule')).toBe('staff'));
    it('public', () => expect(categorizeRoute('/v1/public/status')).toBe('public'));
    it('health', () => expect(categorizeRoute('/v1/health')).toBe('public'));
    it('system fallback', () => expect(categorizeRoute('/v1/settings')).toBe('system'));
});

describe('Route — Versioning', () => {
    it('v1', () => expect(extractVersion('/v1/users')).toBe('v1'));
    it('v2', () => expect(extractVersion('/v2/users')).toBe('v2'));
    it('no version', () => expect(extractVersion('/users')).toBeNull());
    it('v1 not deprecated', () => expect(isDeprecated('v1', 'v1')).toBe(false));
    it('v1 deprecated if v2', () => expect(isDeprecated('v1', 'v2')).toBe(true));
});

describe('Route — Resource Path', () => {
    it('basic', () => expect(buildResourcePath('users')).toBe('/v1/users'));
    it('with id', () => expect(buildResourcePath('users', '123')).toBe('/v1/users/123'));
    it('with sub', () => expect(buildResourcePath('users', '123', 'visits')).toBe('/v1/users/123/visits'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Financial Reporting — P&L, Balance Sheet, Journal Entries
// ═══════════════════════════════════════════════════════════════════════════

type AccountType = 'asset' | 'liability' | 'equity' | 'revenue' | 'expense';

function isDebitNormal(type: AccountType): boolean {
    return type === 'asset' || type === 'expense';
}

function calculateNetIncome(revenue: number, expenses: number): number {
    return revenue - expenses;
}

function isBalanced(debits: number, credits: number): boolean {
    return Math.abs(debits - credits) < 0.01;
}

function buildJournalEntry(description: string, lines: Array<{ account: string; debit: number; credit: number }>): { description: string; lines: typeof lines; balanced: boolean; total: number } {
    const totalDebits = lines.reduce((s, l) => s + l.debit, 0);
    const totalCredits = lines.reduce((s, l) => s + l.credit, 0);
    return {
        description,
        lines,
        balanced: isBalanced(totalDebits, totalCredits),
        total: totalDebits,
    };
}

function calculateGrossMargin(revenue: number, cogs: number): number {
    if (revenue === 0) return 0;
    return Math.round(((revenue - cogs) / revenue) * 10000) / 100;
}

function classifyAccount(code: string): AccountType {
    const prefix = parseInt(code.charAt(0));
    if (prefix === 1) return 'asset';
    if (prefix === 2) return 'liability';
    if (prefix === 3) return 'equity';
    if (prefix === 4) return 'revenue';
    return 'expense';
}

describe('Finance — Debit Normal', () => {
    it('asset', () => expect(isDebitNormal('asset')).toBe(true));
    it('expense', () => expect(isDebitNormal('expense')).toBe(true));
    it('revenue', () => expect(isDebitNormal('revenue')).toBe(false));
    it('liability', () => expect(isDebitNormal('liability')).toBe(false));
    it('equity', () => expect(isDebitNormal('equity')).toBe(false));
});

describe('Finance — Net Income', () => {
    it('profit', () => expect(calculateNetIncome(10000, 7000)).toBe(3000));
    it('loss', () => expect(calculateNetIncome(5000, 8000)).toBe(-3000));
    it('breakeven', () => expect(calculateNetIncome(5000, 5000)).toBe(0));
});

describe('Finance — Balance', () => {
    it('balanced', () => expect(isBalanced(1000, 1000)).toBe(true));
    it('unbalanced', () => expect(isBalanced(1000, 999)).toBe(false));
    it('rounding', () => expect(isBalanced(100.005, 100.01)).toBe(true));
});

describe('Finance — Journal Entry', () => {
    it('balanced entry', () => {
        const e = buildJournalEntry('Sale', [{ account: 'Cash', debit: 100, credit: 0 }, { account: 'Revenue', debit: 0, credit: 100 }]);
        expect(e.balanced).toBe(true);
        expect(e.total).toBe(100);
    });
    it('unbalanced entry', () => {
        const e = buildJournalEntry('Bad', [{ account: 'Cash', debit: 100, credit: 0 }]);
        expect(e.balanced).toBe(false);
    });
});

describe('Finance — Gross Margin', () => {
    it('50%', () => expect(calculateGrossMargin(1000, 500)).toBe(50));
    it('30%', () => expect(calculateGrossMargin(1000, 700)).toBe(30));
    it('zero revenue', () => expect(calculateGrossMargin(0, 500)).toBe(0));
});

describe('Finance — Account Classification', () => {
    it('1xxx asset', () => expect(classifyAccount('1000')).toBe('asset'));
    it('2xxx liability', () => expect(classifyAccount('2100')).toBe('liability'));
    it('3xxx equity', () => expect(classifyAccount('3000')).toBe('equity'));
    it('4xxx revenue', () => expect(classifyAccount('4100')).toBe('revenue'));
    it('5xxx expense', () => expect(classifyAccount('5200')).toBe('expense'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Analytics — KPIs, Trends, Aggregation
// ═══════════════════════════════════════════════════════════════════════════

function calculateGrowthRate(current: number, previous: number): number {
    if (previous === 0) return current > 0 ? 100 : 0;
    return Math.round(((current - previous) / previous) * 10000) / 100;
}

function calculateMovingAverage(values: number[], window: number): number[] {
    if (values.length < window) return [];
    const result: number[] = [];
    for (let i = window - 1; i < values.length; i++) {
        const slice = values.slice(i - window + 1, i + 1);
        result.push(Math.round(slice.reduce((a, b) => a + b, 0) / window * 100) / 100);
    }
    return result;
}

function detectTrend(values: number[]): 'up' | 'down' | 'flat' {
    if (values.length < 2) return 'flat';
    const first = values[0], last = values[values.length - 1];
    const change = ((last - first) / Math.abs(first || 1)) * 100;
    if (change > 5) return 'up';
    if (change < -5) return 'down';
    return 'flat';
}

function percentile(values: number[], p: number): number {
    const sorted = [...values].sort((a, b) => a - b);
    const idx = Math.ceil((p / 100) * sorted.length) - 1;
    return sorted[Math.max(0, idx)];
}

function groupBy<T>(items: T[], key: keyof T): Record<string, T[]> {
    return items.reduce((acc, item) => {
        const k = String(item[key]);
        (acc[k] = acc[k] || []).push(item);
        return acc;
    }, {} as Record<string, T[]>);
}

describe('Analytics — Growth Rate', () => {
    it('50% growth', () => expect(calculateGrowthRate(150, 100)).toBe(50));
    it('decline', () => expect(calculateGrowthRate(80, 100)).toBe(-20));
    it('from zero', () => expect(calculateGrowthRate(100, 0)).toBe(100));
    it('zero to zero', () => expect(calculateGrowthRate(0, 0)).toBe(0));
});

describe('Analytics — Moving Average', () => {
    it('3-period', () => {
        const r = calculateMovingAverage([10, 20, 30, 40, 50], 3);
        expect(r).toEqual([20, 30, 40]);
    });
    it('too few values', () => expect(calculateMovingAverage([10, 20], 3)).toEqual([]));
});

describe('Analytics — Trend', () => {
    it('up', () => expect(detectTrend([100, 110, 120, 130])).toBe('up'));
    it('down', () => expect(detectTrend([100, 90, 80, 70])).toBe('down'));
    it('flat', () => expect(detectTrend([100, 101, 100, 99])).toBe('flat'));
    it('single', () => expect(detectTrend([100])).toBe('flat'));
});

describe('Analytics — Percentile', () => {
    it('p50', () => expect(percentile([10, 20, 30, 40, 50], 50)).toBe(30));
    it('p90', () => expect(percentile([10, 20, 30, 40, 50, 60, 70, 80, 90, 100], 90)).toBe(90));
    it('p0', () => expect(percentile([10, 20, 30], 0)).toBe(10));
});

describe('Analytics — GroupBy', () => {
    const items = [{ type: 'a', value: 1 }, { type: 'b', value: 2 }, { type: 'a', value: 3 }];
    it('groups', () => {
        const g = groupBy(items, 'type');
        expect(g['a'].length).toBe(2);
        expect(g['b'].length).toBe(1);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Notification Templates & Channel Routing
// ═══════════════════════════════════════════════════════════════════════════

type NotificationChannel = 'email' | 'sms' | 'push' | 'in_app' | 'slack';
type NotificationPriority = 'low' | 'medium' | 'high' | 'critical';

function getChannelsForPriority(priority: NotificationPriority): NotificationChannel[] {
    switch (priority) {
        case 'critical': return ['email', 'sms', 'push', 'in_app', 'slack'];
        case 'high': return ['email', 'push', 'in_app'];
        case 'medium': return ['email', 'in_app'];
        case 'low': return ['in_app'];
    }
}

function renderTemplate(template: string, vars: Record<string, string>): string {
    return template.replace(/\{\{(\w+)\}\}/g, (_, key) => vars[key] || '');
}

function shouldEscalate(priority: NotificationPriority, ackWithinMinutes: number | null): boolean {
    if (priority === 'critical' && (ackWithinMinutes === null || ackWithinMinutes > 5)) return true;
    if (priority === 'high' && (ackWithinMinutes === null || ackWithinMinutes > 15)) return true;
    return false;
}

function maskEmail(email: string): string {
    const [local, domain] = email.split('@');
    if (!domain) return '***';
    const masked = local.length <= 2 ? '*'.repeat(local.length) : local[0] + '*'.repeat(local.length - 2) + local[local.length - 1];
    return `${masked}@${domain}`;
}

describe('Notifications — Priority Channels', () => {
    it('critical all', () => expect(getChannelsForPriority('critical').length).toBe(5));
    it('high 3', () => expect(getChannelsForPriority('high').length).toBe(3));
    it('medium 2', () => expect(getChannelsForPriority('medium').length).toBe(2));
    it('low 1', () => expect(getChannelsForPriority('low')).toEqual(['in_app']));
});

describe('Notifications — Template', () => {
    it('renders', () => expect(renderTemplate('Hello {{name}}, your code is {{code}}', { name: 'Alice', code: '1234' })).toBe('Hello Alice, your code is 1234'));
    it('missing var', () => expect(renderTemplate('Hi {{name}}', {})).toBe('Hi '));
    it('no vars', () => expect(renderTemplate('Static text', {})).toBe('Static text'));
});

describe('Notifications — Escalation', () => {
    it('critical no ack', () => expect(shouldEscalate('critical', null)).toBe(true));
    it('critical late', () => expect(shouldEscalate('critical', 10)).toBe(true));
    it('critical fast', () => expect(shouldEscalate('critical', 3)).toBe(false));
    it('high no ack', () => expect(shouldEscalate('high', null)).toBe(true));
    it('high fast', () => expect(shouldEscalate('high', 5)).toBe(false));
    it('medium no escalate', () => expect(shouldEscalate('medium', null)).toBe(false));
});

describe('Notifications — Mask Email', () => {
    it('long', () => expect(maskEmail('alice@example.com')).toBe('a***e@example.com'));
    it('short', () => expect(maskEmail('ab@x.com')).toBe('**@x.com'));
    it('invalid', () => expect(maskEmail('nope')).toBe('***'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Webhook Delivery — Signatures, Retry, Filtering
// ═══════════════════════════════════════════════════════════════════════════

function calculateWebhookSignature(payload: string, secret: string): string {
    // Simplified HMAC-like for testing (real would use crypto.subtle)
    let hash = 0;
    const combined = payload + secret;
    for (let i = 0; i < combined.length; i++) {
        hash = ((hash << 5) - hash) + combined.charCodeAt(i);
        hash |= 0;
    }
    return `sha256=${Math.abs(hash).toString(16)}`;
}

function shouldRetryWebhook(attempt: number, maxRetries: number, statusCode: number): boolean {
    if (attempt >= maxRetries) return false;
    if (statusCode >= 200 && statusCode < 300) return false;
    if (statusCode === 410) return false; // Gone — permanently removed
    return true;
}

function getRetryDelay(attempt: number): number {
    return Math.min(1000 * Math.pow(2, attempt), 60000);
}

function filterEvents(events: string[], subscribed: string[]): string[] {
    return events.filter(e => subscribed.includes(e) || subscribed.includes('*'));
}

describe('Webhook — Signature', () => {
    it('deterministic', () => {
        const s1 = calculateWebhookSignature('data', 'secret');
        const s2 = calculateWebhookSignature('data', 'secret');
        expect(s1).toBe(s2);
    });
    it('different payload', () => {
        const s1 = calculateWebhookSignature('data1', 'secret');
        const s2 = calculateWebhookSignature('data2', 'secret');
        expect(s1).not.toBe(s2);
    });
    it('starts with sha256=', () => expect(calculateWebhookSignature('x', 'y').startsWith('sha256=')).toBe(true));
});

describe('Webhook — Retry', () => {
    it('retry on 500', () => expect(shouldRetryWebhook(0, 3, 500)).toBe(true));
    it('no retry on 200', () => expect(shouldRetryWebhook(0, 3, 200)).toBe(false));
    it('no retry on 410', () => expect(shouldRetryWebhook(0, 3, 410)).toBe(false));
    it('max retries', () => expect(shouldRetryWebhook(3, 3, 500)).toBe(false));
    it('retry on 503', () => expect(shouldRetryWebhook(1, 3, 503)).toBe(true));
});

describe('Webhook — Delay', () => {
    it('attempt 0', () => expect(getRetryDelay(0)).toBe(1000));
    it('attempt 1', () => expect(getRetryDelay(1)).toBe(2000));
    it('attempt 2', () => expect(getRetryDelay(2)).toBe(4000));
    it('attempt 10 capped', () => expect(getRetryDelay(10)).toBe(60000));
});

describe('Webhook — Event Filtering', () => {
    it('subscribed', () => expect(filterEvents(['visit.created', 'visit.updated'], ['visit.created']).length).toBe(1));
    it('wildcard', () => expect(filterEvents(['visit.created', 'visit.updated'], ['*']).length).toBe(2));
    it('no match', () => expect(filterEvents(['visit.created'], ['user.created']).length).toBe(0));
});
