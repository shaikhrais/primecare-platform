import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const sharedTraining = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /training/catalog — All available modules (any authenticated user)
const catalogRoute = createRoute({
    method: 'get', path: '/catalog',
    summary: 'Browse all available training modules', tags: ['Training'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), title: z.string(), description: z.string().nullable(),
                        category: z.string().nullable(), durationMinutes: z.number().nullable(),
                    }))
                }
            }, description: 'Catalog'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

sharedTraining.openapi(catalogRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const modules = await prisma.trainingModule.findMany({
        where: { tenantId }, orderBy: { createdAt: 'desc' },
    });

    return c.json(modules.map((m: any) => ({
        id: m.id, title: m.title, description: m.description,
        category: m.category, durationMinutes: m.durationMinutes,
    })), 200);
});

// GET /training/my-progress — Current user's training completions
const progressRoute = createRoute({
    method: 'get', path: '/my-progress',
    summary: 'Current user training progress', tags: ['Training'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        totalAssigned: z.number(), completed: z.number(),
                        inProgress: z.number(), completionRate: z.number(),
                        assignments: z.array(z.object({
                            moduleTitle: z.string(), status: z.string(),
                            assignedAt: z.string(), completedAt: z.string().nullable(),
                        })),
                    })
                }
            }, description: 'Progress'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

sharedTraining.openapi(progressRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;

    // Check for PSW profile
    const psw = await prisma.providerProfile.findUnique({ where: { userId } });
    const where: any = {};
    if (psw) where.providerId = psw.id;
    else where.staffId = userId; // Fallback to staffId

    const assignments = await prisma.trainingAssignment.findMany({
        where, include: { module: true },
    });

    const completed = assignments.filter((a: any) => a.status === 'completed').length;

    return c.json({
        totalAssigned: assignments.length, completed,
        inProgress: assignments.length - completed,
        completionRate: assignments.length > 0 ? Math.round((completed / assignments.length) * 100) : 0,
        assignments: assignments.map((a: any) => ({
            moduleTitle: a.module.title, status: a.status,
            assignedAt: a.assignedAt, completedAt: a.completedAt,
        })),
    }, 200);
});

export default sharedTraining;
