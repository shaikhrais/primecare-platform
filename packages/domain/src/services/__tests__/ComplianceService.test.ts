import { describe, it, expect, beforeAll } from 'vitest';
import { ComplianceService } from '../ComplianceService';
import { PrismaClient } from '@primecare/database';

const prisma = new PrismaClient();

describe('ComplianceService', () => {
    const tenantId = 'tenant-export-test';
    const userId = 'user-test-export';
    const clientId = 'client-test-export';

    beforeAll(async () => {
        // Cleanup
        await prisma.auditLog.deleteMany({ where: { tenantId } });
        await prisma.vitalSign.deleteMany({ where: { patient: { tenantId } } });
        await prisma.clientProfile.deleteMany({ where: { tenantId } });
        await prisma.clientProfile.deleteMany({ where: { user: { email: 'compliance@test.com' } } });
        await prisma.user.deleteMany({ where: { email: 'compliance@test.com' } });
        
        // Setup Tenant
        await prisma.tenant.upsert({
            where: { id: tenantId },
            create: { 
                id: tenantId, 
                name: 'Test Compliance Tenant', 
                slug: 'test-compliance-' + Date.now(),
                allowedVpnRanges: '0.0.0.0/0',
                corsAllowedOrigins: ['*'],
                corsAllowedMethods: ['GET', 'POST', 'PUT', 'DELETE'],
                corsAllowedHeaders: ['Content-Type', 'Authorization']
            },
            update: {}
        });

        // Setup User
        await prisma.user.upsert({
            where: { id: userId },
            create: { 
                id: userId, 
                firstName: 'Compliance',
                lastName: 'Admin',
                email: 'compliance@test.com',
                passwordHash: 'hash',
                tenantId: tenantId
            },
            update: {}
        });

        // Setup Client
        await prisma.clientProfile.create({
            data: {
                id: clientId,
                userId: userId,
                fullName: 'John Doe Client',
                tenantId: tenantId
            }
        });

        // Seed Audit Logs
        await prisma.auditLog.createMany({
            data: [
                {
                    tenantId: tenantId,
                    actorUserId: userId,
                    action: 'LOGIN',
                    resourceType: 'AUTH',
                    resourceId: userId,
                    metadata: { method: 'password' }
                },
                {
                    tenantId: tenantId,
                    actorUserId: userId,
                    action: 'PROVISION_STAFF',
                    resourceType: 'STAFF',
                    resourceId: 'staff-1',
                    metadata: { role: 'nurse' }
                }
            ]
        });

        // Seed Vitals
        await prisma.vitalSign.create({
            data: {
                patientId: clientId,
                type: 'heart_rate',
                value: 75,
                unit: 'bpm',
                source: 'manual'
            }
        });
    });

    it('should aggregate audit report data correctly', async () => {
        const report = await ComplianceService.getAuditReportData(tenantId);
        expect(report.length).toBeGreaterThanOrEqual(1);
        expect(report.some(log => log.action === 'LOGIN')).toBe(true);
        expect(report[0]).toHaveProperty('timestamp');
        expect(report[0].actor).toBe('Compliance Admin');
    });

    it('should aggregate clinical compliance data correctly', async () => {
        const report = await ComplianceService.getClinicalComplianceData(tenantId);
        expect(report.length).toBe(1);
        expect(report[0].patient).toBe('John Doe Client');
        expect(report[0].metricType).toBe('heart_rate');
        expect(report[0].value).toBe(75);
    });

    it('should aggregate staff activity reports correctly', async () => {
        const report = await ComplianceService.getStaffActivityReport(tenantId);
        expect(report.length).toBe(1);
        expect(report[0].action).toBe('PROVISION_STAFF');
        expect(report[0].admin).toBe('Compliance Admin');
    });
});
