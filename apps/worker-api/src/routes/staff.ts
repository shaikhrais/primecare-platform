import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { PrismaClient } from '../../generated/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';
import { Bindings, Variables } from '../bindings';
import { authMiddleware, rbacMiddleware } from '../auth';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const getPrisma = (database_url: string) => {
    return new PrismaClient({
        datasourceUrl: database_url,
    }).$extends(withAccelerate());
};

// Middleware: Staff/Coordinator/Admin
app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});
app.use('*', rbacMiddleware(['staff', 'coordinator', 'admin']));

/**
 * List all support threads
 */
app.get('/tickets', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
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
app.get('/tickets/:id/messages', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
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
app.post('/tickets/:id/reply', zValidator('json', z.object({
    bodyText: z.string().min(1)
})), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
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

/**
 * List all customers (clients)
 */
app.get('/customers', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const customers = await prisma.clientProfile.findMany({
        include: {
            user: { select: { email: true, status: true } }
        }
    });
    return c.json(customers);
});

/**
 * Update client profile
 */
app.patch('/customers/:id', zValidator('json', z.object({
    fullName: z.string().optional(),
    phone: z.string().optional(),
    preferences: z.any().optional()
})), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const id = c.req.param('id');
    const data = c.req.valid('json');

    const customer = await prisma.clientProfile.update({
        where: { id },
        data
    });

    return c.json(customer);
});

export default app;
