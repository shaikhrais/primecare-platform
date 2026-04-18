import { PrismaClient } from '@primecare/database';
import { AuditService } from './AuditService';

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
     */
    static async captureVitals(input: VitalsInput) {
        // Since the current schema might not have a dedicated Vitals model yet,
        // we persist this as an Event/Log or in a PatientObservations model if available.
        // For now, we utilize the Audit Log and a (future proof) Prisma create if it exists.
        
        return prisma.$transaction(async (tx) => {
            // Note: If 'Vitals' model doesn't exist, we fallback to event logging.
            // Check if patient exists
            const patient = await tx.user.findFirst({
                where: { id: input.patientId, tenantId: input.tenantId }
            });

            if (!patient) {
                throw new Error('Patient not found');
            }

            // Record as an Audit Log for now to fulfill the immediate need for persistence
            await AuditService.recordLog({
                tenantId: input.tenantId,
                actorUserId: input.actorUserId,
                action: 'CAPTURE_VITALS',
                resourceType: 'USER',
                resourceId: input.patientId,
                metadata: {
                    systolic: input.systolic,
                    diastolic: input.diastolic,
                    heartRate: input.heartRate,
                    temperature: input.temperature,
                    oxygen: input.oxygenSaturation,
                    weight: input.weight
                }
            });

            return {
                success: true,
                capturedAt: new Date(),
                patientId: input.patientId
            };
        });
    }

    /**
     * Processes a new patient intake and creates a patient record.
     */
    static async processPatientIntake(input: IntakeInput) {
        return prisma.$transaction(async (tx) => {
            // 1. Create Patient User (Role: Patient)
            const patient = await tx.user.create({
                data: {
                    tenantId: input.tenantId,
                    firstName: input.firstName,
                    lastName: input.lastName,
                    email: input.email || `${input.firstName.toLowerCase()}.${input.lastName.toLowerCase()}@placeholder.com`,
                    status: 'active',
                }
            });

            // 2. Assign Patient Role (Assuming Role 'PATIENT' exists in PlatformRole)
            const patientRole = await tx.platformRole.findFirst({
                where: { name: 'PATIENT' }
            });

            if (patientRole) {
                await tx.user.update({
                    where: { id: patient.id },
                    data: { roles: patientRole.name }
                });
            }

            // 3. Record Audit Log
            await AuditService.recordLog({
                tenantId: input.tenantId,
                actorUserId: input.actorUserId,
                action: 'PATIENT_INTAKE',
                resourceType: 'USER',
                resourceId: patient.id,
                metadata: {
                    dob: input.dateOfBirth,
                    gender: input.gender,
                    insurance: input.insuranceProvider,
                    emergencyContact: input.emergencyContactName
                }
            });

            return {
                success: true,
                patientId: patient.id,
                email: patient.email
            };
        });
    }
}
