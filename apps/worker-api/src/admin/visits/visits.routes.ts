import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { VisitStatus } from '../../../generated/client/edge';
import { Bindings, Variables } from '../../bindings';
import { logAudit } from '../../_shared/utils/audit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const VisitParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'visit-uuid',
    }),
});

const AssignPswSchema = z.object({
    visitId: z.string().uuid(),
    pswId: z.string().uuid(),
});

const CreateVisitSchema = z.object({
    clientId: z.string().uuid(),
    serviceId: z.string().uuid(),
    requestedStartAt: z.string().datetime(),
    durationMinutes: z.number().min(30),
    assignedPswId: z.string().uuid().optional(),
    clientNotes: z.string().optional(),
    priority: z.string().optional().default('normal'),
    requiredSkills: z.array(z.string()).optional().default([]),
});

// List All Visits
const listVisitsRoute = createRoute({
    method: 'get',
    path: '/',
    summary: 'List All Visits',
    description: 'Retrieve a list of all visits with client, psw, and service details.',
    tags: ['Admin Visits'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of visits',
        },
    },
});

r.openapi(listVisitsRoute, async (c) => {
    const prisma = c.get('prisma');
    const visits = await prisma.visit.findMany({
        include: {
            client: { select: { fullName: true, addressLine1: true } },
            psw: { select: { fullName: true } },
            service: true,
        },
        orderBy: { requestedStartAt: 'desc' },
    });
    return c.json(visits, 200);
});

// Create Visit
const createVisitRoute = createRoute({
    method: 'post',
    path: '/',
    summary: 'Create Visit',
    description: 'Create a new visit for a client.',
    tags: ['Admin Visits'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: CreateVisitSchema,
                },
            },
        },
    },
    responses: {
        201: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Visit created successfully',
        },
    },
});

r.openapi(createVisitRoute, async (c) => {
    const prisma = c.get('prisma');
    const data = c.req.valid('json');
    const payload = c.get('jwtPayload');

    const status: VisitStatus = data.assignedPswId ? 'scheduled' : 'requested';

    const visit = await prisma.visit.create({
        data: {
            clientId: data.clientId,
            serviceId: data.serviceId,
            requestedStartAt: new Date(data.requestedStartAt),
            durationMinutes: data.durationMinutes,
            assignedPswId: data.assignedPswId,
            status: status,
            clientNotes: data.clientNotes,
            tenantId: payload.tenantId,
            priority: data.priority || 'normal',
            requiredSkills: data.requiredSkills || [],
        },
    });

    await logAudit(prisma, payload.sub, 'CREATE_VISIT', 'VISIT', visit.id, {
        assignedPswId: data.assignedPswId,
        status: status
    });

    return c.json(visit, 201);
});

// POST Post Shift
const postShiftRoute = createRoute({
    method: 'post',
    path: '/{id}/post',
    summary: 'Post Shift',
    description: 'Move a visit status from draft/requested to posted.',
    tags: ['Admin Visits'],
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
            description: 'Shift posted successfully',
        },
    },
});

r.openapi(postShiftRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const payload = c.get('jwtPayload');

    const visit = await prisma.visit.update({
        where: { id },
        data: { status: 'posted' }
    });

    await logAudit(prisma, payload.sub, 'POST_SHIFT', 'VISIT', id);
    return c.json(visit, 200);
});

// POST Offer Shift to PSWs
const offerShiftRoute = createRoute({
    method: 'post',
    path: '/{id}/offer',
    summary: 'Offer Shift to PSWs',
    description: 'Offer a visit to a list of PSWs.',
    tags: ['Admin Visits'],
    request: {
        params: VisitParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        pswIds: z.array(z.string().uuid()),
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        success: z.boolean(),
                        count: z.number(),
                    }),
                },
            },
            description: 'Shift offered successfully',
        },
    },
});

r.openapi(offerShiftRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const { pswIds } = c.req.valid('json');
    const payload = c.get('jwtPayload');

    const assignments = await Promise.all(pswIds.map(pswId =>
        prisma.shiftAssignment.create({
            data: {
                visitId: id,
                pswId,
                status: 'offered',
                tenantId: payload.tenantId,
            }
        })
    ));

    await prisma.visit.update({
        where: { id },
        data: { status: 'offered' }
    });

    await logAudit(prisma, payload.sub, 'OFFER_SHIFT', 'VISIT', id, { pswIds });
    return c.json({ success: true, count: assignments.length }, 200);
});

