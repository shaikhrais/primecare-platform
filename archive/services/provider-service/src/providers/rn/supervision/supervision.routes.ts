import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { ROUTE_METADATA } from '@primecare/infrastructure';
import { requirePermission } from '@primecare/shared-auth';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const PswParamsSchema = z.object({
    providerId: z.string().openapi({ param: { name: 'providerId', in: 'path' } }),
});

/**
 * RN supervisor view of PSW logs/performance
 */
const getPswSupervisionOverviewRoute = createRoute({
    ...ROUTE_METADATA.RN.SUPERVISION_OVERVIEW,
    method: 'get',
    path: '/psw/{providerId}/overview',
    summary: 'Get Psw Supervision Overview',
    tags: ['RN', 'Supervision'],
    middleware: [requirePermission('clinical_oversight')],
    request: {
        params: PswParamsSchema,
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        psw: z.any(),
                        recentVisits: z.array(z.any()),
                        recentIncidents: z.array(z.any()),
                    }),
                },
            },
            description: 'PSW supervision overview',
        },
        404: {
            description: 'PSW not found',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(getPswSupervisionOverviewRoute, async (c) => {
    const prisma = c.get('prisma');
    const { providerId } = c.req.valid('param');

    const [psw, visits, profile] = await Promise.all([
        prisma.providerProfile.findUnique({
            where: { id: providerId },
            include: { user: { select: { email: true } } }
        }),
        prisma.visit.findMany({
            where: { assignedProviderId: providerId },
            take: 10,
            orderBy: { requestedStartAt: 'desc' },
            include: { client: { select: { fullName: true } } }
        }),
        prisma.providerProfile.findUnique({ where: { id: providerId }, select: { userId: true } })
    ]);

    if (!psw) return c.json({ error: 'PSW not found' }, 404);

    const incidents = profile?.userId ? await prisma.incident.findMany({
        where: { reporterUserId: profile.userId },
        take: 5,
        orderBy: { createdAt: 'desc' }
    }) : [];

    return c.json({
        psw,
        recentVisits: visits,
        recentIncidents: incidents
    }, 200);
});

// GET /roster — Supervision roster for RN hub
const getRosterRoute = createRoute({
    method: 'get',
    path: '/roster',
    summary: 'Get Roster',
    tags: ['RN', 'Supervision'],
    middleware: [requirePermission('clinical_oversight')],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(),
                        fullName: z.string(),
                        role: z.string(),
                        stats: z.object({
                            visitsCount: z.number(),
                            qualityScore: z.number(),
                        }).optional(),
                        complianceStatus: z.string(),
                        riskLevel: z.string(),
                    })),
                },
            },
            description: 'Supervision roster of PSW profiles with aggregated stats',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(getRosterRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const providerProfiles = await prisma.providerProfile.findMany({
        where: { tenantId },
        include: {
            user: { select: { fullName: true, roles: true } },
        },
    });

    // Aggregate stats per PSW
    const roster = await Promise.all(providerProfiles.map(async (psw: any) => {
        const [visitsCount, incidentCount] = await Promise.all([
            prisma.visit.count({ where: { assignedProviderId: psw.id } }),
            prisma.incident.count({ where: { reporterUserId: psw.userId } }),
        ]);

        // Quality score: simple heuristic (100 - incidents * 5, min 50)
        const qualityScore = Math.max(50, 100 - incidentCount * 5);

        // Compliance: check if documents are current
        const expiredDocs = await prisma.pswDocument.count({
            where: { providerId: psw.id, expiresAt: { lt: new Date() } }
        });

        return {
            id: psw.id,
            fullName: psw.user?.fullName || psw.fullName || 'Unknown',
            role: 'PSW',
            stats: { visitsCount, qualityScore },
            complianceStatus: expiredDocs > 0 ? 'At Risk' : 'Compliant',
            riskLevel: incidentCount > 3 ? 'High' : incidentCount > 1 ? 'Medium' : 'Low',
        };
    }));

    return c.json(roster, 200);
});

export default r;
