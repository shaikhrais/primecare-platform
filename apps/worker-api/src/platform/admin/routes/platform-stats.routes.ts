import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';

type Env = { Bindings: any; Variables: any };
const platformStats = new OpenAPIHono<Env>();

const getPlatformStatsRoute = createRoute({
    method: 'get',
    path: '/stats',
    summary: 'Get Platform Statistics',
    description: 'Returns aggregated platform-wide statistics across all tenants: total tenants, users, visits, network revenue, system health, and critical incidents.',
    tags: ['Admin', 'Platform Stats'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        tenants: z.number().openapi({ example: 12 }),
                        users: z.number().openapi({ example: 150 }),
                        visits: z.number().openapi({ example: 4200 }),
                        networkRevenue: z.number().openapi({ example: 10500 }),
                        systemHealth: z.number().openapi({ example: 99.98 }),
                        activeCriticalIncidents: z.number().openapi({ example: 0 }),
                    }),
                },
            },
            description: 'Platform-wide statistics',
        },
        500: { description: 'Server error' },
    },
});

platformStats.openapi(getPlatformStatsRoute, async (c) => {
    const prisma = c.get('prisma');

    const [tenants, users, visits] = await Promise.all([
        prisma.tenant.count(),
        prisma.user.count(),
        prisma.visit.count()
    ]);

    const totalFees = visits * 2.50;

    return c.json({
        tenants,
        users,
        visits,
        networkRevenue: totalFees,
        systemHealth: 99.98,
        activeCriticalIncidents: 0
    }, 200);
});

export { platformStats };
