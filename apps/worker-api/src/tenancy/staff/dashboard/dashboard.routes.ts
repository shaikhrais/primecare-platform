import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../';
import { ROUTE_METADATA } from '../../../constants/route_metadata';
import { requireRole } from '../../../middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET Dashboard Stats for Staff
const getStaffStatsRoute = createRoute({
    ...ROUTE_METADATA.STAFF.DASHBOARD_STATS,
    method: 'get',
    path: '/stats',
    middleware: [requireRole(['staff', 'admin'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        kpi: z.any(),
                    }),
                },
            },
            description: 'Staff dashboard statistics',
        },
    },
});

r.openapi(getStaffStatsRoute, async (c) => {
    const prisma = c.get('prisma');

    // MOCK OR REAL DATA: Operations Staff KPI Stats
    const kpiData = {
        urgentSchedulingNeeds: await prisma.visit.count({ where: { status: 'requested' } }),
        activeCaregivers: await prisma.pswProfile.count({ where: { isApproved: true } }),
        missingTimesheets: 5, // Mock value for illustration
    };

    return c.json({
        kpi: kpiData,
    }, 200);
});

export default r;
