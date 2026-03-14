/**
 * ContentRegistry Tests
 *
 * Validates content key structure, no empty strings, role labels,
 * menu items, auth strings, and common fallbacks.
 */
import { describe, it, expect } from 'vitest';
import { ContentRegistry } from 'prime-care-shared';

// ── Structure ──────────────────────────────────────────────────────────────

describe('ContentRegistry · Structure', () => {
    it('exports ContentRegistry as an object', () => {
        expect(ContentRegistry).toBeDefined();
        expect(typeof ContentRegistry).toBe('object');
    });

    it('has APP section with NAME and TAGLINE', () => {
        expect(ContentRegistry.APP).toBeDefined();
        expect(ContentRegistry.APP.NAME).toBe('PrimeCare');
        expect(ContentRegistry.APP.TAGLINE.length).toBeGreaterThan(5);
    });

    it('has AUTH section with login strings', () => {
        expect(ContentRegistry.AUTH).toBeDefined();
        expect(ContentRegistry.AUTH.LOGIN_TITLE).toBeDefined();
        expect(ContentRegistry.AUTH.BUTTON).toBeDefined();
        expect(ContentRegistry.AUTH.EMAIL_LABEL).toBeDefined();
        expect(ContentRegistry.AUTH.PASSWORD_LABEL).toBeDefined();
    });

    it('has ROLES section with known roles', () => {
        expect(ContentRegistry.ROLES).toBeDefined();
        expect(ContentRegistry.ROLES.ADMIN).toBeDefined();
        expect(ContentRegistry.ROLES.PSW).toBeDefined();
        expect(ContentRegistry.ROLES.CLIENT).toBeDefined();
        expect(ContentRegistry.ROLES.RN).toBeDefined();
    });

    it('has MENU section with navigation items', () => {
        expect(ContentRegistry.MENU).toBeDefined();
        expect(ContentRegistry.MENU.DASHBOARD).toBe('Dashboard');
        expect(ContentRegistry.MENU.SETTINGS).toBe('Settings');
    });

    it('has LAYOUT section with UI labels', () => {
        expect(ContentRegistry.LAYOUT).toBeDefined();
        expect(ContentRegistry.LAYOUT.LOGOUT).toBe('Sign Out');
        expect(ContentRegistry.LAYOUT.PROFILE_TITLE).toBeDefined();
    });

    it('has COMMON section with shared strings', () => {
        expect(ContentRegistry.COMMON).toBeDefined();
        expect(ContentRegistry.COMMON.SAVE).toBe('Save');
        expect(ContentRegistry.COMMON.CLOSE).toBe('Close');
        expect(ContentRegistry.COMMON.DELETE).toBe('Delete');
    });
});

// ── No Empty Strings ─────────────────────────────────────────────────────────

describe('ContentRegistry · No Empty Strings', () => {
    const checkNoEmpty = (obj: any, path: string) => {
        for (const [key, value] of Object.entries(obj)) {
            const fullPath = `${path}.${key}`;
            if (typeof value === 'string') {
                if (value.trim() === '') {
                    throw new Error(`Empty string at ${fullPath}`);
                }
            } else if (typeof value === 'object' && value !== null) {
                checkNoEmpty(value, fullPath);
            }
        }
    };

    it('no string value in ContentRegistry is empty', () => {
        expect(() => checkNoEmpty(ContentRegistry, 'ContentRegistry')).not.toThrow();
    });
});

// ── Auth Strings ─────────────────────────────────────────────────────────

describe('ContentRegistry · Auth Strings', () => {
    it('has role-specific login titles', () => {
        expect(ContentRegistry.AUTH.LOGIN_TITLE_CLIENT).toContain('Client');
        expect(ContentRegistry.AUTH.LOGIN_TITLE_STAFF).toContain('Staff');
        expect(ContentRegistry.AUTH.LOGIN_TITLE_PSW).toContain('Caregiver');
        expect(ContentRegistry.AUTH.LOGIN_TITLE_RN).toContain('Nurse');
    });

    it('has register strings', () => {
        expect(ContentRegistry.AUTH.REGISTER_TITLE).toBeDefined();
        expect(ContentRegistry.AUTH.BUTTON_REGISTER).toBeDefined();
        expect(ContentRegistry.AUTH.SIGNUP_LINK).toBeDefined();
    });
});

// ── Menu Items ───────────────────────────────────────────────────────────

describe('ContentRegistry · Menu Items', () => {
    it('has at least 30 menu items', () => {
        const menuKeys = Object.keys(ContentRegistry.MENU);
        expect(menuKeys.length).toBeGreaterThanOrEqual(30);
    });

    it('all menu items are non-empty strings', () => {
        for (const [key, value] of Object.entries(ContentRegistry.MENU)) {
            expect(typeof value).toBe('string');
            expect((value as string).trim().length).toBeGreaterThan(0);
        }
    });

    it('includes core navigation items', () => {
        const coreItems = ['DASHBOARD', 'USERS', 'SCHEDULE', 'REPORTS', 'SETTINGS'];
        for (const item of coreItems) {
            expect(ContentRegistry.MENU).toHaveProperty(item);
        }
    });
});

// ── Common Fallbacks ────────────────────────────────────────────────────────

describe('ContentRegistry · Common Fallbacks & Units', () => {
    it('has FALLBACKS sub-group', () => {
        expect(ContentRegistry.COMMON.FALLBACKS).toBeDefined();
        expect(ContentRegistry.COMMON.FALLBACKS.NA).toBe('N/A');
        expect(ContentRegistry.COMMON.FALLBACKS.TBD).toBe('TBD');
    });

    it('has UNITS sub-group', () => {
        expect(ContentRegistry.COMMON.UNITS).toBeDefined();
        expect(ContentRegistry.COMMON.UNITS.MMHG).toBe('mmHg');
    });

    it('has TABLE sub-group with column headers', () => {
        expect(ContentRegistry.COMMON.TABLE).toBeDefined();
        expect(ContentRegistry.COMMON.TABLE.NAME).toBe('Name');
        expect(ContentRegistry.COMMON.TABLE.EMAIL).toBe('Email');
        expect(ContentRegistry.COMMON.TABLE.STATUS).toBe('Status');
    });
});

// ── Role Labels ──────────────────────────────────────────────────────────

describe('ContentRegistry · Role Labels', () => {
    it('ROLE_LABELS has at least 6 entries', () => {
        const labels = Object.keys(ContentRegistry.ROLE_LABELS);
        expect(labels.length).toBeGreaterThanOrEqual(6);
    });

    it('ROLE_LABELS includes user-friendly names', () => {
        expect(ContentRegistry.ROLE_LABELS.PSW).toContain('Caregiver');
        expect(ContentRegistry.ROLE_LABELS.RN).toContain('Nurse');
        expect(ContentRegistry.ROLE_LABELS.SCRUM_MASTER).toContain('Scrum Master');
    });
});
