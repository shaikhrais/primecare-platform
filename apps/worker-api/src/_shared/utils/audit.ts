import { PrismaClient } from '../../../generated/client/edge';

/**
 * Logs a standard audit action to the database.
 */
export async function logAudit(
    prisma: any,
    userId: string | null,
    action: string,
    resourceType: string,
    resourceId: string | null = null,
    metadata: any = {}
) {
    try {
        await prisma.auditLog.create({
            data: {
                tenantId: metadata.tenantId || 'system',
                actorUserId: userId,
                action,
                resourceType,
                resourceId,
                metadataJson: metadata,
                createdAt: new Date(),
            },
        });
    } catch (e) {
        console.error('Audit Log failed', e);
    }
}
