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

    const config = (tenant?.brandingConfig as any) || {};
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
                        usageStats: z.any(),
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

    const existing = (tenant?.brandingConfig as any) || {};

    await prisma.tenant.update({
        where: { id: tenantId },
        data: {
            brandingConfig: {
                ...existing,
                usageStats: body.usageStats,
                usageStatsUpdatedAt: new Date().toISOString(),
            }
        }
    });

    return c.json({ success: true });
});

export default usage;
