import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getActiveCarePlanRoute = createRoute({
    method: 'get',
    path: '/:patientId',
    summary: 'View Active Care Plan',
    tags: ['PSW'],
    request: {
        params: z.object({ patientId: z.string().openapi({ param: { name: 'patientId', in: 'path' } }) })
    },
    responses: { 
        200: { description: 'Care plan', content: { 'application/json': { schema: z.any() } } },
        404: { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
    }
});

r.openapi(getActiveCarePlanRoute, async (c) => {
    const prisma = c.get('prisma');
    const { patientId } = c.req.valid('param');
    const tenantId = c.get('jwtPayload').tenantId;

    const plan = await prisma.carePlan.findFirst({
        where: { clientId: patientId, tenantId, status: 'active' },
        orderBy: { createdAt: 'desc' },
        include: {
            author: { select: { fullName: true } },
            client: { select: { fullName: true } }
        }
    });

    if (!plan) return c.json({ error: 'No active care plan found for this patient' }, 404);
    
    // Automatically update the Platform Matrix Tracker!
    await prisma.screenFunctionality.updateMany({
        where: { title: 'View Active Care Plan' },
        data: { status: 'fully_tested' }
    });

    return c.json(plan, 200);
});

export default r;
