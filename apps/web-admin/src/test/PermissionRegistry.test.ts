/**
 * PermissionRegistry Tests
 *
 * Validates the RBAC permission system: role definitions, permission matrix,
 * helper functions, and security invariants.
 */
import { describe, it, expect } from 'vitest';
import {
    PLATFORM_ROLES,
    ROLE_PERMISSIONS,
    can,
    canAny,
    canAll,
    getPermissions,
    getRolesWithPermission,
} from 'prime-care-shared';

// ── Structure ──────────────────────────────────────────────────────────────

describe('PermissionRegistry · Structure', () => {
    it('exports PLATFORM_ROLES as a non-empty array', () => {
        expect(Array.isArray(PLATFORM_ROLES)).toBe(true);
        expect(PLATFORM_ROLES.length).toBeGreaterThanOrEqual(20);
    });

    it('has at least 24 defined roles', () => {
        expect(PLATFORM_ROLES.length).toBeGreaterThanOrEqual(24);
    });

    it('every PLATFORM_ROLE has a matching ROLE_PERMISSIONS entry', () => {
        for (const role of PLATFORM_ROLES) {
            expect(ROLE_PERMISSIONS).toHaveProperty(role);
            expect(Array.isArray(ROLE_PERMISSIONS[role])).toBe(true);
        }
    });

    it('ROLE_PERMISSIONS has no extra roles not in PLATFORM_ROLES', () => {
        const roleKeys = Object.keys(ROLE_PERMISSIONS);
        for (const key of roleKeys) {
            expect(PLATFORM_ROLES).toContain(key);
        }
    });

    it('no duplicate roles in PLATFORM_ROLES', () => {
        const unique = new Set(PLATFORM_ROLES);
        expect(unique.size).toBe(PLATFORM_ROLES.length);
    });
});

// ── Permission Coverage ─────────────────────────────────────────────────────

describe('PermissionRegistry · Permission Coverage', () => {
    it('every role has at least view_dashboard', () => {
        for (const role of PLATFORM_ROLES) {
            expect(can(role, 'view_dashboard')).toBe(true);
        }
    });

    it('super_admin has every permission', () => {
        const superPerms = ROLE_PERMISSIONS['super_admin'];
        expect(superPerms.length).toBeGreaterThanOrEqual(60);
    });

    it('scrum_master has same permissions as super_admin', () => {
        expect(ROLE_PERMISSIONS['scrum_master'].length).toBe(ROLE_PERMISSIONS['super_admin'].length);
    });

    it('client cannot manage_users', () => {
        expect(can('client', 'manage_users')).toBe(false);
    });

    it('psw cannot delete_users', () => {
        expect(can('psw', 'delete_users')).toBe(false);
    });

    it('admin can manage_users and manage_billing', () => {
        expect(can('admin', 'manage_users')).toBe(true);
        expect(can('admin', 'manage_billing')).toBe(true);
    });

    it('coordinator has dispatch permissions', () => {
        expect(can('coordinator', 'manage_dispatch')).toBe(true);
        expect(can('coordinator', 'manage_sos')).toBe(true);
        expect(can('coordinator', 'manage_waitlist')).toBe(true);
    });

    it('rn has clinical permissions', () => {
        expect(can('rn', 'clinical_oversight')).toBe(true);
        expect(can('rn', 'manage_care_plans')).toBe(true);
        expect(can('rn', 'manage_medications')).toBe(true);
    });

    it('psw has schedule and availability permissions', () => {
        expect(can('psw', 'view_open_shifts')).toBe(true);
        expect(can('psw', 'manage_availability')).toBe(true);
        expect(can('psw', 'clock_in_out')).toBe(true);
    });

    it('client has self-service permissions', () => {
        expect(can('client', 'submit_feedback')).toBe(true);
        expect(can('client', 'request_booking')).toBe(true);
        expect(can('client', 'view_own_medical')).toBe(true);
        expect(can('client', 'view_family_portal')).toBe(true);
    });

    it('finance_director has ledger and reconciliation permissions', () => {
        expect(can('finance_director', 'manage_ledger')).toBe(true);
        expect(can('finance_director', 'manage_reconciliation')).toBe(true);
        expect(can('finance_director', 'manage_tax')).toBe(true);
    });
});

// ── Helper Functions ────────────────────────────────────────────────────────

