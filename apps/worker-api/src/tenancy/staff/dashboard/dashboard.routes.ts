import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requireRole } from '../../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET Dashboard Stats for Staff
const getStaffStatsRoute = createRoute({
    ...ROUTE_METADATA.STAFF.DASHBOARD_STATS,
    method: 'get',
    path: '/stats',
    summary: 'Get Staff Stats',
    tags: ['Staff', 'Dashboard'],
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
    const tenantId = c.get('jwtPayload').tenantId;

    // REAL DATA: Operations Staff KPI Stats
    const [urgentSchedulingNeeds, activeCaregivers, missingTimesheets] = await Promise.all([
        prisma.visit.count({ where: { status: 'requested', tenantId } }),
        prisma.pswProfile.count({ where: { isApproved: true, tenantId } }),
        prisma.visit.count({
            where: {
                status: 'completed',
                tenantId,
                timesheetItems: { none: {} } // Simplified logic for "missing timesheets"
            }
        }),
    ]);

    return c.json({
        kpi: {
            urgentSchedulingNeeds,
            activeCaregivers,
            missingTimesheets,
        },
    }, 200);
});

export default r;
