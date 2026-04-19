import { describe, it, expect, beforeAll } from 'vitest';
import { IdentityService } from '../IdentityService';
import { PrismaClient } from '@primecare/database';

const prisma = new PrismaClient();

describe('IdentityService', () => {
    const tenantId = 'tenant-hq'; // Use standard seeder tenant ID
    const actorId = 'actor-' + Date.now();
    let testRoleId: string;

    beforeAll(async () => {
        // Setup Tenant (using standard ID to ensure FK compatibility)
        await prisma.tenant.upsert({
            where: { id: tenantId },
            create: { 
                id: tenantId, 
                name: 'Identity Test Tenant',
                slug: `identity-test-${Date.now()}`,
                corsAllowedOrigins: JSON.stringify([]),
                corsAllowedMethods: JSON.stringify([]),
                corsAllowedHeaders: JSON.stringify([]),
                allowedVpnRanges: '0.0.0.0/0'
            },
            update: {}
        });

        // Setup Actor
        await prisma.user.upsert({
            where: { id: actorId },
            create: { 
                id: actorId, 
                firstName: 'Identity',
                lastName: 'Actor',
                email: `actor-${Date.now()}@test.com`,
                tenantId: tenantId
            },
            update: {}
        });

        // Setup a test role with unique name
        const roleName = 'TEST_ROLE_' + Date.now();
        const role = await prisma.platformRole.create({
            data: {
                name: roleName,
                description: 'Role for testing permissions',
                tenantId: tenantId
            }
        });
        testRoleId = role.id;

        // Ensure at least one platform screen exists
        await prisma.platformScreen.upsert({
            where: { id: 'test-admin-screen' },
            create: {
                id: 'test-admin-screen',
                name: 'Test Admin',
                route: '/test/admin',
                roleId: testRoleId
            },
            update: {
                roleId: testRoleId
            }
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

        await IdentityService.updateRolePermissions(testRoleId, permissions, actorId);

        const savedPerms = await IdentityService.getRolePermissions(testRoleId);
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

        await IdentityService.updateRolePermissions(testRoleId, update, actorId);

        const savedPerms = await IdentityService.getRolePermissions(testRoleId);
        const adminPerm = savedPerms.find(p => p.screenRoute === '/test/admin');

        expect(adminPerm?.canWrite).toBe(false);
    });
});
