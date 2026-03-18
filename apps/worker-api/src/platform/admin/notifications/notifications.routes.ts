import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const notifications = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /notifications — User's notifications (paginated)
const listRoute = createRoute({
    method: 'get', path: '/',
    summary: 'List notifications for current user', tags: ['Notifications'],
    request: { query: z.object({ page: z.string().optional(), limit: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        items: z.array(z.object({
                            id: z.string(), type: z.string(), message: z.string(),
                            isRead: z.boolean(), createdAt: z.string(),
                        })),
                        total: z.number(), unreadCount: z.number(),
                    })
                }
            }, description: 'Notifications'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

notifications.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const page = parseInt(c.req.query('page') || '1');
    const limit = Math.min(parseInt(c.req.query('limit') || '20'), 50);

    const [alerts, total, unread] = await Promise.all([
        prisma.patientAlert.findMany({
            where: { tenantId }, orderBy: { createdAt: 'desc' },
            skip: (page - 1) * limit, take: limit,
        }),
        prisma.patientAlert.count({ where: { tenantId } }),
        prisma.patientAlert.count({ where: { tenantId, status: 'open' } }),
    ]);

    return c.json({
        items: alerts.map((a: any) => ({
            id: a.id, type: a.type, message: a.message,
            isRead: a.status !== 'open', createdAt: a.createdAt,
        })),
        total, unreadCount: unread,
    }, 200);
});

// PATCH /notifications/:id/read — Mark as read
const readRoute = createRoute({
    method: 'patch', path: '/{id}/read',
    summary: 'Mark notification as read', tags: ['Notifications'],
    request: { params: z.object({ id: z.string() }) },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Marked' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

notifications.openapi(readRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    try {
        await prisma.patientAlert.update({ where: { id }, data: { status: 'acknowledged' } });
        return c.json({ success: true }, 200);
    } catch { return c.json({ error: 'Notification not found' }, 404); }
});

// POST /notifications/broadcast — Admin broadcast
const broadcastRoute = createRoute({
    method: 'post', path: '/broadcast',
    summary: 'Broadcast notification to all users', tags: ['Notifications'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        type: z.string(), message: z.string(), severity: z.string().optional(),
                        targetPatientId: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Created' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

notifications.openapi(broadcastRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    // If no specific patient, create a tenant-wide alert
    const clients = body.targetPatientId
        ? [{ id: body.targetPatientId }]
        : await prisma.clientProfile.findMany({ where: { tenantId }, select: { id: true }, take: 100 });

    const alerts = await Promise.all(clients.map((client: any) =>
        prisma.patientAlert.create({
            data: {
                tenantId, patientId: client.id,
                type: body.type || 'OPERATIONAL',
                severity: body.severity || 'MEDIUM',
                message: body.message, status: 'open',
            },
        })
    ));

    return c.json({ id: alerts[0]?.id || '' }, 200);
});

// GET /notifications/family/:clientId — Family notifications
const familyRoute = createRoute({
    method: 'get', path: '/family/{clientId}',
    summary: 'Family notifications for a client', tags: ['Notifications'],
    request: { params: z.object({ clientId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), type: z.string(), message: z.string(),
                        isRead: z.boolean(), createdAt: z.string(),
                    }))
                }
            }, description: 'Notifications'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

notifications.openapi(familyRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { clientId } = c.req.valid('param');

    const notifs = await prisma.familyNotification.findMany({
        where: { tenantId, clientId }, orderBy: { createdAt: 'desc' }, take: 50,
    });

    return c.json(notifs.map((n: any) => ({
        id: n.id, type: n.type, message: n.message,
        isRead: n.isRead, createdAt: n.createdAt,
    })), 200);
});

export default notifications;
