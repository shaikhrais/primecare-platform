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
        const result = await AdminService.provisionStaff({
            tenantId,
            firstName: 'Case',
            lastName: 'Test',
            email: email,
            roleId: 'nurse', // lowercase
            actorUserId: actorId
        });

        expect(result.success).toBe(true);
        expect(result.role).toBe('NURSE'); // Standardized
        
        const user = await prisma.user.findUnique({ where: { id: result.userId } });
        expect(user?.roles).toBe('NURSE');
    });

    it('should throw error if email already exists', async () => {
        const email = `duplicate.${Date.now()}@test.com`;
        await AdminService.provisionStaff({
            tenantId,
            firstName: 'First',
            lastName: 'User',
            email: email,
            roleId: 'NURSE',
            actorUserId: actorId
        });

        await expect(AdminService.provisionStaff({
            tenantId,
            firstName: 'Second',
            lastName: 'User',
            email: email,
            roleId: 'NURSE',
            actorUserId: actorId
        })).rejects.toThrow(`Email already registered: ${email}`);
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

    it('should list all staff members for a tenant', async () => {
        const staff = await AdminService.listStaffMembers(tenantId);
        expect(staff.length).toBeGreaterThan(0);
        expect(staff.some(s => s.email.includes('case.staff'))).toBe(true);
        expect(staff.every(s => s.roles !== 'client')).toBe(true);
    });

    it('should deactivate a staff member and log the action', async () => {
        // 1. Provision a staff member to deactivate
        const email = `deactivate.${Date.now()}@test.com`;
        const provisionResult = await AdminService.provisionStaff({
            tenantId,
            firstName: 'To',
            lastName: 'Deactivate',
            email: email,
            roleId: 'NURSE',
            actorUserId: actorId
        });

        // 2. Deactivate
        const result = await AdminService.deactivateStaff(provisionResult.userId, actorId);
        expect(result.success).toBe(true);
        expect(result.status).toBe('deactivated');

        // 3. Verify Database
        const user = await prisma.user.findUnique({ where: { id: provisionResult.userId } });
        expect(user?.status).toBe('deactivated');

        // 4. Verify Audit Log
        const log = await prisma.auditLog.findFirst({
            where: { 
                resourceId: provisionResult.userId,
                action: 'DEACTIVATE_STAFF'
            }
        });
        expect(log).toBeDefined();
        expect(log?.actorUserId).toBe(actorId);
    });

    it('should return available departments', async () => {
        const depts = await AdminService.getAvailableDepartments();
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

            const log = await AdminService.requestAuditOverride(data);

            expect(log).toBeDefined();
            expect(log.action).toBe('AUDIT_OVERRIDE_REQUEST');
            expect((log.metadata as any).overrideName).toBe(data.name);
        });
    });
});
