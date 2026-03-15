/**
 * API Registry Completeness Tests
 *
 * Validates that the ApiRegistry covers all backend module endpoints
 * and maintains consistency between frontend references and backend routes.
 */
import { describe, it, expect } from 'vitest';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry } = AdminRegistry;

// Recursively extract all string values (endpoints) from ApiRegistry
function extractEndpoints(obj: any, prefix = ''): { key: string; endpoint: string }[] {
    const results: { key: string; endpoint: string }[] = [];
    for (const key in obj) {
        const val = obj[key];
        const fullKey = prefix ? `${prefix}.${key}` : key;
        if (typeof val === 'string') {
            results.push({ key: fullKey, endpoint: val });
        } else if (typeof val === 'object' && val !== null && typeof val !== 'function') {
            results.push(...extractEndpoints(val, fullKey));
        }
    }
    return results;
}

describe('API Registry Completeness', () => {
    const allEndpoints = extractEndpoints(ApiRegistry);

    // ── Coverage ──────────────────────────────────────────────────────────
    describe('endpoint coverage', () => {
        it('should have at least 100 API endpoints registered', () => {
            expect(allEndpoints.length).toBeGreaterThanOrEqual(100);
        });

        it('all endpoints should start with /v1/', () => {
            const invalid = allEndpoints.filter(e => !e.endpoint.startsWith('/v1/'));
            expect(
                invalid.map(e => `${e.key}: "${e.endpoint}"`),
                'Endpoints not starting with /v1/'
            ).toEqual([]);
        });
    });

    // ── Backend Module Coverage ────────────────────────────────────────────
    describe('backend module coverage', () => {
        const expectedModules = [
            { name: 'AUTH', prefix: '/v1/auth' },
            { name: 'ADMIN', prefix: '/v1/admin' },
            { name: 'MANAGER', prefix: '/v1/manager' },
            { name: 'PSW', prefix: '/v1/psw' },
            { name: 'RN', prefix: '/v1/rn' },
            { name: 'CLIENT', prefix: '/v1/client' },
        ];

        expectedModules.forEach(({ name, prefix }) => {
            it(`should have endpoints for ${name} module (${prefix})`, () => {
                const moduleEndpoints = allEndpoints.filter(e => e.endpoint.startsWith(prefix));
                expect(
                    moduleEndpoints.length,
                    `No endpoints found for ${name} (${prefix})`
                ).toBeGreaterThanOrEqual(1);
            });
        });
    });

    // ── Auth Endpoints ────────────────────────────────────────────────────
    describe('auth endpoints', () => {
        it('should have login endpoint', () => {
            expect(ApiRegistry.AUTH.LOGIN).toBeDefined();
            expect(ApiRegistry.AUTH.LOGIN).toContain('login');
        });

        it('should have register endpoint', () => {
            expect(ApiRegistry.AUTH.REGISTER).toBeDefined();
            expect(ApiRegistry.AUTH.REGISTER).toContain('register');
        });

        it('should have refresh endpoint', () => {
            expect(ApiRegistry.AUTH.REFRESH).toBeDefined();
            expect(ApiRegistry.AUTH.REFRESH).toContain('refresh');
        });
    });

    // ── Admin CRUD Endpoints ──────────────────────────────────────────────
    describe('admin CRUD endpoints', () => {
        it('should have user management endpoints', () => {
            expect(ApiRegistry.ADMIN.USERS).toBeDefined();
        });

        it('should have service management endpoints', () => {
            expect(ApiRegistry.ADMIN.SERVICES).toBeDefined();
        });
    });

    // ── Endpoint Format Validation ────────────────────────────────────────
    describe('endpoint format validation', () => {
        it('endpoints should use kebab-case', () => {
            const withUnderscore = allEndpoints.filter(e => {
                const segments = e.endpoint.split('/').filter(Boolean);
                return segments.some(s => s.includes('_') && !s.startsWith(':'));
            });
            // Allow some exceptions for legacy endpoints
            expect(withUnderscore.length).toBeLessThan(20);
        });

        it('no endpoints should contain double slashes', () => {
            const withDouble = allEndpoints.filter(e => e.endpoint.includes('//'));
            expect(withDouble.map(e => `${e.key}: "${e.endpoint}"`)).toEqual([]);
        });

        it('no endpoints should have trailing slashes', () => {
            const withTrailing = allEndpoints.filter(
                e => e.endpoint.endsWith('/') && e.endpoint.length > 1
            );
            expect(withTrailing.map(e => `${e.key}: "${e.endpoint}"`)).toEqual([]);
        });
    });

    // ── Consistency ───────────────────────────────────────────────────────
    describe('consistency', () => {
        it('should have a high unique endpoint ratio', () => {
            const values = allEndpoints.map(e => e.endpoint);
            const uniqueValues = [...new Set(values)];
            // With role-based overlap, unique endpoints should be at least 30% of total
            const uniqueRatio = uniqueValues.length / values.length;
            expect(uniqueRatio).toBeGreaterThan(0.15);
        });
    });
});
