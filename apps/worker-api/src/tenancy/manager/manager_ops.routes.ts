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
    // Mock implementation for regional stats
    return c.json({
        revenue: 125000.50,
        utilization: 88.5,
        churnRate: 2.1,
        activeClients: 142,
        activeProviders: 38,
    }, 200);
});

r.openapi(complianceSyncRoute, async (c) => {
    // Mock implementation for compliance sync
    return c.json({
        success: true,
        processed: 156,
        flags: 4,
    }, 200);
});

r.openapi(feedbackTriageRoute, async (c) => {
    return c.json({ success: true }, 200);
});

export default r;
