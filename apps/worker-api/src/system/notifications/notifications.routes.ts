import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const RegisterDeviceSchema = z.object({
    token: z.string(),
    platform: z.enum(['ios', 'android', 'web']),
});

r.post('/register-device', zValidator('json', RegisterDeviceSchema), async (c) => {
    const { token, platform } = c.req.valid('json');
    console.log(`Registered device for push: ${token} (${platform})`);
    return c.json({ success: true });
});

r.get('/', async (c) => {
    const prisma = c.get('prisma');
    const payload = c.get('jwtPayload');
    if (!payload?.sub) return c.json({ error: 'Unauthorized' }, 401);

    const userId = payload.sub;

    const notifications = await prisma.notification.findMany({
        where: { userId },
        orderBy: { createdAt: 'desc' },
        take: 50
    });

    return c.json(notifications);
});

r.patch('/:id/read', async (c) => {
    const prisma = c.get('prisma');
    const id = c.req.param('id');
    const payload = c.get('jwtPayload');

    const notification = await prisma.notification.update({
        where: { id, userId: payload.sub },
        data: { isRead: true }
    });

    return c.json(notification);
});

export default r;
