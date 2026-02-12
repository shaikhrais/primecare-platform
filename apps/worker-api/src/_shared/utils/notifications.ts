export async function sendNotification(prisma: any, userId: string, title: string, message: string, type: string = 'info') {
    return await prisma.notification.create({
        data: {
            userId,
            tenantId: 'system', // Default or derived from user
            title,
            message,
            type,
            isRead: false
        }
    });
}
