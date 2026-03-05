import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';
import { requirePermission } from '../../_shared/middleware/rbac';
import { logAudit } from '../../_shared/utils/audit';
import { IncidentType } from '@prisma/client';

const coordinator = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const CoordinatorStatsSchema = z.object({
    livePsw: z.number(),
    sosActive: z.number(),
    pendingMatches: z.number(),
    waitlistCount: z.number(),
});

const SosIncidentSchema = z.object({
    id: z.string(),
    type: z.string(),
    status: z.string(),
    description: z.string(),
    createdAt: z.string(),
    reporter: z.object({
        id: z.string(),
        email: z.string(),
    }).nullable(),
    visit: z.object({
        client: z.object({
            id: z.string(),
            fullName: z.string(),
            addressLine1: z.string(),
        }),
        psw: z.object({
            id: z.string(),
            fullName: z.string(),
        }),
    }).nullable(),
});

/**
 * Coordinator Override Match
 */
const matchOverrideRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.MATCH_OVERRIDE,
    method: 'post',
    path: '/match/override',
    middleware: [requirePermission('COORDINATOR_DISPATCH')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        visitId: z.string(),
                        pswId: z.string(),
                        reason: z.string().optional(),
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            description: 'Match overridden successfully',
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
        },
    },
});

/**
 * Coordinator Sync Waitlist
 */
const waitlistSyncRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.WAITLIST_SYNC,
    method: 'post',
    path: '/waitlist/sync',
    middleware: [requirePermission('COORDINATOR_DISPATCH')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        updates: z.array(z.object({
                            id: z.string(),
                            priority: z.number(),
                        })),
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            description: 'Waitlist synchronized',
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
        },
    },
});

/**
 * Coordinator Acknowledge SOS
 */
const sosAckRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.SOS_ACK,
    method: 'post',
    path: '/incident/ack',
    middleware: [requirePermission('COORDINATOR_DISPATCH')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        incidentId: z.string(),
                        notes: z.string().optional(),
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            description: 'SOS acknowledged',
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
        },
    },
});

/**
 * Coordinator Dashboard Stats
 */
const dashboardStatsRoute = createRoute({
    ...ROUTE_METADATA.COORDINATOR.DASHBOARD_STATS,
    method: 'get',
    path: '/dashboard/stats',
    middleware: [requirePermission('COORDINATOR_DISPATCH')],
    responses: {
        200: {
            description: 'Coordinator dashboard stats retrieved',
            content: {
                'application/json': {
                    schema: CoordinatorStatsSchema,
                },
            },
        },
    },
});

/**
 * Coordinator List SOS Incidents
 */
const listSosRoute = createRoute({
    summary: 'List SOS Incidents',
    description: 'Retrieve a list of active SOS emergency alerts.',
    method: 'get',
    path: '/incidents',
    middleware: [requirePermission('COORDINATOR_DISPATCH')],
    responses: {
        200: {
            description: 'SOS incident list retrieved',
            content: {
                'application/json': {
                    schema: z.array(SosIncidentSchema),
                },
            },
        },
    },
});

coordinator.openapi(matchOverrideRoute as any, async (c: any) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;

    const match = await prisma.visitMatch.create({
        data: {
            visitId: body.visitId,
            pswId: body.pswId,
            score: 100, // Manual override gives full score
            status: 'accepted',
            tenantId,
        },
    });

    // Also update the visit's assigned psw
    await prisma.visit.update({
        where: { id: body.visitId },
        data: {
            assignedPswId: body.pswId,
            status: 'assigned',
        },
    });

    await logAudit(prisma, userId, 'MATCH_OVERRIDE', 'VISIT', body.visitId, body);

    return c.json(match as any, 200);
});

coordinator.openapi(waitlistSyncRoute as any, async (c: any) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    const results = await Promise.all(body.updates.map((upd: any) =>
        prisma.waitlistEntry.update({
            where: { id: upd.id },
            data: { priority: upd.priority }
        })
    ));

    await logAudit(prisma, userId, 'WAITLIST_SYNC', 'TENANT', c.get('jwtPayload').tenantId, body);

    return c.json(results as any, 200);
});

coordinator.openapi(sosAckRoute as any, async (c: any) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    const incident = await prisma.incident.update({
        where: { id: body.incidentId },
        data: {
            status: 'investigating',
            acknowledgedAt: new Date(),
            acknowledgedBy: userId,
            resolutionNotes: body.notes,
        },
    });

    await logAudit(prisma, userId, 'SOS_ACK', 'INCIDENT', body.incidentId, body);

    return c.json(incident as any, 200);
});

coordinator.openapi(listSosRoute as any, async (c: any) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const incidents = await prisma.incident.findMany({
        where: {
            tenantId,
            type: 'sos_alert' as any,
            status: { in: ['open', 'investigating'] }
        },
        include: {
            reporter: {
                select: {
                    id: true,
                    email: true,
                }
            },
            visit: {
                include: {
                    client: {
                        select: {
                            id: true,
                            fullName: true,
                            addressLine1: true,
                        }
                    },
                    psw: {
                        select: {
                            id: true,
                            fullName: true,
                        }
                    }
                }
            }
        },
        orderBy: { createdAt: 'desc' }
    });

    return c.json(incidents as any, 200);
});

coordinator.openapi(dashboardStatsRoute as any, async (c: any) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const [livePsw, sosActive, pendingMatches, waitlistCount] = await Promise.all([
        prisma.pswProfile.count({ where: { tenantId, isApproved: true } }),
        prisma.incident.count({ where: { tenantId, type: 'sos_alert' as any, status: 'open' } }),
        prisma.visitMatch.count({ where: { tenantId, status: 'pending' } }),
        prisma.waitlistEntry.count({ where: { tenantId, status: 'active' } }),
    ]);

    return c.json({
        livePsw,
        sosActive,
        pendingMatches,
        waitlistCount,
    } as any, 200);
});

export default coordinator;
