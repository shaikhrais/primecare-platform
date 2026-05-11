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
        const result = await IdentityService.listRoles(prisma);
        const roles = result.data;
        expect(roles.length).toBeGreaterThan(0);
        expect(roles.some(r => r.name.startsWith('TEST_ROLE_'))).toBe(true);
    });

    it('should list available screens', async () => {
        const result = await IdentityService.getAvailableScreens(prisma);
        const screens = result.data;
        expect(screens.length).toBeGreaterThan(0);
        expect(screens.some(s => s.route === '/test/admin')).toBe(true);
    });

    it('should update and retrieve role permissions', async () => {
        const roleName = await prisma.platformRole.findUnique({ where: { id: testRoleId } }).then(r => r?.name || '');
        const permissions = ['/test/admin'];

        await IdentityService.updateRolePermissions(prisma, {
            roleName,
            permissions,
            tenantId,
            actorUserId: actorId
        });

        const result = await IdentityService.getRolePermissions(prisma, testRoleId);
        const savedPerms = result.data;
        const adminPerm = savedPerms.find(p => p.screenRoute === '/test/admin');

        expect(adminPerm).toBeDefined();
        expect(adminPerm?.canRead).toBe(true);
        expect(adminPerm?.canWrite).toBe(true);
    });

    it('should upsert permissions gracefully', async () => {
        const role = await prisma.platformRole.findUnique({ where: { id: testRoleId } });
        const update = ['/test/admin'];

        await IdentityService.updateRolePermissions(prisma, {
            roleName: role?.name || '',
            permissions: update,
            tenantId,
            actorUserId: actorId
        });

        const result = await IdentityService.getRolePermissions(prisma, testRoleId);
        const savedPerms = result.data;
        const adminPerm = savedPerms.find(p => p.screenRoute === '/test/admin');

        expect(adminPerm).toBeDefined();
    });
});
