import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { ROUTE_METADATA } from '@primecare/shared-utils';
import { handleAcceptOffer } from './offers-handlers';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const listOffersRoute = createRoute({ ...ROUTE_METADATA.PSW_SCHEDULE.LIST_OFFERS, method: 'get', path: '/', responses: { 200: { content: { 'application/json': { schema: z.array(z.any()) } }, description: 'List of shift offers' }, 404: { description: 'Profile not found' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });
const acceptOfferRoute = createRoute({ ...ROUTE_METADATA.PSW_SCHEDULE.ACCEPT_OFFER, method: 'post', path: '/{id}/accept', request: { params: z.object({ id: z.string() }) }, responses: { 200: { content: { 'application/json': { schema: z.any() } }, description: 'Offer accepted successfully' }, 400: { description: 'Offer already accepted or no longer available' }, 404: { description: 'Offer not found' } } });
const declineOfferRoute = createRoute({ ...ROUTE_METADATA.PSW_SCHEDULE.DECLINE_OFFER, method: 'post', path: '/{id}/decline', request: { params: z.object({ id: z.string() }) }, responses: { 200: { content: { 'application/json': { schema: z.any() } }, description: 'Offer declined successfully' }, 404: { description: 'Offer not found' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });

r.openapi(listOffersRoute, async (c) => {
    const prisma = c.get('prisma'); const userId = c.get('jwtPayload').sub;
    const profile = await prisma.providerProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);
    const offers = await prisma.visit.findMany({ where: { status: 'posted', offers: { some: { providerId: profile.id, status: 'pending' } } }, orderBy: { requestedStartAt: 'asc' }, include: { client: { select: { fullName: true, city: true } }, service: true } });
    return c.json(offers, 200);
});

r.openapi(acceptOfferRoute, handleAcceptOffer);

r.openapi(declineOfferRoute, async (c) => {
    const prisma = c.get('prisma'); const userId = c.get('jwtPayload').sub; const { id: visitId } = c.req.valid('param');
    const profile = await prisma.providerProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);
    await prisma.shiftAssignment.updateMany({ where: { visitId, providerId: profile.id }, data: { status: 'declined' } });
    return c.json({ success: true }, 200);
});

export default r;
