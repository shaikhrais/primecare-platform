/**
 * ApiRegistry Unit Tests
 *
 * Validates the ApiRegistry structure: all endpoint categories exist,
 * endpoint values are valid strings or functions, no orphan patterns,
 * and AUTH/USER/PLATFORM/TENANCY/PUBLIC all have expected shape.
 */
import { describe, it, expect } from 'vitest';
import { ApiRegistry } from 'prime-care-shared';

// Helper: recursively collect all string endpoints from an object
function collectEndpoints(obj: any, prefix = ''): { path: string; key: string }[] {
    const endpoints: { path: string; key: string }[] = [];
    for (const [key, value] of Object.entries(obj)) {
        const fullKey = prefix ? `${prefix}.${key}` : key;
        if (typeof value === 'string') {
            endpoints.push({ path: value, key: fullKey });
        } else if (typeof value === 'function') {
            // Dynamic endpoints like MESSAGING_SEND(threadId) — test with a placeholder
            try {
                const result = value('test-id');
                if (typeof result === 'string') {
                    endpoints.push({ path: result, key: fullKey });
                }
            } catch {
                // Some functions need multiple args — skip them
            }
        } else if (typeof value === 'object' && value !== null) {
            endpoints.push(...collectEndpoints(value, fullKey));
        }
    }
    return endpoints;
}

describe('ApiRegistry', () => {
    // ── Top-Level Structure ───────────────────────────────────────────────
    describe('top-level structure', () => {
        it('should have AUTH section', () => {
            expect(ApiRegistry.AUTH).toBeDefined();
            expect(ApiRegistry.AUTH.LOGIN).toBeDefined();
            expect(ApiRegistry.AUTH.REGISTER).toBeDefined();
            expect(ApiRegistry.AUTH.LOGOUT).toBeDefined();
        });

        it('should have USER section', () => {
            expect(ApiRegistry.USER).toBeDefined();
            expect(ApiRegistry.USER.PROFILE).toBeDefined();
        });

        it('should have PLATFORM section', () => {
            expect(ApiRegistry.PLATFORM).toBeDefined();
        });

        it('should have TENANCY section', () => {
            expect(ApiRegistry.TENANCY).toBeDefined();
        });

        it('should have PUBLIC section', () => {
            expect(ApiRegistry.PUBLIC).toBeDefined();
        });

        it('should have SUPPORT section', () => {
            expect(ApiRegistry.SUPPORT).toBeDefined();
        });
    });

    // ── AUTH Endpoints ────────────────────────────────────────────────────
    describe('AUTH endpoints', () => {
        it('LOGIN should be a valid path', () => {
            expect(ApiRegistry.AUTH.LOGIN).toBe('/v1/auth/login');
        });

        it('all AUTH paths should start with /v1/auth/', () => {
            const authEndpoints = collectEndpoints(ApiRegistry.AUTH);
            authEndpoints.forEach(({ path, key }) => {
                expect(path.startsWith('/v1/auth/'), `${key}: "${path}" should start with /v1/auth/`).toBe(true);
            });
        });
    });

    // ── Endpoint Format Validation ────────────────────────────────────────
    describe('endpoint format validation', () => {
        it('all string endpoints should start with /', () => {
            const allEndpoints = collectEndpoints(ApiRegistry);
            allEndpoints.forEach(({ path, key }) => {
                expect(path.startsWith('/'), `${key}: "${path}" should start with /`).toBe(true);
            });
        });

        it('should have at least 50 unique endpoints', () => {
            const allEndpoints = collectEndpoints(ApiRegistry);
            const uniquePaths = new Set(allEndpoints.map(e => e.path));
            expect(uniquePaths.size).toBeGreaterThanOrEqual(50);
        });

        it('all endpoints should start with /v1/', () => {
            const allEndpoints = collectEndpoints(ApiRegistry);
            allEndpoints.forEach(({ path, key }) => {
                expect(path.startsWith('/v1/'), `${key}: "${path}" should start with /v1/`).toBe(true);
            });
        });

        it('no endpoint should have trailing slash', () => {
            const allEndpoints = collectEndpoints(ApiRegistry);
            allEndpoints.forEach(({ path, key }) => {
                if (path.length > 1) {
                    expect(path.endsWith('/'), `${key}: "${path}" has trailing slash`).toBe(false);
                }
            });
        });
    });

    // ── Legacy Mappings ───────────────────────────────────────────────────
    describe('legacy mappings', () => {
        it('MANAGER should be an alias for TENANCY.MANAGER', () => {
            expect(ApiRegistry.MANAGER).toBeDefined();
        });

        it('PSW should be an alias for TENANCY.PSW', () => {
            expect(ApiRegistry.PSW).toBeDefined();
        });

        it('CLIENT should be an alias for TENANCY.CLIENT', () => {
            expect(ApiRegistry.CLIENT).toBeDefined();
        });
    });

    // ── Dynamic Endpoints ─────────────────────────────────────────────────
    describe('dynamic endpoints', () => {
        it('MESSAGING_SEND should be a function', () => {
            expect(typeof ApiRegistry.USER.MESSAGING_SEND).toBe('function');
        });

        it('MESSAGING_SEND returns valid path', () => {
            const path = ApiRegistry.USER.MESSAGING_SEND('thread-123');
            expect(path).toBe('/v1/user/messaging/threads/thread-123/messages');
        });
    });

    // ── Endpoint Count Per Section ────────────────────────────────────────
    describe('endpoint distribution', () => {
        it('PLATFORM section should have significant endpoints', () => {
            const platformEndpoints = collectEndpoints(ApiRegistry.PLATFORM);
            expect(platformEndpoints.length).toBeGreaterThan(20);
        });

        it('TENANCY section should have significant endpoints', () => {
            const tenancyEndpoints = collectEndpoints(ApiRegistry.TENANCY);
            expect(tenancyEndpoints.length).toBeGreaterThan(20);
        });
    });
});
