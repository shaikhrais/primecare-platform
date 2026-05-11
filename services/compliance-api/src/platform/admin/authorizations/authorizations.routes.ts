import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const authorizations = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const AuthorizationSchema = z.object({
    clientId: z.string(), serviceId: z.string().optional(),
    fundingSource: z.string(), authorizedHours: z.number(),
    startDate: z.string(), endDate: z.string(),
    authCode: z.string().optional(), notes: z.string().optional(),
});

// GET / — List all active authorizations
const listRoute = createRoute({
    method: 'get', path: '/', summary: 'List Service Authorizations', tags: ['Authorizations'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), clientId: z.string(), fundingSource: z.string(),
                        authorizedHours: z.number(), usedHours: z.number(), status: z.string(),
                    }))
                }
            }, description: 'Authorizations list'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

authorizations.openapi(listRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const auths = await prisma.serviceAuthorization.findMany({
        where: { tenantId }, include: { client: { select: { fullName: true } } },
        orderBy: { endDate: 'asc' },
    });
    return c.json(auths, 200);
});

// POST / — Create authorization
const createRoute2 = createRoute({
    method: 'post', path: '/', summary: 'Create Service Authorization', tags: ['Authorizations'],
    request: { body: { content: { 'application/json': { schema: AuthorizationSchema } } } },
    responses: { 200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Created' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

authorizations.openapi(createRoute2, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    const auth = await prisma.serviceAuthorization.create({
        data: { ...body, startDate: new Date(body.startDate), endDate: new Date(body.endDate), tenantId },
    });
    return c.json(auth, 200);
});

// PATCH /:id — Update authorization
const updateRoute = createRoute({
    method: 'patch', path: '/{id}', summary: 'Update Authorization', tags: ['Authorizations'],
    request: {
        params: z.object({ id: z.string() }),
        body: { content: { 'application/json': { schema: AuthorizationSchema.partial() } } },
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Updated' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

authorizations.openapi(updateRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { id } = c.req.valid('param');
    const body = c.req.valid('json');

    const existing = await prisma.serviceAuthorization.findFirst({ where: { id, tenantId } });
    if (!existing) return c.json({ error: 'Not found' }, 404);

    const data: any = { ...body };
    if (body.startDate) data.startDate = new Date(body.startDate);
    if (body.endDate) data.endDate = new Date(body.endDate);

    await prisma.serviceAuthorization.update({ where: { id }, data });
    return c.json({ success: true }, 200);
});

// GET /alerts — Near-expiry and near-exhaustion warnings
const alertsRoute = createRoute({
    method: 'get', path: '/alerts', summary: 'Authorization Alerts', tags: ['Authorizations'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        nearExpiry: z.array(z.object({ id: z.string(), clientId: z.string(), endDate: z.string() })),
                        nearExhaustion: z.array(z.object({ id: z.string(), clientId: z.string(), usedHours: z.number(), authorizedHours: z.number() })),
                    })
                }
            }, description: 'Alerts'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

authorizations.openapi(alertsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const twoWeeksFromNow = new Date();
    twoWeeksFromNow.setDate(twoWeeksFromNow.getDate() + 14);

    const [nearExpiry, allActive] = await Promise.all([
        prisma.serviceAuthorization.findMany({
            where: { tenantId, status: 'active', endDate: { lte: twoWeeksFromNow, gte: new Date() } },
            include: { client: { select: { fullName: true } } },
        }),
        prisma.serviceAuthorization.findMany({
            where: { tenantId, status: 'active' },
            include: { client: { select: { fullName: true } } },
        }),
    ]);

    const nearExhaustion = allActive.filter((a: any) => a.authorizedHours > 0 && (a.usedHours / a.authorizedHours) >= 0.85);

    return c.json({ nearExpiry, nearExhaustion }, 200);
});

// GET /utilization/:clientId — Hours breakdown
const utilizationRoute = createRoute({
    method: 'get', path: '/utilization/{clientId}', summary: 'Client Authorization Utilization', tags: ['Authorizations'],
    request: { params: z.object({ clientId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), fundingSource: z.string(),
                        authorizedHours: z.number(), usedHours: z.number(), remainingHours: z.number(),
                    }))
                }
            }, description: 'Utilization'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

authorizations.openapi(utilizationRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { clientId } = c.req.valid('param');

    const auths = await prisma.serviceAuthorization.findMany({
        where: { tenantId, clientId, status: 'active' },
    });

    const result = auths.map((a: any) => ({
        ...a, remainingHours: Math.max(0, a.authorizedHours - a.usedHours),
    }));
    return c.json(result, 200);
});

export default authorizations;
