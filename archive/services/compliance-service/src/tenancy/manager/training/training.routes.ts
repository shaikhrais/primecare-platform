import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const trainingAdmin = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// POST /training/assign — Manager assigns training to a PSW
const assignRoute = createRoute({
    method: 'post', path: '/assign',
    summary: 'Assign training module to a PSW or staff', tags: ['Training Admin'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        moduleId: z.string(), providerId: z.string().optional(), staffId: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ id: z.string() }) } }, description: 'Assigned' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

trainingAdmin.openapi(assignRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');

    const assignment = await prisma.trainingAssignment.create({
        data: { moduleId: body.moduleId, providerId: body.providerId, staffId: body.staffId, status: 'assigned' },
    });

    return c.json({ id: assignment.id }, 200);
});

// GET /training/compliance — Training completion rates
const complianceRoute = createRoute({
    method: 'get', path: '/compliance',
    summary: 'Training compliance / completion rates', tags: ['Training Admin'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        totalAssignments: z.number(), completedCount: z.number(),
                        completionRate: z.number(), overdueCount: z.number(),
                    })
                }
            }, description: 'Compliance stats'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

trainingAdmin.openapi(complianceRoute, async (c) => {
    const prisma = c.get('prisma');

    const [total, completed] = await Promise.all([
        prisma.trainingAssignment.count(),
        prisma.trainingAssignment.count({ where: { status: 'completed' } }),
    ]);

    return c.json({
        totalAssignments: total, completedCount: completed,
        completionRate: total > 0 ? Math.round((completed / total) * 100) : 0,
        overdueCount: total - completed,
    }, 200);
});

// GET /training/modules — List all training modules
const modulesRoute = createRoute({
    method: 'get', path: '/modules',
    summary: 'List all training modules', tags: ['Training Admin'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), title: z.string(), description: z.string().nullable(),
                        category: z.string().nullable(), videoUrl: z.string().nullable(),
                    }))
                }
            }, description: 'Modules'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

trainingAdmin.openapi(modulesRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const modules = await prisma.trainingModule.findMany({
        where: { tenantId }, orderBy: { createdAt: 'desc' },
    });

    return c.json(modules.map((m: any) => ({
        id: m.id, title: m.title, description: m.description,
        category: m.category, videoUrl: m.videoUrl,
    })), 200);
});

export default trainingAdmin;
