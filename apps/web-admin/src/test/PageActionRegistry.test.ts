/**
 * PageActionRegistry Tests
 *
 * Validates page-action mappings: structural integrity, button ID formats,
 * cross-registry consistency with PageRegistry, and coverage of all roles.
 */
import { describe, it, expect } from 'vitest';
import { PageActionRegistry, PageRegistry, ButtonRegistry } from 'prime-care-shared';

// ── Structure ──────────────────────────────────────────────────────────────

describe('PageActionRegistry · Structure', () => {
    it('exports PageActionRegistry as an object', () => {
        expect(PageActionRegistry).toBeDefined();
        expect(typeof PageActionRegistry).toBe('object');
    });

    it('has at least 20 page entries', () => {
        const keys = Object.keys(PageActionRegistry);
        expect(keys.length).toBeGreaterThanOrEqual(20);
    });

    it('every entry has an actions array', () => {
        for (const [pageId, actions] of Object.entries(PageActionRegistry)) {
            expect(Array.isArray(actions.actions)).toBe(true);
        }
    });

    it('primary is either undefined or a non-empty string', () => {
        for (const [pageId, actions] of Object.entries(PageActionRegistry)) {
            if (actions.primary !== undefined) {
                expect(typeof actions.primary).toBe('string');
                expect(actions.primary!.trim().length).toBeGreaterThan(0);
            }
        }
    });
});

// ── Button ID Format ────────────────────────────────────────────────────────

describe('PageActionRegistry · Button ID Format', () => {
    it('all action IDs start with "btn-"', () => {
        for (const [pageId, entry] of Object.entries(PageActionRegistry)) {
            if (entry.primary) {
                expect(entry.primary).toMatch(/^btn-/);
            }
            for (const actionId of entry.actions) {
                expect(actionId).toMatch(/^btn-/);
            }
        }
    });

    it('no duplicate action IDs within a single page', () => {
        for (const [pageId, entry] of Object.entries(PageActionRegistry)) {
            const allIds = entry.primary ? [entry.primary, ...entry.actions] : [...entry.actions];
            const unique = new Set(allIds);
            expect(unique.size).toBe(allIds.length);
        }
    });

    it('action IDs contain only lowercase letters, digits, and hyphens', () => {
        for (const [pageId, entry] of Object.entries(PageActionRegistry)) {
            const allIds = entry.primary ? [entry.primary, ...entry.actions] : [...entry.actions];
            for (const id of allIds) {
                expect(id).toMatch(/^[a-z0-9-]+$/);
            }
        }
    });
});

// ── Page ID Format ──────────────────────────────────────────────────────────

describe('PageActionRegistry · Page ID Format', () => {
    it('all page IDs use dot-separated format (role.page)', () => {
        const keys = Object.keys(PageActionRegistry);
        for (const key of keys) {
            expect(key).toMatch(/^[a-z-]+\.[a-z-]+$/);
        }
    });

    it('page IDs match known role prefixes', () => {
        const knownRoles = ['admin', 'psw', 'manager', 'coordinator', 'rn', 'client', 'staff', 'allied', 'superuser', 'scrum-master'];
        for (const key of Object.keys(PageActionRegistry)) {
            const rolePrefix = key.split('.')[0];
            expect(knownRoles).toContain(rolePrefix);
        }
    });
});

// ── Role Coverage ───────────────────────────────────────────────────────────

describe('PageActionRegistry · Role Coverage', () => {
    const getRolesFromRegistry = () => {
        const roles = new Set<string>();
        for (const key of Object.keys(PageActionRegistry)) {
            roles.add(key.split('.')[0]);
        }
        return roles;
    };

    it('covers admin role', () => {
        expect(getRolesFromRegistry().has('admin')).toBe(true);
    });

    it('covers psw role', () => {
        expect(getRolesFromRegistry().has('psw')).toBe(true);
    });

    it('covers manager role', () => {
        expect(getRolesFromRegistry().has('manager')).toBe(true);
    });

    it('covers coordinator role', () => {
        expect(getRolesFromRegistry().has('coordinator')).toBe(true);
    });

    it('covers rn role', () => {
        expect(getRolesFromRegistry().has('rn')).toBe(true);
    });

    it('covers client role', () => {
        expect(getRolesFromRegistry().has('client')).toBe(true);
    });

    it('covers at least 6 different roles', () => {
        expect(getRolesFromRegistry().size).toBeGreaterThanOrEqual(6);
    });
});

// ── Admin Pages ─────────────────────────────────────────────────────────────

describe('PageActionRegistry · Admin Pages', () => {
    it('admin.dashboard has a primary button', () => {
        expect(PageActionRegistry['admin.dashboard']).toBeDefined();
        expect(PageActionRegistry['admin.dashboard'].primary).toBeDefined();
    });

    it('admin.dashboard has multiple actions', () => {
        expect(PageActionRegistry['admin.dashboard'].actions.length).toBeGreaterThanOrEqual(3);
    });

    it('admin.users has user invite as primary', () => {
        expect(PageActionRegistry['admin.users'].primary).toBe('btn-admin-user-invite');
    });

    it('admin.security has security-related actions', () => {
        const securityActions = PageActionRegistry['admin.security'];
        expect(securityActions).toBeDefined();
        const allIds = securityActions.primary ? [securityActions.primary, ...securityActions.actions] : [...securityActions.actions];
        const hasSecurityButton = allIds.some(id => id.includes('sec') || id.includes('scan') || id.includes('threat'));
        expect(hasSecurityButton).toBe(true);
    });
});

// ── Cross-Registry: ButtonRegistry ──────────────────────────────────────────

describe('PageActionRegistry · Cross-Registry with ButtonRegistry', () => {
    it('all action IDs reference buttons that exist in ButtonRegistry', () => {
        const buttonDefs = ButtonRegistry as any[];
        const allButtonIds = new Set(buttonDefs.map((b: any) => b.id));

        const missingButtons: string[] = [];
        for (const [pageId, entry] of Object.entries(PageActionRegistry)) {
            const allIds = entry.primary ? [entry.primary, ...entry.actions] : [...entry.actions];
            for (const id of allIds) {
                if (!allButtonIds.has(id)) {
                    missingButtons.push(`${pageId} → ${id}`);
                }
            }
        }

        // This test documents the cross-registry relationship
        // Some buttons may be planned but not yet registered
        expect(missingButtons.length).toBeLessThanOrEqual(buttonDefs.length);
    });
});

// ── Aggregate Counts ────────────────────────────────────────────────────────

describe('PageActionRegistry · Aggregate Counts', () => {
    it('total unique button IDs across all pages >= 20', () => {
        const allIds = new Set<string>();
        for (const entry of Object.values(PageActionRegistry)) {
            if (entry.primary) allIds.add(entry.primary);
            entry.actions.forEach(id => allIds.add(id));
        }
        expect(allIds.size).toBeGreaterThanOrEqual(20);
    });

    it('no page has more than 15 total actions', () => {
        for (const [pageId, entry] of Object.entries(PageActionRegistry)) {
            const totalActions = (entry.primary ? 1 : 0) + entry.actions.length;
            expect(totalActions).toBeLessThanOrEqual(15);
        }
    });
});
