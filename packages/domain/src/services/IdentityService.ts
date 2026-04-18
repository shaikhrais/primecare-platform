import { PrismaClient } from '@primecare/database';

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
    static async listRoles() {
        return prisma.platformRole.findMany({
            orderBy: { name: 'asc' },
            select: {
                id: true,
                name: true,
                description: true,
                isCustom: true
            }
        });
    }

    /**
     * Retrieves unique screen routes from the PlatformScreen registry
     */
    static async getAvailableScreens() {
        const screens = await prisma.platformScreen.findMany({
            select: {
                route: true,
                name: true
            },
            distinct: ['route']
        });
        return screens;
    }

    /**
     * Fetches current permissions for a specific role
     */
    static async getRolePermissions(roleId: string) {
        return prisma.roleScreenAccess.findMany({
            where: { roleId },
            select: {
                screenRoute: true,
                canRead: true,
                canWrite: true
            }
        });
    }

    /**
     * Atomically updates role permissions.
     * Overwrites existing permissions for the provided routes.
     */
    static async updateRolePermissions(roleId: string, permissions: PermissionUpdate[]) {
        return prisma.$transaction(async (tx) => {
            for (const perm of permissions) {
                await tx.roleScreenAccess.upsert({
                    where: {
                        roleId_screenRoute: {
                            roleId,
                            screenRoute: perm.screenRoute
                        }
                    },
                    update: {
                        canRead: perm.canRead,
                        canWrite: perm.canWrite
                    },
                    create: {
                        roleId,
                        screenRoute: perm.screenRoute,
                        canRead: perm.canRead,
                        canWrite: perm.canWrite
                    }
                });
            }
            return { success: true, count: permissions.length };
        });
    }
}
