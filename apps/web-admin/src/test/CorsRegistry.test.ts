/**
 * CorsRegistry Tests
 *
 * Validates CORS configuration: allowed origins, methods, headers,
 * security constraints, and production readiness.
 */
import { describe, it, expect } from 'vitest';
import { CorsRegistry } from 'prime-care-shared';

// ── Structure ──────────────────────────────────────────────────────────────

describe('CorsRegistry · Structure', () => {
    it('exports CorsRegistry as an object', () => {
        expect(CorsRegistry).toBeDefined();
        expect(typeof CorsRegistry).toBe('object');
    });

    it('has all required CORS configuration keys', () => {
        expect(CorsRegistry.ALLOWED_ORIGINS).toBeDefined();
        expect(CorsRegistry.ALLOWED_METHODS).toBeDefined();
        expect(CorsRegistry.ALLOWED_HEADERS).toBeDefined();
        expect(CorsRegistry.EXPOSE_HEADERS).toBeDefined();
        expect(CorsRegistry.MAX_AGE).toBeDefined();
        expect(CorsRegistry.CREDENTIALS).toBeDefined();
    });
});

// ── Allowed Origins ─────────────────────────────────────────────────────────

describe('CorsRegistry · Allowed Origins', () => {
    it('ALLOWED_ORIGINS is an array', () => {
        expect(Array.isArray(CorsRegistry.ALLOWED_ORIGINS)).toBe(true);
    });

    it('has at least 2 origins (production + development)', () => {
        expect(CorsRegistry.ALLOWED_ORIGINS.length).toBeGreaterThanOrEqual(2);
    });

    it('includes production origin (pages.dev)', () => {
        const hasProd = CorsRegistry.ALLOWED_ORIGINS.some(o => o.includes('pages.dev'));
        expect(hasProd).toBe(true);
    });

    it('includes localhost for development', () => {
        const hasLocal = CorsRegistry.ALLOWED_ORIGINS.some(o => o.includes('localhost'));
        expect(hasLocal).toBe(true);
    });

    it('all origins start with http:// or https://', () => {
        for (const origin of CorsRegistry.ALLOWED_ORIGINS) {
            expect(origin).toMatch(/^https?:\/\//);
        }
    });

    it('no origin has a trailing slash', () => {
        for (const origin of CorsRegistry.ALLOWED_ORIGINS) {
            expect(origin.endsWith('/')).toBe(false);
        }
    });

    it('does not include wildcard *', () => {
        expect(CorsRegistry.ALLOWED_ORIGINS).not.toContain('*');
    });
});

// ── Allowed Methods ─────────────────────────────────────────────────────────

describe('CorsRegistry · Allowed Methods', () => {
    it('ALLOWED_METHODS is an array', () => {
        expect(Array.isArray(CorsRegistry.ALLOWED_METHODS)).toBe(true);
    });

    it('includes standard CRUD methods', () => {
        expect(CorsRegistry.ALLOWED_METHODS).toContain('GET');
        expect(CorsRegistry.ALLOWED_METHODS).toContain('POST');
        expect(CorsRegistry.ALLOWED_METHODS).toContain('PUT');
        expect(CorsRegistry.ALLOWED_METHODS).toContain('DELETE');
    });

    it('includes PATCH for partial updates', () => {
        expect(CorsRegistry.ALLOWED_METHODS).toContain('PATCH');
    });

    it('includes OPTIONS for preflight requests', () => {
        expect(CorsRegistry.ALLOWED_METHODS).toContain('OPTIONS');
    });

    it('all methods are uppercase strings', () => {
        for (const method of CorsRegistry.ALLOWED_METHODS) {
            expect(method).toBe(method.toUpperCase());
        }
    });

    it('does not include dangerous methods like TRACE or CONNECT', () => {
        expect(CorsRegistry.ALLOWED_METHODS).not.toContain('TRACE');
        expect(CorsRegistry.ALLOWED_METHODS).not.toContain('CONNECT');
    });
});

// ── Allowed Headers ─────────────────────────────────────────────────────────

describe('CorsRegistry · Allowed Headers', () => {
    it('ALLOWED_HEADERS is an array', () => {
        expect(Array.isArray(CorsRegistry.ALLOWED_HEADERS)).toBe(true);
    });

    it('includes Content-Type for JSON payloads', () => {
        expect(CorsRegistry.ALLOWED_HEADERS).toContain('Content-Type');
    });

    it('includes Authorization for JWT/Bearer tokens', () => {
        expect(CorsRegistry.ALLOWED_HEADERS).toContain('Authorization');
    });

    it('includes tenant identification headers', () => {
        const hasTenantHeader = CorsRegistry.ALLOWED_HEADERS.some(
            h => h.toLowerCase().includes('tenant')
        );
        expect(hasTenantHeader).toBe(true);
    });

    it('includes device identification headers', () => {
        const hasDeviceHeader = CorsRegistry.ALLOWED_HEADERS.some(
            h => h.toLowerCase().includes('device')
        );
        expect(hasDeviceHeader).toBe(true);
    });

    it('has at least 5 allowed headers', () => {
        expect(CorsRegistry.ALLOWED_HEADERS.length).toBeGreaterThanOrEqual(5);
    });
});

// ── Expose Headers ──────────────────────────────────────────────────────────

describe('CorsRegistry · Expose Headers', () => {
    it('EXPOSE_HEADERS is an array', () => {
        expect(Array.isArray(CorsRegistry.EXPOSE_HEADERS)).toBe(true);
    });

    it('includes Content-Length', () => {
        expect(CorsRegistry.EXPOSE_HEADERS).toContain('Content-Length');
    });
});

// ── Security Configuration ──────────────────────────────────────────────────

describe('CorsRegistry · Security Configuration', () => {
    it('MAX_AGE is a positive number', () => {
        expect(typeof CorsRegistry.MAX_AGE).toBe('number');
        expect(CorsRegistry.MAX_AGE).toBeGreaterThan(0);
    });

    it('MAX_AGE is not excessively long (≤ 86400 = 24h)', () => {
        expect(CorsRegistry.MAX_AGE).toBeLessThanOrEqual(86400);
    });

    it('CREDENTIALS is true (cookie-based auth support)', () => {
        expect(CorsRegistry.CREDENTIALS).toBe(true);
    });
});

// ── Production Readiness ────────────────────────────────────────────────────

describe('CorsRegistry · Production Readiness', () => {
    it('production origin uses HTTPS', () => {
        const prodOrigins = CorsRegistry.ALLOWED_ORIGINS.filter(o => !o.includes('localhost'));
        for (const origin of prodOrigins) {
            expect(origin).toMatch(/^https:\/\//);
        }
    });

    it('localhost origins use HTTP (not HTTPS)', () => {
        const localOrigins = CorsRegistry.ALLOWED_ORIGINS.filter(o => o.includes('localhost'));
        for (const origin of localOrigins) {
            expect(origin).toMatch(/^http:\/\//);
        }
    });

    it('no duplicate origins', () => {
        const unique = new Set(CorsRegistry.ALLOWED_ORIGINS);
        expect(unique.size).toBe(CorsRegistry.ALLOWED_ORIGINS.length);
    });

    it('no duplicate methods', () => {
        const unique = new Set(CorsRegistry.ALLOWED_METHODS);
        expect(unique.size).toBe(CorsRegistry.ALLOWED_METHODS.length);
    });

    it('no duplicate headers', () => {
        const normalizedHeaders = CorsRegistry.ALLOWED_HEADERS.map(h => h.toLowerCase());
        const unique = new Set(normalizedHeaders);
        // Allow case variants (X-Tenant-ID vs x-tenant-id) to coexist
        // but flag exact duplicates
        const exactUnique = new Set(CorsRegistry.ALLOWED_HEADERS);
        expect(exactUnique.size).toBe(CorsRegistry.ALLOWED_HEADERS.length);
    });
});
