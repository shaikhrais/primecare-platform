import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const routes = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// ─── G10: Insurance Provider CRUD ───

const listInsuranceRoute = createRoute({
    method: 'get', path: '/insurance-providers',
    summary: 'List insurance providers', tags: ['Insurance'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), name: z.string(), networkId: z.string().nullable(),
                        contactPhone: z.string().nullable(), claimsEmail: z.string().nullable(),
                    }))
                }
            }, description: 'Providers'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

routes.openapi(listInsuranceRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const kv = (c.env as any).KV;
    const cacheKey = `insurance_providers_${tenantId}`;

    if (kv) {
        const cached = await kv.get(cacheKey, 'json');
        if (cached) return c.json(cached, 200);
    }

    const providers = await prisma.insuranceProvider.findMany({ where: { tenantId } });
    const formatted = providers.map((p: any) => ({
        id: p.id, name: p.name, networkId: p.networkId,
        contactPhone: p.contactPhone, claimsEmail: p.claimsEmail,
    }));

    if (kv) {
        await kv.put(cacheKey, JSON.stringify(formatted), { expirationTtl: 3600 });
    }

    return c.json(formatted, 200);
});

const createInsuranceRoute = createRoute({
    method: 'post', path: '/insurance-providers',
    summary: 'Create insurance provider', tags: ['Insurance'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        name: z.string(), networkId: z.string().optional(),
                        contactPhone: z.string().optional(), claimsEmail: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Created' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

routes.openapi(createInsuranceRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');
    const provider = await prisma.insuranceProvider.create({ data: { tenantId, ...body } });
    return c.json({ id: provider.id }, 200);
});

const deleteInsuranceRoute = createRoute({
    method: 'delete', path: '/insurance-providers/{id}',
    summary: 'Delete insurance provider', tags: ['Insurance'],
    request: { params: z.object({ id: z.string() }) },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Deleted' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

routes.openapi(deleteInsuranceRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    try { await prisma.insuranceProvider.delete({ where: { id } }); return c.json({ success: true }, 200); }
    catch { return c.json({ error: 'Not found' }, 404); }
});

// ─── G11: Billing Code Directory ───

const listBillingCodesRoute = createRoute({
    method: 'get', path: '/billing-codes',
    summary: 'List billing codes (HCPCS, CPT, ICD-10)', tags: ['Billing Codes'],
    request: { query: z.object({ category: z.string().optional(), search: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), code: z.string(), description: z.string(),
                        category: z.string(), defaultRate: z.number(),
                    }))
                }
            }, description: 'Codes'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

routes.openapi(listBillingCodesRoute, async (c) => {
    const prisma = c.get('prisma');
    const category = c.req.query('category');
    const search = c.req.query('search');
    const where: any = {};
    if (category) where.category = category;
    if (search) where.OR = [
        { code: { contains: search, mode: 'insensitive' } },
        { description: { contains: search, mode: 'insensitive' } },
    ];
    const codes = await prisma.billingCode.findMany({ where, take: 100 });
    return c.json(codes.map((bc: any) => ({
        id: bc.id, code: bc.code, description: bc.description,
        category: bc.category, defaultRate: bc.defaultRate,
    })), 200);
});

const createBillingCodeRoute = createRoute({
    method: 'post', path: '/billing-codes',
    summary: 'Create a billing code', tags: ['Billing Codes'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        code: z.string(), description: z.string(),
                        category: z.string(), defaultRate: z.number(),
                    })
                }
            }
        }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Created' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

routes.openapi(createBillingCodeRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const bc = await prisma.billingCode.create({ data: body });
    return c.json({ id: bc.id }, 200);
});

const updateBillingCodeRoute = createRoute({
    method: 'put', path: '/billing-codes/{id}',
    summary: 'Update a billing code', tags: ['Billing Codes'],
    request: {
        params: z.object({ id: z.string() }),
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        description: z.string().optional(), defaultRate: z.number().optional(),
                    })
                }
            }
        },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Updated' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

routes.openapi(updateBillingCodeRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const body = c.req.valid('json');
    try { await prisma.billingCode.update({ where: { id }, data: body }); return c.json({ success: true }, 200); }
    catch { return c.json({ error: 'Not found' }, 404); }
});

export default routes;
