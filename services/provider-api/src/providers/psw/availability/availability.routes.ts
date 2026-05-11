import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { ROUTE_METADATA } from '@primecare/infrastructure';
import { logAudit } from '@primecare/infrastructure';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const AvailabilityOverrideSchema = z.object({
    overrides: z.array(z.object({
        date: z.string(),
        startTime: z.string(),
        endTime: z.string(),
        isAvailable: z.boolean()
    }))
});

const syncAvailabilityRoute = createRoute({
    ...ROUTE_METADATA.PSW_EXTRA.AVAILABILITY_OVERRIDE_SYNC,
    method: 'post',
    path: '/sync',
    summary: 'Sync Availability',
    tags: ['PSW', 'Availability'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: AvailabilityOverrideSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean(), count: z.number() }),
                },
            },
            description: 'Availability overrides synced successfully',
        },
        404: {
            content: {
                'application/json': {
                    schema: z.object({ error: z.string() }),
                },
            },
            description: 'Resource not found',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(syncAvailabilityRoute, async (c) => {
    const prisma = c.get('prisma');
    const user = c.get('user');
    const tenantId = c.get('jwtPayload').tenantId;
    const { overrides } = c.req.valid('json');

    const providerProfile = await prisma.providerProfile.findUnique({
        where: { userId: user.id }
    });

    if (!providerProfile) {
        return c.json({ error: 'PSW profile not found' }, 404);
    }

    // Delete existing overrides for these dates
    const dates = overrides.map(o => new Date(o.date));
    await prisma.availabilityOverride.deleteMany({
        where: {
            providerId: providerProfile.id,
            date: { in: dates }
        }
    });

    // Create new overrides
    const created = await prisma.availabilityOverride.createMany({
        data: overrides.map(o => ({
            providerId: providerProfile.id,
            tenantId,
            date: new Date(o.date),
            startTime: o.startTime,
            endTime: o.endTime,
            isAvailable: o.isAvailable
        }))
    });

    await logAudit(prisma, user.id, 'SYNC_AVAILABILITY_OVERRIDES', 'AVAILABILITY_OVERRIDE', providerProfile.id, { count: created.count });

    return c.json({ success: true, count: created.count }, 200);
});

export default r;
