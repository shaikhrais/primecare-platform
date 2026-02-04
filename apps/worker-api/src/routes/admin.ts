import { Hono } from 'hono';
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
 *     security:
 *       - bearerAuth: []
 */
app.get('/users', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const users = await prisma.user.findMany({
        orderBy: { createdAt: 'desc' },
        include: {
            clientProfile: true,
            pswProfile: true,
        },
    });
    return c.json(users);
});

/**
 * @openapi
 * /v1/admin/psw/approve/{id}:
 *   post:
 *     summary: Approve a PSW profile
 *     security:
 *       - bearerAuth: []
 */
app.post('/psw/approve/:id', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const pswId = c.req.param('id');

    const profile = await prisma.pswProfile.update({
        where: { id: pswId },
        data: { isApproved: true, approvedAt: new Date() },
    });

    return c.json(profile);
});

/**
 * @openapi
 * /v1/admin/visits/unassigned:
 *   get:
 *     summary: List unassigned visits
 *     security:
 *       - bearerAuth: []
 */
app.get('/visits/unassigned', async (c) => {
    const prisma = getPrisma(c.env.DATABASE_URL);
    const visits = await prisma.visit.findMany({
        where: { assignedPswId: null, status: 'requested' },
        include: { client: true, service: true },
    });
    return c.json(visits);
});

export default app;
