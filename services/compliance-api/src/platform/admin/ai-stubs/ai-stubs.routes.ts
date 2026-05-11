import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const aiStubs = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// F16. AI Predictions — Surface existing AIRecommendation data
const predictionsRoute = createRoute({
    method: 'get', path: '/predictions',
    summary: 'AI Predictions (Fall Risk, Readmission, Churn)', tags: ['AI'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), clientId: z.string(), type: z.string(),
                        riskScore: z.number(), recommendation: z.string(), createdAt: z.string(),
                    }))
                }
            }, description: 'Predictions'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

aiStubs.openapi(predictionsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const recs = await prisma.aIRecommendation.findMany({
        where: { tenantId }, orderBy: { createdAt: 'desc' }, take: 50,
    });

    const result = recs.map((r: any) => ({
        id: r.id, clientId: r.clientId || '', type: r.type,
        riskScore: r.data?.riskScore || 0, recommendation: r.recommendation || '',
        createdAt: r.createdAt,
    }));
    return c.json(result, 200);
});

// F17. IoT Vitals — Surface existing VitalSign data
const vitalsRoute = createRoute({
    method: 'get', path: '/vitals/{clientId}',
    summary: 'Latest Vital Signs from Wearables', tags: ['IoT'],
    request: { params: z.object({ clientId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), type: z.string(), value: z.number(),
                        unit: z.string(), source: z.string(), recordedAt: z.string(),
                    }))
                }
            }, description: 'Vitals'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

aiStubs.openapi(vitalsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { clientId } = c.req.valid('param');

    const vitals = await prisma.vitalSign.findMany({
        where: { tenantId, clientId }, orderBy: { recordedAt: 'desc' }, take: 20,
    });

    return c.json(vitals.map((v: any) => ({
        id: v.id, type: v.type, value: v.value,
        unit: v.unit || '', source: v.source || 'manual',
        recordedAt: v.recordedAt,
    })), 200);
});

// F18. Telehealth — Session stub
const telehealthRoute = createRoute({
    method: 'post', path: '/telehealth/session',
    summary: 'Create Telehealth Session (WebRTC Placeholder)', tags: ['Telehealth'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(), scheduledAt: z.string(),
                        participants: z.array(z.string()).optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        sessionId: z.string(), joinUrl: z.string(), status: z.string(),
                    })
                }
            }, description: 'Session created'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

aiStubs.openapi(telehealthRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    const session = await prisma.telehealthSession.create({
        data: {
            clientId: body.clientId, tenantId,
            scheduledAt: new Date(body.scheduledAt),
            status: 'scheduled',
        },
    });

    return c.json({
        sessionId: session.id,
        joinUrl: `/telehealth/join/${session.id}`, // Placeholder — WebRTC not yet implemented
        status: 'scheduled',
    }, 200);
});

export default aiStubs;
