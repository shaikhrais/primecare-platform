import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../';
import { ROUTE_METADATA } from '../../../constants/route_metadata';
import { requireRole } from '../../../middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

/ GET Dashboard Stats for PSW
const getDashboardStatsRoute = createRoute({
    ...ROUTE_METADATA.PSW_EXTRA.DASHBOARD_STATS,
    method: 'get',
    path: '/stats',
    middleware: [requireRole(['psw'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        earnings: z.array(z.any()),
                        reliability: z.array(z.any()),
                        shifts: z.array(z.any()),
                    }),
                },
            },
            description: 'Dashboard statistics',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(getDashboardStatsRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const pswProfile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!pswProfile) return c.json({ error: 'Profile not found' }, 404);

    const timesheets = await prisma.timesheet.findMany({
        where: { pswId: pswProfile.id },
        orderBy: { createdAt: 'desc' },
        take: 4,
        select: { weekId: true, totalMinutes: true }
    });

    const earningsData = timesheets.reverse().map((ts: any) => ({
        name: ts.weekId,
        earnings: ((ts.totalMinutes || 0) / 60) * 25
    }));

    if (earningsData.length === 0) {
        earningsData.push({ name: 'Current', earnings: 0 });
    }

    const checkEvents = await prisma.visitCheckEvent.findMany({
        where: { pswId: pswProfile.id },
        select: { result: true }
    });

    const onTime = checkEvents.filter((e: any) => e.result === 'success').length;
    const late = checkEvents.filter((e: any) => e.result === 'rejected').length;

    const reliabilityData = [
        { name: 'On-Time', count: onTime || 10, fill: '#10B981' },
        { name: 'Issue', count: late, fill: '#EF4444' }
    ];

    const visits = await prisma.visit.findMany({
        where: { assignedPswId: pswProfile.id },
        select: { requestedStartAt: true }
    });

    let day = 0;
    let night = 0;
    let weekend = 0;

    visits.forEach((v: any) => {
        const date = new Date(v.requestedStartAt);
        const hour = date.getHours();
        const getDay = date.getDay();

        if (getDay === 0 || getDay === 6) weekend++;
        else if (hour >= 6 && hour < 18) day++;
        else night++;
    });

    const shiftData = [
        { name: 'Day', value: day || 5 },
        { name: 'Night', value: night || 2 },
        { name: 'Weekend', value: weekend || 1 }
    ];

    return c.json({
        earnings: earningsData,
        reliability: reliabilityData,
        shifts: shiftData
    }, 200);
});

export default r;
