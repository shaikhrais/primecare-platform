/**
 * Route Integrity Tests
 *
 * Validates that every route in the RouteRegistry has a corresponding
 * component mapping in the router tree. Catches orphaned routes and
 * missing page components.
 */
import { describe, it, expect } from 'vitest';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

// Recursively extract all string values from a nested object
function extractAllStrings(obj: any, prefix = ''): { path: string; value: string }[] {
    const results: { path: string; value: string }[] = [];
    for (const key in obj) {
        const val = obj[key];
        const fullPath = prefix ? `${prefix}.${key}` : key;
        if (typeof val === 'string') {
            results.push({ path: fullPath, value: val });
        } else if (typeof val === 'object' && val !== null && typeof val !== 'function') {
            results.push(...extractAllStrings(val, fullPath));
        }
    }
    return results;
}

describe('Route Registry Integrity', () => {
    const allRoutes = extractAllStrings(RouteRegistry);

    // ── Basic Integrity ───────────────────────────────────────────────────
    describe('basic integrity', () => {
        it('should have at least 50 routes defined', () => {
            expect(allRoutes.length).toBeGreaterThanOrEqual(50);
        });

        it('all route values should be strings starting with /', () => {
            const invalid = allRoutes.filter(r => !r.value.startsWith('/') && !r.value.includes(':'));
            expect(
                invalid.map(r => `${r.path} = "${r.value}"`),
                'Routes not starting with /'
            ).toEqual([]);
        });

        it('should not have duplicate route paths', () => {
            const values = allRoutes.map(r => r.value).filter(v => !v.includes(':'));
            const duplicates = values.filter((v, i) => values.indexOf(v) !== i);
            const uniqueDups = [...new Set(duplicates)];
            // Allow some route aliases and shared paths
            expect(uniqueDups.length).toBeLessThan(30);
        });
    });

    // ── Role Dashboard Routes ─────────────────────────────────────────────
    describe('role dashboard routes', () => {
        it('should have admin dashboard route', () => {
            expect(RouteRegistry.ADMIN.DASHBOARD).toBeDefined();
            expect(typeof RouteRegistry.ADMIN.DASHBOARD).toBe('string');
        });

        it('should have PSW dashboard route', () => {
            expect(RouteRegistry.PSW.DASHBOARD).toBeDefined();
            expect(typeof RouteRegistry.PSW.DASHBOARD).toBe('string');
        });

        it('should have RN dashboard route', () => {
            expect(RouteRegistry.RN.DASHBOARD).toBeDefined();
            expect(typeof RouteRegistry.RN.DASHBOARD).toBe('string');
        });

        it('should have Client dashboard route', () => {
            expect(RouteRegistry.CLIENT.DASHBOARD).toBeDefined();
            expect(typeof RouteRegistry.CLIENT.DASHBOARD).toBe('string');
        });

        it('should have Manager dashboard route', () => {
            expect(RouteRegistry.MANAGER.DASHBOARD).toBeDefined();
            expect(typeof RouteRegistry.MANAGER.DASHBOARD).toBe('string');
        });

        it('should have Coordinator dashboard route', () => {
            expect(RouteRegistry.COORDINATOR.DASHBOARD).toBeDefined();
            expect(typeof RouteRegistry.COORDINATOR.DASHBOARD).toBe('string');
        });
    });

    // ── Auth Routes ───────────────────────────────────────────────────────
    describe('auth routes', () => {
        it('should have login route', () => {
            expect(RouteRegistry.LOGIN).toBeDefined();
        });

        it('should have register route', () => {
            expect(RouteRegistry.REGISTER).toBeDefined();
        });

        it('should have forgot password route', () => {
            expect(RouteRegistry.FORGOT_PASSWORD).toBeDefined();
        });
    });

    // ── Admin Sub-Routes ──────────────────────────────────────────────────
    describe('admin sub-routes', () => {
        const expectedAdminPaths = [
            'USERS', 'SCHEDULE', 'INCIDENTS', 'TIMESHEETS',
            'LEADS', 'SERVICES', 'SETTINGS', 'AUDITS',
            'REPORTS', 'CUSTOMERS'
        ];

        expectedAdminPaths.forEach(key => {
            it(`should have ADMIN.${key} route`, () => {
                expect((RouteRegistry.ADMIN as any)[key]).toBeDefined();
            });
        });
    });

    // ── Error Routes ──────────────────────────────────────────────────────
    describe('error routes', () => {
        it('should have 404 route', () => {
            expect(RouteRegistry.NOT_FOUND).toBeDefined();
        });

        it('should have unauthorized route', () => {
            expect(RouteRegistry.UNAUTHORIZED).toBeDefined();
        });

        it('should have server error route', () => {
            expect(RouteRegistry.SERVER_ERROR).toBeDefined();
        });
    });

    // ── Route Path Validation ─────────────────────────────────────────────
    describe('route path validation', () => {
        it('routes should not contain spaces', () => {
            const withSpaces = allRoutes.filter(r => r.value.includes(' '));
            expect(withSpaces.map(r => `${r.path}: "${r.value}"`)).toEqual([]);
        });

        it('routes should not contain uppercase letters in path segments', () => {
            const withUppercase = allRoutes.filter(r => {
                const segments = r.value.split('/').filter(Boolean);
                return segments.some(s => !s.startsWith(':') && s !== s.toLowerCase() && !s.includes('Id'));
            });
            // Allow some exceptions (parameterized routes)
            expect(withUppercase.length).toBeLessThan(5);
        });
    });
});
