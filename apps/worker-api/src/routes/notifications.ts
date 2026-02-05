import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings } from '../bindings';
import { authMiddleware } from '../auth';
import { PrismaClient } from '@prisma/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';

const app = new Hono<{ Bindings: Bindings }>();

// Prisma Helper
const getPrisma = (database_url: string) => {
    return new PrismaClient({
        datasourceUrl: database_url,
    }).$extends(withAccelerate());
};

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

export default app;
