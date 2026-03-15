/**
 * RBAC (Role-Based Access Control) Tests
 *
 * Tests the core permissions model re-exported from prime-care-shared:
 * - Can function (permission checking)
 * - Role-permission matrix
 * - Platform roles registry
 */
import { describe, it, expect } from 'vitest';

// ── RBAC Module Exports ───────────────────────────────────────────────────

describe('RBAC Module: can.ts', () => {
    it('exports can function', async () => {
        const mod = await import('@/shared/rbac/can');
        expect(mod.can).toBeDefined();
        expect(typeof mod.can).toBe('function');
    });
});

describe('RBAC Module: permissions.ts', () => {
    it('exports RolePermissions', async () => {
        const mod = await import('@/shared/rbac/permissions');
        expect(mod.RolePermissions).toBeDefined();
        expect(typeof mod.RolePermissions).toBe('object');
    });

    it('RolePermissions has admin role', async () => {
        const { RolePermissions } = await import('@/shared/rbac/permissions');
        expect(RolePermissions['admin']).toBeDefined();
    });

    it('RolePermissions has psw role', async () => {
        const { RolePermissions } = await import('@/shared/rbac/permissions');
        expect(RolePermissions['psw']).toBeDefined();
    });

    it('RolePermissions has client role', async () => {
        const { RolePermissions } = await import('@/shared/rbac/permissions');
        expect(RolePermissions['client']).toBeDefined();
    });

    it('admin has more permissions than client', async () => {
        const { RolePermissions } = await import('@/shared/rbac/permissions');
        const adminPerms = RolePermissions['admin'] || [];
        const clientPerms = RolePermissions['client'] || [];
        expect(adminPerms.length).toBeGreaterThan(clientPerms.length);
    });

    it('admin permissions is a non-empty array', async () => {
        const { RolePermissions } = await import('@/shared/rbac/permissions');
        const adminPerms = RolePermissions['admin'];
        expect(Array.isArray(adminPerms)).toBe(true);
        expect(adminPerms.length).toBeGreaterThan(0);
    });
});

describe('RBAC Module: roles.ts', () => {
    it('exports ROLES', async () => {
        const mod = await import('@/shared/rbac/roles');
        expect(mod.ROLES).toBeDefined();
    });

    it('ROLES is a non-empty array', async () => {
        const { ROLES } = await import('@/shared/rbac/roles');
        expect(Array.isArray(ROLES)).toBe(true);
        expect(ROLES.length).toBeGreaterThan(0);
    });

    it('ROLES includes admin', async () => {
        const { ROLES } = await import('@/shared/rbac/roles');
        expect(ROLES).toContain('admin');
    });

    it('ROLES includes psw', async () => {
        const { ROLES } = await import('@/shared/rbac/roles');
        expect(ROLES).toContain('psw');
    });

    it('ROLES includes client', async () => {
        const { ROLES } = await import('@/shared/rbac/roles');
        expect(ROLES).toContain('client');
    });

    it('ROLES includes coordinator', async () => {
        const { ROLES } = await import('@/shared/rbac/roles');
        expect(ROLES).toContain('coordinator');
    });

    it('ROLES includes manager', async () => {
        const { ROLES } = await import('@/shared/rbac/roles');
        expect(ROLES).toContain('manager');
    });

    it('ROLES includes rn', async () => {
        const { ROLES } = await import('@/shared/rbac/roles');
        expect(ROLES).toContain('rn');
    });

    it('every role has permissions defined', async () => {
        const { ROLES } = await import('@/shared/rbac/roles');
        const { RolePermissions } = await import('@/shared/rbac/permissions');
        ROLES.forEach((role: string) => {
            expect(RolePermissions[role]).toBeDefined();
        });
    });
});

// ── Can function with role-permission matrix ──────────────────────────────

describe('can() permission checks', () => {
    it('admin can do admin-only actions', async () => {
        const { can } = await import('@/shared/rbac/can');
        const { RolePermissions } = await import('@/shared/rbac/permissions');
        const adminPerms = RolePermissions['admin'];
        if (adminPerms && adminPerms.length > 0) {
            expect(can('admin', adminPerms[0])).toBe(true);
        }
    });

    it('returns false for non-existent permission', async () => {
        const { can } = await import('@/shared/rbac/can');
        // Using a permission that definitely doesn't exist
        expect(can('client', 'DESTROY_UNIVERSE' as any)).toBe(false);
    });

    it('returns false for non-existent role', async () => {
        const { can } = await import('@/shared/rbac/can');
        expect(can('nonexistent_role' as any, 'VIEW_DASHBOARD' as any)).toBe(false);
    });
});
