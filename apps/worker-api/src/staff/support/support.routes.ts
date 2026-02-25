import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const TicketParamsSchema = z.object({
    id: z.string().openapi({ param: { name: 'id', in: 'path' } }),
});

/**
 * List all support threads
 */
const listTicketsRoute = createRoute({
    method: 'get',
    path: '/tickets',
    summary: 'List Support Tickets',
    description: 'Retrieve a list of all support message threads.',
    tags: ['Staff Support'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of support tickets',
        },
    },
});

r.openapi(listTicketsRoute, async (c) => {
    const prisma = c.get('prisma');
    const threads = await prisma.messageThread.findMany({
        include: {
            client: { select: { fullName: true } },
            psw: { select: { fullName: true } },
            messages: {
                orderBy: { createdAt: 'desc' },
                take: 1
            }
        },
        orderBy: { createdAt: 'desc' }
    });
    return c.json(threads, 200);
});

/**
 * Get messages for a thread
 */
const getTicketMessagesRoute = createRoute({
    method: 'get',
    path: '/tickets/{id}/messages',
    summary: 'Get Ticket Messages',
    description: 'Retrieve all messages for a specific support thread.',
    tags: ['Staff Support'],
    request: {
        params: TicketParamsSchema,
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of messages',
        },
    },
});

r.openapi(getTicketMessagesRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const messages = await prisma.message.findMany({
        where: { threadId: id },
        orderBy: { createdAt: 'asc' }
    });
    return c.json(messages, 200);
});

/**
 * Reply to a thread
 */
const replyTicketRoute = createRoute({
    method: 'post',
    path: '/tickets/{id}/reply',
    summary: 'Reply to Ticket',
    description: 'Send a reply within a specific support thread.',
    tags: ['Staff Support'],
    request: {
        params: TicketParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        bodyText: z.string().min(1)
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Reply sent successfully',
        },
    },
});

r.openapi(replyTicketRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id: threadId } = c.req.valid('param');
    const { bodyText } = c.req.valid('json');
    const payload = c.get('jwtPayload');
    const senderUserId = payload.sub;

    const message = await prisma.message.create({
        data: {
            threadId,
            senderUserId,
            bodyText
        }
    });

    return c.json(message, 200);
});

export default r;
