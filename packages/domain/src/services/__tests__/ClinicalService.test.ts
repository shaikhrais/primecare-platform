import { describe, it, expect, beforeAll } from 'vitest';
import { ClinicalService } from '../ClinicalService';
import { PrismaClient } from '@primecare/database';

const prisma = new PrismaClient();

describe('ClinicalService', () => {
    const tenantId = 'test-clinical-tenant';
    const actorId = 'test-clinical-actor';

    beforeAll(async () => {
        // Setup Tenant
        await prisma.tenant.upsert({
            where: { id: tenantId },
            create: { 
                id: tenantId, 
                name: 'Test Clinical Tenant', 
                slug: 'test-clinical-' + Date.now(),
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
                firstName: 'Clinical',
                lastName: 'Actor',
                email: 'clinical-actor@test.com',
                tenantId: tenantId
            },
            update: {}
        });

        // Setup Patient Role
        await prisma.platformRole.upsert({
            where: { name: 'PATIENT' },
            create: {
                id: 'role-patient-id',
                name: 'PATIENT',
                description: 'Patient Role'
            },
            update: {}
        });
    });

    it('should process patient intake', async () => {
        const result = await ClinicalService.processPatientIntake({
            tenantId,
            firstName: 'John',
            lastName: 'Patient',
            email: `john.patient.${Date.now()}@test.com`,
            dateOfBirth: new Date('1990-01-01'),
            gender: 'Male',
            actorUserId: actorId
        });

        expect(result.success).toBe(true);
        expect(result.patientId).toBeDefined();

        const user = await prisma.user.findUnique({
            where: { id: result.patientId }
        });

        expect(user?.firstName).toBe('John');
        expect(user?.roles).toBe('PATIENT');
    });

    it('should capture vitals and record audit trail', async () => {
        // Create a patient first
        const intake = await ClinicalService.processPatientIntake({
            tenantId,
            firstName: 'Vital',
            lastName: 'Target',
            email: `vital.target.${Date.now()}@test.com`,
            dateOfBirth: new Date('1985-05-12'),
            gender: 'Female',
            actorUserId: actorId
        });

        const result = await ClinicalService.captureVitals({
            tenantId,
            patientId: intake.patientId,
            systolic: 120,
            diastolic: 80,
            heartRate: 72,
            temperature: 36.6,
            actorUserId: actorId
        });

        expect(result.success).toBe(true);

        // Verify Audit Log for vitals
        const log = await prisma.auditLog.findFirst({
            where: { 
                action: 'CAPTURE_VITALS',
                resourceId: intake.patientId
            }
        });

        expect(log).toBeDefined();
        const metadata = log?.metadata as any;
        expect(metadata.systolic).toBe(120);
        expect(metadata.heartRate).toBe(72);
    });
});
