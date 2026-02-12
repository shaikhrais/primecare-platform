export const logAudit = async (
    prisma: any,
    actorUserId: string | null,
    action: string,
    resourceType: string,
    resourceId?: string,
    metadata?: any,
    ipAddress?: string,
    options: { throwOnError?: boolean } = {}
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
        if (options.throwOnError) {
            throw error;
        }
    }
};
