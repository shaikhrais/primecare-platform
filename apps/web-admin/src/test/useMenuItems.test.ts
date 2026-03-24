/**
 * useMenuItems Unit Tests
 *
 * Validates that the useMenuItems hook (which drives the sidebar)
 * correctly generates menu items from the registry for each role.
 * Tests are non-React since useMenuItems is a pure function under useMemo.
 */
import { describe, it, expect } from 'vitest';
import { AdminRegistry, getLinksForRole } from 'prime-care-shared';

const { RouteRegistry, ContentRegistry } = AdminRegistry;

// Replicate the logic from useMenuItems.ts for unit testing
// (the hook just wraps this in useMemo)
function buildMenuItems(role: string) {
    const DASHBOARD_MAP: Record<string, { label: string; path: string; icon: string }> = {
        admin:        { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.ADMIN.DASHBOARD, icon: '📊' },
        psw:          { label: ContentRegistry.MENU.WORK_SCHEDULE, path: RouteRegistry.PSW.DASHBOARD, icon: '🗓️' },
        rn:           { label: ContentRegistry.MENU.CLINICAL_DASHBOARD, path: RouteRegistry.RN.DASHBOARD, icon: '🩺' },
        coordinator:  { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.COORDINATOR.DASHBOARD, icon: '📍' },
        client:       { label: ContentRegistry.MENU.CLIENT_HUB, path: RouteRegistry.CLIENT.DASHBOARD, icon: '🏠' },
        manager:      { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.MANAGER.DASHBOARD, icon: '📊' },
    };

    const lowerRole = role.toLowerCase();
    const home = DASHBOARD_MAP[lowerRole] || DASHBOARD_MAP['client'];
    const registryLinks = getLinksForRole(lowerRole);
    const roleLinks = registryLinks.map(link => ({
        label: link.label,
        path: link.path || '#',
        icon: '📄',
    }));

    const seen = new Set<string>();
    const result: { label: string; path: string; icon: string }[] = [];
    for (const item of [home, ...roleLinks]) {
        if (!seen.has(item.path)) {
            seen.add(item.path);
            result.push(item);
        }
    }
    return result;
}

describe('useMenuItems (sidebar generation)', () => {
    // ── Core: Every role gets a non-empty menu ────────────────────────────
    describe('every role gets menu items', () => {
        const roles = ['admin', 'psw', 'rn', 'coordinator', 'client', 'manager'];

        roles.forEach(role => {
            it(`${role} should have at least 3 menu items`, () => {
                const items = buildMenuItems(role);
                expect(items.length).toBeGreaterThanOrEqual(3);
            });
        });
    });

    // ── Home is always first ────────────────────────────────────────
    describe('home positioning', () => {
        it('admin menu should start with Home', () => {
            const items = buildMenuItems('admin');
            expect(items[0].path).toBe(RouteRegistry.ADMIN.DASHBOARD);
        });

        it('psw menu should start with Work Schedule', () => {
            const items = buildMenuItems('psw');
            expect(items[0].path).toBe(RouteRegistry.PSW.DASHBOARD);
        });

        it('rn menu should start with Clinical Home', () => {
            const items = buildMenuItems('rn');
            expect(items[0].path).toBe(RouteRegistry.RN.DASHBOARD);
        });
    });

    // ── No duplicate paths ───────────────────────────────────────────────
    describe('deduplication', () => {
        const roles = ['admin', 'psw', 'rn', 'coordinator', 'client', 'manager'];

        roles.forEach(role => {
            it(`${role} menu should have no duplicate paths`, () => {
                const items = buildMenuItems(role);
                const paths = items.map(i => i.path);
                const unique = new Set(paths);
                expect(unique.size).toBe(paths.length);
            });
        });
    });

    // ── All paths are valid ──────────────────────────────────────────────
    describe('path validity', () => {
        const roles = ['admin', 'psw', 'rn', 'coordinator', 'client', 'manager'];

        roles.forEach(role => {
            it(`${role} menu items should all have paths starting with /`, () => {
                const items = buildMenuItems(role);
                items.forEach(item => {
                    expect(item.path.startsWith('/'), `Item "${item.label}" has invalid path: ${item.path}`).toBe(true);
                });
            });
        });
    });

    // ── Admin has expected links ─────────────────────────────────────────
    describe('admin menu completeness', () => {
        it('admin should have links for key modules', () => {
            const items = buildMenuItems('admin');
            const paths = items.map(i => i.path);

            // These are critical admin links that should always exist
            expect(paths.some(p => p.includes('users')), 'Missing users link').toBe(true);
            expect(paths.some(p => p.includes('schedule')), 'Missing schedule link').toBe(true);
        });
    });
});
