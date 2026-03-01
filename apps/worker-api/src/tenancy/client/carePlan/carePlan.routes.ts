import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requirePermission } from '../../../_shared/middleware/rbac';
import { logAudit } from '../../../_shared/utils/audit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const CarePlanSchema = z.object({
    goals: z.array(z.string()),
    precautions: z.array(z.string()),
    interventions: z.array(z.string()),
    riskLevel: z.enum(['LOW', 'MEDIUM', 'HIGH', 'CRITICAL']).optional()
});

const ClientParamsSchema = z.object({
    clientId: z.string().openapi({ param: { name: 'clientId', in: 'path' } }),
});

// POST Care Plan
const createCarePlanRoute = createRoute({
    ...ROUTE_METADATA.CLIENT.CARE_PLAN_CREATE,
    method: 'post',
    path: '/{clientId}',
    middleware: [requirePermission('CARE_PLAN_CREATE')],
    request: {
        params: ClientParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: CarePlanSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        success: z.boolean(),
                        message: z.string(),
                        data: z.any(),
                    }),
                },
            },
            description: 'Care plan created successfully',
        },
    },
});

r.openapi(createCarePlanRoute, async (c) => {
    const prisma = c.get('prisma');
    const { clientId } = c.req.valid('param');
    const data = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    await logAudit(prisma, userId, 'CREATE_CARE_PLAN', 'ClientProfile', clientId, data);

    return c.json({ success: true, message: 'Care plan created', data }, 200);
});

// PATCH Care Plan
const updateCarePlanRoute = createRoute({
    ...ROUTE_METADATA.CLIENT.CARE_PLAN_UPDATE,
    method: 'patch',
    path: '/{clientId}',
    middleware: [requirePermission('CARE_PLAN_UPDATE')],
    request: {
        params: ClientParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: CarePlanSchema.partial(),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        success: z.boolean(),
                        message: z.string(),
                        data: z.any(),
                    }),
                },
            },
            description: 'Care plan updated successfully',
        },
    },
});

r.openapi(updateCarePlanRoute, async (c) => {
    const prisma = c.get('prisma');
    const { clientId } = c.req.valid('param');
    const data = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    await logAudit(prisma, userId, 'UPDATE_CARE_PLAN', 'ClientProfile', clientId, data);

    return c.json({ success: true, message: 'Care plan updated', data }, 200);
});

export default r;
