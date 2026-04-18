import { describe, it, expect, beforeAll } from 'vitest';
import { AdminService } from '../AdminService';
import { PrismaClient } from '@primecare/database';

const prisma = new PrismaClient();

describe('AdminService', () => {
    const tenantId = 'test-admin-tenant';
    const actorId = 'test-admin-actor';

    beforeAll(async () => {
        // Setup Tenant
        await prisma.tenant.upsert({
            where: { id: tenantId },
            create: { 
                id: tenantId, 
                name: 'Test Admin Tenant', 
                slug: 'test-admin-' + Date.now(),
                allowedVpnRanges: '0.0.0.0/0',
                corsAllowedOrigins: ['*'],
                corsAllowedMethods: ['GET', 'POST', 'PUT', 'DELETE'],
                corsAllowedHeaders: ['Content-Type', 'Authorization']
            },
            update: {}
        });

        // Setup Actor
        await prisma.user.upsert({
            where: { id: actorId },
            create: { 
                id: actorId, 
                firstName: 'Admin',
                lastName: 'Actor',
                email: 'admin-actor@test.com',
                tenantId: tenantId
            },
            update: {}
        });

        // Setup a Role
        await prisma.platformRole.upsert({
            where: { name: 'NURSE' },
            create: {
                id: 'role-nurse-id',
                name: 'NURSE',
                description: 'Nurse Staff'
            },
            update: {}
        });
    });

    it('should provision a new staff member and assign the role', async () => {
        const email = `new.staff.${Date.now()}@test.com`;
        const result = await AdminService.provisionStaff({
            tenantId,
            firstName: 'Jane',
            lastName: 'Doe',
            email: email,
            roleId: 'NURSE',
            department: 'Emergency',
            actorUserId: actorId
        });

        expect(result.success).toBe(true);
        expect(result.userId).toBeDefined();

        // Verify DB records
        const user = await prisma.user.findUnique({
            where: { id: result.userId }
        });

        expect(user).toBeDefined();
        expect(user?.email).toBe(email);
        expect(user?.roles).toBe('NURSE');

        // Verify Audit Log
        const logs = await prisma.auditLog.findMany({
            where: { resourceId: result.userId }
        });
        expect(logs.length).toBe(1);
        expect(logs[0].action).toBe('PROVISION_STAFF');
    });

    it('should throw error if role is invalid', async () => {
        await expect(AdminService.provisionStaff({
            tenantId,
            firstName: 'Invalid',
            lastName: 'Role',
            email: 'invalid@test.com',
            roleId: 'NON_EXISTENT_ROLE',
            actorUserId: actorId
        })).rejects.toThrow('Role not found: NON_EXISTENT_ROLE');
    });
});
