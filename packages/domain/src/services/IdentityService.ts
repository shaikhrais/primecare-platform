import { PrismaClient } from '@primecare/database';
import { AuditService } from './AuditService';
import { Result } from '../utils/Result';

const prisma = new PrismaClient();

export interface PermissionUpdate {
    screenRoute: string;
    canRead: boolean;
    canWrite: boolean;
}

export class IdentityService {
    /**
     * Lists all platform roles
     */
    static async listRoles(): Promise<Result<any[]>> {
        return Result.guard(async () => {
            return prisma.platformRole.findMany({
                orderBy: { name: 'asc' },
                select: {
                    id: true,
                    name: true,
                    description: true,
                    isCustom: true
                }
            });
        });
    }

    /**
     * Retrieves unique screen routes from the PlatformScreen registry
     */
    static async getAvailableScreens(): Promise<Result<any[]>> {
        return Result.guard(async () => {
            const screens = await prisma.platformScreen.findMany({
                select: {
                    route: true,
                    name: true
                },
                distinct: ['route']
            });
            return screens;
        });
    }

    /**
     * Retrieves permissions for a specific role by name
     */
    static async getPermissionsForRole(roleName: string): Promise<Result<{ permissions: string[] }>> {
        return Result.guard(async () => {
            const role = await prisma.platformRole.findFirst({
                where: { name: { equals: roleName, mode: 'insensitive' } },
                include: { screenAccess: true }
            });

            if (!role) {
                return { permissions: [] };
            }

            return { permissions: role.screenAccess.map(sa => sa.screenRoute) };
        });
    }

    /**
     * Fetches current permissions for a specific role
     */
    static async getRolePermissions(roleId: string): Promise<Result<any[]>> {
        return Result.guard(async () => {
            return prisma.roleScreenAccess.findMany({
                where: { roleId },
                select: {
                    screenRoute: true,
                    canRead: true,
                    canWrite: true
                }
            });
        });
    }

    /**
     * Atomically updates role permissions.
     */
    static async updateRolePermissions(input: {
        roleName: string;
        permissions: string[];
        tenantId: string;
        actorUserId: string;
    }): Promise<Result<{ success: boolean; roleName: string; count: number }>> {
        return Result.guard(async () => {
            return prisma.$transaction(async (tx) => {
                const role = await tx.platformRole.findFirst({
                    where: { name: { equals: input.roleName, mode: 'insensitive' } }
                });

                if (!role) {
                    throw new Error(`Role not found: ${input.roleName}`);
                }

                // Delete existing access
                await tx.roleScreenAccess.deleteMany({
                    where: { roleId: role.id }
                });

                // Create new access entries
                if (input.permissions.length > 0) {
                    await tx.roleScreenAccess.createMany({
                        data: input.permissions.map(route => ({
                            roleId: role.id,
                            screenRoute: route,
                            canRead: true,
                            canWrite: true
                        }))
                    });
                }

                await AuditService.recordLog({
                    tenantId: input.tenantId,
                    actorUserId: input.actorUserId,
                    action: 'UPDATE_ROLE_PERMISSIONS',
                    resourceType: 'PLATFORM_ROLE',
                    resourceId: role.id,
                    metadata: {
                        roleName: input.roleName,
                        newPermissionsCount: input.permissions.length
                    }
                });

                return {
                    success: true,
                    roleName: role.name,
                    count: input.permissions.length
                };
            });
        });
    }
}
