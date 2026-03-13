import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const RegisterDeviceSchema = z.object({
    token: z.string(),
    platform: z.enum(['ios', 'android', 'web']),
});

const NotificationParamsSchema = z.object({
    id: z.string().openapi({ param: { name: 'id', in: 'path' } }),
});

const registerDeviceRoute = createRoute({
    ...ROUTE_METADATA.SYSTEM.REGISTER_DEVICE,
    method: 'post',
    path: '/register-device',
    summary: 'Register Device',
    tags: ['System', 'Notifications'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: RegisterDeviceSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean() }),
                },
            },
            description: 'Device registered successfully',
        },
    },
});

r.openapi(registerDeviceRoute, async (c) => {
    const { token, platform } = c.req.valid('json');
    // R15: Don't log push tokens — they're device credentials
    return c.json({ success: true }, 200);
});

const listNotificationsRoute = createRoute({
    ...ROUTE_METADATA.SYSTEM.LIST_NOTIFICATIONS,
    method: 'get',
    path: '/',
    summary: 'List Notifications',
    tags: ['System', 'Notifications'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of notifications',
        },
        401: {
            description: 'Unauthorized',
        },
    },
});

r.openapi(listNotificationsRoute, async (c) => {
    const prisma = c.get('prisma');
    const payload = c.get('jwtPayload');
    if (!payload?.sub) return c.json({ error: 'Unauthorized' }, 401);

    const userId = payload.sub;

    const notifications = await prisma.appNotification.findMany({
        where: { userId },
        orderBy: { createdAt: 'desc' },
        take: 50
    });

    return c.json(notifications, 200);
});

const markNotificationReadRoute = createRoute({
    ...ROUTE_METADATA.SYSTEM.READ_NOTIFICATION,
    method: 'patch',
    path: '/{id}/read',
    summary: 'Mark Notification Read',
    tags: ['System', 'Notifications'],
    request: {
        params: NotificationParamsSchema,
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Notification marked as read',
        },
    },
});

r.openapi(markNotificationReadRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const payload = c.get('jwtPayload');

    const notification = await prisma.appNotification.update({
        where: { id, userId: payload.sub },
        data: { isRead: true }
    });

    return c.json(notification, 200);
});

export default r;
