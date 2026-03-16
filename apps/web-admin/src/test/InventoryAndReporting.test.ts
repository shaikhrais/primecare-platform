/**
 * Inventory Management, Reporting Engine, Permissions Matrix & i18n — Phase 41
 *
 * Self-contained replicas covering:
 * - Inventory management: stock levels, reorder points, batch tracking
 * - Reporting engine: aggregation, filtering, export formatting
 * - Permission matrix: resource-action CRUD mapping, inheritance
 * - Internationalization: locale detection, message formatting, pluralization
 * - Rate limiting: token bucket, sliding window, burst detection
 * - Data transformation: CSV parsing, JSON flattening, tree building
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Inventory Management — Stock Levels & Reorder
// ═══════════════════════════════════════════════════════════════════════════

type StockStatus = 'in_stock' | 'low_stock' | 'out_of_stock' | 'discontinued';

function getStockStatus(quantity: number, reorderPoint: number, isActive: boolean): StockStatus {
    if (!isActive) return 'discontinued';
    if (quantity <= 0) return 'out_of_stock';
    if (quantity <= reorderPoint) return 'low_stock';
    return 'in_stock';
}

function calculateReorderQuantity(avgDailyUsage: number, leadTimeDays: number, safetyStockDays: number): number {
    return Math.ceil(avgDailyUsage * (leadTimeDays + safetyStockDays));
}

function isReorderNeeded(currentStock: number, reorderPoint: number, onOrder: number): boolean {
    return (currentStock + onOrder) <= reorderPoint;
}

function calculateStockValue(items: Array<{ quantity: number; unitCost: number }>): number {
    return Math.round(items.reduce((sum, item) => sum + item.quantity * item.unitCost, 0) * 100) / 100;
}

function getExpirationStatus(expiryDate: string, now: string, warningDays: number = 30): 'expired' | 'expiring_soon' | 'valid' {
    const expiry = new Date(expiryDate).getTime();
    const current = new Date(now).getTime();
    if (current >= expiry) return 'expired';
    if ((expiry - current) <= warningDays * 86400000) return 'expiring_soon';
    return 'valid';
}

describe('Inventory — Stock Status', () => {
    it('in stock', () => expect(getStockStatus(100, 20, true)).toBe('in_stock'));
    it('low stock', () => expect(getStockStatus(15, 20, true)).toBe('low_stock'));
    it('at reorder point', () => expect(getStockStatus(20, 20, true)).toBe('low_stock'));
    it('out of stock', () => expect(getStockStatus(0, 20, true)).toBe('out_of_stock'));
    it('negative', () => expect(getStockStatus(-5, 20, true)).toBe('out_of_stock'));
    it('discontinued', () => expect(getStockStatus(100, 20, false)).toBe('discontinued'));
});

describe('Inventory — Reorder Quantity', () => {
    it('basic', () => expect(calculateReorderQuantity(10, 5, 3)).toBe(80));
    it('high usage', () => expect(calculateReorderQuantity(50, 7, 2)).toBe(450));
    it('no safety', () => expect(calculateReorderQuantity(10, 5, 0)).toBe(50));
});

describe('Inventory — Reorder Needed', () => {
    it('needed', () => expect(isReorderNeeded(10, 20, 5)).toBe(true));
    it('not needed', () => expect(isReorderNeeded(30, 20, 0)).toBe(false));
    it('with on-order', () => expect(isReorderNeeded(10, 20, 15)).toBe(false));
});

describe('Inventory — Stock Value', () => {
    it('basic', () => expect(calculateStockValue([{ quantity: 10, unitCost: 5.5 }, { quantity: 20, unitCost: 3.25 }])).toBe(120));
    it('empty', () => expect(calculateStockValue([])).toBe(0));
});

describe('Inventory — Expiration', () => {
    it('expired', () => expect(getExpirationStatus('2026-01-01', '2026-03-15')).toBe('expired'));
    it('expiring soon', () => expect(getExpirationStatus('2026-04-01', '2026-03-15')).toBe('expiring_soon'));
    it('valid', () => expect(getExpirationStatus('2026-12-31', '2026-03-15')).toBe('valid'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Reporting Engine — Aggregation & Export
// ═══════════════════════════════════════════════════════════════════════════

function aggregate(values: number[], operation: 'sum' | 'avg' | 'min' | 'max' | 'count'): number {
    if (values.length === 0) return 0;
    switch (operation) {
        case 'sum': return values.reduce((a, b) => a + b, 0);
        case 'avg': return Math.round((values.reduce((a, b) => a + b, 0) / values.length) * 100) / 100;
        case 'min': return Math.min(...values);
        case 'max': return Math.max(...values);
        case 'count': return values.length;
    }
}

function formatReportDate(isoDate: string, format: 'short' | 'long' | 'iso'): string {
    const d = new Date(isoDate);
    if (format === 'iso') return d.toISOString().split('T')[0];
    if (format === 'short') return `${d.getMonth() + 1}/${d.getDate()}/${d.getFullYear()}`;
    return d.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });
}

function groupByPeriod(data: Array<{ date: string; value: number }>, period: 'day' | 'month' | 'year'): Record<string, number> {
    return data.reduce((acc, item) => {
        let key: string;
        if (period === 'day') key = item.date.slice(0, 10);
        else if (period === 'month') key = item.date.slice(0, 7);
        else key = item.date.slice(0, 4);
        acc[key] = (acc[key] || 0) + item.value;
        return acc;
    }, {} as Record<string, number>);
}

function formatCSVRow(values: (string | number)[]): string {
    return values.map(v => {
        const str = String(v);
        return str.includes(',') || str.includes('"') ? `"${str.replace(/"/g, '""')}"` : str;
    }).join(',');
}

function buildReportSummary(title: string, rows: number, generatedAt: string): { title: string; rowCount: number; generatedAt: string; isEmpty: boolean } {
    return { title, rowCount: rows, generatedAt, isEmpty: rows === 0 };
}

describe('Reporting — Aggregation', () => {
    it('sum', () => expect(aggregate([10, 20, 30], 'sum')).toBe(60));
    it('avg', () => expect(aggregate([10, 20, 30], 'avg')).toBe(20));
    it('min', () => expect(aggregate([10, 20, 30], 'min')).toBe(10));
    it('max', () => expect(aggregate([10, 20, 30], 'max')).toBe(30));
    it('count', () => expect(aggregate([10, 20, 30], 'count')).toBe(3));
    it('empty', () => expect(aggregate([], 'sum')).toBe(0));
});

describe('Reporting — Date Format', () => {
    it('iso', () => expect(formatReportDate('2026-03-15T00:00:00Z', 'iso')).toBe('2026-03-15'));
    it('short', () => expect(formatReportDate('2026-03-15T12:00:00.000Z', 'short')).toContain('2026'));
});

describe('Reporting — Group By Period', () => {
    const data = [
        { date: '2026-01-15', value: 100 },
        { date: '2026-01-20', value: 200 },
        { date: '2026-02-10', value: 150 },
    ];
    it('by month', () => {
        const r = groupByPeriod(data, 'month');
        expect(r['2026-01']).toBe(300);
        expect(r['2026-02']).toBe(150);
    });
    it('by year', () => {
        const r = groupByPeriod(data, 'year');
        expect(r['2026']).toBe(450);
    });
    it('by day', () => {
        const r = groupByPeriod(data, 'day');
        expect(Object.keys(r).length).toBe(3);
    });
});

describe('Reporting — CSV', () => {
    it('basic row', () => expect(formatCSVRow(['Alice', 30, 'NYC'])).toBe('Alice,30,NYC'));
    it('with comma', () => expect(formatCSVRow(['Smith, John', 25])).toBe('"Smith, John",25'));
    it('with quotes', () => expect(formatCSVRow(['He said "hi"', 1])).toBe('"He said ""hi""",1'));
});

describe('Reporting — Summary', () => {
    it('with data', () => {
        const s = buildReportSummary('Sales Report', 100, '2026-03-15');
        expect(s.isEmpty).toBe(false);
        expect(s.rowCount).toBe(100);
    });
    it('empty', () => expect(buildReportSummary('Empty', 0, '2026-03-15').isEmpty).toBe(true));
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Permission Matrix — Resource-Action CRUD
// ═══════════════════════════════════════════════════════════════════════════

type CRUDAction = 'create' | 'read' | 'update' | 'delete';

function buildPermissionKey(resource: string, action: CRUDAction): string {
    return `${resource}:${action}`;
}

function hasPermission(userPermissions: string[], resource: string, action: CRUDAction): boolean {
    const key = buildPermissionKey(resource, action);
    return userPermissions.includes(key) || userPermissions.includes(`${resource}:*`) || userPermissions.includes('*:*');
}

function getEffectivePermissions(rolePermissions: string[][], inheritedPermissions: string[]): string[] {
    const all = new Set<string>(inheritedPermissions);
    rolePermissions.forEach(rp => rp.forEach(p => all.add(p)));
    return [...all].sort();
}

function canDelegate(delegatorPermissions: string[], permissionToDelegate: string): boolean {
    if (delegatorPermissions.includes('*:*')) return true;
    return delegatorPermissions.includes(permissionToDelegate);
}

describe('Permissions — Key', () => {
    it('builds', () => expect(buildPermissionKey('user', 'create')).toBe('user:create'));
    it('with resource', () => expect(buildPermissionKey('visit', 'read')).toBe('visit:read'));
});

describe('Permissions — Check', () => {
    it('direct', () => expect(hasPermission(['user:create', 'user:read'], 'user', 'create')).toBe(true));
    it('wildcard action', () => expect(hasPermission(['user:*'], 'user', 'delete')).toBe(true));
    it('super admin', () => expect(hasPermission(['*:*'], 'anything', 'create')).toBe(true));
    it('denied', () => expect(hasPermission(['user:read'], 'user', 'delete')).toBe(false));
    it('wrong resource', () => expect(hasPermission(['user:create'], 'visit', 'create')).toBe(false));
});

describe('Permissions — Effective', () => {
    it('merges', () => {
        const eff = getEffectivePermissions([['user:create'], ['visit:read']], ['user:read']);
        expect(eff).toContain('user:create');
        expect(eff).toContain('visit:read');
        expect(eff).toContain('user:read');
    });
    it('dedupes', () => {
        const eff = getEffectivePermissions([['user:create']], ['user:create']);
        expect(eff.length).toBe(1);
    });
});

describe('Permissions — Delegation', () => {
    it('can delegate', () => expect(canDelegate(['user:create', 'user:read'], 'user:create')).toBe(true));
    it('cannot delegate', () => expect(canDelegate(['user:read'], 'user:create')).toBe(false));
    it('super admin', () => expect(canDelegate(['*:*'], 'anything:create')).toBe(true));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Internationalization — Locale & Pluralization
// ═══════════════════════════════════════════════════════════════════════════

function detectLocale(acceptLanguage: string): string {
    const locales = acceptLanguage.split(',').map(l => l.trim().split(';')[0]);
    const supported = ['en', 'fr', 'es', 'de', 'ar', 'zh'];
    for (const locale of locales) {
        const lang = locale.split('-')[0].toLowerCase();
        if (supported.includes(lang)) return lang;
    }
    return 'en';
}

function pluralize(count: number, singular: string, plural: string): string {
    return count === 1 ? singular : plural;
}

function formatMessage(template: string, params: Record<string, string | number>): string {
    return template.replace(/\{(\w+)\}/g, (_, key) => String(params[key] ?? `{${key}}`));
}

function getDirection(locale: string): 'ltr' | 'rtl' {
    return ['ar', 'he', 'fa', 'ur'].includes(locale) ? 'rtl' : 'ltr';
}

function getDateFormat(locale: string): string {
    const formats: Record<string, string> = {
        en: 'MM/DD/YYYY', fr: 'DD/MM/YYYY', de: 'DD.MM.YYYY',
        es: 'DD/MM/YYYY', ar: 'DD/MM/YYYY', zh: 'YYYY/MM/DD',
    };
    return formats[locale] || 'YYYY-MM-DD';
}

function getCurrencyForLocale(locale: string): string {
    const currencies: Record<string, string> = {
        en: 'USD', fr: 'EUR', de: 'EUR', es: 'EUR', ar: 'SAR', zh: 'CNY',
    };
    return currencies[locale] || 'USD';
}

describe('i18n — Locale Detection', () => {
    it('english', () => expect(detectLocale('en-US,en;q=0.9')).toBe('en'));
    it('french', () => expect(detectLocale('fr-FR,fr;q=0.9,en;q=0.8')).toBe('fr'));
    it('fallback', () => expect(detectLocale('xx-XX')).toBe('en'));
    it('spanish', () => expect(detectLocale('es-MX')).toBe('es'));
});

describe('i18n — Pluralization', () => {
    it('singular', () => expect(pluralize(1, 'item', 'items')).toBe('item'));
    it('plural', () => expect(pluralize(5, 'item', 'items')).toBe('items'));
    it('zero plural', () => expect(pluralize(0, 'item', 'items')).toBe('items'));
});

describe('i18n — Format Message', () => {
    it('basic', () => expect(formatMessage('Hello {name}', { name: 'Alice' })).toBe('Hello Alice'));
    it('multiple', () => expect(formatMessage('{count} {type}', { count: 5, type: 'items' })).toBe('5 items'));
    it('missing', () => expect(formatMessage('Hi {name}', {})).toBe('Hi {name}'));
});

describe('i18n — Direction', () => {
    it('english ltr', () => expect(getDirection('en')).toBe('ltr'));
    it('arabic rtl', () => expect(getDirection('ar')).toBe('rtl'));
    it('hebrew rtl', () => expect(getDirection('he')).toBe('rtl'));
});

describe('i18n — Date Format', () => {
    it('english', () => expect(getDateFormat('en')).toBe('MM/DD/YYYY'));
    it('french', () => expect(getDateFormat('fr')).toBe('DD/MM/YYYY'));
    it('german', () => expect(getDateFormat('de')).toBe('DD.MM.YYYY'));
    it('chinese', () => expect(getDateFormat('zh')).toBe('YYYY/MM/DD'));
    it('unknown', () => expect(getDateFormat('xx')).toBe('YYYY-MM-DD'));
});

describe('i18n — Currency', () => {
    it('english USD', () => expect(getCurrencyForLocale('en')).toBe('USD'));
    it('french EUR', () => expect(getCurrencyForLocale('fr')).toBe('EUR'));
    it('arabic SAR', () => expect(getCurrencyForLocale('ar')).toBe('SAR'));
    it('unknown USD', () => expect(getCurrencyForLocale('xx')).toBe('USD'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Rate Limiting — Token Bucket & Sliding Window
// ═══════════════════════════════════════════════════════════════════════════

function tokenBucketCheck(tokens: number, maxTokens: number, refillRate: number, lastRefill: number, now: number): { allowed: boolean; remainingTokens: number } {
    const elapsed = (now - lastRefill) / 1000;
    const refilled = Math.min(maxTokens, tokens + Math.floor(elapsed * refillRate));
    if (refilled <= 0) return { allowed: false, remainingTokens: 0 };
    return { allowed: true, remainingTokens: refilled - 1 };
}

function slidingWindowCheck(requestTimes: number[], windowMs: number, maxRequests: number, now: number): boolean {
    const recent = requestTimes.filter(t => (now - t) < windowMs);
    return recent.length < maxRequests;
}

function calculateRetryAfter(windowMs: number, oldestRequest: number, now: number): number {
    const waitMs = windowMs - (now - oldestRequest);
    return Math.max(0, Math.ceil(waitMs / 1000));
}

function getRateLimitProfile(endpoint: string): { windowMs: number; maxRequests: number } {
    if (endpoint.includes('/auth/')) return { windowMs: 60000, maxRequests: 5 };
    if (endpoint.includes('/admin/')) return { windowMs: 60000, maxRequests: 30 };
    return { windowMs: 60000, maxRequests: 100 };
}

describe('Rate Limit — Token Bucket', () => {
    it('allowed', () => {
        const r = tokenBucketCheck(10, 10, 1, 1000, 2000);
        expect(r.allowed).toBe(true);
    });
    it('empty bucket', () => {
        const r = tokenBucketCheck(0, 10, 0, 1000, 1000);
        expect(r.allowed).toBe(false);
    });
    it('refill', () => {
        const r = tokenBucketCheck(0, 10, 2, 1000, 3000);
        expect(r.allowed).toBe(true);
    });
});

describe('Rate Limit — Sliding Window', () => {
    it('allowed', () => expect(slidingWindowCheck([1000, 2000], 60000, 5, 5000)).toBe(true));
    it('blocked', () => expect(slidingWindowCheck([1000, 2000, 3000, 4000, 5000], 60000, 5, 6000)).toBe(false));
    it('expired window', () => expect(slidingWindowCheck([1000], 5000, 5, 100000)).toBe(true));
});

describe('Rate Limit — Retry After', () => {
    it('wait time', () => expect(calculateRetryAfter(60000, 10000, 50000)).toBe(20));
    it('no wait', () => expect(calculateRetryAfter(60000, 10000, 100000)).toBe(0));
});

describe('Rate Limit — Profile', () => {
    it('auth strict', () => expect(getRateLimitProfile('/v1/auth/login').maxRequests).toBe(5));
    it('admin moderate', () => expect(getRateLimitProfile('/v1/admin/users').maxRequests).toBe(30));
    it('default', () => expect(getRateLimitProfile('/v1/visits').maxRequests).toBe(100));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Data Transformation — CSV, JSON Flatten, Tree Building
// ═══════════════════════════════════════════════════════════════════════════

function parseCSVLine(line: string): string[] {
    const result: string[] = [];
    let current = '';
    let inQuotes = false;
    for (let i = 0; i < line.length; i++) {
        if (line[i] === '"') {
            if (inQuotes && line[i + 1] === '"') { current += '"'; i++; }
            else inQuotes = !inQuotes;
        } else if (line[i] === ',' && !inQuotes) {
            result.push(current); current = '';
        } else {
            current += line[i];
        }
    }
    result.push(current);
    return result;
}

function flattenObject(obj: Record<string, any>, prefix: string = ''): Record<string, any> {
    const result: Record<string, any> = {};
    for (const [key, value] of Object.entries(obj)) {
        const newKey = prefix ? `${prefix}.${key}` : key;
        if (value && typeof value === 'object' && !Array.isArray(value)) {
            Object.assign(result, flattenObject(value, newKey));
        } else {
            result[newKey] = value;
        }
    }
    return result;
}

function buildTree<T extends { id: string; parentId: string | null }>(items: T[]): Array<T & { children: T[] }> {
    const map = new Map<string, T & { children: T[] }>();
    items.forEach(item => map.set(item.id, { ...item, children: [] }));
    const roots: Array<T & { children: T[] }> = [];
    map.forEach(item => {
        if (item.parentId && map.has(item.parentId)) {
            map.get(item.parentId)!.children.push(item);
        } else {
            roots.push(item);
        }
    });
    return roots;
}

function unflattenObject(flat: Record<string, any>): Record<string, any> {
    const result: Record<string, any> = {};
    for (const [path, value] of Object.entries(flat)) {
        const keys = path.split('.');
        let current = result;
        for (let i = 0; i < keys.length - 1; i++) {
            current[keys[i]] = current[keys[i]] || {};
            current = current[keys[i]];
        }
        current[keys[keys.length - 1]] = value;
    }
    return result;
}

describe('Data — CSV Parse', () => {
    it('basic', () => expect(parseCSVLine('Alice,30,NYC')).toEqual(['Alice', '30', 'NYC']));
    it('quoted', () => expect(parseCSVLine('"Smith, John",25')).toEqual(['Smith, John', '25']));
    it('escaped quotes', () => expect(parseCSVLine('"He said ""hi""",1')).toEqual(['He said "hi"', '1']));
});

describe('Data — Flatten', () => {
    it('nested', () => {
        const r = flattenObject({ a: { b: { c: 1 } }, d: 2 });
        expect(r['a.b.c']).toBe(1);
        expect(r['d']).toBe(2);
    });
    it('flat input', () => {
        const r = flattenObject({ x: 1, y: 2 });
        expect(r).toEqual({ x: 1, y: 2 });
    });
});

describe('Data — Unflatten', () => {
    it('basic', () => {
        const r = unflattenObject({ 'a.b.c': 1, 'd': 2 });
        expect(r.a.b.c).toBe(1);
        expect(r.d).toBe(2);
    });
});

describe('Data — Tree', () => {
    it('builds tree', () => {
        const items = [
            { id: '1', parentId: null, name: 'Root' },
            { id: '2', parentId: '1', name: 'Child' },
            { id: '3', parentId: '1', name: 'Child2' },
            { id: '4', parentId: '2', name: 'Grandchild' },
        ];
        const tree: any[] = buildTree(items as any);
        expect(tree.length).toBe(1);
        expect(tree[0].children.length).toBe(2);
        expect(tree[0].children[0].children.length).toBe(1);
    });
    it('multiple roots', () => {
        const items = [
            { id: '1', parentId: null, name: 'Root1' },
            { id: '2', parentId: null, name: 'Root2' },
        ];
        expect(buildTree(items).length).toBe(2);
    });
});
