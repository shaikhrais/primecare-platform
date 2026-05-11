import { PrismaClient } from '@primecare/database';
import { AuditService } from './AuditService';
import { Result } from '../utils/Result';

export interface ProvisionStaffInput {
    tenantId: string;
    firstName: string;
    lastName: string;
    email: string;
    roleId: string;
    department?: string;
    additionalNotes?: string;
    actorUserId?: string;
}

export class AdminService {
    /**
     * Provisions a new staff member by creating a user record and assigning a role.
     * Atomically records the creation in the audit log.
     */
    static async provisionStaff(prisma: any, input: ProvisionStaffInput): Promise<Result<{ userId: string; email: string; role: string }>> {
        return Result.guard(async () => {
            return prisma.$transaction(async (tx: any) => {
                // 1. Check if email already exists
                const existingUser = await tx.user.findUnique({
                    where: { email: input.email }
                });

                if (existingUser) {
                    throw new Error(`Email already registered: ${input.email}`);
                }

                // 2. Look up role (Case-insensitive)
                const role = await tx.platformRole.findFirst({
                    where: {
                        OR: [
                            { id: input.roleId },
                            { name: { equals: input.roleId, mode: 'insensitive' } }
                        ]
                    }
                });

                if (!role) {
                    throw new Error(`Role not found: ${input.roleId}`);
                }

                // 3. Create User with the identified role
                const user = await tx.user.create({
                    data: {
                        tenantId: input.tenantId,
                        firstName: input.firstName,
                        lastName: input.lastName,
                        email: input.email,
                        status: 'active',
                        roles: role.name,
                    }
                });

                // 4. Record Audit Log
                await AuditService.recordLog(tx, {
                    tenantId: input.tenantId,
                    actorUserId: input.actorUserId || 'SYSTEM',
                    action: 'PROVISION_STAFF',
                    resourceType: 'USER',
                    resourceId: user.id,
                    metadata: {
                        email: input.email,
                        role: role.name,
                        department: input.department,
                        notes: input.additionalNotes
                    }
                });

                return {
                    userId: user.id,
                    email: user.email,
                    role: role.name
                };
            });
        });
    }

    /**
     * Lists all staff members for a specific tenant.
     * Includes their role names for UI binding.
     */
    static async listStaffMembers(prisma: any, tenantId: string): Promise<Result<any[]>> {
        return Result.guard(async () => {
            const users = await prisma.user.findMany({
                where: {
                    tenantId,
                    NOT: { roles: 'client' }
                },
                select: {
                    id: true,
                    firstName: true,
                    lastName: true,
                    email: true,
                    roles: true,
                    status: true,
                    createdAt: true
                },
                orderBy: { createdAt: 'desc' }
            });

            return users;
        });
    }

    /**
     * Deactivates a staff member by setting their status to 'deactivated'.
     */
    static async deactivateStaff(prisma: any, userId: string, actorUserId: string): Promise<Result<{ userId: string; status: string }>> {
        return Result.guard(async () => {
            return prisma.$transaction(async (tx: any) => {
                const user = await tx.user.findUnique({
                    where: { id: userId }
                });

                if (!user) {
                    throw new Error(`User not found: ${userId}`);
                }

                const updatedUser = await tx.user.update({
                    where: { id: userId },
                    data: { status: 'deactivated' }
                });

                await AuditService.recordLog(tx, {
                    tenantId: user.tenantId,
                    actorUserId: actorUserId,
                    action: 'DEACTIVATE_STAFF',
                    resourceType: 'USER',
                    resourceId: userId,
                    metadata: {
                        previousStatus: user.status,
                        newStatus: 'deactivated'
                    }
                });

                return { userId: updatedUser.id, status: updatedUser.status as string };
            });
        });
    }

    /**
     * Returns a structured list of available departments for staff provisioning.
     */
    static async getAvailableDepartments(prisma: any): Promise<Result<any[]>> {
        return Result.guard(async () => {
            // In a more advanced setup, this would come from a Registry or a Department table.
            // For now, we normalize it in the domain layer to ensure consistency.
            return [
                { id: 'GENERAL', label: 'General / Operations' },
                { id: 'NURSING', label: 'Nursing' },
                { id: 'ADMIN', label: 'Administration' },
                { id: 'SALES', label: 'Sales & Marketing' },
                { id: 'FINANCE', label: 'Finance' },
                { id: 'IT', label: 'Information Technology' }
            ];
        });
    }

    /**
     * Requests an audit override.
     */
    static async requestAuditOverride(prisma: any, data: {
        name: string;
        details: string;
        actorUserId: string;
        tenantId: string;
    }) {
        const { name, details, actorUserId, tenantId } = data;

        // Records a high-priority audit log as a 'request'.
        return await AuditService.recordLog(prisma, {
            tenantId,
            actorUserId,
            action: 'AUDIT_OVERRIDE_REQUEST',
            resourceType: 'SYSTEM_CONFIG',
            metadata: {
                overrideName: name,
                overrideDetails: details,
                timestamp: new Date().toISOString()
            }
        });
    }
}
