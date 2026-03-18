import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requirePermission } from '../../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const payrollAuditRoute = createRoute({
    ...ROUTE_METADATA.MANAGER.PAYROLL_AUDIT,
    method: 'get',
    path: '/payroll-audit',
    summary: 'Payroll Audit',
    tags: ['Manager', 'Finance'],
    middleware: [requirePermission('manage_payroll')],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'Payroll audit data retrieved',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(payrollAuditRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    // In a real system, this would calculate variances between VisitCheckEvent and Timesheet
    // For now, we return seeded audit data for the UI to consume
    const auditData = [
        { id: '1', pswName: 'Sarah Jenkins', totalHours: 38.5, scheduledHours: 40, variance: -1.5, status: 'pending', amount: 962.50 },
        { id: '2', pswName: 'Michael Chen', totalHours: 42.0, scheduledHours: 40, variance: 2.0, status: 'flagged', amount: 1050.00 },
        { id: '3', pswName: 'Elena Rodriguez', totalHours: 40.0, scheduledHours: 40, variance: 0, status: 'pending', amount: 1000.00 },
        { id: '4', pswName: 'David Kim', totalHours: 35.0, scheduledHours: 35, variance: 0, status: 'verified', amount: 875.00 },
    ];

    return c.json(auditData, 200);
});

export default r;
