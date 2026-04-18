import { PrismaClient } from '@primecare/database';
import { AuditService } from './AuditService';

const prisma = new PrismaClient();

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
    static async provisionStaff(input: ProvisionStaffInput) {
        return prisma.$transaction(async (tx) => {
            // 1. Look up role by name or ID in PlatformRole first
            const role = await tx.platformRole.findFirst({
                where: {
                    OR: [
                        { id: input.roleId },
                        { name: input.roleId }
                    ]
                }
            });

            if (!role) {
                throw new Error(`Role not found: ${input.roleId}`);
            }

            // 2. Create User with the identified role
            const user = await tx.user.create({
                data: {
                    tenantId: input.tenantId,
                    firstName: input.firstName,
                    lastName: input.lastName,
                    email: input.email,
                    status: 'active',
                    roles: role.name, // Assigning role name to the roles string field
                }
            });

            // 3. Record Audit Log
            await AuditService.recordLog({
                tenantId: input.tenantId,
                actorUserId: input.actorUserId || 'SYSTEM',
                action: 'PROVISION_STAFF',
                resourceType: 'USER',
                resourceId: user.id,
                metadata: {
                    email: input.email,
                    roleId: input.roleId,
                    department: input.department,
                    notes: input.additionalNotes
                }
            });

            return {
                success: true,
                userId: user.id,
                email: user.email
            };
        });
    }
}
