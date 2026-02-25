import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../bindings';
import { logAudit } from '../../../../_shared/utils/audit';
import { ROUTE_METADATA } from '../../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const VisitParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'visit-uuid',
    }),
});

// POST /{id}/post
const postShiftRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_VISITS.POST_SHIFT,
    method: 'post',
    path: '/{id}/post',
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

// POST /{id}/offer
const offerShiftRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_VISITS.OFFER_SHIFT,
    method: 'post',
    path: '/{id}/offer',
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

// GET /{id}/suggest
const suggestPswsRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_VISITS.SUGGEST_PSWS,
    method: 'get',
    path: '/{id}/suggest',
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

export default r;

