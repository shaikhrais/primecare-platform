import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { ROUTE_METADATA } from '@primecare/infrastructure';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const riskSurveillanceRoute = createRoute({
    method: 'get',
    path: '/',
    tags: ['Super Admin // System'],
    summary: 'Platform Risk Surveillance',
    description: 'Aggregates and scores compliance and performance risk across all tenants on the platform.',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'List of tenants with risk scores',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Internal server error',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    }
});

r.openapi(riskSurveillanceRoute, async (c) => {
    const prisma = c.get('prisma');

    try {
        // Fetch all tenants with aggregated counts
        // Need to use raw queries or multiple queries as Prisma's `include._count` doesn't support complex where clauses yet.
        const tenants = await prisma.tenant.findMany({
            where: {
                status: 'active'
            },
            select: {
                id: true,
                name: true,
                slug: true,
                createdAt: true,
                _count: {
                    select: {
                        users: true,
                        visits: true
                    }
                }
            }
        });

        // Current date for comparisons
        const now = new Date();
        const thirtyDaysAgo = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);

        const riskData = await Promise.all(tenants.map(async (tenant: any) => {
            // 1. Compliance Risk: Expired or pending documents
            const documentCount = await prisma.pswDocument.count({
                where: {
                    tenantId: tenant?.id,
                    status: { in: ['expired', 'pending'] }
                }
            });

            // 2. Performance Risk: Cancelled visits in last 30 days vs total visits completed
            const cancelledVisits = await prisma.visit.count({
                where: {
                    tenantId: tenant?.id,
                    status: 'cancelled',
                    requestedStartAt: { gte: thirtyDaysAgo }
                }
            });

            const completedVisits = await prisma.visit.count({
                where: {
                    tenantId: tenant?.id,
                    status: 'completed',
                    requestedStartAt: { gte: thirtyDaysAgo }
                }
            });

            const totalRecentVisits = cancelledVisits + completedVisits;
            const cancelRatio = totalRecentVisits > 0 ? (cancelledVisits / totalRecentVisits) : 0;

            // 3. User Risk: High ratio of inactive users
            const inactiveUsers = await prisma.user.count({
                where: {
                    tenantId: tenant?.id,
                    status: 'inactive'
                }
            });
            const totalUsers = tenant?._count.users;
            const inactiveRatio = totalUsers > 0 ? (inactiveUsers / totalUsers) : 0;

            // Calculate Risk Score (0-100, higher is worse)
            let riskScore = 0;
            const riskFactors: string[] = [];

            // Compliance penalty (Heavy)
            if (documentCount > 10) {
                riskScore += 40;
                riskFactors.push(`High Compliance Risk (${documentCount} pending/expired docs)`);
            } else if (documentCount > 0) {
                riskScore += 15;
                riskFactors.push(`Minor Compliance Risk (${documentCount} bad docs)`);
            }

            // Performance penalty (Medium)
            if (cancelRatio > 0.2) { // More than 20% cancellation rate
                riskScore += 30;
                riskFactors.push(`High Cancellation Rate (${(cancelRatio * 100).toFixed(1)}%)`);
            } else if (cancelRatio > 0.1) {
                riskScore += 15;
                riskFactors.push(`Elevated Cancellation Rate`);
            }

            // Activity penalty (Low)
            if (inactiveRatio > 0.5 && totalUsers > 5) { // More than 50% inactive
                riskScore += 20;
                riskFactors.push(`High Inactive User Ratio (${(inactiveRatio * 100).toFixed(1)}%)`);
            }

            // Cap at 100
            riskScore = Math.min(riskScore, 100);

            let riskLevel = 'Low';
            if (riskScore >= 70) riskLevel = 'Critical';
            else if (riskScore >= 40) riskLevel = 'Warning';

            return {
                tenantId: tenant?.id,
                name: tenant?.name,
                slug: tenant?.slug,
                userCount: totalUsers,
                visitCount: tenant?._count.visits,
                riskScore,
                riskLevel,
                riskFactors
            };
        }));

        // Sort by highest risk score first
        riskData.sort((a: any, b: any) => b.riskScore - a.riskScore);

        return c.json({ data: riskData } as any, 200 as const);

    } catch (error) {
        // R14: Don't leak internal errors
        return c.json({ data: [], error: 'Internal server error' } as any, 500 as const);
    }
});

export { r as riskSurveillanceRoutes };
