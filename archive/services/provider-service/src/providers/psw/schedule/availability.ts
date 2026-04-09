import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { ROUTE_METADATA } from '@primecare/shared-utils';

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
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(updateAvailabilityRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { availability } = c.req.valid('json');

    const profile = await prisma.providerProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    // Feature 18: Availability Conflict Resolver
    const upcomingVisits = await prisma.visit.findMany({
        where: {
            assignedProviderId: profile.id,
            status: 'scheduled',
            requestedStartAt: { gt: new Date() }
        }
    });

    if (upcomingVisits.length > 0 && profile.tenantId) {
        const adminManager = await prisma.user.findFirst({
            where: { tenantId: profile.tenantId, role: 'manager' }
        });

        if (adminManager) {
            await prisma.appNotification.create({
                data: {
                    userId: adminManager.id,
                    tenantId: profile.tenantId,
                    title: 'Urgent: Schedule Conflict Detected',
                    message: `PSW ${profile.userId} modified structural availability while assigned to ${upcomingVisits.length} upcoming shifts. Some blocks may now collide. Please review.`,
                    type: 'critical'
                }
            });
            console.log(`[Worker] Feature 18 Fired: Availability conflict flag generated for PSW ${profile.id}`);
        }
    }

    // Simplified update logic for demonstration
    const updated = await prisma.providerProfile.update({
        where: { id: profile.id },
        data: {
            structuralAvailability: availability
        },
    });

    return c.json(updated, 200);
});

export default r;
