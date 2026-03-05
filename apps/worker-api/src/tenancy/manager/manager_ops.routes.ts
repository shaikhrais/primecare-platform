import { createRoute, OpenAPIHono, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const StatsSchema = z.object({
    revenue: z.number(),
    utilization: z.number(),
    churnRate: z.number(),
    activeClients: z.number(),
    activeProviders: z.number(),
});

const ComplianceSchema = z.object({
    success: z.boolean(),
    processed: z.number(),
    flags: z.number(),
});

const FeedbackTriageSchema = z.object({
    status: z.string(),
    resolutionNote: z.string().optional(),
});

const statsRoute = createRoute({
    method: 'get',
    path: '/stats',
    request: {},
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: StatsSchema,
                },
            },
            description: 'Regional stats retrieved',
        },
    },
    ...ROUTE_METADATA.MANAGER.OPS_STATS,
});

const complianceSyncRoute = createRoute({
    method: 'post',
    path: '/compliance/sync',
    request: {},
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: ComplianceSchema,
                },
            },
            description: 'Compliance synchronized',
        },
    },
    ...ROUTE_METADATA.MANAGER.COMPLIANCE_SYNC,
});

const feedbackTriageRoute = createRoute({
    method: 'patch',
    path: '/feedback/{id}/triage',
    request: {
        params: z.object({
            id: z.string().openapi({ example: '123' }),
        }),
        body: {
            content: {
                'application/json': {
                    schema: FeedbackTriageSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean() }),
                },
            },
            description: 'Feedback triaged',
        },
    },
    ...ROUTE_METADATA.MANAGER.FEEDBACK_TRIAGE,
});

r.openapi(statsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const [activeClients, activeProviders, paidInvoices] = await Promise.all([
        prisma.clientProfile.count({ where: { tenantId } }),
        prisma.pswProfile.count({ where: { tenantId } }),
        prisma.invoice.findMany({
            where: { tenantId, status: 'paid' },
            select: { total: true }
        })
    ]);

    const revenue = paidInvoices.reduce((acc: number, inv: any) => acc + Number(inv.total || 0), 0);

    return c.json({
        revenue,
        utilization: 88.5, // Logic for utilization can be complex, keeping as high-fidelity mock for now
        churnRate: 2.1,
        activeClients,
        activeProviders,
    }, 200);
});

r.openapi(complianceSyncRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const complianceCount = await prisma.pswDocument.count({
        where: { psw: { tenantId }, status: 'verified' }
    });

    return c.json({
        success: true,
        processed: complianceCount,
        flags: 0,
    }, 200);
});

r.openapi(feedbackTriageRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const { status, resolutionNote } = c.req.valid('json');

    await prisma.feedback.update({
        where: { id },
        data: { status, comment: resolutionNote }
    });

    return c.json({ success: true }, 200);
});

export default r;
