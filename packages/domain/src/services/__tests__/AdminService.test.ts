// Governance - Category: test | Purpose: Setup Tenant
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

    it('should provision a new staff member with case-insensitive role (nurse -> NURSE)', async () => {
        const email = `case.staff.${Date.now()}@test.com`;
        const result = await AdminService.provisionStaff(prisma, {
            tenantId,
            firstName: 'Case',
            lastName: 'Test',
            email: email,
            roleId: 'nurse', // lowercase
            actorUserId: actorId
        });

        expect(result.isSuccess).toBe(true);
        expect(result.data.role).toBe('NURSE'); // Standardized
        
        const user = await prisma.user.findUnique({ where: { id: result.data.userId } });
        expect(user?.roles).toBe('NURSE');
    });

    it('should throw error if email already exists', async () => {
        const email = `duplicate.${Date.now()}@test.com`;
        await AdminService.provisionStaff(prisma, {
            tenantId,
            firstName: 'First',
            lastName: 'User',
            email: email,
            roleId: 'NURSE',
            actorUserId: actorId
        });

        const result = await AdminService.provisionStaff(prisma, {
            tenantId: tenantId,
            firstName: 'Duplicate',
            lastName: 'Staff',
            email: email,
            roleId: 'NURSE',
            actorUserId: actorId
        });

        expect(result.isFailure).toBe(true);
        expect(result.error).toMatch(`Email already registered: ${email}`);
    });

    it('should throw error if role is invalid', async () => {
        const result = await AdminService.provisionStaff(prisma, {
            tenantId: tenantId,
            firstName: 'Invalid',
            lastName: 'Role',
            email: 'invalid.role@test.com',
            roleId: 'NON_EXISTENT_ROLE',
            actorUserId: actorId
        });

        expect(result.isFailure).toBe(true);
        expect(result.error).toMatch('Role not found: NON_EXISTENT_ROLE');
    });

    it('should list all staff members for a tenant', async () => {
        const result = await AdminService.listStaffMembers(prisma, tenantId);
        expect(result.isSuccess).toBe(true);
        const staff = result.data;
        expect(staff.length).toBeGreaterThan(0);
        expect(staff.some(s => s.email.includes('case.staff'))).toBe(true);
        expect(staff.every(s => s.roles !== 'client')).toBe(true);
    });

    it('should deactivate a staff member and log the action', async () => {
        // 1. Provision a staff member to deactivate
        const email = `deactivate.${Date.now()}@test.com`;
        const provisionResult = await AdminService.provisionStaff(prisma, {
            tenantId,
            firstName: 'To',
            lastName: 'Deactivate',
            email: email,
            roleId: 'NURSE',
            actorUserId: actorId
        });

        // 2. Deactivate
        const result = await AdminService.deactivateStaff(prisma, provisionResult.data.userId, actorId);
        expect(result.isSuccess).toBe(true);
        expect(result.data.status).toBe('deactivated');

        // 3. Verify Database
        const user = await prisma.user.findUnique({ where: { id: provisionResult.data.userId } });
        expect(user?.status).toBe('deactivated');

        // 4. Verify Audit Log
        const log = await prisma.auditLog.findFirst({
            where: { 
                resourceId: provisionResult.data.userId,
                action: 'DEACTIVATE_STAFF'
            }
        });
        expect(log).toBeDefined();
        expect(log?.actorUserId).toBe(actorId);
    });

    it('should return available departments', async () => {
        const result = await AdminService.getAvailableDepartments(prisma);
        expect(result.isSuccess).toBe(true);
        const depts = result.data;
        expect(depts).toBeInstanceOf(Array);
        expect(depts.length).toBeGreaterThan(0);
        expect(depts[0]).toHaveProperty('id');
        expect(depts[0]).toHaveProperty('label');
    });

    describe('requestAuditOverride', () => {
        it('should record an audit log for an override request', async () => {
            const data = {
                name: 'Data Retention Override',
                details: 'Extend retention to 10 years for compliance',
                actorUserId: actorId,
                tenantId: 'tenant-hq'
            };

            const result = await AdminService.requestAuditOverride(prisma, data);

            expect(result.isSuccess).toBe(true);
            const log = result.data;
            expect(log).toBeDefined();
            expect(log.action).toBe('AUDIT_OVERRIDE_REQUEST');
            expect((log.metadata as any).overrideName).toBe(data.name);
        });
    });
});
