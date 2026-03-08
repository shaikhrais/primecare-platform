/**
 * R4: Notification utility — derives tenantId from caller context.
 * Includes channel support for future email/push/in-app routing.
 */

type NotificationChannel = 'in_app' | 'email' | 'push';

interface NotificationOptions {
    userId: string;
    tenantId: string;
    title: string;
    message: string;
    type?: string;
    channels?: NotificationChannel[];
    metadata?: Record<string, any>;
}

export async function sendNotification(prisma: any, options: NotificationOptions) {
    const { userId, tenantId, title, message, type = 'info', channels = ['in_app'], metadata } = options;

    // In-app notification (always)
    const notification = await prisma.notification.create({
        data: {
            userId,
            tenantId,
            title,
            message,
            type,
            isRead: false,
            ...(metadata ? { metadataJson: metadata } : {}),
        }
    });

    // Future: Email channel (requires SendGrid/Resend integration)
    if (channels.includes('email')) {
        // TODO: Integrate email service (SendGrid, Resend, or AWS SES)
        console.log(JSON.stringify({
            level: 'info',
            event: 'email_notification_queued',
            userId,
            title,
        }));
    }

    // Future: Push notification (requires FCM/APNs)
    if (channels.includes('push')) {
        console.log(JSON.stringify({
            level: 'info',
            event: 'push_notification_queued',
            userId,
            title,
        }));
    }

    return notification;
}

/**
 * Legacy-compatible overload for existing callers.
 * TODO: Migrate all callers to use the NotificationOptions interface.
 */
export async function sendNotificationLegacy(
    prisma: any,
    userId: string,
    title: string,
    message: string,
    type: string = 'info',
    tenantId: string = 'system'
) {
    return sendNotification(prisma, { userId, tenantId, title, message, type });
}
