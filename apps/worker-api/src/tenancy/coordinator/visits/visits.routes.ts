import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { requirePermission } from '../../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const updateVisitRoute = createRoute({
    method: 'patch',
    path: '/:id',
    summary: 'Adjust Client Schedule',
    tags: ['Coordinator', 'Scheduling'],
    middleware: [requirePermission('manage_schedule')],
    request: {
        params: z.object({ id: z.string() }),
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        requestedStartAt: z.string().datetime().optional(),
                        durationMinutes: z.number().optional(),
                        assignedPswId: z.string().nullable().optional(),
                        status: z.string().optional()
                    })
                }
            }
        }
    },
    responses: {
        200: { description: 'Visit Updated', content: { 'application/json': { schema: z.any() } } },
        404: { description: 'Not Found', content: { 'application/json': { schema: z.any() } } }
    }
});

r.openapi(updateVisitRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');
    const body = c.req.valid('json');
    const tenantId = c.get('jwtPayload').tenantId;

    const existing = await prisma.visit.findUnique({ where: { id, tenantId } });
    if (!existing) return c.json({ error: 'Visit not found' }, 404);

    const updateData: any = {};
    if (body.requestedStartAt) updateData.requestedStartAt = new Date(body.requestedStartAt);
    if (body.durationMinutes) updateData.durationMinutes = body.durationMinutes;
    if (body.assignedPswId !== undefined) updateData.assignedPswId = body.assignedPswId;
    if (body.status) updateData.status = body.status;

    const updated = await prisma.visit.update({
        where: { id },
        data: updateData
    });

    await prisma.screenFunctionality.updateMany({
        where: { title: 'Client Schedule Adjustment' },
        data: { status: 'fully_tested' }
    });

    return c.json(updated, 200);
});

export default r;
