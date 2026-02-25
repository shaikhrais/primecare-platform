import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET Offered Shifts
const listOffersRoute = createRoute({
    method: 'get',
    path: '/',
    summary: 'Get Offered Shifts',
    description: 'Retrieve a list of shifts offered to the authenticated PSW.',
    tags: ['PSW Schedule'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of offered shifts',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(listOffersRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const offers = await prisma.shiftAssignment.findMany({
        where: { pswId: profile.id, status: 'offered' },
        include: {
            visit: {
                include: {
                    client: { select: { fullName: true, addressLine1: true, city: true } },
                    service: true,
                }
            }
        }
    });

    return c.json(offers, 200);
});

// POST Accept Offer
const acceptOfferRoute = createRoute({
    method: 'post',
    path: '/{id}/accept',
    summary: 'Accept Shift Offer',
    description: 'Accept an offered shift and mark the visit as scheduled.',
    tags: ['PSW Schedule'],
    request: {
        params: z.object({
            id: z.string().openapi({ param: { name: 'id', in: 'path' }, example: 'offer-uuid' })
        }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean() }),
                },
            },
            description: 'Offer accepted successfully',
        },
        404: {
            description: 'Offer or profile not found',
        },
    },
});

r.openapi(acceptOfferRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: assignmentId } = c.req.valid('param');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const assignment = await prisma.shiftAssignment.findUnique({
        where: { id: assignmentId },
        include: { visit: true }
    });

    if (!assignment || assignment.pswId !== profile.id) {
        return c.json({ error: 'Offer not found' }, 404);
    }

    await prisma.$transaction([
        prisma.shiftAssignment.update({
            where: { id: assignmentId },
            data: { status: 'accepted' }
        }),
        prisma.visit.update({
            where: { id: assignment.visitId },
            data: {
                status: 'accepted',
                assignedPswId: profile.id
            }
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: userId,
                action: 'ACCEPT_OFFER',
                resourceType: 'VISIT',
                resourceId: assignment.visitId,
                tenantId: profile.tenantId
            }
        })
    ]);

    return c.json({ success: true }, 200);
});

// POST Decline Offer
const declineOfferRoute = createRoute({
    method: 'post',
    path: '/{id}/decline',
    summary: 'Decline Shift Offer',
    description: 'Decline an offered shift.',
    tags: ['PSW Schedule'],
    request: {
        params: z.object({
            id: z.string().openapi({ param: { name: 'id', in: 'path' }, example: 'offer-uuid' })
        }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean() }),
                },
            },
            description: 'Offer declined successfully',
        },
    },
});

r.openapi(declineOfferRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id: assignmentId } = c.req.valid('param');

    await prisma.shiftAssignment.update({
        where: { id: assignmentId },
        data: { status: 'declined' }
    });

    return c.json({ success: true }, 200);
});

export default r;




