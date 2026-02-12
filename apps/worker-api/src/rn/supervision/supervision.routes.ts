import { Hono } from 'hono';
import { Bindings, Variables } from '../../bindings';
import { requirePermission } from '../../_shared/middleware/rbac';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

/**
 * RN supervisor view of PSW logs/performance
 */
r.get('/psw/:pswId/overview', requirePermission('PSW_SUPERVISE'), async (c) => {
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

export default r;
