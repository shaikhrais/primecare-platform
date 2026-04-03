import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const webhooks = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET / — List webhooks
const listRoute = createRoute({
    method: 'get', path: '/', summary: 'List Webhook Endpoints', tags: ['Webhooks'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), url: z.string(), events: z.array(z.string()),
                        status: z.string(), failureCount: z.number(),
                    }))
                }
            }, description: 'Endpoints'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

webhooks.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const endpoints = await prisma.webhookEndpoint.findMany({ where: { tenantId } });
    return c.json(endpoints, 200);
});

// POST / — Register webhook
const registerRoute = createRoute({
    method: 'post', path: '/', summary: 'Register Webhook', tags: ['Webhooks'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        url: z.string().url(), events: z.array(z.string()),
                    })
                }
            }
        }
    },
    responses: { 200: { content: { 'application/json': { schema: z.object({ id: z.string(), secret: z.string() }) } }, description: 'Registered' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

webhooks.openapi(registerRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    const secret = `whsec_${crypto.randomUUID().replace(/-/g, '')}`;
    const endpoint = await prisma.webhookEndpoint.create({
        data: { url: body.url, events: body.events, secret, tenantId },
    });
    return c.json({ id: endpoint.id, secret }, 200);
});

// DELETE /:id — Remove webhook
const deleteRoute = createRoute({
    method: 'delete', path: '/{id}', summary: 'Delete Webhook', tags: ['Webhooks'],
    request: { params: z.object({ id: z.string() }) },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ deleted: z.boolean() }) } }, description: 'Deleted' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

webhooks.openapi(deleteRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { id } = c.req.valid('param');

    const ep = await prisma.webhookEndpoint.findFirst({ where: { id, tenantId } });
    if (!ep) return c.json({ error: 'Not found' }, 404);

    await prisma.webhookDelivery.deleteMany({ where: { endpointId: id } });
    await prisma.webhookEndpoint.delete({ where: { id } });
    return c.json({ deleted: true }, 200);
});

// GET /deliveries — Delivery log
const deliveriesRoute = createRoute({
    method: 'get', path: '/deliveries', summary: 'Webhook Delivery Log', tags: ['Webhooks'],
    request: { query: z.object({ endpointId: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), event: z.string(), statusCode: z.number().nullable(),
                        retryCount: z.number(), deliveredAt: z.string(),
                    }))
                }
            }, description: 'Deliveries'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

webhooks.openapi(deliveriesRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { endpointId } = c.req.valid('query');

    const endpoints = await prisma.webhookEndpoint.findMany({
        where: { tenantId }, select: { id: true },
    });
    const epIds = endpoints.map((e: any) => e.id);

    const where: any = { endpointId: { in: epIds } };
    if (endpointId) where.endpointId = endpointId;

    const deliveries = await prisma.webhookDelivery.findMany({
        where, orderBy: { deliveredAt: 'desc' }, take: 100,
    });
    return c.json(deliveries, 200);
});

// POST /test/:id — Send test payload
const testRoute = createRoute({
    method: 'post', path: '/test/{id}', summary: 'Send Test Webhook', tags: ['Webhooks'],
    request: { params: z.object({ id: z.string() }) },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ statusCode: z.number(), success: z.boolean() }) } }, description: 'Test result' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

webhooks.openapi(testRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { id } = c.req.valid('param');

    const ep = await prisma.webhookEndpoint.findFirst({ where: { id, tenantId } });
    if (!ep) return c.json({ error: 'Not found' }, 404);

    const payload = { event: 'test.ping', timestamp: new Date().toISOString(), data: { message: 'PrimeCare webhook test' } };

    try {
        const res = await fetch(ep.url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json', 'X-Webhook-Secret': ep.secret },
            body: JSON.stringify(payload),
        });

        await prisma.webhookDelivery.create({
            data: { endpointId: id, event: 'test.ping', payload, statusCode: res.status },
        });

        return c.json({ statusCode: res.status, success: res.ok }, 200);
    } catch (err: any) {
        await prisma.webhookDelivery.create({
            data: { endpointId: id, event: 'test.ping', payload, statusCode: 0, responseBody: err.message },
        });
        return c.json({ statusCode: 0, success: false }, 200);
    }
});

export default webhooks;
