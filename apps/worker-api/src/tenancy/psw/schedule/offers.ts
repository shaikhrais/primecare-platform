import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../';
import { ROUTE_METADATA } from '../../../constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

/ GET Offered Shifts
const listOffersRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.LIST_OFFERS,
    method: 'get',
    path: '/',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of shift offers',
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

    const offers = await prisma.visit.findMany({
        where: {
            status: 'posted',
            offers: { some: { pswId: profile.id, status: 'pending' } },
        },
        orderBy: { requestedStartAt: 'asc' },
        include: {
            client: { select: { fullName: true, city: true } },
            service: true,
        },
    });

    return c.json(offers, 200);
});

/ POST Accept Offer
const acceptOfferRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.ACCEPT_OFFER,
    method: 'post',
    path: '/{id}/accept',
    request: {
        params: z.object({ id: z.string() }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Offer accepted successfully',
        },
        400: {
            description: 'Offer already accepted or no longer available',
        },
        404: {
            description: 'Offer not found',
        },
    },
});

r.openapi(acceptOfferRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: visitId } = c.req.valid('param');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visit = await prisma.visit.findUnique({
        where: { id: visitId },
        include: { offers: { where: { pswId: profile.id } } },
    });

    if (!visit || visit.status !== 'posted') {
        return c.json({ error: 'Offer no longer available' }, 400);
    }

    await prisma.$transaction([
        prisma.visit.update({
            where: { id: visitId },
            data: { status: 'scheduled', assignedPswId: profile.id },
        }),
        prisma.shiftOffer.updateMany({
            where: { visitId, pswId: profile.id },
            data: { status: 'accepted' },
        }),
        prisma.shiftOffer.updateMany({
            where: { visitId, pswId: { not: profile.id } },
            data: { status: 'expired' },
        }),
    ]);

    return c.json({ success: true }, 200);
});

/ POST Decline Offer
const declineOfferRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.DECLINE_OFFER,
    method: 'post',
    path: '/{id}/decline',
    request: {
        params: z.object({ id: z.string() }),
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Offer declined successfully',
        },
        404: {
            description: 'Offer not found',
        },
    },
});

r.openapi(declineOfferRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: visitId } = c.req.valid('param');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    await prisma.shiftOffer.updateMany({
        where: { visitId, pswId: profile.id },
        data: { status: 'declined' },
    });

    return c.json({ success: true }, 200);
});

export default r;
