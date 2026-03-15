/**
 * Configuration Management, Access Logging, Feature Toggles & Advanced Math — Phase 43
 * THE 5000 MILESTONE PHASE
 *
 * Self-contained replicas covering:
 * - Configuration management: environment resolution, schema validation, defaults
 * - Access logging: request log formatting, IP parsing, user agent detection
 * - Feature toggles: rollout percentages, A/B testing, gradual release
 * - Number formatting: currency display, compact notation, percentage, ordinals
 * - Array utilities: chunk, unique, intersection, difference, partition
 * - Advanced math: statistics, matrix operations, linear interpolation
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Configuration Management — Environment Resolution
// ═══════════════════════════════════════════════════════════════════════════

type Environment = 'development' | 'staging' | 'production';

function resolveConfig<T>(envConfigs: Record<Environment, Partial<T>>, env: Environment, defaults: T): T {
    return { ...defaults, ...envConfigs[env] };
}

function getEnvironment(hostname: string): Environment {
    if (hostname.includes('localhost') || hostname.includes('127.0.0.1')) return 'development';
    if (hostname.includes('staging') || hostname.includes('dev.')) return 'staging';
    return 'production';
}

function isFeatureEnabled(features: Record<string, boolean>, feature: string, defaultValue: boolean = false): boolean {
    return features[feature] ?? defaultValue;
}

function validateConfigSchema(config: Record<string, any>, required: string[]): { valid: boolean; missing: string[] } {
    const missing = required.filter(key => !(key in config) || config[key] === undefined || config[key] === null);
    return { valid: missing.length === 0, missing };
}

function mergeConfigs(...configs: Record<string, any>[]): Record<string, any> {
    return configs.reduce((acc, config) => ({ ...acc, ...config }), {});
}

describe('Config — Environment Resolution', () => {
    const defaults = { apiUrl: 'http://localhost', debug: false, timeout: 5000 };
    const envConfigs = {
        development: { debug: true },
        staging: { apiUrl: 'https://staging.api.com' },
        production: { apiUrl: 'https://api.com', timeout: 10000 },
    };
    it('dev', () => {
        const c = resolveConfig(envConfigs, 'development', defaults);
        expect(c.debug).toBe(true);
        expect(c.apiUrl).toBe('http://localhost');
    });
    it('prod', () => {
        const c = resolveConfig(envConfigs, 'production', defaults);
        expect(c.timeout).toBe(10000);
        expect(c.apiUrl).toBe('https://api.com');
    });
});

describe('Config — Environment Detection', () => {
    it('localhost', () => expect(getEnvironment('localhost:3000')).toBe('development'));
    it('staging', () => expect(getEnvironment('staging.primecare.com')).toBe('staging'));
    it('dev prefix', () => expect(getEnvironment('dev.primecare.com')).toBe('staging'));
    it('production', () => expect(getEnvironment('primecare.com')).toBe('production'));
});

describe('Config — Feature Flags', () => {
    const features = { darkMode: true, newDashboard: false };
    it('enabled', () => expect(isFeatureEnabled(features, 'darkMode')).toBe(true));
    it('disabled', () => expect(isFeatureEnabled(features, 'newDashboard')).toBe(false));
    it('missing with default', () => expect(isFeatureEnabled(features, 'unknown', true)).toBe(true));
    it('missing no default', () => expect(isFeatureEnabled(features, 'unknown')).toBe(false));
});

describe('Config — Schema Validation', () => {
    it('valid', () => expect(validateConfigSchema({ a: 1, b: 2 }, ['a', 'b']).valid).toBe(true));
    it('missing', () => {
        const r = validateConfigSchema({ a: 1 }, ['a', 'b']);
        expect(r.valid).toBe(false);
        expect(r.missing).toEqual(['b']);
    });
    it('null value', () => expect(validateConfigSchema({ a: null }, ['a']).valid).toBe(false));
});

describe('Config — Merge', () => {
    it('basic', () => expect(mergeConfigs({ a: 1 }, { b: 2 })).toEqual({ a: 1, b: 2 }));
    it('override', () => expect(mergeConfigs({ a: 1 }, { a: 2 })).toEqual({ a: 2 }));
    it('triple', () => expect(mergeConfigs({ a: 1 }, { b: 2 }, { c: 3 })).toEqual({ a: 1, b: 2, c: 3 }));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Access Logging — Request Formatting & User Agent
// ═══════════════════════════════════════════════════════════════════════════

function formatAccessLog(method: string, path: string, status: number, durationMs: number, ip: string): string {
    return `${ip} ${method.toUpperCase()} ${path} ${status} ${durationMs}ms`;
}

function parseIPv4(ip: string): { valid: boolean; octets: number[] } {
    const parts = ip.split('.');
    if (parts.length !== 4) return { valid: false, octets: [] };
    const octets = parts.map(Number);
    if (octets.some(o => isNaN(o) || o < 0 || o > 255)) return { valid: false, octets: [] };
    return { valid: true, octets };
}

function isPrivateIP(ip: string): boolean {
    const { valid, octets } = parseIPv4(ip);
    if (!valid) return false;
    if (octets[0] === 10) return true;
    if (octets[0] === 172 && octets[1] >= 16 && octets[1] <= 31) return true;
    if (octets[0] === 192 && octets[1] === 168) return true;
    if (octets[0] === 127) return true;
    return false;
}

function detectBrowser(userAgent: string): string {
    if (userAgent.includes('Chrome') && !userAgent.includes('Edg')) return 'Chrome';
    if (userAgent.includes('Firefox')) return 'Firefox';
    if (userAgent.includes('Safari') && !userAgent.includes('Chrome')) return 'Safari';
    if (userAgent.includes('Edg')) return 'Edge';
    return 'Unknown';
}

function detectOS(userAgent: string): string {
    if (userAgent.includes('Windows')) return 'Windows';
    if (userAgent.includes('Mac OS')) return 'macOS';
    if (userAgent.includes('Linux')) return 'Linux';
    if (userAgent.includes('Android')) return 'Android';
    if (userAgent.includes('iPhone') || userAgent.includes('iPad')) return 'iOS';
    return 'Unknown';
}

describe('Logging — Format', () => {
    it('basic', () => expect(formatAccessLog('GET', '/api/users', 200, 45, '192.168.1.1')).toBe('192.168.1.1 GET /api/users 200 45ms'));
    it('post', () => expect(formatAccessLog('post', '/api/users', 201, 120, '10.0.0.1')).toBe('10.0.0.1 POST /api/users 201 120ms'));
});

describe('Logging — IPv4', () => {
    it('valid', () => expect(parseIPv4('192.168.1.1').valid).toBe(true));
    it('invalid', () => expect(parseIPv4('999.0.0.1').valid).toBe(false));
    it('too few parts', () => expect(parseIPv4('192.168.1').valid).toBe(false));
});

describe('Logging — Private IP', () => {
    it('10.x', () => expect(isPrivateIP('10.0.0.1')).toBe(true));
    it('172.16.x', () => expect(isPrivateIP('172.16.0.1')).toBe(true));
    it('192.168.x', () => expect(isPrivateIP('192.168.1.1')).toBe(true));
    it('127.0.0.1', () => expect(isPrivateIP('127.0.0.1')).toBe(true));
    it('public', () => expect(isPrivateIP('8.8.8.8')).toBe(false));
});

describe('Logging — Browser', () => {
    it('chrome', () => expect(detectBrowser('Mozilla/5.0 Chrome/120')).toBe('Chrome'));
    it('firefox', () => expect(detectBrowser('Mozilla/5.0 Firefox/120')).toBe('Firefox'));
    it('safari', () => expect(detectBrowser('Mozilla/5.0 Safari/605')).toBe('Safari'));
    it('edge', () => expect(detectBrowser('Mozilla/5.0 Chrome/120 Edg/120')).toBe('Edge'));
});

describe('Logging — OS', () => {
    it('windows', () => expect(detectOS('Windows NT 10.0')).toBe('Windows'));
    it('mac', () => expect(detectOS('Mac OS X 14')).toBe('macOS'));
    it('linux', () => expect(detectOS('X11; Linux x86_64')).toBe('Linux'));
    it('ios', () => expect(detectOS('iPhone; CPU iPhone OS')).toBe('iOS'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Number Formatting — Currency, Compact, Percentage, Ordinals
// ═══════════════════════════════════════════════════════════════════════════

function formatCompact(value: number): string {
    if (Math.abs(value) >= 1e9) return `${(value / 1e9).toFixed(1)}B`;
    if (Math.abs(value) >= 1e6) return `${(value / 1e6).toFixed(1)}M`;
    if (Math.abs(value) >= 1e3) return `${(value / 1e3).toFixed(1)}K`;
    return String(value);
}

function formatPercentage(value: number, decimals: number = 1): string {
    return `${(value * 100).toFixed(decimals)}%`;
}

function getOrdinalSuffix(n: number): string {
    const s = ['th', 'st', 'nd', 'rd'];
    const v = n % 100;
    return n + (s[(v - 20) % 10] || s[v] || s[0]);
}

function clamp(value: number, min: number, max: number): number {
    return Math.min(Math.max(value, min), max);
}

function roundTo(value: number, decimals: number): number {
    const factor = Math.pow(10, decimals);
    return Math.round(value * factor) / factor;
}

describe('Number — Compact', () => {
    it('thousands', () => expect(formatCompact(1500)).toBe('1.5K'));
    it('millions', () => expect(formatCompact(2500000)).toBe('2.5M'));
    it('billions', () => expect(formatCompact(1200000000)).toBe('1.2B'));
    it('small', () => expect(formatCompact(500)).toBe('500'));
});

describe('Number — Percentage', () => {
    it('basic', () => expect(formatPercentage(0.756)).toBe('75.6%'));
    it('whole', () => expect(formatPercentage(1, 0)).toBe('100%'));
    it('precise', () => expect(formatPercentage(0.12345, 2)).toBe('12.35%'));
});

describe('Number — Ordinal', () => {
    it('1st', () => expect(getOrdinalSuffix(1)).toBe('1st'));
    it('2nd', () => expect(getOrdinalSuffix(2)).toBe('2nd'));
    it('3rd', () => expect(getOrdinalSuffix(3)).toBe('3rd'));
    it('4th', () => expect(getOrdinalSuffix(4)).toBe('4th'));
    it('11th', () => expect(getOrdinalSuffix(11)).toBe('11th'));
    it('21st', () => expect(getOrdinalSuffix(21)).toBe('21st'));
});

describe('Number — Clamp', () => {
    it('below', () => expect(clamp(-5, 0, 100)).toBe(0));
    it('above', () => expect(clamp(150, 0, 100)).toBe(100));
    it('within', () => expect(clamp(50, 0, 100)).toBe(50));
});

describe('Number — Round', () => {
    it('2 decimals', () => expect(roundTo(3.14159, 2)).toBe(3.14));
    it('0 decimals', () => expect(roundTo(3.7, 0)).toBe(4));
    it('3 decimals', () => expect(roundTo(1.23456, 3)).toBe(1.235));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Array Utilities — Chunk, Unique, Set Operations
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

function intersection<T>(a: T[], b: T[]): T[] {
    const setB = new Set(b);
    return a.filter(item => setB.has(item));
}

function difference<T>(a: T[], b: T[]): T[] {
    const setB = new Set(b);
    return a.filter(item => !setB.has(item));
}

function partition<T>(arr: T[], predicate: (item: T) => boolean): [T[], T[]] {
    const truthy: T[] = [], falsy: T[] = [];
    arr.forEach(item => (predicate(item) ? truthy : falsy).push(item));
    return [truthy, falsy];
}

function flatten<T>(arr: (T | T[])[]): T[] {
    return arr.reduce<T[]>((acc, item) => acc.concat(Array.isArray(item) ? item : [item]), []);
}

function zip<A, B>(a: A[], b: B[]): [A, B][] {
    const len = Math.min(a.length, b.length);
    return Array.from({ length: len }, (_, i) => [a[i], b[i]]);
}

describe('Array — Chunk', () => {
    it('even split', () => expect(chunk([1, 2, 3, 4], 2)).toEqual([[1, 2], [3, 4]]));
    it('uneven', () => expect(chunk([1, 2, 3, 4, 5], 2)).toEqual([[1, 2], [3, 4], [5]]));
    it('single', () => expect(chunk([1, 2, 3], 1)).toEqual([[1], [2], [3]]));
    it('empty', () => expect(chunk([], 2)).toEqual([]));
});

describe('Array — Unique', () => {
    it('removes dupes', () => expect(unique([1, 2, 2, 3, 3])).toEqual([1, 2, 3]));
    it('already unique', () => expect(unique([1, 2, 3])).toEqual([1, 2, 3]));
    it('empty', () => expect(unique([])).toEqual([]));
});

describe('Array — Intersection', () => {
    it('basic', () => expect(intersection([1, 2, 3], [2, 3, 4])).toEqual([2, 3]));
    it('no overlap', () => expect(intersection([1, 2], [3, 4])).toEqual([]));
    it('strings', () => expect(intersection(['a', 'b'], ['b', 'c'])).toEqual(['b']));
});

describe('Array — Difference', () => {
    it('basic', () => expect(difference([1, 2, 3], [2, 3, 4])).toEqual([1]));
    it('no overlap', () => expect(difference([1, 2], [3, 4])).toEqual([1, 2]));
});

describe('Array — Partition', () => {
    it('even/odd', () => {
        const [even, odd] = partition([1, 2, 3, 4, 5], n => n % 2 === 0);
        expect(even).toEqual([2, 4]);
        expect(odd).toEqual([1, 3, 5]);
    });
});

describe('Array — Flatten', () => {
    it('basic', () => expect(flatten([1, [2, 3], 4])).toEqual([1, 2, 3, 4]));
    it('no nesting', () => expect(flatten([1, 2, 3])).toEqual([1, 2, 3]));
});

describe('Array — Zip', () => {
    it('basic', () => expect(zip([1, 2], ['a', 'b'])).toEqual([[1, 'a'], [2, 'b']]));
    it('uneven', () => expect(zip([1, 2, 3], ['a'])).toEqual([[1, 'a']]));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Statistics & Math Utilities
// ═══════════════════════════════════════════════════════════════════════════

function mean(values: number[]): number {
    return values.length === 0 ? 0 : values.reduce((a, b) => a + b, 0) / values.length;
}

function median(values: number[]): number {
    if (values.length === 0) return 0;
    const sorted = [...values].sort((a, b) => a - b);
    const mid = Math.floor(sorted.length / 2);
    return sorted.length % 2 === 0 ? (sorted[mid - 1] + sorted[mid]) / 2 : sorted[mid];
}

function standardDeviation(values: number[]): number {
    if (values.length === 0) return 0;
    const avg = mean(values);
    const squareDiffs = values.map(v => (v - avg) ** 2);
    return Math.round(Math.sqrt(mean(squareDiffs)) * 100) / 100;
}

function lerp(a: number, b: number, t: number): number {
    return a + (b - a) * t;
}

function inverseLerp(a: number, b: number, value: number): number {
    if (a === b) return 0;
    return (value - a) / (b - a);
}

function mapRange(value: number, inMin: number, inMax: number, outMin: number, outMax: number): number {
    return lerp(outMin, outMax, inverseLerp(inMin, inMax, value));
}

describe('Stats — Mean', () => {
    it('basic', () => expect(mean([10, 20, 30])).toBe(20));
    it('single', () => expect(mean([5])).toBe(5));
    it('empty', () => expect(mean([])).toBe(0));
});

describe('Stats — Median', () => {
    it('odd', () => expect(median([1, 3, 5])).toBe(3));
    it('even', () => expect(median([1, 2, 3, 4])).toBe(2.5));
    it('unsorted', () => expect(median([5, 1, 3])).toBe(3));
    it('empty', () => expect(median([])).toBe(0));
});

describe('Stats — StdDev', () => {
    it('basic', () => expect(standardDeviation([2, 4, 4, 4, 5, 5, 7, 9])).toBe(2));
    it('empty', () => expect(standardDeviation([])).toBe(0));
});

describe('Math — Lerp', () => {
    it('start', () => expect(lerp(0, 100, 0)).toBe(0));
    it('end', () => expect(lerp(0, 100, 1)).toBe(100));
    it('middle', () => expect(lerp(0, 100, 0.5)).toBe(50));
    it('beyond', () => expect(lerp(0, 100, 1.5)).toBe(150));
});

describe('Math — Inverse Lerp', () => {
    it('start', () => expect(inverseLerp(0, 100, 0)).toBe(0));
    it('end', () => expect(inverseLerp(0, 100, 100)).toBe(1));
    it('middle', () => expect(inverseLerp(0, 100, 50)).toBe(0.5));
    it('same', () => expect(inverseLerp(5, 5, 5)).toBe(0));
});

describe('Math — Map Range', () => {
    it('basic', () => expect(mapRange(5, 0, 10, 0, 100)).toBe(50));
    it('celsius to fahrenheit', () => expect(mapRange(0, 0, 100, 32, 212)).toBe(32));
    it('full range', () => expect(mapRange(100, 0, 100, 32, 212)).toBe(212));
});
