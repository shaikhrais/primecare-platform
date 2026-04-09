import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { ROUTE_METADATA } from '@primecare/shared-utils';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getPayoutHistoryRoute = createRoute({
    ...ROUTE_METADATA.PSW_EXTRA.PAYOUT_HISTORY,
    method: 'get',
    path: '/history',
    summary: 'Get Payout History',
    tags: ['PSW', 'Payouts'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(),
                        amount: z.any(),
                        currency: z.string(),
                        status: z.string(),
                        createdAt: z.date(),
                        processedAt: z.date().nullable()
                    })),
                },
            },
            description: 'Payout history retrieved successfully',
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

r.openapi(getPayoutHistoryRoute, async (c) => {
    const prisma = c.get('prisma');
    const user = c.get('user');

    const providerProfile = await prisma.providerProfile.findUnique({
        where: { userId: user.id }
    });

    if (!providerProfile) {
        return c.json({ error: 'PSW profile not found' }, 404);
    }

    const payouts = await prisma.payout.findMany({
        where: { providerId: providerProfile.id },
        orderBy: { createdAt: 'desc' }
    });

    return c.json(payouts, 200);
});

export default r;
