import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const training = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /training/assigned — PSW's assigned training modules
const assignedRoute = createRoute({
    method: 'get', path: '/assigned',
    summary: 'List training modules assigned to current PSW', tags: ['Training'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), moduleTitle: z.string(), moduleCategory: z.string().nullable(),
                        status: z.string(), assignedAt: z.string(), completedAt: z.string().nullable(),
                    }))
                }
            }, description: 'Assigned training'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

training.openapi(assignedRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;
    const psw = await prisma.providerProfile.findUnique({ where: { userId } });

    const assignments = await prisma.trainingAssignment.findMany({
        where: { providerId: psw?.id }, include: { module: true }, orderBy: { assignedAt: 'desc' },
    });

    return c.json(assignments.map((a: any) => ({
        id: a.id, moduleTitle: a.module.title, moduleCategory: a.module.category,
        status: a.status, assignedAt: a.assignedAt, completedAt: a.completedAt,
    })), 200);
});

// POST /training/:id/complete — Mark a training module as completed
const completeRoute = createRoute({
    method: 'post', path: '/{id}/complete',
    summary: 'Mark training assignment as completed', tags: ['Training'],
    request: { params: z.object({ id: z.string() }) },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Completed' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

training.openapi(completeRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');

    try {
        await prisma.trainingAssignment.update({
            where: { id }, data: { status: 'completed', completedAt: new Date() },
        });
        return c.json({ success: true }, 200);
    } catch { return c.json({ error: 'Assignment not found' }, 404); }
});

export default training;
