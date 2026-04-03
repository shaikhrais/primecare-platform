import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../bindings';
import { requirePermission } from '@primecare/shared-auth';
import { ROUTE_METADATA } from '@primecare/shared-utils';
import { getFulfillmentStats, getRevenueStats } from './stats/fulfillment';
import { getIncidentStats, getVolumeAndServiceStats } from './stats/indicators';
import { getStaffStats } from './stats/staff';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET Home Stats for Manager/Admin
const getManagerStatsRoute = createRoute({
    ...ROUTE_METADATA.MANAGER.STATS,
    method: 'get',
    path: '/stats',
    middleware: [requirePermission('view_reports')],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        shiftFulfillment: z.array(z.any()),
                        revenue: z.array(z.any()),
                        incidents: z.array(z.any()),
                        visitVolume: z.array(z.any()),
                        servicePopularity: z.array(z.any()),
                        staffUtilization: z.array(z.any()),
                        travelTime: z.array(z.any()),
                        staffAttendance: z.array(z.any()).optional(),
                        carePlanAdherence: z.array(z.any()),
                        clientSatisfaction: z.array(z.any()),
                        overtimeRisk: z.array(z.any()),
                        resourceAvailability: z.array(z.any()),
                    }),
                },
            },
            description: 'Manager home statistics',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(getManagerStatsRoute, async (c) => {
    const prisma = c.get('prisma');

    const [shiftFulfillment, revenue, incidents, volumeStats, staffStats] = await Promise.all([
        getFulfillmentStats(prisma),
        getRevenueStats(prisma),
        getIncidentStats(prisma),
        getVolumeAndServiceStats(prisma),
        getStaffStats(prisma)
    ]);

    return c.json({
        shiftFulfillment,
        revenue,
        incidents,
        visitVolume: volumeStats.visitVolume,
        servicePopularity: volumeStats.servicePopularity,
        staffUtilization: staffStats.staffUtilization,
        travelTime: staffStats.travelTime,
        staffAttendance: staffStats.staffAttendance,
        carePlanAdherence: [
            { name: 'Adherent', count: 85, fill: '#10B981' },
            { name: 'Non-Adherent', count: 15, fill: '#EF4444' },
        ],
        clientSatisfaction: [
            { subject: 'Reliability', A: 120, fullMark: 150 },
            { subject: 'Communication', A: 98, fullMark: 150 },
            { subject: 'Care Quality', A: 140, fullMark: 150 },
            { subject: 'Responsiveness', A: 110, fullMark: 150 },
            { subject: 'Safety', A: 135, fullMark: 150 },
        ],
        overtimeRisk: [
            { name: 'Low Risk', value: 80 },
            { name: 'Medium Risk', value: 15 },
            { name: 'High Risk', value: 5 },
        ],
        resourceAvailability: [
            { time: '08:00', available: 12, total: 15 },
            { time: '12:00', available: 8, total: 15 },
            { time: '16:00', available: 10, total: 15 },
        ]
    }, 200);
});

export default r;
