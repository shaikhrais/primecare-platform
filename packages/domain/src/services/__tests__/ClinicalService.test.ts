import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { PrismaClient } from '@primecare/database';
import { ClinicalService } from '../ClinicalService';

const prisma = new PrismaClient();

describe('ClinicalService Hardening Tests', () => {
    const testTenantId = 'tenant-hq';
    const uniqueId = Date.now();
    const testActorId = `actor-clinical-${uniqueId}`;
    let testPatientId: string;

    beforeAll(async () => {
        // Ensure test tenant exists
        await prisma.tenant.upsert({
            where: { id: 'tenant-hq' },
            update: {},
            create: {
                id: 'tenant-hq',
                name: 'HQ Tenant',
                slug: 'hq-' + uniqueId,
                corsAllowedOrigins: '["*"]',
                corsAllowedMethods: '["GET","POST"]',
                corsAllowedHeaders: '["Content-Type"]',
                allowedVpnRanges: '0.0.0.0/0',
            },
        });

        // Initialize Platform Role for the test
        await prisma.platformRole.upsert({
            where: { id: 'ROLE_CLIENT_ID' },
            update: {},
            create: {
                id: 'ROLE_CLIENT_ID',
                name: 'CLIENT_' + uniqueId,
            },
        });

        // Initialize a test actor (admin)
        await prisma.user.create({
            data: {
                id: testActorId,
                email: 'actor-' + uniqueId + '@primecare.local',
                tenantId: 'tenant-hq',
            },
        });

        // Initialize a test patient
        const user = await prisma.user.create({
            data: {
                id: 'TEST_PATIENT_' + uniqueId,
                email: `patient.${uniqueId}@test.com`,
                tenantId: 'tenant-hq',
            },
        });

        const profile = await prisma.clientProfile.create({
            data: {
                id: 'TEST_PATIENT_' + uniqueId,
                userId: 'TEST_PATIENT_' + uniqueId,
                fullName: 'Test Patient',
                tenantId: 'tenant-hq',
            },
        });

        testPatientId = profile.id;
    });

    afterAll(async () => {
        // Cleanup test data only if IDs were successfully initialized
        if (testPatientId) {
            await prisma.vitalSign.deleteMany({ where: { patientId: testPatientId } }).catch(() => {});
            await prisma.clientProfile.delete({ where: { id: testPatientId } }).catch(() => {});
            await prisma.user.delete({ where: { id: testPatientId } }).catch(() => {});
        }
        await prisma.auditLog.deleteMany({ where: { actorUserId: testActorId } }).catch(() => {});
    });

    it('should successfully capture vitals with valid patient context', async () => {
        const result = await ClinicalService.captureVitals({
            tenantId: testTenantId,
            patientId: testPatientId,
            systolic: 120,
            diastolic: 80,
            heartRate: 72,
            actorUserId: testActorId
        });

        expect(result.success).toBe(true);
        expect(result.count).toBe(3); // Systolic, Diastolic, Heart Rate

        // Verify database state
        const savedVitals = await prisma.vitalSign.findMany({
            where: { patientId: testPatientId }
        });
        expect(savedVitals.length).toBe(3);
        expect(savedVitals.some(v => v.type === 'BLOOD_PRESSURE_SYSTOLIC' && v.value === 120)).toBe(true);
    });

    it('should throw error if patientId does not exist in the tenant', async () => {
        await expect(ClinicalService.captureVitals({
            tenantId: testTenantId,
            patientId: 'NON_EXISTENT_GUID',
            systolic: 120,
            actorUserId: testActorId
        })).rejects.toThrow(/Client profile not found/);
    });

    it('should successfully process patient intake', async () => {
        const intakeId = `intake-${Date.now()}`;
        const result = await ClinicalService.processPatientIntake({
            tenantId: testTenantId,
            firstName: 'New',
            lastName: 'Intake',
            email: `intake.${intakeId}@test.com`,
            dateOfBirth: new Date('1990-01-01'),
            gender: 'Male',
            actorUserId: testActorId
        });

        expect(result.success).toBe(true);
        expect(result.patientId).toBeDefined();

        // Cleanup the created intake patient
        await prisma.clientProfile.delete({ where: { id: result.patientId } });
        await prisma.user.delete({ where: { id: result.userId } });
    });

    it('should rollback and throw if email already exists', async () => {
        const duplicateEmail = `patient.${uniqueId}@test.com`;

        await expect(ClinicalService.processPatientIntake({
            tenantId: testTenantId,
            firstName: 'Duplicate',
            lastName: 'Test',
            email: duplicateEmail,
            dateOfBirth: new Date(),
            gender: 'Other',
            actorUserId: testActorId
        })).rejects.toThrow(/already exists in this tenant/);
    });
});
