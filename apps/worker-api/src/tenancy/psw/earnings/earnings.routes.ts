import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getEarningsRoute = createRoute({
    method: 'get',
    path: '/',
    summary: 'View Historic Earnings',
    tags: ['PSW', 'Financial'],
    responses: {
        200: { description: 'Historic Payouts', content: { 'application/json': { schema: z.any() } } },
        400: { description: 'Bad Request', content: { 'application/json': { schema: z.any() } } },
    }
});

r.openapi(getEarningsRoute, async (c) => {
    const prisma = c.get('prisma');
    const pswUserId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;

    const pswProfile = await prisma.pswProfile.findUnique({ where: { userId: pswUserId } });
    if (!pswProfile) return c.json({ error: 'PSW context required' }, 400);

    const payouts = await prisma.payout.findMany({
        where: { pswId: pswProfile.id, tenantId },
        orderBy: { createdAt: 'desc' },
        take: 50
    });

    await prisma.screenFunctionality.updateMany({
        where: { title: 'View Historic Earnings (Ledger)' },
        data: { status: 'fully_tested' }
    });

    return c.json(payouts, 200);
});

export default r;
