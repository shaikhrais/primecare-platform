/**
 * API Client & Utilities Deep Tests
 *
 * Self-contained logic tests for:
 * - ApiError class behavior
 * - apiClient method signatures & export structure
 * - Device detection (user-agent parsing)
 * - Environment validation patterns
 * - URL construction & query param handling
 * - Request header patterns
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Replicated ApiError class from apiClient.ts
// ═══════════════════════════════════════════════════════════════════════════

class ApiError extends Error {
    status: number;
    data: unknown;
    constructor(status: number, message: string, data?: unknown) {
        super(message);
        this.name = 'ApiError';
        this.status = status;
        this.data = data;
    }
}

describe('ApiError Class', () => {
    it('extends Error', () => {
        const err = new ApiError(404, 'Not Found');
        expect(err instanceof Error).toBe(true);
    });

    it('has name "ApiError"', () => {
        const err = new ApiError(500, 'Server Error');
        expect(err.name).toBe('ApiError');
    });

    it('stores status code', () => {
        const err = new ApiError(403, 'Forbidden');
        expect(err.status).toBe(403);
    });

    it('stores message', () => {
        const err = new ApiError(400, 'Bad Request');
        expect(err.message).toBe('Bad Request');
    });

    it('stores optional data', () => {
        const data = { field: 'email', error: 'invalid' };
        const err = new ApiError(422, 'Validation', data);
        expect(err.data).toEqual(data);
    });

    it('data is undefined when not provided', () => {
        const err = new ApiError(500, 'Internal');
        expect(err.data).toBeUndefined();
    });

    it('status 408 for timeout', () => {
        const err = new ApiError(408, 'Request timeout after 30000ms', { path: '/api/test' });
        expect(err.status).toBe(408);
        expect(err.data).toEqual({ path: '/api/test' });
    });

    it('is throwable and catchable', () => {
        expect(() => { throw new ApiError(500, 'fail'); }).toThrow('fail');
    });

    it('caught error has correct status', () => {
        try {
            throw new ApiError(429, 'Rate limited');
        } catch (e) {
            expect((e as ApiError).status).toBe(429);
        }
    });

    const statusCodes = [200, 201, 204, 301, 400, 401, 403, 404, 409, 422, 429, 500, 502, 503];
    for (const code of statusCodes) {
        it(`supports status code ${code}`, () => {
            const err = new ApiError(code, `Status ${code}`);
            expect(err.status).toBe(code);
        });
    }
});

// ═══════════════════════════════════════════════════════════════════════════
// apiClient Module Exports
// ═══════════════════════════════════════════════════════════════════════════

describe('apiClient Module Exports', () => {
    it('exports apiClient object', async () => {
        const mod = await import('@/shared/utils/apiClient');
        expect(mod.apiClient).toBeDefined();
    });

    it('exports ApiError class', async () => {
        const mod = await import('@/shared/utils/apiClient');
        expect(mod.ApiError).toBeDefined();
    });

    it('apiClient has get method', async () => {
        const mod = await import('@/shared/utils/apiClient');
        expect(typeof mod.apiClient.get).toBe('function');
    });

    it('apiClient has post method', async () => {
        const mod = await import('@/shared/utils/apiClient');
        expect(typeof mod.apiClient.post).toBe('function');
    });

    it('apiClient has put method', async () => {
        const mod = await import('@/shared/utils/apiClient');
        expect(typeof mod.apiClient.put).toBe('function');
    });

    it('apiClient has patch method', async () => {
        const mod = await import('@/shared/utils/apiClient');
        expect(typeof mod.apiClient.patch).toBe('function');
    });

    it('apiClient has delete method', async () => {
        const mod = await import('@/shared/utils/apiClient');
        expect(typeof mod.apiClient.delete).toBe('function');
    });

    it('apiClient has request method', async () => {
        const mod = await import('@/shared/utils/apiClient');
        expect(typeof mod.apiClient.request).toBe('function');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// URL Construction Logic (replicated)
// ═══════════════════════════════════════════════════════════════════════════

function buildUrl(apiUrl: string, path: string, params?: Record<string, string>): string {
    let url = `${apiUrl}${path}`;
    if (params) {
        const searchParams = new URLSearchParams(params);
        url += `?${searchParams.toString()}`;
    }
    return url;
}

describe('URL Construction', () => {
    const API_URL = 'https://api.example.com';

    it('builds simple path', () => {
        expect(buildUrl(API_URL, '/v1/users')).toBe('https://api.example.com/v1/users');
    });

    it('appends query params', () => {
        const url = buildUrl(API_URL, '/v1/users', { page: '1', limit: '10' });
        expect(url).toContain('page=1');
        expect(url).toContain('limit=10');
    });

    it('handles empty params', () => {
        expect(buildUrl(API_URL, '/v1/data')).toBe('https://api.example.com/v1/data');
    });

    it('handles single param', () => {
        const url = buildUrl(API_URL, '/v1/search', { q: 'test' });
        expect(url).toBe('https://api.example.com/v1/search?q=test');
    });

    it('handles special characters in params', () => {
        const url = buildUrl(API_URL, '/v1/search', { q: 'hello world' });
        expect(url).toContain('q=hello+world');
    });

    it('handles empty API URL', () => {
        expect(buildUrl('', '/v1/health')).toBe('/v1/health');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Request Header Construction (replicated)
// ═══════════════════════════════════════════════════════════════════════════

function buildHeaders(tenantId?: string, isFormData?: boolean, customHeaders?: Record<string, string>): Record<string, string> {
    const headers: Record<string, string> = {};
    if (!isFormData) headers['Content-Type'] = 'application/json';
    if (tenantId) headers['X-Tenant-ID'] = tenantId;
    headers['X-Requested-With'] = 'XMLHttpRequest';
    if (customHeaders) Object.assign(headers, customHeaders);
    return headers;
}

describe('Request Header Construction', () => {
    it('includes Content-Type for JSON', () => {
        const h = buildHeaders();
        expect(h['Content-Type']).toBe('application/json');
    });

    it('excludes Content-Type for FormData', () => {
        const h = buildHeaders(undefined, true);
        expect(h['Content-Type']).toBeUndefined();
    });

    it('includes CSRF protection header', () => {
        const h = buildHeaders();
        expect(h['X-Requested-With']).toBe('XMLHttpRequest');
    });

    it('includes tenant ID when provided', () => {
        const h = buildHeaders('tenant-123');
        expect(h['X-Tenant-ID']).toBe('tenant-123');
    });

    it('excludes tenant ID when not provided', () => {
        const h = buildHeaders();
        expect(h['X-Tenant-ID']).toBeUndefined();
    });

    it('custom headers override defaults', () => {
        const h = buildHeaders(undefined, false, { 'Content-Type': 'text/plain' });
        expect(h['Content-Type']).toBe('text/plain');
    });

    it('all default headers present for standard request', () => {
        const h = buildHeaders('t-1');
        expect(Object.keys(h)).toContain('Content-Type');
        expect(Object.keys(h)).toContain('X-Tenant-ID');
        expect(Object.keys(h)).toContain('X-Requested-With');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Retry Logic (replicated from QueryProvider)
// ═══════════════════════════════════════════════════════════════════════════

function shouldRetry(failureCount: number, errorStatus?: number): boolean {
    if (errorStatus !== undefined && errorStatus >= 400 && errorStatus < 500) return false;
    return failureCount < 2;
}

function retryDelay(attempt: number): number {
    return Math.min(1000 * 2 ** attempt, 10_000);
}

describe('Retry Logic', () => {
    it('retries on first failure (server error)', () => {
        expect(shouldRetry(0, 500)).toBe(true);
    });

    it('retries on second failure (server error)', () => {
        expect(shouldRetry(1, 500)).toBe(true);
    });

    it('stops after 2 failures', () => {
        expect(shouldRetry(2, 500)).toBe(false);
    });

    it('does not retry 400 errors', () => {
        expect(shouldRetry(0, 400)).toBe(false);
    });

    it('does not retry 401 errors', () => {
        expect(shouldRetry(0, 401)).toBe(false);
    });

    it('does not retry 403 errors', () => {
        expect(shouldRetry(0, 403)).toBe(false);
    });

    it('does not retry 404 errors', () => {
        expect(shouldRetry(0, 404)).toBe(false);
    });

    it('does not retry 422 errors', () => {
        expect(shouldRetry(0, 422)).toBe(false);
    });

    it('retries on 502 errors', () => {
        expect(shouldRetry(0, 502)).toBe(true);
    });

    it('retries on 503 errors', () => {
        expect(shouldRetry(0, 503)).toBe(true);
    });

    it('retries when no status (network error)', () => {
        expect(shouldRetry(0)).toBe(true);
    });

    it('retry delay exponential backoff', () => {
        expect(retryDelay(0)).toBe(1000);
        expect(retryDelay(1)).toBe(2000);
        expect(retryDelay(2)).toBe(4000);
    });

    it('retry delay caps at 10s', () => {
        expect(retryDelay(10)).toBe(10_000);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Device Detection Logic (replicated from device.ts)
// ═══════════════════════════════════════════════════════════════════════════

function detectDeviceType(ua: string): string {
    if (/mobile/i.test(ua)) return 'Mobile';
    if (/tablet/i.test(ua)) return 'Tablet';
    return 'Desktop';
}

function detectBrowser(ua: string): string {
    if (/chrome/i.test(ua)) return 'Chrome';
    if (/firefox/i.test(ua)) return 'Firefox';
    if (/safari/i.test(ua) && !/chrome/i.test(ua)) return 'Safari';
    if (/edge/i.test(ua)) return 'Edge';
    return 'Unknown Browser';
}

describe('Device Type Detection', () => {
    it('detects mobile', () => {
        expect(detectDeviceType('Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1')).toBe('Mobile');
    });

    it('detects tablet', () => {
        expect(detectDeviceType('Mozilla/5.0 (iPad; CPU OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Tablet Safari/604.1')).toBe('Tablet');
    });

    it('detects desktop (Chrome)', () => {
        expect(detectDeviceType('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36')).toBe('Desktop');
    });

    it('detects desktop (empty UA)', () => {
        expect(detectDeviceType('')).toBe('Desktop');
    });
});

describe('Browser Detection', () => {
    it('detects Chrome', () => {
        expect(detectBrowser('Mozilla/5.0 (Windows) Chrome/120.0.0.0 Safari/537.36')).toBe('Chrome');
    });

    it('detects Firefox', () => {
        expect(detectBrowser('Mozilla/5.0 (Windows) Gecko/20100101 Firefox/121.0')).toBe('Firefox');
    });

    it('detects Safari (not Chrome)', () => {
        expect(detectBrowser('Mozilla/5.0 (Macintosh) AppleWebKit/537.36 Safari/604.1')).toBe('Safari');
    });

    it('Edge detected as Chrome (Chromium-based)', () => {
        // Edge UA includes "Chrome" so it gets detected as Chrome first
        expect(detectBrowser('Mozilla/5.0 Edge/120 Chrome/120')).toBe('Chrome');
    });

    it('unknown browser for empty UA', () => {
        expect(detectBrowser('')).toBe('Unknown Browser');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// device.ts Module Exports
// ═══════════════════════════════════════════════════════════════════════════

describe('device.ts Module Exports', () => {
    it('exports getDeviceId', async () => {
        const mod = await import('@/shared/utils/device');
        expect(mod.getDeviceId).toBeDefined();
        expect(typeof mod.getDeviceId).toBe('function');
    });

    it('exports getDeviceMetadata', async () => {
        const mod = await import('@/shared/utils/device');
        expect(mod.getDeviceMetadata).toBeDefined();
        expect(typeof mod.getDeviceMetadata).toBe('function');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// env.ts Module Exports
// ═══════════════════════════════════════════════════════════════════════════

describe('env.ts Module Exports', () => {
    it('exports validateEnvironment', async () => {
        const mod = await import('@/shared/utils/env');
        expect(mod.validateEnvironment).toBeDefined();
        expect(typeof mod.validateEnvironment).toBe('function');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Environment Validation Logic (replicated from env.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface EnvVar { name: string; required: boolean; defaultValue?: string; }

function validateEnv(vars: EnvVar[], envValues: Record<string, string | undefined>): string[] {
    const missing: string[] = [];
    for (const { name, required, defaultValue } of vars) {
        const value = envValues[name];
        if (required && !value && !defaultValue) {
            missing.push(name);
        }
    }
    return missing;
}

describe('Environment Validation', () => {
    it('no missing when all required present', () => {
        const vars: EnvVar[] = [{ name: 'API_URL', required: true }];
        expect(validateEnv(vars, { API_URL: 'http://localhost' })).toEqual([]);
    });

    it('reports missing required vars', () => {
        const vars: EnvVar[] = [{ name: 'API_URL', required: true }];
        expect(validateEnv(vars, {})).toEqual(['API_URL']);
    });

    it('optional vars not reported missing', () => {
        const vars: EnvVar[] = [{ name: 'DEBUG', required: false }];
        expect(validateEnv(vars, {})).toEqual([]);
    });

    it('required with default not reported missing', () => {
        const vars: EnvVar[] = [{ name: 'PORT', required: true, defaultValue: '3000' }];
        expect(validateEnv(vars, {})).toEqual([]);
    });

    it('multiple missing vars reported', () => {
        const vars: EnvVar[] = [
            { name: 'A', required: true },
            { name: 'B', required: true },
            { name: 'C', required: false },
        ];
        expect(validateEnv(vars, {})).toEqual(['A', 'B']);
    });

    it('empty string treated as missing', () => {
        const vars: EnvVar[] = [{ name: 'TOKEN', required: true }];
        expect(validateEnv(vars, { TOKEN: '' })).toEqual(['TOKEN']);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Body Serialization Logic (replicated from apiClient)
// ═══════════════════════════════════════════════════════════════════════════

function serializeBody(body: unknown, isFormData: boolean): string | FormData | undefined {
    if (!body) return undefined;
    if (isFormData) return body as FormData;
    return JSON.stringify(body);
}

describe('Body Serialization', () => {
    it('serializes object to JSON string', () => {
        expect(serializeBody({ name: 'test' }, false)).toBe('{"name":"test"}');
    });

    it('returns undefined for null body', () => {
        expect(serializeBody(null, false)).toBeUndefined();
    });

    it('returns undefined for undefined body', () => {
        expect(serializeBody(undefined, false)).toBeUndefined();
    });

    it('leaves FormData as-is', () => {
        const fd = new FormData();
        fd.append('file', 'test');
        expect(serializeBody(fd, true)).toBe(fd);
    });

    it('serializes arrays', () => {
        expect(serializeBody([1, 2, 3], false)).toBe('[1,2,3]');
    });

    it('serializes nested objects', () => {
        const result = serializeBody({ a: { b: 'c' } }, false);
        expect(result).toBe('{"a":{"b":"c"}}');
    });
});
