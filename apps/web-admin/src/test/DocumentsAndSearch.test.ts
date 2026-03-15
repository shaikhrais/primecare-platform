/**
 * Document Management, Search, API Client Patterns & Form Validation — Phase 40
 *
 * Self-contained replicas covering:
 * - Document management: versioning, access control, file type validation
 * - Search & indexing: tokenization, relevance scoring, fuzzy matching
 * - API client patterns: request building, error handling, retry strategies
 * - Form validation: complex field rules, conditional validation, cross-field checks
 * - URL and query string utilities: parsing, building, encoding
 * - Color and theme utilities: hex/rgb conversion, contrast calculation
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Document Management — Versioning & Access Control
// ═══════════════════════════════════════════════════════════════════════════

type DocPermission = 'view' | 'edit' | 'comment' | 'delete' | 'share';

function canAccessDocument(userRole: string, docOwner: string, userId: string, isPublic: boolean): DocPermission[] {
    if (userRole === 'admin' || userRole === 'super_admin') return ['view', 'edit', 'comment', 'delete', 'share'];
    if (userId === docOwner) return ['view', 'edit', 'comment', 'delete', 'share'];
    if (isPublic) return ['view', 'comment'];
    return [];
}

function generateVersionNumber(major: number, minor: number, patch: number): string {
    return `${major}.${minor}.${patch}`;
}

function incrementVersion(version: string, type: 'major' | 'minor' | 'patch'): string {
    const [major, minor, patch] = version.split('.').map(Number);
    switch (type) {
        case 'major': return `${major + 1}.0.0`;
        case 'minor': return `${major}.${minor + 1}.0`;
        case 'patch': return `${major}.${minor}.${patch + 1}`;
    }
}

function isAllowedFileType(filename: string, allowed: string[]): boolean {
    const ext = filename.split('.').pop()?.toLowerCase() || '';
    return allowed.includes(ext);
}

function getFileSizeLabel(bytes: number): string {
    if (bytes < 1024) return `${bytes} B`;
    if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
    if (bytes < 1024 * 1024 * 1024) return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
    return `${(bytes / (1024 * 1024 * 1024)).toFixed(1)} GB`;
}

function isWithinSizeLimit(bytes: number, limitMB: number): boolean {
    return bytes <= limitMB * 1024 * 1024;
}

describe('Document — Access Control', () => {
    it('admin full access', () => expect(canAccessDocument('admin', 'u-1', 'u-2', false).length).toBe(5));
    it('owner full access', () => expect(canAccessDocument('staff', 'u-1', 'u-1', false).length).toBe(5));
    it('public view/comment', () => expect(canAccessDocument('staff', 'u-1', 'u-2', true)).toEqual(['view', 'comment']));
    it('private no access', () => expect(canAccessDocument('staff', 'u-1', 'u-2', false)).toEqual([]));
});

describe('Document — Versioning', () => {
    it('generate', () => expect(generateVersionNumber(1, 2, 3)).toBe('1.2.3'));
    it('major bump', () => expect(incrementVersion('1.2.3', 'major')).toBe('2.0.0'));
    it('minor bump', () => expect(incrementVersion('1.2.3', 'minor')).toBe('1.3.0'));
    it('patch bump', () => expect(incrementVersion('1.2.3', 'patch')).toBe('1.2.4'));
});

describe('Document — File Types', () => {
    it('pdf allowed', () => expect(isAllowedFileType('report.pdf', ['pdf', 'docx', 'xlsx'])).toBe(true));
    it('exe blocked', () => expect(isAllowedFileType('virus.exe', ['pdf', 'docx'])).toBe(false));
    it('case insensitive', () => expect(isAllowedFileType('Report.PDF', ['pdf'])).toBe(true));
});

describe('Document — File Size', () => {
    it('bytes', () => expect(getFileSizeLabel(500)).toBe('500 B'));
    it('KB', () => expect(getFileSizeLabel(1500)).toBe('1.5 KB'));
    it('MB', () => expect(getFileSizeLabel(2500000)).toBe('2.4 MB'));
    it('GB', () => expect(getFileSizeLabel(1500000000)).toBe('1.4 GB'));
    it('within limit', () => expect(isWithinSizeLimit(5000000, 10)).toBe(true));
    it('over limit', () => expect(isWithinSizeLimit(15000000, 10)).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Search & Indexing — Tokenization & Relevance Scoring
// ═══════════════════════════════════════════════════════════════════════════

function tokenize(text: string): string[] {
    return text.toLowerCase().split(/\s+/).filter(t => t.length > 1);
}

function calculateRelevance(query: string[], tokens: string[]): number {
    const matches = query.filter(q => tokens.some(t => t.includes(q)));
    return query.length === 0 ? 0 : Math.round((matches.length / query.length) * 100);
}

function fuzzyMatch(needle: string, haystack: string, threshold: number = 0.6): boolean {
    const n = needle.toLowerCase();
    const h = haystack.toLowerCase();
    if (h.includes(n)) return true;
    let matches = 0;
    let haystackIdx = 0;
    for (let i = 0; i < n.length && haystackIdx < h.length; i++) {
        const idx = h.indexOf(n[i], haystackIdx);
        if (idx !== -1) { matches++; haystackIdx = idx + 1; }
    }
    return (matches / n.length) >= threshold;
}

function highlightMatches(text: string, query: string): string {
    const re = new RegExp(`(${query.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')})`, 'gi');
    return text.replace(re, '**$1**');
}

function buildSearchSuggestions(query: string, items: string[], max: number = 5): string[] {
    return items.filter(i => i.toLowerCase().includes(query.toLowerCase())).slice(0, max);
}

describe('Search — Tokenize', () => {
    it('splits words', () => expect(tokenize('Hello World Test')).toEqual(['hello', 'world', 'test']));
    it('filters short', () => expect(tokenize('a b cd ef')).toEqual(['cd', 'ef']));
    it('empty', () => expect(tokenize('')).toEqual([]));
});

describe('Search — Relevance', () => {
    it('100%', () => expect(calculateRelevance(['hello', 'world'], ['hello', 'world', 'test'])).toBe(100));
    it('50%', () => expect(calculateRelevance(['hello', 'missing'], ['hello', 'world'])).toBe(50));
    it('0%', () => expect(calculateRelevance(['missing'], ['hello', 'world'])).toBe(0));
    it('empty query', () => expect(calculateRelevance([], ['hello'])).toBe(0));
});

describe('Search — Fuzzy', () => {
    it('exact', () => expect(fuzzyMatch('hello', 'hello world')).toBe(true));
    it('fuzzy match', () => expect(fuzzyMatch('hlo', 'hello')).toBe(true));
    it('no match', () => expect(fuzzyMatch('xyz', 'hello')).toBe(false));
});

describe('Search — Highlight', () => {
    it('highlights', () => expect(highlightMatches('Hello World', 'World')).toBe('Hello **World**'));
    it('case insensitive', () => expect(highlightMatches('Hello world', 'hello')).toBe('**Hello** world'));
});

describe('Search — Suggestions', () => {
    const items = ['Alice Smith', 'Bob Jones', 'Alice Bob', 'Charlie'];
    it('matches', () => expect(buildSearchSuggestions('alice', items).length).toBe(2));
    it('max limit', () => expect(buildSearchSuggestions('', items, 2).length).toBe(2));
    it('no match', () => expect(buildSearchSuggestions('xyz', items).length).toBe(0));
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. API Client Patterns — Request Building & Error Handling
// ═══════════════════════════════════════════════════════════════════════════

function buildApiUrl(base: string, path: string, params?: Record<string, string>): string {
    let url = `${base}${path}`;
    if (params) {
        const qs = Object.entries(params).map(([k, v]) => `${encodeURIComponent(k)}=${encodeURIComponent(v)}`).join('&');
        url += `?${qs}`;
    }
    return url;
}

function buildHeaders(token?: string, tenantId?: string): Record<string, string> {
    const h: Record<string, string> = { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' };
    if (token) h['Authorization'] = `Bearer ${token}`;
    if (tenantId) h['X-Tenant-ID'] = tenantId;
    return h;
}

function isRetryableError(status: number): boolean {
    return [408, 429, 500, 502, 503, 504].includes(status);
}

function isAuthError(status: number): boolean {
    return status === 401 || status === 403;
}

function parseApiError(body: any): string {
    if (typeof body === 'string') return body;
    if (body?.error?.message) return body.error.message;
    if (body?.message) return body.message;
    if (body?.error) return typeof body.error === 'string' ? body.error : 'Unknown error';
    return 'Unknown error';
}

describe('API Client — URL Building', () => {
    it('basic', () => expect(buildApiUrl('https://api.com', '/v1/users')).toBe('https://api.com/v1/users'));
    it('with params', () => expect(buildApiUrl('https://api.com', '/v1/users', { page: '1', limit: '10' })).toBe('https://api.com/v1/users?page=1&limit=10'));
});

describe('API Client — Headers', () => {
    it('basic', () => {
        const h = buildHeaders();
        expect(h['Content-Type']).toBe('application/json');
        expect(h['X-Requested-With']).toBe('XMLHttpRequest');
    });
    it('with token', () => expect(buildHeaders('tok-123')['Authorization']).toBe('Bearer tok-123'));
    it('with tenant', () => expect(buildHeaders(undefined, 't-1')['X-Tenant-ID']).toBe('t-1'));
});

describe('API Client — Retryable', () => {
    it('429 retryable', () => expect(isRetryableError(429)).toBe(true));
    it('500 retryable', () => expect(isRetryableError(500)).toBe(true));
    it('503 retryable', () => expect(isRetryableError(503)).toBe(true));
    it('404 not retryable', () => expect(isRetryableError(404)).toBe(false));
    it('200 not retryable', () => expect(isRetryableError(200)).toBe(false));
});

describe('API Client — Auth Error', () => {
    it('401', () => expect(isAuthError(401)).toBe(true));
    it('403', () => expect(isAuthError(403)).toBe(true));
    it('404 not auth', () => expect(isAuthError(404)).toBe(false));
});

describe('API Client — Parse Error', () => {
    it('string', () => expect(parseApiError('Some error')).toBe('Some error'));
    it('nested message', () => expect(parseApiError({ error: { message: 'Bad' } })).toBe('Bad'));
    it('flat message', () => expect(parseApiError({ message: 'Not found' })).toBe('Not found'));
    it('string error', () => expect(parseApiError({ error: 'Fail' })).toBe('Fail'));
    it('unknown', () => expect(parseApiError({})).toBe('Unknown error'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Form Validation — Complex Rules & Cross-Field Checks
// ═══════════════════════════════════════════════════════════════════════════

function validateRequired(value: any, fieldName: string): string | null {
    if (value === undefined || value === null || value === '') return `${fieldName} is required`;
    return null;
}

function validateMinLength(value: string, min: number, fieldName: string): string | null {
    if (value.length < min) return `${fieldName} must be at least ${min} characters`;
    return null;
}

function validateMaxLength(value: string, max: number, fieldName: string): string | null {
    if (value.length > max) return `${fieldName} must be at most ${max} characters`;
    return null;
}

function validateRange(value: number, min: number, max: number, fieldName: string): string | null {
    if (value < min || value > max) return `${fieldName} must be between ${min} and ${max}`;
    return null;
}

function validateDateRange(startDate: string, endDate: string): string | null {
    if (new Date(startDate) >= new Date(endDate)) return 'Start date must be before end date';
    return null;
}

function validateMatchingFields(value1: string, value2: string, fieldName: string): string | null {
    if (value1 !== value2) return `${fieldName} fields must match`;
    return null;
}

function validateForm(fields: Record<string, any>, rules: Array<() => string | null>): { valid: boolean; errors: string[] } {
    const errors = rules.map(r => r()).filter(Boolean) as string[];
    return { valid: errors.length === 0, errors };
}

describe('Form — Required', () => {
    it('empty', () => expect(validateRequired('', 'Name')).toBe('Name is required'));
    it('null', () => expect(validateRequired(null, 'Name')).toBe('Name is required'));
    it('undefined', () => expect(validateRequired(undefined, 'Name')).toBe('Name is required'));
    it('filled', () => expect(validateRequired('Alice', 'Name')).toBeNull());
});

describe('Form — MinLength', () => {
    it('too short', () => expect(validateMinLength('ab', 3, 'Name')).toContain('at least 3'));
    it('ok', () => expect(validateMinLength('abc', 3, 'Name')).toBeNull());
});

describe('Form — MaxLength', () => {
    it('too long', () => expect(validateMaxLength('abcdef', 5, 'Name')).toContain('at most 5'));
    it('ok', () => expect(validateMaxLength('abc', 5, 'Name')).toBeNull());
});

describe('Form — Range', () => {
    it('below', () => expect(validateRange(1, 5, 10, 'Age')).toContain('between'));
    it('above', () => expect(validateRange(15, 5, 10, 'Age')).toContain('between'));
    it('ok', () => expect(validateRange(7, 5, 10, 'Age')).toBeNull());
});

describe('Form — Date Range', () => {
    it('valid', () => expect(validateDateRange('2026-01-01', '2026-12-31')).toBeNull());
    it('invalid', () => expect(validateDateRange('2026-12-31', '2026-01-01')).toContain('before'));
    it('same date', () => expect(validateDateRange('2026-01-01', '2026-01-01')).toContain('before'));
});

describe('Form — Matching', () => {
    it('match', () => expect(validateMatchingFields('abc', 'abc', 'Password')).toBeNull());
    it('mismatch', () => expect(validateMatchingFields('abc', 'def', 'Password')).toContain('must match'));
});

describe('Form — Full Validation', () => {
    it('valid', () => {
        const r = validateForm({}, [
            () => validateRequired('Alice', 'Name'),
            () => validateMinLength('Alice', 2, 'Name'),
        ]);
        expect(r.valid).toBe(true);
    });
    it('invalid', () => {
        const r = validateForm({}, [
            () => validateRequired('', 'Name'),
            () => validateMinLength('', 2, 'Name'),
        ]);
        expect(r.valid).toBe(false);
        expect(r.errors.length).toBe(2);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. URL & Query String Utilities
// ═══════════════════════════════════════════════════════════════════════════

function parseQueryString(qs: string): Record<string, string> {
    if (!qs || qs === '?') return {};
    const query = qs.startsWith('?') ? qs.slice(1) : qs;
    return Object.fromEntries(query.split('&').map(pair => pair.split('=').map(decodeURIComponent)));
}

function buildQueryString(params: Record<string, string | number | boolean>): string {
    const entries = Object.entries(params).filter(([_, v]) => v !== undefined && v !== null);
    if (entries.length === 0) return '';
    return '?' + entries.map(([k, v]) => `${encodeURIComponent(k)}=${encodeURIComponent(String(v))}`).join('&');
}

function joinPath(...segments: string[]): string {
    return segments.map((s, i) => {
        if (i === 0) return s.replace(/\/$/, '');
        if (i === segments.length - 1) return s.replace(/^\//, '');
        return s.replace(/^\/|\/$/g, '');
    }).join('/');
}

describe('URL — Parse QS', () => {
    it('basic', () => expect(parseQueryString('?page=1&limit=10')).toEqual({ page: '1', limit: '10' }));
    it('no ?', () => expect(parseQueryString('page=1')).toEqual({ page: '1' }));
    it('empty', () => expect(parseQueryString('')).toEqual({}));
});

describe('URL — Build QS', () => {
    it('basic', () => expect(buildQueryString({ page: 1, limit: 10 })).toBe('?page=1&limit=10'));
    it('empty', () => expect(buildQueryString({})).toBe(''));
    it('booleans', () => expect(buildQueryString({ active: true })).toBe('?active=true'));
});

describe('URL — Join Path', () => {
    it('basic', () => expect(joinPath('/api', 'v1', 'users')).toBe('/api/v1/users'));
    it('trailing slash', () => expect(joinPath('/api/', '/v1/', '/users')).toBe('/api/v1/users'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Color & Theme Utilities
// ═══════════════════════════════════════════════════════════════════════════

function hexToRgb(hex: string): { r: number; g: number; b: number } | null {
    const match = hex.replace('#', '').match(/^([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i);
    if (!match) return null;
    return { r: parseInt(match[1], 16), g: parseInt(match[2], 16), b: parseInt(match[3], 16) };
}

function rgbToHex(r: number, g: number, b: number): string {
    return '#' + [r, g, b].map(c => c.toString(16).padStart(2, '0')).join('');
}

function getLuminance(r: number, g: number, b: number): number {
    const [rs, gs, bs] = [r, g, b].map(c => {
        const s = c / 255;
        return s <= 0.03928 ? s / 12.92 : Math.pow((s + 0.055) / 1.055, 2.4);
    });
    return 0.2126 * rs + 0.7152 * gs + 0.0722 * bs;
}

function getContrastRatio(color1: { r: number; g: number; b: number }, color2: { r: number; g: number; b: number }): number {
    const l1 = getLuminance(color1.r, color1.g, color1.b);
    const l2 = getLuminance(color2.r, color2.g, color2.b);
    const lighter = Math.max(l1, l2);
    const darker = Math.min(l1, l2);
    return Math.round(((lighter + 0.05) / (darker + 0.05)) * 100) / 100;
}

function meetsWCAG(contrastRatio: number, level: 'AA' | 'AAA'): boolean {
    return level === 'AA' ? contrastRatio >= 4.5 : contrastRatio >= 7;
}

function isDarkColor(hex: string): boolean {
    const rgb = hexToRgb(hex);
    if (!rgb) return false;
    return getLuminance(rgb.r, rgb.g, rgb.b) < 0.179;
}

describe('Color — Hex to RGB', () => {
    it('black', () => expect(hexToRgb('#000000')).toEqual({ r: 0, g: 0, b: 0 }));
    it('white', () => expect(hexToRgb('#ffffff')).toEqual({ r: 255, g: 255, b: 255 }));
    it('red', () => expect(hexToRgb('#ff0000')).toEqual({ r: 255, g: 0, b: 0 }));
    it('no hash', () => expect(hexToRgb('00ff00')).toEqual({ r: 0, g: 255, b: 0 }));
    it('invalid', () => expect(hexToRgb('xyz')).toBeNull());
});

describe('Color — RGB to Hex', () => {
    it('black', () => expect(rgbToHex(0, 0, 0)).toBe('#000000'));
    it('white', () => expect(rgbToHex(255, 255, 255)).toBe('#ffffff'));
    it('blue', () => expect(rgbToHex(0, 0, 255)).toBe('#0000ff'));
});

describe('Color — Contrast', () => {
    it('black/white max', () => expect(getContrastRatio({ r: 0, g: 0, b: 0 }, { r: 255, g: 255, b: 255 })).toBe(21));
    it('same color 1:1', () => expect(getContrastRatio({ r: 128, g: 128, b: 128 }, { r: 128, g: 128, b: 128 })).toBe(1));
});

describe('Color — WCAG', () => {
    it('AA pass', () => expect(meetsWCAG(5.0, 'AA')).toBe(true));
    it('AA fail', () => expect(meetsWCAG(3.0, 'AA')).toBe(false));
    it('AAA pass', () => expect(meetsWCAG(8.0, 'AAA')).toBe(true));
    it('AAA fail', () => expect(meetsWCAG(5.0, 'AAA')).toBe(false));
});

describe('Color — Dark', () => {
    it('black', () => expect(isDarkColor('#000000')).toBe(true));
    it('white', () => expect(isDarkColor('#ffffff')).toBe(false));
    it('dark blue', () => expect(isDarkColor('#000080')).toBe(true));
});
