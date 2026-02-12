import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../bindings';
import { authMiddleware } from '../auth';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});

const RegisterDeviceSchema = z.object({
    token: z.string(),
    platform: z.enum(['ios', 'android', 'web']),
});

app.post('/register-device', zValidator('json', RegisterDeviceSchema), async (c) => {
    // In a real app, save this to a DeviceToken table linked to the user
    // For now, we'll log it and mock success as we don't have the table schema migration handy
    // and don't want to break the DB synchronization.

    // const prisma = getPrisma(c.env.DATABASE_URL);
    // const userId = c.get('jwtPayload').sub;

    const { token, platform } = c.req.valid('json');
    console.log(`Registered device for push: ${token} (${platform})`);

    return c.json({ success: true });
});

app.get('/', async (c) => {
    const prisma = c.get('prisma');
    const payload = c.get('jwtPayload') as any;
    if (!payload) return c.json({ error: 'Unauthorized' }, 401);

    const userId = payload.sub;

    const notifications = await prisma.notification.findMany({
        where: { userId },
        orderBy: { createdAt: 'desc' },
        take: 50
    });

    return c.json(notifications);
});

app.patch('/:id/read', async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const payload = c.get('jwtPayload') as any;
    if (!payload) return c.json({ error: 'Unauthorized' }, 401);

    const notification = await prisma.notification.update({
        where: { id, userId: payload.sub },
        data: { isRead: true }
    });

    return c.json(notification);
});

export default app;
