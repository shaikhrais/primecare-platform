import { describe, it, expect, beforeAll } from 'vitest';
import { IdentityService } from '../IdentityService';
import { PrismaClient } from '@primecare/database';

const prisma = new PrismaClient();

describe('IdentityService', () => {
    let testRole: any;

    beforeAll(async () => {
        // Setup a test role
        testRole = await prisma.platformRole.upsert({
            where: { name: 'TEST_PERM_ROLE' },
            create: {
                name: 'TEST_PERM_ROLE',
                description: 'Role for testing permissions'
            },
            update: {}
        });

        // Ensure at least one platform screen exists
        await prisma.platformScreen.upsert({
            where: { id: 'test-admin-screen' },
            create: {
                id: 'test-admin-screen',
                name: 'Test Admin',
                route: '/test/admin',
                roleId: testRole.id
            },
            update: {}
        });
    });

    it('should list platform roles', async () => {
        const roles = await IdentityService.listRoles();
        expect(roles.length).toBeGreaterThan(0);
        expect(roles.some(r => r.name === 'TEST_PERM_ROLE')).toBe(true);
    });

    it('should list available screens', async () => {
        const screens = await IdentityService.getAvailableScreens();
        expect(screens.length).toBeGreaterThan(0);
        expect(screens.some(s => s.route === '/test/admin')).toBe(true);
    });

    it('should update and retrieve role permissions', async () => {
        const permissions = [
            {
                screenRoute: '/test/admin',
                canRead: true,
                canWrite: true
            }
        ];

        await IdentityService.updateRolePermissions(testRole.id, permissions);

        const savedPerms = await IdentityService.getRolePermissions(testRole.id);
        const adminPerm = savedPerms.find(p => p.screenRoute === '/test/admin');

        expect(adminPerm).toBeDefined();
        expect(adminPerm?.canRead).toBe(true);
        expect(adminPerm?.canWrite).toBe(true);
    });

    it('should upsert permissions gracefully', async () => {
        const update = [
            {
                screenRoute: '/test/admin',
                canRead: true,
                canWrite: false // Toggle write off
            }
        ];

        await IdentityService.updateRolePermissions(testRole.id, update);

        const savedPerms = await IdentityService.getRolePermissions(testRole.id);
        const adminPerm = savedPerms.find(p => p.screenRoute === '/test/admin');

        expect(adminPerm?.canWrite).toBe(false);
    });
});
