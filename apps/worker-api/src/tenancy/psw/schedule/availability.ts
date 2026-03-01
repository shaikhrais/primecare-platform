import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// POST Update Availability
const updateAvailabilityRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.UPDATE_AVAILABILITY,
    method: 'post',
    path: '/',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        availability: z.array(z.any()),
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
            description: 'Availability updated successfully',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(updateAvailabilityRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { availability } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    // Simplified update logic for demonstration
    const updated = await prisma.pswProfile.update({
        where: { id: profile.id },
        data: {
            structuralAvailability: availability
        },
    });

    return c.json(updated, 200);
});

export default r;
