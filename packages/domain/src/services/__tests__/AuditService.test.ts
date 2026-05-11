import { describe, it, expect, beforeAll } from 'vitest';
import { AuditService } from '../AuditService';
import { PrismaClient } from '@primecare/database';

const prisma = new PrismaClient();

describe('AuditService', () => {
    const tenantId = 'test-audit-tenant';
    const actorId = 'test-audit-actor';

    beforeAll(async () => {
        // Cleanup and Setup
        await prisma.auditLog.deleteMany({ where: { tenantId } });
        
        await prisma.tenant.upsert({
            where: { id: tenantId },
            create: { 
                id: tenantId, 
                name: 'Test Audit Tenant', 
                slug: 'test-audit-' + Date.now(),
                allowedVpnRanges: '0.0.0.0/0',
                corsAllowedOrigins: ['*'],
                corsAllowedMethods: ['GET', 'POST', 'PUT', 'DELETE'],
                corsAllowedHeaders: ['Content-Type', 'Authorization']
            },
            update: {}
        });

        await prisma.user.upsert({
            where: { id: actorId },
            create: { 
                id: actorId, 
                firstName: 'Audit',
                lastName: 'Actor',
                email: 'audit@test.com',
                passwordHash: 'hash',
                tenantId: tenantId
            },
            update: {}
        });
    });

    it('should record an audit log', async () => {
        const result = await AuditService.recordLog(prisma, {
            tenantId,
            actorUserId: actorId,
            action: 'TEST_ACTION',
            resourceType: 'TEST_RESOURCE',
            metadata: { key: 'value' }
        });

        expect(result.isSuccess).toBe(true);
        expect(result.data.id).toBeDefined();
        expect(result.data.action).toBe('TEST_ACTION');
    });

    it('should list and filter audit logs', async () => {
        // Record another log with a different action
        await AuditService.recordLog(prisma, {
            tenantId,
            actorUserId: actorId,
            action: 'FILTER_ACTION',
            resourceType: 'FILTER_RESOURCE'
        });

        const result = await AuditService.listLogs(prisma, tenantId, { action: 'FILTER_ACTION' });
        
        expect(result.isSuccess).toBe(true);
        expect(result.data.logs.length).toBe(1);
        expect(result.data.logs[0].action).toBe('FILTER_ACTION');
        expect(result.data.pagination.total).toBe(1);
    });

    it('should enforce tenant isolation', async () => {
        const result = await AuditService.listLogs(prisma, 'other-tenant');
        expect(result.isSuccess).toBe(true);
        expect(result.data.logs.length).toBe(0);
        expect(result.data.pagination.total).toBe(0);
    });
});
