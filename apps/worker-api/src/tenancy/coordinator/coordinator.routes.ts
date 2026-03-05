import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';
import { requirePermission } from '../../_shared/middleware/rbac';
import { logAudit } from '../../_shared/utils/audit';

const coordinator = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

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

coordinator.openapi(matchOverrideRoute, async (c) => {
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

    return c.json(match, 200);
});

coordinator.openapi(waitlistSyncRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    const results = await Promise.all(body.updates.map(upd =>
        prisma.waitlistEntry.update({
            where: { id: upd.id },
            data: { priority: upd.priority }
        })
    ));

    await logAudit(prisma, userId, 'WAITLIST_SYNC', 'TENANT', c.get('jwtPayload').tenantId, body);

    return c.json(results, 200);
});

coordinator.openapi(sosAckRoute, async (c) => {
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

    return c.json(incident, 200);
});

export default coordinator;
