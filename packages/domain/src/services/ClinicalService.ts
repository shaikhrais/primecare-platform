import { PrismaClient } from '@primecare/database';
import { AuditService } from './AuditService';
import { Result } from '../utils/Result';

const prisma = new PrismaClient();

export interface VitalsInput {
    tenantId: string;
    patientId: string;
    systolic?: number;
    diastolic?: number;
    heartRate?: number;
    temperature?: number;
    respiratoryRate?: number;
    oxygenSaturation?: number;
    weight?: number;
    height?: number;
    actorUserId: string;
}

export interface IntakeInput {
    tenantId: string;
    firstName: string;
    lastName: string;
    dateOfBirth: Date;
    gender: string;
    email?: string;
    phone?: string;
    address?: string;
    insuranceProvider?: string;
    insuranceNumber?: string;
    emergencyContactName?: string;
    emergencyContactPhone?: string;
    medicalHistory?: string;
    actorUserId: string;
}

export class ClinicalService {
    /**
     * Records a new set of vitals for a patient.
     * Persists multiple records to the VitalSign model and records an audit log.
     */
    static async captureVitals(input: VitalsInput): Promise<Result<{ success: boolean; capturedAt: Date; patientId: string; count: number }>> {
        return Result.guard(async () => {
            return prisma.$transaction(async (tx) => {
                // 1. Verify ClientProfile exists with correct tenant scoping
                const client = await tx.clientProfile.findFirst({
                    where: { 
                        id: input.patientId,
                        tenantId: input.tenantId
                    }
                });

                if (!client) {
                    throw new Error(`Client profile not found or unauthorized for tenant: ${input.patientId}`);
                }

                const vitalsToCreate = [];

                if (input.systolic !== undefined) {
                    vitalsToCreate.push({ patientId: input.patientId, type: 'BLOOD_PRESSURE_SYSTOLIC', value: Number(input.systolic), unit: 'mmHg' });
                }
                if (input.diastolic !== undefined) {
                    vitalsToCreate.push({ patientId: input.patientId, type: 'BLOOD_PRESSURE_DIASTOLIC', value: Number(input.diastolic), unit: 'mmHg' });
                }
                if (input.heartRate !== undefined) {
                    vitalsToCreate.push({ patientId: input.patientId, type: 'HEART_RATE', value: Number(input.heartRate), unit: 'bpm' });
                }
                if (input.temperature !== undefined) {
                    vitalsToCreate.push({ patientId: input.patientId, type: 'TEMPERATURE', value: Number(input.temperature), unit: 'degC' });
                }
                if (input.oxygenSaturation !== undefined) {
                    vitalsToCreate.push({ patientId: input.patientId, type: 'OXYGEN_SATURATION', value: Number(input.oxygenSaturation), unit: '%' });
                }
                if (input.respiratoryRate !== undefined) {
                    vitalsToCreate.push({ patientId: input.patientId, type: 'RESPIRATORY_RATE', value: Number(input.respiratoryRate), unit: 'breaths/min' });
                }

                // 2. Batch Persist Vitals
                if (vitalsToCreate.length > 0) {
                    await tx.vitalSign.createMany({
                        data: vitalsToCreate
                    });
                }

                // 3. Record Audit Log
                await AuditService.recordLog({
                    tenantId: input.tenantId,
                    actorUserId: input.actorUserId,
                    action: 'CAPTURE_VITALS',
                    resourceType: 'CLIENT',
                    resourceId: input.patientId,
                    metadata: {
                        vitalsCaptured: vitalsToCreate.map(v => v.type),
                        ...input
                    }
                });

                return {
                    success: true,
                    capturedAt: new Date(),
                    patientId: input.patientId,
                    count: vitalsToCreate.length
                };
            });
        });
    }

    /**
     * Processes a new patient intake.
     * Atomically creates both a User account and a ClientProfile.
     */
    static async processPatientIntake(input: IntakeInput): Promise<Result<{ patientId: string; userId: string; email: string }>> {
        return Result.guard(async () => {
            return prisma.$transaction(async (tx) => {
                // 1. Check for existing user by email in THIS tenant
                if (input.email) {
                    const existing = await tx.user.findFirst({ 
                        where: { 
                            email: input.email,
                            tenantId: input.tenantId
                        } 
                    });
                    if (existing) throw new Error(`User with email ${input.email} already exists in this tenant.`);
                }

                // 2. Standardize Role
                const role = await tx.platformRole.findFirst({
                    where: { name: { equals: 'CLIENT', mode: 'insensitive' } }
                });
                const roleName = (role?.name || 'CLIENT').toUpperCase();

                // 3. Create User record
                const user = await tx.user.create({
                    data: {
                        tenantId: input.tenantId,
                        firstName: input.firstName,
                        lastName: input.lastName,
                        email: input.email || `${input.firstName.toLowerCase()}.${input.lastName.toLowerCase()}.${Date.now()}@placeholder.com`,
                        status: 'active',
                        roles: roleName
                    }
                });

                // 4. Create ClientProfile record
                const profile = await tx.clientProfile.create({
                    data: {
                        id: user.id, // Linking profile ID to user ID for 1:1 parity
                        userId: user.id,
                        tenantId: input.tenantId,
                        fullName: `${input.firstName} ${input.lastName}`,
                        dob: input.dateOfBirth,
                        emergencyName: input.emergencyContactName,
                        emergencyPhone: input.emergencyContactPhone,
                        preferences: input.medicalHistory ? { medicalHistory: input.medicalHistory } : undefined,
                    }
                });

                // 5. Record Audit Log
                await AuditService.recordLog({
                    tenantId: input.tenantId,
                    actorUserId: input.actorUserId,
                    action: 'PATIENT_INTAKE',
                    resourceType: 'CLIENT',
                    resourceId: profile.id,
                    metadata: {
                        email: user.email,
                        role: user.roles
                    }
                });

                return {
                    patientId: profile.id,
                    userId: user.id,
                    email: user.email
                };
            });
        });
    }

    /**
     * Checks if a patient email is already in use within the tenant.
     */
    static async checkPatientEmail(tenantId: string, email: string): Promise<Result<{ available: boolean }>> {
        return Result.guard(async () => {
            const existing = await prisma.user.findFirst({
                where: {
                    email,
                    tenantId
                }
            });
            return { available: !existing };
        });
    }
}
