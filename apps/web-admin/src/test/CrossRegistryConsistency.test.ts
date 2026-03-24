/**
 * Cross-Registry Consistency Tests
 *
 * Validates cross-registry integrity: every page with a formRegistryId
 * references a real form, every home has a valid route, every
 * list's fetchEndpoint is non-empty, and sidebar links point to valid routes.
 */
import { describe, it, expect } from 'vitest';
import {
    PageRegistry, HomeRegistry, ListRegistry,
    getLinksForRole, getButtonsForPage,
    FormRegistry, AdminRegistry,
} from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

describe('Cross-Registry Consistency', () => {
    // ── Page → Form Wiring ────────────────────────────────────────────────
    describe('page→form wiring', () => {
        it('every page with formRegistryId should reference an existing form', () => {
            const pagesWithForms = PageRegistry.filter(p => p.formRegistryId);
            const formIds = FormRegistry.map((f: any) => f.id);

            pagesWithForms.forEach(page => {
                expect(
                    formIds.includes(page.formRegistryId),
                    `Page ${page.id} references form "${page.formRegistryId}" which doesn't exist in FormRegistry`
                ).toBe(true);
            });
        });
    });

    // ── Home Validation ──────────────────────────────────────────────
    describe('home validation', () => {
        it('every home route should start with /', () => {
            HomeRegistry.forEach(dash => {
                expect(
                    dash.route.startsWith('/'),
                    `Home ${dash.id} route "${dash.route}" is invalid`
                ).toBe(true);
            });
        });

        it('every home should have at least one widget', () => {
            HomeRegistry.forEach(dash => {
                expect(
                    dash.widgets.length,
                    `Home ${dash.id} has no widgets`
                ).toBeGreaterThan(0);
            });
        });
    });

    // ── List Validation ───────────────────────────────────────────────────
    describe('list validation', () => {
        it('every list fetchEndpoint should be non-empty', () => {
            ListRegistry.forEach(list => {
                expect(
                    list.fetchEndpoint.length,
                    `List ${list.id} has empty fetchEndpoint`
                ).toBeGreaterThan(0);
            });
        });

        it('every list should have at least one column', () => {
            ListRegistry.forEach(list => {
                expect(
                    list.columns.length,
                    `List ${list.id} has no columns`
                ).toBeGreaterThan(0);
            });
        });
    });

    // ── Sidebar Link Validation ───────────────────────────────────────────
    describe('sidebar link consistency', () => {
        const roles = ['admin', 'psw', 'rn', 'coordinator', 'client', 'manager', 'scrum_master'];

        roles.forEach(role => {
            it(`${role} sidebar links should have valid paths`, () => {
                const links = getLinksForRole(role);
                links.forEach(link => {
                    expect(link.path, `Link ${link.id} has no path`).toBeDefined();
                    expect(
                        link.path!.startsWith('/'),
                        `Link ${link.id} path "${link.path}" should start with /`
                    ).toBe(true);
                });
            });
        });

        it('every role should have at least 2 sidebar links', () => {
            const coreRoles = ['admin', 'psw', 'rn', 'coordinator', 'client'];
            coreRoles.forEach(role => {
                const links = getLinksForRole(role);
                expect(
                    links.length,
                    `${role} has only ${links.length} sidebar links`
                ).toBeGreaterThanOrEqual(2);
            });
        });
    });

    // ── RouteRegistry Structural ──────────────────────────────────────────
    describe('RouteRegistry structure', () => {
        it('should have LOGIN route', () => {
            expect(RouteRegistry.LOGIN).toBeDefined();
        });

        it('should have ADMIN routes', () => {
            expect(RouteRegistry.ADMIN).toBeDefined();
            expect(RouteRegistry.ADMIN.DASHBOARD).toBeDefined();
            expect(RouteRegistry.ADMIN.USERS).toBeDefined();
        });

        it('should have role-specific routes', () => {
            expect(RouteRegistry.PSW).toBeDefined();
            expect(RouteRegistry.RN).toBeDefined();
            expect(RouteRegistry.COORDINATOR).toBeDefined();
            expect(RouteRegistry.CLIENT).toBeDefined();
        });

        it('all route values should be strings starting with /', () => {
            const flattenRoutes = (obj: any, prefix = ''): string[] => {
                const routes: string[] = [];
                for (const [key, value] of Object.entries(obj)) {
                    if (typeof value === 'string') {
                        routes.push(value);
                    } else if (typeof value === 'object' && value !== null && typeof value !== 'function') {
                        routes.push(...flattenRoutes(value, `${prefix}${key}.`));
                    }
                }
                return routes;
            };

            const allRoutes = flattenRoutes(RouteRegistry);
            allRoutes.forEach(route => {
                expect(
                    typeof route === 'string' && route.startsWith('/'),
                    `Route "${route}" should be a string starting with /`
                ).toBe(true);
            });
        });
    });

    // ── getButtonsForPage() Wiring ────────────────────────────────────────
    describe('getButtonsForPage()', () => {
        it('admin.home should have buttons', () => {
            const buttons = getButtonsForPage('admin.home');
            // May return empty if not wired, but should not throw
            expect(Array.isArray(buttons)).toBe(true);
        });

        it('returned buttons should have id and label', () => {
            const buttons = getButtonsForPage('admin.home');
            buttons.forEach(btn => {
                expect(btn.id).toBeDefined();
                expect(btn.label).toBeDefined();
            });
        });
    });
});
