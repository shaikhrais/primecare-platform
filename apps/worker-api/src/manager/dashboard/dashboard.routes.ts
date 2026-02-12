import { Hono } from 'hono';
import { Bindings, Variables } from '../../bindings';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// GET KPI Stats
r.get('/kpi', async (c) => {
    const prisma = c.get('prisma');
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const [activeClients, staffOnDuty, openIncidents, todayShifts] = await Promise.all([
        prisma.clientProfile.count(),
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

// GET Today's Timeline
r.get('/today', async (c) => {
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

export default r;
