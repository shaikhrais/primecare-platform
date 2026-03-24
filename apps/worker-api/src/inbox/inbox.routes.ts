import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

app.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});

// GET /v1/inbox => Fetch all MessageThreads for the User's Tenant
app.openapi(createRoute({
    method: 'get',
    path: '/',
    responses: { 200: { description: 'Inbox Threads', content: { 'application/json': { schema: z.any() } } }, 401: { description: 'Unauthorized' } }
}), async (c) => {
    const user = c.var.user as any;
    if (!user) return c.json({ error: 'Unauthorized' }, 401);

    const threads = await c.var.prisma.messageThread.findMany({
        where: { tenantId: user.tenantId },
        include: {
            messages: {
                orderBy: { createdAt: 'desc' },
                take: 1,
                include: { sender: { select: { id: true, email: true } } }
            },
            client: { select: { id: true, fullName: true } },
            psw: { select: { id: true, fullName: true } },
        },
        orderBy: { createdAt: 'desc' }
    });

    return c.json(threads, 200);
});

// POST /v1/inbox => Create a new message in a new or existing global thread
app.openapi(createRoute({
    method: 'post',
    path: '/',
    request: { body: { content: { 'application/json': { schema: z.object({ threadType: z.string().default('general'), bodyText: z.string() }) } } } },
    responses: { 200: { description: 'Message Sent', content: { 'application/json': { schema: z.any() } } }, 401: { description: 'Unauthorized' } }
}), async (c) => {
    const user = c.var.user as any;
    const { threadType, bodyText } = c.req.valid('json');
    if (!user) return c.json({ error: 'Unauthorized' }, 401);

    const thread = await c.var.prisma.messageThread.create({
        data: {
            tenantId: user.tenantId,
            threadType: threadType,
            messages: {
                create: {
                    senderUserId: user.id,
                    bodyText: bodyText
                }
            }
        },
        include: { messages: { include: { sender: { select: { email: true } } } } }
    });

    return c.json(thread, 200);
});

export default app;
