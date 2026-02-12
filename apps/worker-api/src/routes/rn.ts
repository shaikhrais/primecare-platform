import { Hono } from 'hono';
import { Bindings, Variables } from '../bindings';
import { authMiddleware, requirePermission } from '../auth';
import { tenantMiddleware } from '../middleware/tenant';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});
app.use('*', tenantMiddleware());

/**
 * @openapi
 * /v1/rn/psw/:pswId/overview:
 *   get:
 *     summary: RN supervisor view of PSW logs/performance
 */
app.get('/psw/:pswId/overview', requirePermission('PSW_SUPERVISE'), async (c) => {
    const prisma = c.get('prisma');
    const pswId = c.req.param('pswId');

    const [psw, visits, incidents] = await Promise.all([
        prisma.pswProfile.findUnique({
            where: { id: pswId },
            include: { user: { select: { email: true } } }
        }),
        prisma.visit.findMany({
            where: { assignedPswId: pswId },
            take: 10,
            orderBy: { requestedStartAt: 'desc' },
            include: { client: { select: { fullName: true } } }
        }),
        prisma.incident.findMany({
            where: { reporterUserId: (await prisma.pswProfile.findUnique({ where: { id: pswId }, select: { userId: true } }))?.userId },
            take: 5,
            orderBy: { createdAt: 'desc' }
        })
    ]);

    if (!psw) return c.json({ error: 'PSW not found' }, 404);

    return c.json({
        psw,
        recentVisits: visits,
        recentIncidents: incidents
    });
});

export default app;
