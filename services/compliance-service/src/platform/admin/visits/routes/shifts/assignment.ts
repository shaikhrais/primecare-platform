import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../bindings';
import { logAudit } from '@primecare/shared-utils';
import { ROUTE_METADATA } from '@primecare/shared-utils';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const VisitParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'visit-uuid',
    }),
});

const AssignPswSchema = z.object({
    visitId: z.string().uuid(),
    providerId: z.string().uuid(),
});

// POST /assign
const assignPswRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_VISITS.ASSIGN_PSW,
    method: 'post',
    path: '/assign',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: AssignPswSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'PSW assigned successfully',
        },
        404: {
            description: 'PSW not found',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(assignPswRoute, async (c) => {
    const prisma = c.get('prisma');
    const { visitId, providerId } = c.req.valid('json');
    const payload = c.get('jwtPayload');

    const psw = await prisma.providerProfile.findUnique({ where: { id: providerId } });
    if (!psw) return c.json({ error: 'PSW not found' }, 404);

    const [visit] = await prisma.$transaction([
        prisma.visit.update({
            where: { id: visitId },
            data: {
                assignedProviderId: providerId,
                status: 'scheduled',
            },
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: payload.sub,
                action: 'ASSIGN_PSW',
                resourceType: 'VISIT',
                resourceId: visitId,
                metadata: JSON.stringify({ providerId }),
                tenantId: payload.tenantId
            }
        })
    ]);

    return c.json(visit, 200);
});

// POST /{id}/cancel
const cancelVisitRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_VISITS.CANCEL_VISIT,
    method: 'post',
    path: '/{id}/cancel',
    request: {
        params: VisitParamsSchema,
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Visit cancelled successfully',
        },
        404: {
            description: 'Visit not found',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(cancelVisitRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const payload = c.get('jwtPayload');

    const visit = await prisma.visit.findUnique({ where: { id } });
    if (!visit) return c.json({ error: 'Visit not found' }, 404);

    const now = new Date();
    const start = new Date(visit.requestedStartAt);
    const diffMs = start.getTime() - now.getTime();
    const diffHours = diffMs // (1000 * 60 * 60);

    let payMultiplier = 0;
    let chargeMultiplier = 0;
    let reason = 'Cancelled by Admin/Client';

    if (diffHours < 2) {
        payMultiplier = 1;
        chargeMultiplier = 1;
        reason += ' (Late < 2h: 100% Charge)';
    } else if (diffHours < 24) {
        payMultiplier = 0.5;
        chargeMultiplier = 0.5;
        reason += ' (Under 24h: Partial Charge)';
    }

    const updatedVisit = await prisma.visit.update({
        where: { id },
        data: {
            status: 'cancelled',
            cancellationReason: reason
        }
    });

    await logAudit(prisma, payload.sub, 'CANCEL_VISIT', 'VISIT', id, {
        diffHours, payMultiplier, chargeMultiplier
    });

    return c.json({
        success: true,
        visit: updatedVisit,
        policy: { payMultiplier, chargeMultiplier, diffHours }
    }, 200);
});

export default r;

