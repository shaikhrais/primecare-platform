import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { PrismaClient } from '@prisma/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';
import { Bindings, Variables } from '../bindings';
import { authMiddleware, rbacMiddleware } from '../auth';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const getPrisma = (database_url: string) => {
    return new PrismaClient({
        datasourceUrl: database_url,
    }).$extends(withAccelerate());
};

const AssignPswSchema = z.object({
    visitId: z.string().uuid(),
    pswId: z.string().uuid(),
});

// Middleware: Admin Only
app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});
app.use('*', rbacMiddleware(['admin']));

/**
 * @openapi
 * /v1/admin/users:
 *   get:
 *     summary: List all users
 */
app.get('/users', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const users = await prisma.user.findMany({
        select: {
            id: true,
            email: true,
            role: true,
            isVerified: true,
            createdAt: true,
            ClientProfile: { select: { fullName: true } },
            PswProfile: { select: { fullName: true } },
        },
        orderBy: { createdAt: 'desc' },
    });
    return c.json(users);
});

/**
 * @openapi
 * /v1/admin/visits:
 *   get:
 *     summary: List all visits (Scheduling)
 */
app.get('/visits', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const visits = await prisma.visit.findMany({
        include: {
            client: { select: { fullName: true, addressLine1: true } },
            psw: { select: { fullName: true } },
            service: true,
        },
        orderBy: { requestedStartAt: 'desc' },
    });
    return c.json(visits);
});

/**
 * @openapi
 * /v1/admin/visits/assign:
 *   post:
 *     summary: Assign PSW to Visit
 */
app.post('/visits/assign', zValidator('json', AssignPswSchema), async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const { visitId, pswId } = c.req.valid('json');

    // Verify PSW exists
    const psw = await prisma.pswProfile.findUnique({ where: { id: pswId } });
    if (!psw) return c.json({ error: 'PSW not found' }, 404);

    const visit = await prisma.visit.update({
        where: { id: visitId },
        data: {
            assignedPswId: pswId,
            status: 'scheduled',
        },
    });

    return c.json(visit);
});

/**
 * @openapi
 * /v1/admin/stats:
 *   get:
 *     summary: Dashboard Stats
 */
app.get('/stats', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);

    const [totalUsers, totalVisits, pendingVisits] = await Promise.all([
        prisma.user.count(),
        prisma.visit.count(),
        prisma.visit.count({ where: { status: 'requested' } }),
    ]);

    return c.json({
        totalUsers,
        totalVisits,
        pendingVisits,
    });
});

export default app;
