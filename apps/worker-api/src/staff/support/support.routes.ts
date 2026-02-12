import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

/**
 * List all support threads
 */
r.get('/tickets', async (c) => {
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
    return c.json(threads);
});

/**
 * Get messages for a thread
 */
r.get('/tickets/:id/messages', async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const messages = await prisma.message.findMany({
        where: { threadId: id },
        orderBy: { createdAt: 'asc' }
    });
    return c.json(messages);
});

/**
 * Reply to a thread
 */
r.post('/tickets/:id/reply', zValidator('json', z.object({
    bodyText: z.string().min(1)
})), async (c) => {
    const prisma = c.get('prisma');
    const threadId = c.req.param('id');
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

    return c.json(message);
});

export default r;
