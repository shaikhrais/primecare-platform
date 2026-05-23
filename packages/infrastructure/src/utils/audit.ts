// Governance - Category: service | Purpose: Logs a standard audit action to the database.
import { PrismaClient } from '@primecare/database';

/**
 * Logs a standard audit action to the database.
 */
export async function logAudit(
    prisma: any,
    userId: string | null,
    action: string,
    resourceType: string,
    resourceId: string | null = null,
    metadata: any = {},
    deviceId: string | null = null
) {
    try {
        await prisma.auditLog.create({
            data: {
                tenantId: metadata.tenantId || 'system',
                actorUserId: userId,
                action,
                resourceType,
                resourceId,
                metadata: typeof metadata === 'string' ? metadata : metadata,
                createdAt: new Date(),
            },
        });
    } catch (e) {
        console.error('Audit Log failed', e);
    }
}
