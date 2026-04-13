import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const messaging = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /messaging/threads — List threads with unread counts
const listThreadsRoute = createRoute({
    method: 'get', path: '/threads',
    summary: 'List message threads with unread counts', tags: ['Messaging'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), threadType: z.string(),
                        lastMessage: z.string().nullable(), unreadCount: z.number(), createdAt: z.string(),
                    }))
                }
            }, description: 'Threads'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

messaging.openapi(listThreadsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const threads = await prisma.messageThread.findMany({
        where: { tenantId },
        include: { messages: { orderBy: { createdAt: 'desc' }, take: 1 } },
        orderBy: { createdAt: 'desc' }, take: 50,
    });

    return c.json(threads.map((t: any) => ({
        id: t.id, threadType: t.threadType,
        lastMessage: t.messages[0]?.bodyText || null,
        unreadCount: 0, createdAt: t.createdAt,
    })), 200);
});

// POST /messaging/threads — Create new thread
const createThreadRoute = createRoute({
    method: 'post', path: '/threads',
    summary: 'Create a new message thread', tags: ['Messaging'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        threadType: z.string(), clientId: z.string().optional(), providerId: z.string().optional(),
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

messaging.openapi(createThreadRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    const thread = await prisma.messageThread.create({
        data: { tenantId, threadType: body.threadType, clientId: body.clientId, providerId: body.providerId },
    });

    return c.json({ id: thread.id }, 200);
});

// POST /messaging/threads/:id/messages — Send a message
const sendMessageRoute = createRoute({
    method: 'post', path: '/threads/{threadId}/messages',
    summary: 'Send a message in a thread', tags: ['Messaging'],
    request: {
        params: z.object({ threadId: z.string() }),
        body: { content: { 'application/json': { schema: z.object({ bodyText: z.string() }) } } },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Sent' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

messaging.openapi(sendMessageRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;
    const { threadId } = c.req.valid('param');
    const { bodyText } = c.req.valid('json');

    const msg = await prisma.message.create({
        data: { threadId, senderUserId: userId, bodyText },
    });

    return c.json({ id: msg.id }, 200);
});

// GET /messaging/threads/:id/messages — Get messages in a thread
const getMessagesRoute = createRoute({
    method: 'get', path: '/threads/{threadId}/messages',
    summary: 'Get messages in a thread', tags: ['Messaging'],
    request: { params: z.object({ threadId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), senderUserId: z.string(), bodyText: z.string(), createdAt: z.string(),
                    }))
                }
            }, description: 'Messages'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

messaging.openapi(getMessagesRoute, async (c) => {
    const prisma = c.get('prisma');
    const { threadId } = c.req.valid('param');

    const messages = await prisma.message.findMany({
        where: { threadId }, orderBy: { createdAt: 'asc' },
    });

    return c.json(messages.map((m: any) => ({
        id: m.id, senderUserId: m.senderUserId, bodyText: m.bodyText, createdAt: m.createdAt,
    })), 200);
});

export default messaging;