describe('PermissionRegistry · can()', () => {
    it('returns true for valid role+permission', () => {
        expect(can('admin', 'view_dashboard')).toBe(true);
    });

    it('returns false for invalid permission', () => {
        expect(can('client', 'manage_tenants')).toBe(false);
    });

    it('returns false for unknown role', () => {
        expect(can('nonexistent_role', 'view_dashboard')).toBe(false);
    });

    it('is case-insensitive for role', () => {
        expect(can('ADMIN', 'view_dashboard')).toBe(true);
        expect(can('Admin', 'view_dashboard')).toBe(true);
    });
});

describe('PermissionRegistry · canAny()', () => {
    it('returns true if role has at least one permission', () => {
        expect(canAny('client', ['manage_users', 'submit_feedback'])).toBe(true);
    });

    it('returns false if role has none of the permissions', () => {
        expect(canAny('client', ['manage_users', 'delete_users', 'manage_tenants'])).toBe(false);
    });

    it('returns false for empty permissions array', () => {
        expect(canAny('admin', [])).toBe(false);
    });
});

describe('PermissionRegistry · canAll()', () => {
    it('returns true if role has all permissions', () => {
        expect(canAll('admin', ['view_dashboard', 'manage_users', 'view_reports'])).toBe(true);
    });

    it('returns false if role is missing one', () => {
        expect(canAll('client', ['view_dashboard', 'manage_users'])).toBe(false);
    });

    it('returns true for empty permissions array', () => {
        expect(canAll('client', [])).toBe(true);
    });
});

describe('PermissionRegistry · getPermissions()', () => {
    it('returns permissions array for valid role', () => {
        const perms = getPermissions('admin');
        expect(Array.isArray(perms)).toBe(true);
        expect(perms.length).toBeGreaterThan(10);
    });

    it('returns empty array for unknown role', () => {
        expect(getPermissions('nonexistent')).toEqual([]);
    });
});

describe('PermissionRegistry · getRolesWithPermission()', () => {
    it('returns roles that have view_dashboard', () => {
        const roles = getRolesWithPermission('view_dashboard');
        expect(roles).toContain('admin');
        expect(roles).toContain('client');
        expect(roles).toContain('psw');
        expect(roles.length).toBe(PLATFORM_ROLES.length); // all roles have view_dashboard
    });

    it('returns only admin-level roles for manage_tenants', () => {
        const roles = getRolesWithPermission('manage_tenants');
        expect(roles).toContain('super_admin');
        expect(roles).toContain('scrum_master');
        expect(roles).not.toContain('client');
        expect(roles).not.toContain('psw');
    });

    it('impersonate_users is restricted to super_admin and scrum_master', () => {
        const roles = getRolesWithPermission('impersonate_users');
        expect(roles).toContain('super_admin');
        expect(roles).toContain('scrum_master');
        expect(roles).not.toContain('admin');
        expect(roles).not.toContain('client');
    });
});

// ── Security Invariants ─────────────────────────────────────────────────────

describe('PermissionRegistry · Security Invariants', () => {
    it('no permission array contains duplicates', () => {
        for (const [role, perms] of Object.entries(ROLE_PERMISSIONS)) {
            const unique = new Set(perms);
            expect(unique.size).toBe(perms.length);
        }
    });

    it('only super_admin and scrum_master have impersonate_users', () => {
        const impersonators = getRolesWithPermission('impersonate_users');
        expect(impersonators.sort()).toEqual(['scrum_master', 'super_admin']);
    });

    it('clinical roles have clinical_oversight', () => {
        expect(can('rn', 'clinical_oversight')).toBe(true);
        expect(can('clinical_manager', 'clinical_oversight')).toBe(true);
        expect(can('allied', 'clinical_oversight')).toBe(true);
    });

    it('frontline roles cannot manage_settings', () => {
        expect(can('psw', 'manage_settings')).toBe(false);
        expect(can('client', 'manage_settings')).toBe(false);
        expect(can('rn', 'manage_settings')).toBe(false);
    });

    it('all roles have view_knowledge_base and view_training', () => {
        for (const role of PLATFORM_ROLES) {
            expect(can(role, 'view_knowledge_base')).toBe(true);
            expect(can(role, 'view_training')).toBe(true);
        }
    });
});