// GET Suggest PSWs
const suggestPswsRoute = createRoute({
    method: 'get',
    path: '/{id}/suggest',
    summary: 'Suggest PSWs',
    description: 'Get a list of suggested PSWs for a visit based on availability and skills.',
    tags: ['Admin Visits'],
    request: {
        params: VisitParamsSchema,
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of suggested PSWs',
        },
        404: {
            description: 'Visit not found',
        },
    },
});

r.openapi(suggestPswsRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');

    const visit = await prisma.visit.findUnique({
        where: { id },
        include: { client: true }
    });
    if (!visit) return c.json({ error: 'Visit not found' }, 404);

    const psws = await prisma.pswProfile.findMany({
        where: { isApproved: true, tenantId: visit.tenantId },
        include: { availability: true }
    });

    const suggested = psws.map((psw: any) => {
        let score = 50;
        const day = visit.requestedStartAt.getDay();
        const hasAvailability = psw.availability.some((a: any) => a.dayOfWeek === day);
        if (hasAvailability) score += 30;

        const visitSkills = (visit.requiredSkills as string[]) || [];
        const pswSkills = (psw.skills as string[]) || [];
        const hasAllSkills = visitSkills.every((s: string) => pswSkills.includes(s));
        if (hasAllSkills && visitSkills.length > 0) score += 40;
        else if (visitSkills.length > 0) score -= 20;

        return {
            id: psw.id,
            fullName: psw.fullName,
            score,
            reasons: [
                hasAvailability ? 'Availability matches' : 'No structured availability',
                hasAllSkills ? 'Skills match' : (visitSkills.length > 0 ? 'Missing required skills' : 'No specific skills required')
            ]
        };
    }).sort((a: any, b: any) => b.score - a.score).slice(0, 5);

    return c.json(suggested, 200);
});

// Assign PSW
const assignPswRoute = createRoute({
    method: 'post',
    path: '/assign',
    summary: 'Assign PSW',
    description: 'Manually assign a PSW to a visit.',
    tags: ['Admin Visits'],
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
    },
});

r.openapi(assignPswRoute, async (c) => {
    const prisma = c.get('prisma');
    const { visitId, pswId } = c.req.valid('json');
    const payload = c.get('jwtPayload');

    const psw = await prisma.pswProfile.findUnique({ where: { id: pswId } });
    if (!psw) return c.json({ error: 'PSW not found' }, 404);

    const [visit] = await prisma.$transaction([
        prisma.visit.update({
            where: { id: visitId },
            data: {
                assignedPswId: pswId,
                status: 'scheduled',
            },
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: payload.sub,
                action: 'ASSIGN_PSW',
                resourceType: 'VISIT',
                resourceId: visitId,
                metadataJson: { pswId },
                tenantId: payload.tenantId
            }
        })
    ]);

    return c.json(visit, 200);
});

// Update Visit
const updateVisitRoute = createRoute({
    method: 'patch',
    path: '/{id}',
    summary: 'Update Visit',
    description: 'Update visit details or status.',
    tags: ['Admin Visits'],
    request: {
        params: VisitParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        status: z.string().optional(),
                        requestedStartAt: z.string().datetime().optional(),
                        durationMinutes: z.number().optional(),
                    }),
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
            description: 'Visit updated successfully',
        },
    },
});

r.openapi(updateVisitRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const data = c.req.valid('json');

    const updateData: any = { ...data };
    if (data.status) {
        updateData.status = data.status as VisitStatus;
    }

    const visit = await prisma.visit.update({
        where: { id },
        data: updateData,
    });
    return c.json(visit, 200);
});

// Delete Visit
const deleteVisitRoute = createRoute({
    method: 'delete',
    path: '/{id}',
    summary: 'Delete Visit',
    description: 'Remove a visit from the system.',
    tags: ['Admin Visits'],
    request: {
        params: VisitParamsSchema,
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        success: z.boolean(),
                    }),
                },
            },
            description: 'Visit deleted successfully',
        },
    },
});

r.openapi(deleteVisitRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    await prisma.visit.delete({ where: { id } });
    return c.json({ success: true }, 200);
});

// POST Cancel Visit
const cancelVisitRoute = createRoute({
    method: 'post',
    path: '/{id}/cancel',
    summary: 'Cancel Visit',
    description: 'Cancel a visit and apply cancellation policy.',
    tags: ['Admin Visits'],
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
    const diffHours = diffMs / (1000 * 60 * 60);

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
