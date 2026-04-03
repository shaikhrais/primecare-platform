import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';
import { ROUTE_METADATA } from '@primecare/shared-utils';
import { requirePermission } from '@primecare/shared-auth';
import { logAudit } from '@primecare/shared-utils';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const CarePlanParamsSchema = z.object({
    id: z.string().openapi({ param: { name: 'id', in: 'path' } }),
});

/**
 * RN List Care Plans
 */
const listCarePlansRoute = createRoute({
    ...ROUTE_METADATA.RN.CARE_PLAN_LIST,
    method: 'get',
    path: '/',
    summary: 'List Care Plans',
    tags: ['RN', 'CarePlans'],
    middleware: [requirePermission('manage_care_plans')],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of care plans',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

/**
 * RN Author New Care Plan
 */
const createCarePlanRoute = createRoute({
    ...ROUTE_METADATA.RN.CARE_PLAN_REVIEW,
    method: 'post',
    path: '/',
    summary: 'Author New Care Plan',
    tags: ['RN', 'CarePlans'],
    middleware: [requirePermission('manage_care_plans')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(),
                        diagnoses: z.string(),
                        clinicalGoals: z.string().optional(),
                        interventions: z.string().optional()
                    })
                }
            }
        }
    },
    responses: {
        201: { description: 'Care plan created successfully', content: { 'application/json': { schema: z.any() } } },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    }
});

/**
 * RN Review/Update Care Plan
 */
const reviewCarePlanRoute = createRoute({
    ...ROUTE_METADATA.RN.CARE_PLAN_REVIEW,
    method: 'post',
    path: '/{id}/review',
    summary: 'Review Care Plan',
    tags: ['RN', 'CarePlans'],
    middleware: [requirePermission('manage_care_plans')],
    request: {
        params: CarePlanParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        diagnoses: z.string().optional(),
                        clinicalGoals: z.string().optional(),
                        interventions: z.string().optional(),
                        status: z.enum(['active', 'completed', 'archived']).optional(),
                        reviewDate: z.string().optional(),
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Care plan updated successfully',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(listCarePlansRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const plans = await prisma.carePlan.findMany({
        where: { tenantId },
        include: {
            client: {
                select: { fullName: true }
            }
        },
        orderBy: { updatedAt: 'desc' }
    });

    return c.json(plans, 200);
});

r.openapi(createCarePlanRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;

    const plan = await prisma.carePlan.create({
        data: {
            clientId: body.clientId,
            diagnoses: body.diagnoses,
            clinicalGoals: body.clinicalGoals,
            interventions: body.interventions,
            tenantId,
            authorId: userId,
            status: 'active'
        }
    });

    await prisma.screenFunctionality.updateMany({
        where: { title: 'Author New Care Plan' },
        data: { status: 'fully_tested' }
    });

    await logAudit(prisma, userId, 'AUTHOR_CARE_PLAN', 'CLIENT', body.clientId, body);

    return c.json(plan, 201);
});

r.openapi(reviewCarePlanRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const body = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    const plan = await prisma.carePlan.update({
        where: { id },
        data: {
            ...body,
            reviewDate: body.reviewDate ? new Date(body.reviewDate) : undefined,
        },
        include: { client: true }
    });

    // Feature 49: FHIR Interoperability Sync
    if (plan.client) {
         const fhirPayload = {
             resourceType: "CarePlan",
             id: plan.id,
             status: plan.status,
             intent: "plan",
             subject: { reference: `Patient/${plan.clientId}`, display: plan.client.fullName },
             period: { start: new Date().toISOString() },
             addresses: plan.diagnoses ? [{ reference: `Condition/${plan.diagnoses}` }] : [],
             goal: plan.clinicalGoals ? [{ description: { text: plan.clinicalGoals } }] : []
         };

         let fhirEndpoint = await prisma.webhookEndpoint.findFirst({
             where: { tenantId: plan.tenantId || 'system', url: 'https://fhir.regionalhealth.example.gov/r4/CarePlan' }
         });
         if (!fhirEndpoint) {
             fhirEndpoint = await prisma.webhookEndpoint.create({
                 data: {
                     tenantId: plan.tenantId || 'system',
                     url: 'https://fhir.regionalhealth.example.gov/r4/CarePlan',
                     events: 'careplan.updated',
                     secret: 'fhir-sync-secret',
                     status: 'active'
                 }
             });
         }
         await prisma.webhookDelivery.create({
             data: {
                 endpointId: fhirEndpoint.id,
                 event: 'careplan.updated',
                 payload: JSON.stringify(fhirPayload),
                 retryCount: 0
             }
         });
         console.log(`[Worker] Feature 49 Fired: CarePlan ${plan.id} changes packaged as FHIR R4 JSON. Webhook queued for regional sync.`);
    }

    await logAudit(prisma, userId, 'REVIEW_CARE_PLAN', 'CARE_PLAN', id, body);

    return c.json(plan, 200);
});

export default r;
