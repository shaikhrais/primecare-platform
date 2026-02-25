import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// POST Update Availability
const updateAvailabilityRoute = createRoute({
    method: 'post',
    path: '/',
    summary: 'Update Availability',
    description: 'Update the structural availability for the PSW.',
    tags: ['PSW Schedule'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        dayOfWeek: z.number().min(0).max(6),
                        startTime: z.string().regex(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/),
                        endTime: z.string().regex(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/),
                    })),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean() }),
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
    const availabilityData = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    await prisma.$transaction([
        prisma.availability.deleteMany({ where: { pswId: profile.id } }),
        ...availabilityData.map(data => prisma.availability.create({
            data: {
                pswId: profile.id,
                ...data,
                tenantId: profile.tenantId
            }
        }))
    ]);

    return c.json({ success: true }, 200);
});

export default r;




