export const logAudit = async (
    prisma: any,
    actorUserId: string | null,
    action: string,
    resourceType: string,
    resourceId?: string,
    metadata?: any,
    ipAddress?: string
) => {
    try {
        await prisma.auditLog.create({
            data: {
                actorUserId,
                action,
                resourceType,
                resourceId,
                metadataJson: metadata ? JSON.parse(JSON.stringify(metadata)) : undefined,
                ipAddress,
            },
        });
    } catch (error) {
        console.error('Audit Logging Failed:', error);
        // We don't throw here to avoid blocking the main request
    }
};
