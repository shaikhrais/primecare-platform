import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET Marketplace Shifts (Unassigned)
const listMarketplaceRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.LIST_MARKETPLACE,
    method: 'get',
    path: '/',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of unassigned open shifts',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(listMarketplaceRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    // Fetch shifts that are posted but HAVE NOT been offered to this specific PSW (those are handled by /offers)
    const shifts = await prisma.visit.findMany({
        where: {
            status: 'posted',
            offers: { none: { pswId: profile.id } },
        },
        orderBy: { requestedStartAt: 'asc' },
        include: {
            client: { select: { fullName: true, city: true, addressLine1: true } },
            service: true,
        },
    });

    return c.json(shifts, 200);
});

// POST Accept Marketplace Shift
const acceptMarketplaceRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.ACCEPT_MARKETPLACE,
    method: 'post',
    path: '/{id}/accept',
    request: {
        params: z.object({ id: z.string() }),
    },
    responses: {
        200: {
            content: { 'application/json': { schema: z.any() } },
            description: 'Shift accepted successfully',
        },
        400: { description: 'Shift already accepted or no longer available' },
        404: { description: 'Shift not found' },
    },
});

r.openapi(acceptMarketplaceRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: visitId } = c.req.valid('param');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visit = await prisma.visit.findUnique({
        where: { id: visitId },
    });

    if (!visit || visit.status !== 'posted') {
        return c.json({ error: 'Shift no longer available' }, 400);
    }

    await prisma.$transaction([
        prisma.visit.update({
            where: { id: visitId },
            data: { status: 'scheduled', assignedPswId: profile.id },
        }),
        // Expire any pending direct offers for this shift to other PSWs since someone took it from the marketplace
        prisma.shiftOffer.updateMany({
            where: { visitId, status: 'pending' },
            data: { status: 'expired' },
        }),
    ]);

    return c.json({ success: true }, 200);
});

export default r;
