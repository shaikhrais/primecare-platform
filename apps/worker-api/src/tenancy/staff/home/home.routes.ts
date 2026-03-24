import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requirePermission } from '../../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET Home Stats for Staff
const getStaffStatsRoute = createRoute({
    ...ROUTE_METADATA.STAFF.HOME_STATS,
    method: 'get',
    path: '/stats',
    summary: 'Get Staff Stats',
    tags: ['Staff', 'Home'],
    middleware: [requirePermission('view_ops_home')],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        kpi: z.any(),
                    }),
                },
            },
            description: 'Staff home statistics',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(getStaffStatsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    // REAL DATA: Home Staff KPI Stats
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
