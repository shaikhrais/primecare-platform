import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const woundCare = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /assessments/:clientId — Wound assessment history
const assessmentsRoute = createRoute({
    method: 'get', path: '/assessments/{clientId}',
    summary: 'Wound Assessment History', tags: ['Wound Care'],
    request: { params: z.object({ clientId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), type: z.string(), data: z.any(), createdAt: z.string(),
                    }))
                }
            }, description: 'Assessments'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

woundCare.openapi(assessmentsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { clientId } = c.req.valid('param');

    const records = await prisma.clinicalRecord.findMany({
        where: { tenantId, clientId, type: { in: ['WoundAssessment', 'Condition'] } },
        orderBy: { createdAt: 'desc' },
    });
    return c.json(records, 200);
});

// POST /assessments — Create wound assessment with PUSH scoring
const createAssessmentRoute = createRoute({
    method: 'post', path: '/assessments',
    summary: 'Create Wound Assessment (PUSH Tool)', tags: ['Wound Care'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(),
                        woundLocation: z.string(),
                        woundType: z.enum(['pressure_ulcer', 'surgical', 'diabetic', 'venous', 'arterial', 'other']),
                        lengthCm: z.number(), widthCm: z.number(), depthCm: z.number().optional(),
                        tissueType: z.enum(['closed', 'epithelial', 'granulation', 'slough', 'necrotic']),
                        exudateAmount: z.enum(['none', 'light', 'moderate', 'heavy']),
                        photoKey: z.string().optional(), // R2 storage key
                        notes: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: { 200: { content: { 'application/json': { schema: z.object({ id: z.string(), pushScore: z.number() }) } }, description: 'Created' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

woundCare.openapi(createAssessmentRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const body = c.req.valid('json');

    // PUSH Tool Score Calculation
    const area = body.lengthCm * body.widthCm;
    let areaScore = 0;
    if (area === 0) areaScore = 0;
    else if (area < 0.3) areaScore = 1;
    else if (area < 0.7) areaScore = 2;
    else if (area < 1.0) areaScore = 3;
    else if (area < 2.0) areaScore = 4;
    else if (area < 3.0) areaScore = 5;
    else if (area < 4.0) areaScore = 6;
    else if (area < 8.0) areaScore = 7;
    else if (area < 12.0) areaScore = 8;
    else if (area < 24.0) areaScore = 9;
    else areaScore = 10;

    const exudateScores: Record<string, number> = { none: 0, light: 1, moderate: 2, heavy: 3 };
    const tissueScores: Record<string, number> = { closed: 0, epithelial: 1, granulation: 2, slough: 3, necrotic: 4 };

    const pushScore = areaScore + (exudateScores[body.exudateAmount] || 0) + (tissueScores[body.tissueType] || 0);

    const record = await prisma.clinicalRecord.create({
        data: {
            clientId: body.clientId, type: 'WoundAssessment', tenantId,
            data: { ...body, pushScore, area },
        },
    });

    return c.json({ id: record.id, pushScore }, 200);
});

// GET /progress/:clientId — Healing progress timeline
const progressRoute = createRoute({
    method: 'get', path: '/progress/{clientId}',
    summary: 'Wound Healing Progress', tags: ['Wound Care'],
    request: { params: z.object({ clientId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        date: z.string(), pushScore: z.number(), area: z.number(),
                    }))
                }
            }, description: 'Progress timeline'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

woundCare.openapi(progressRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { clientId } = c.req.valid('param');

    const records = await prisma.clinicalRecord.findMany({
        where: { tenantId, clientId, type: 'WoundAssessment' },
        orderBy: { createdAt: 'asc' },
    });

    const timeline = records.map((r: any) => ({
        date: r.createdAt, pushScore: r.data?.pushScore || 0, area: r.data?.area || 0,
    }));
    return c.json(timeline, 200);
});

// GET /chronic/:clientId — Chronic condition home
const chronicRoute = createRoute({
    method: 'get', path: '/chronic/{clientId}',
    summary: 'Chronic Condition Home', tags: ['Wound Care'],
    request: { params: z.object({ clientId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        conditions: z.array(z.object({ type: z.string(), data: z.any(), recordedAt: z.string() })),
                        vitalsTrend: z.array(z.object({ date: z.string(), type: z.string(), value: z.number() })),
                    })
                }
            }, description: 'Home data'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

woundCare.openapi(chronicRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { clientId } = c.req.valid('param');

    const [conditions, vitals] = await Promise.all([
        prisma.clinicalRecord.findMany({
            where: { tenantId, clientId, type: 'Condition' },
            orderBy: { createdAt: 'desc' },
        }),
        prisma.vitalSign.findMany({
            where: { tenantId, clientId },
            orderBy: { recordedAt: 'desc' }, take: 50,
        }),
    ]);

    return c.json({
        conditions: conditions.map((c: any) => ({ type: c.type, data: c.data, recordedAt: c.createdAt })),
        vitalsTrend: vitals.map((v: any) => ({ date: v.recordedAt, type: v.type, value: v.value })),
    }, 200);
});

export default woundCare;
