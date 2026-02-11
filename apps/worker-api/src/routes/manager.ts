import { Hono } from 'hono';
import { Bindings, Variables } from '../bindings';
import { authMiddleware, rbacMiddleware } from '../auth';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});

app.use('*', rbacMiddleware(['manager', 'admin']));

/**
 * @openapi
 * /v1/manager/dashboard/kpi:
 *   get:
 *     summary: Manager KPI Stats
 */
app.get('/dashboard/kpi', async (c) => {
    const prisma = c.get('prisma');

    // Mocking some logical counts
    // In real app, date filters would apply (e.g., today)
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const [activeClients, staffOnDuty, openIncidents, todayShifts] = await Promise.all([
        prisma.clientProfile.count(),
        // Staff on duty = checked in visits today? OR generic active users?
        // Let's count visits in progress
        prisma.visit.count({ where: { status: 'in_progress' } }),
        prisma.incident.count({ where: { status: 'open' } }),
        prisma.visit.count({
            where: {
                requestedStartAt: {
                    gte: today
                }
            }
        })
    ]);

    return c.json({
        activeClients,
        staffOnDuty,
        openIncidents,
        todayShifts
    });
});

/**
 * @openapi
 * /v1/manager/dashboard/today:
 *   get:
 *     summary: Today's Schedule Timeline
 */
app.get('/dashboard/today', async (c) => {
    const prisma = c.get('prisma');
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const shifts = await prisma.visit.findMany({
        where: {
            requestedStartAt: {
                gte: today,
                lt: tomorrow
            }
        },
        include: {
            client: { select: { fullName: true } },
            psw: { select: { fullName: true } },
            service: { select: { name: true } }
        },
        orderBy: { requestedStartAt: 'asc' }
    });

    return c.json(shifts);
});

export default app;
