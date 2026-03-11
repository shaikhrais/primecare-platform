import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const usage = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /v1/admin/settings/usage-stats — load saved usage snapshot
usage.get('/', async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const tenant = await prisma.tenant.findUnique({
        where: { id: tenantId },
        select: { brandingConfig: true }
    });

    let config: any = {};
    if (tenant?.brandingConfig) {
        try { config = typeof tenant.brandingConfig === 'string' ? JSON.parse(tenant.brandingConfig) : tenant.brandingConfig; } catch (e) {}
    }
    return c.json({ usageStats: config.usageStats || null });
});

// PATCH /v1/admin/settings/usage-stats — save usage snapshot
const saveUsageRoute = createRoute({
    method: 'patch',
    path: '/',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        // R16: Validate structure instead of z.any()
                        usageStats: z.object({
                            routes: z.record(z.any()).optional(),
                            forms: z.record(z.any()).optional(),
                            apiCalls: z.record(z.any()).optional(),
                            clicks: z.record(z.any()).optional(),
                            sessionStart: z.number().optional(),
                            totalSessions: z.number().optional(),
                            lastActivity: z.number().optional(),
                            totalClicks: z.number().optional(),
                            totalFormSubmits: z.number().optional(),
                        }),
                    }),
                },
            },
        },
    },
    responses: {
        200: { description: 'Usage stats saved' }
    }
});

usage.openapi(saveUsageRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const body = c.req.valid('json');

    // Merge into existing brandingConfig
    const tenant = await prisma.tenant.findUnique({
        where: { id: tenantId },
        select: { brandingConfig: true }
    });

    let existing: any = {};
    if (tenant?.brandingConfig) {
        try { existing = typeof tenant.brandingConfig === 'string' ? JSON.parse(tenant.brandingConfig) : tenant.brandingConfig; } catch (e) {}
    }

    await prisma.tenant.update({
        where: { id: tenantId },
        data: {
            brandingConfig: JSON.stringify({
                ...existing,
                usageStats: body.usageStats,
                usageStatsUpdatedAt: new Date().toISOString(),
            })
        }
    });

    return c.json({ success: true });
});

export default usage;
