import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requirePermission } from '../../../_shared/middleware/rbac';
import { logAudit } from '../../../_shared/utils/audit';

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
    middleware: [requirePermission('CARE_PLAN_VIEW')],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of care plans',
        },
    },
});

/**
 * RN Review/Update Care Plan
 */
const reviewCarePlanRoute = createRoute({
    ...ROUTE_METADATA.RN.CARE_PLAN_REVIEW,
    method: 'post',
    path: '/{id}/review',
    middleware: [requirePermission('CARE_PLAN_UPDATE')],
    request: {
        params: CarePlanParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        diagnoses: z.array(z.string()).optional(),
                        clinicalGoals: z.any().optional(),
                        interventions: z.any().optional(),
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
             addresses: plan.diagnoses?.map((d: string) => ({ reference: `Condition/${d}` })) || [],
             goal: plan.clinicalGoals?.map((g: any) => ({ description: { text: g } })) || []
         };

         await prisma.webhookDelivery.create({
             data: {
                 tenantId: plan.tenantId || 'system',
                 endpointUrl: 'https://fhir.regionalhealth.example.gov/r4/CarePlan',
                 payload: JSON.stringify(fhirPayload),
                 status: 'pending',
                 attempts: 0
             }
         });
         console.log(`[Worker] Feature 49 Fired: CarePlan ${plan.id} changes packaged as FHIR R4 JSON. Webhook queued for regional sync.`);
    }

    await logAudit(prisma, userId, 'REVIEW_CARE_PLAN', 'CARE_PLAN', id, body);

    return c.json(plan, 200);
});

export default r;
