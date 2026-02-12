export const createNotification = async (
    prisma: any,
    userId: string,
    tenantId: string,
    title: string,
    message: string,
    options: { type?: string; role?: string } = {}
) => {
    return await prisma.notification.create({
        data: {
            userId,
            tenantId,
            title,
            message,
            type: options.type || 'info',
            role: options.role
        }
    });
};
