import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const referrals = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ReferralSchema = z.object({
    clientName: z.string(), clientPhone: z.string().optional(), clientEmail: z.string().optional(),
    referrerName: z.string(), referrerOrg: z.string().optional(),
    referrerType: z.enum(['internal', 'external', 'self']).optional(),
    serviceNeeded: z.string().optional(), urgency: z.enum(['routine', 'urgent', 'emergent']).optional(),
    clinicalNotes: z.string().optional(),
});

// GET / — List referrals
const listRoute = createRoute({
    method: 'get', path: '/', summary: 'List Referrals', tags: ['Referrals'],
    request: { query: z.object({ status: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), clientName: z.string(), referrerName: z.string(),
                        status: z.string(), urgency: z.string(), createdAt: z.string(),
                    }))
                }
            }, description: 'List'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

referrals.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { status } = c.req.valid('query');

    const where: any = { tenantId };
    if (status) where.status = status;

    const list = await prisma.referral.findMany({ where, orderBy: { createdAt: 'desc' } });
    return c.json(list, 200);
});

// POST / — Create referral
const createRoute2 = createRoute({
    method: 'post', path: '/', summary: 'Create Referral', tags: ['Referrals'],
    request: { body: { content: { 'application/json': { schema: ReferralSchema } } } },
    responses: { 200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Created' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

referrals.openapi(createRoute2, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    const referral = await prisma.referral.create({ data: { ...body, tenantId } });
    return c.json(referral, 200);
});

// PATCH /:id — Update status
const updateRoute = createRoute({
    method: 'patch', path: '/{id}', summary: 'Update Referral', tags: ['Referrals'],
    request: {
        params: z.object({ id: z.string() }),
        body: { content: { 'application/json': { schema: z.object({ status: z.string(), clinicalNotes: z.string().optional() }) } } },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Updated' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

referrals.openapi(updateRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { id } = c.req.valid('param');
    const body = c.req.valid('json');

    const existing = await prisma.referral.findFirst({ where: { id, tenantId } });
    if (!existing) return c.json({ error: 'Not found' }, 404);

    await prisma.referral.update({ where: { id }, data: body });
    return c.json({ success: true }, 200);
});

// POST /:id/convert — Convert to client
const convertRoute = createRoute({
    method: 'post', path: '/{id}/convert', summary: 'Convert Referral to Client', tags: ['Referrals'],
    request: { params: z.object({ id: z.string() }) },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ clientId: z.string() }) } }, description: 'Converted' },
        404: { description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

referrals.openapi(convertRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { id } = c.req.valid('param');

    const ref = await prisma.referral.findFirst({ where: { id, tenantId } });
    if (!ref) return c.json({ error: 'Not found' }, 404);

    const client = await prisma.clientProfile.create({
        data: { fullName: ref.clientName, email: ref.clientEmail, phone: ref.clientPhone, tenantId, status: 'active' },
    });

    await prisma.referral.update({
        where: { id }, data: { status: 'converted', convertedClientId: client.id, convertedAt: new Date() },
    });

    return c.json({ clientId: client.id }, 200);
});

// GET /analytics — Source tracking
const analyticsRoute = createRoute({
    method: 'get', path: '/analytics', summary: 'Referral Analytics', tags: ['Referrals'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        total: z.number(), byStatus: z.record(z.number()), bySource: z.record(z.number()),
                        conversionRate: z.number(),
                    })
                }
            }, description: 'Analytics'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

referrals.openapi(analyticsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const all = await prisma.referral.findMany({ where: { tenantId } });
    const byStatus: Record<string, number> = {};
    const bySource: Record<string, number> = {};

    for (const r of all) {
        byStatus[r.status] = (byStatus[r.status] || 0) + 1;
        const src = (r as any).referrerOrg || 'Unknown';
        bySource[src] = (bySource[src] || 0) + 1;
    }

    const converted = all.filter((r: any) => r.status === 'converted').length;
    return c.json({
        total: all.length, byStatus, bySource,
        conversionRate: all.length > 0 ? Math.round((converted / all.length) * 10000) / 100 : 0,
    }, 200);
});

export default referrals;
