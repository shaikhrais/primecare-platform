/**
 * PermissionRegistry Unit Tests
 *
 * Tests the RBAC permission system: role→permission matrix,
 * helper functions (can, canAny, canAll), and edge cases.
 */
import { describe, it, expect } from 'vitest';
import {
    can, canAny, canAll, getPermissions, getRolesWithPermission,
    ROLE_PERMISSIONS, PLATFORM_ROLES, Permission,
} from 'prime-care-shared';

describe('PermissionRegistry', () => {
    // ── Role Coverage ────────────────────────────────────────────────────
    describe('role coverage', () => {
        it('should define permissions for all platform roles', () => {
            for (const role of PLATFORM_ROLES) {
                expect(ROLE_PERMISSIONS[role]).toBeDefined();
                expect(Array.isArray(ROLE_PERMISSIONS[role])).toBe(true);
            }
        });

        it('should have at least 25 roles', () => {
            expect(PLATFORM_ROLES.length).toBeGreaterThanOrEqual(25);
        });

        it('should have at least 50 unique permissions', () => {
            const allPerms = new Set<string>();
            Object.values(ROLE_PERMISSIONS).forEach(perms =>
                perms.forEach(p => allPerms.add(p))
            );
            expect(allPerms.size).toBeGreaterThanOrEqual(50);
        });
    });

    // ── super_admin / scrum_master Full Access ───────────────────────────
    describe('full access roles', () => {
        const fullAccessRoles = ['super_admin', 'scrum_master'];
        const spotCheckPerms: Permission[] = [
            'manage_users', 'delete_users', 'manage_tenants',
            'manage_registries', 'run_diagnostics', 'view_forensics',
        ];

        fullAccessRoles.forEach(role => {
            it(`${role} should have ALL permissions`, () => {
                spotCheckPerms.forEach(perm => {
                    expect(can(role, perm)).toBe(true);
                });
            });
        });
    });

    // ── can() ────────────────────────────────────────────────────────────
    describe('can()', () => {
        it('admin can manage_users', () => {
            expect(can('admin', 'manage_users')).toBe(true);
        });

        it('client cannot manage_users', () => {
            expect(can('client', 'manage_users')).toBe(false);
        });

        it('psw can clock_in_out', () => {
            expect(can('psw', 'clock_in_out')).toBe(true);
        });

        it('rn can manage_care_plans', () => {
            expect(can('rn', 'manage_care_plans')).toBe(true);
        });

        it('coordinator can manage_dispatch', () => {
            expect(can('coordinator', 'manage_dispatch')).toBe(true);
        });

        it('finance_director can manage_ledger', () => {
            expect(can('finance_director', 'manage_ledger')).toBe(true);
        });

        it('client can view_family_portal', () => {
            expect(can('client', 'view_family_portal')).toBe(true);
        });

        it('should be case-insensitive', () => {
            expect(can('Admin', 'manage_users')).toBe(true);
            expect(can('PSW', 'clock_in_out')).toBe(true);
        });

        it('unknown role returns false', () => {
            expect(can('nonexistent', 'manage_users')).toBe(false);
        });
    });

    // ── canAny() ─────────────────────────────────────────────────────────
    describe('canAny()', () => {
        it('returns true if role has at least one permission', () => {
            expect(canAny('psw', ['manage_users', 'clock_in_out'])).toBe(true);
        });

        it('returns false if role has none of the permissions', () => {
            expect(canAny('client', ['manage_users', 'manage_tenants'])).toBe(false);
        });
    });

    // ── canAll() ─────────────────────────────────────────────────────────
    describe('canAll()', () => {
        it('returns true if role has all permissions', () => {
            expect(canAll('admin', ['manage_users', 'view_users'])).toBe(true);
        });

        it('returns false if role is missing one', () => {
            expect(canAll('psw', ['clock_in_out', 'manage_users'])).toBe(false);
        });
    });

    // ── getPermissions() ─────────────────────────────────────────────────
    describe('getPermissions()', () => {
        it('returns permissions array for valid role', () => {
            const perms = getPermissions('admin');
            expect(perms.length).toBeGreaterThan(10);
            expect(perms).toContain('manage_users');
        });

        it('returns empty array for unknown role', () => {
            expect(getPermissions('ghost')).toEqual([]);
        });
    });

    // ── getRolesWithPermission() ─────────────────────────────────────────
    describe('getRolesWithPermission()', () => {
        it('returns roles that have manage_users', () => {
            const roles = getRolesWithPermission('manage_users');
            expect(roles).toContain('admin');
            expect(roles).toContain('super_admin');
            expect(roles).not.toContain('client');
        });

        it('returns roles that can clock_in_out', () => {
            const roles = getRolesWithPermission('clock_in_out');
            expect(roles).toContain('psw');
            expect(roles).toContain('rn');
            expect(roles).not.toContain('admin');
        });
    });

    // ── Role-Specific Boundaries ─────────────────────────────────────────
    describe('role boundaries', () => {
        it('psw should NOT have admin permissions', () => {
            expect(can('psw', 'manage_users')).toBe(false);
            expect(can('psw', 'manage_settings')).toBe(false);
            expect(can('psw', 'manage_tenants')).toBe(false);
        });

        it('client should only have self-service permissions', () => {
            expect(can('client', 'submit_feedback')).toBe(true);
            expect(can('client', 'view_own_medical')).toBe(true);
            expect(can('client', 'manage_schedule')).toBe(false);
            expect(can('client', 'manage_billing')).toBe(false);
        });

        it('every role should have view_dashboard', () => {
            PLATFORM_ROLES.forEach(role => {
                expect(can(role, 'view_dashboard')).toBe(true);
            });
        });

        it('every role should have view_knowledge_base', () => {
            PLATFORM_ROLES.forEach(role => {
                expect(can(role, 'view_knowledge_base')).toBe(true);
            });
        });
    });

    // ── Sprint 9 Regression: view_own_billing ────────────────────────────
    describe('view_own_billing permission', () => {
        it('client should have view_own_billing', () => {
            expect(can('client', 'view_own_billing')).toBe(true);
        });

        it('psw should NOT have view_own_billing', () => {
            expect(can('psw', 'view_own_billing')).toBe(false);
        });

        it('admin should have view_own_billing via super_admin only', () => {
            // admin doesn't have it directly — it's a client-only permission
            expect(can('admin', 'view_own_billing')).toBe(false);
            expect(can('super_admin', 'view_own_billing')).toBe(true);
        });

        it('client should have all self-service billing perms', () => {
            expect(can('client', 'view_own_billing')).toBe(true);
            expect(can('client', 'view_own_bookings')).toBe(true);
            expect(can('client', 'view_own_medical')).toBe(true);
            expect(can('client', 'request_booking')).toBe(true);
        });
    });

    // ── RBAC Matrix Consistency ──────────────────────────────────────────
    describe('RBAC matrix consistency', () => {
        it('every permission in ROLE_PERMISSIONS should be valid', () => {
            // Ensure no typos in permission strings
            const allPermsFromRoles = new Set<string>();
            Object.values(ROLE_PERMISSIONS).forEach(perms =>
                perms.forEach(p => allPermsFromRoles.add(p))
            );
            // All permissions should exist in super_admin (which has ALL_PERMISSIONS)
            const superAdminPerms = new Set(ROLE_PERMISSIONS.super_admin);
            allPermsFromRoles.forEach(perm => {
                expect(superAdminPerms.has(perm as Permission)).toBe(true);
            });
        });

        it('no role should have duplicate permissions', () => {
            for (const [role, perms] of Object.entries(ROLE_PERMISSIONS)) {
                const unique = new Set(perms);
                expect(unique.size).toBe(perms.length);
            }
        });

        it('coordinator should have dispatch and scheduling permissions', () => {
            expect(can('coordinator', 'manage_dispatch')).toBe(true);
            expect(can('coordinator', 'manage_sos')).toBe(true);
            expect(can('coordinator', 'manage_shift_swap')).toBe(true);
            expect(can('coordinator', 'manage_schedule')).toBe(true);
        });

        it('finance_director should have all finance permissions', () => {
            expect(can('finance_director', 'manage_billing')).toBe(true);
            expect(can('finance_director', 'manage_invoices')).toBe(true);
            expect(can('finance_director', 'manage_ledger')).toBe(true);
            expect(can('finance_director', 'manage_payroll')).toBe(true);
            expect(can('finance_director', 'manage_reconciliation')).toBe(true);
            expect(can('finance_director', 'manage_tax')).toBe(true);
        });
    });
});
