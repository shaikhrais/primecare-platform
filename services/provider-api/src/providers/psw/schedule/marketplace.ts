import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { ROUTE_METADATA } from '@primecare/infrastructure';

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
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(listMarketplaceRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.providerProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    // Fetch shifts that are posted but HAVE NOT been assigned/offered to this specific PSW (those are handled by /assignments)
    const shifts = await prisma.visit.findMany({
        where: {
            status: 'posted',
            assignments: { none: { providerId: profile.id } },
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

    const profile = await prisma.providerProfile.findUnique({ where: { userId } });
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
            data: { status: 'scheduled', assignedProviderId: profile.id },
        }),
        // Expire any pending direct offers for this shift to other PSWs since someone took it from the marketplace
        prisma.shiftAssignment.updateMany({
            where: { visitId, status: 'offered' },
            data: { status: 'expired' },
        }),
    ]);

    return c.json({ success: true }, 200);
});

// GET Peer Swaps
const listSwapsRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.LIST_MARKETPLACE,
    method: 'get',
    path: '/swaps',
    responses: {
        200: { content: { 'application/json': { schema: z.array(z.any()) } }, description: 'Peer Swaps' },
        404: { description: 'Profile not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(listSwapsRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.providerProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const swaps = await prisma.visit.findMany({
        where: {
            status: 'swap_requested',
            assignedProviderId: { not: profile.id }, // don't show your own swaps on the board
        },
        orderBy: { requestedStartAt: 'asc' },
        include: {
            client: { select: { fullName: true, city: true, addressLine1: true } },
            service: true,
            psw: { select: { fullName: true } }
        },
    });

    // Map to frontend expectation
    const mappedSwaps = swaps.map((s: any) => ({
        ...s,
        offeredBy: s.psw?.fullName || 'Peer Worker',
        note: s.clientNotes || 'Can someone cover this for me? Appreciate it!',
    }));

    return c.json(mappedSwaps, 200);
});

export default r;
