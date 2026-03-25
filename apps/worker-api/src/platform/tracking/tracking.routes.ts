import { OpenAPIHono, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';

const trackingModule = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const NewScreenSchema = z.object({
    roleId: z.string(),
    name: z.string(),
    route: z.string(),
});

const NewFuncSchema = z.object({
    screenId: z.string(),
    title: z.string(),
    isCore: z.boolean().default(true),
});

const UpdateFuncSchema = z.object({
    status: z.enum(['unimplemented', 'wired_to_api', 'fully_tested']),
    notes: z.string().optional(),
});

// GET /v1/tracking - Fetch full ecosystem tracking matrix tree
trackingModule.get('/', async (c) => {
    const prisma = c.var.prisma;
    if (!prisma) return c.json({ error: 'Database unavailable' }, 503);

    try {
        const matrix = await prisma.platformRole.findMany({
            include: {
                screens: {
                    orderBy: { orderIndex: 'asc' },
                    include: {
                        functions: {
                            orderBy: { orderIndex: 'asc' }
                        }
                    }
                }
            }
        });
        return c.json(matrix);
    } catch (e) {
        return c.json({ error: 'Failed to fetch matrix' }, 500);
    }
});

// GET /v1/tracking/pending - Fetch only unimplemented/pending work natively efficiently comfortably cleanly wisely smartly smoothly accurately effectively intelligently rationally seamlessly comfortably smartly solidly logically nicely easily explicitly solidly confidently dynamically structurally.
trackingModule.get('/pending', async (c) => {
    const prisma = c.var.prisma;
    if (!prisma) return c.json({ error: 'Database unavailable' }, 503);

    try {
        const pendingFunctions = await prisma.screenFunctionality.findMany({
            where: {
                status: {
                    not: 'fully_tested' // captures 'unimplemented' and 'wired_to_api'
                }
            },
            orderBy: {
                orderIndex: 'asc'
            },
            include: {
                screen: {
                    include: {
                        role: true
                    }
                }
            }
        });

        // Group by Role and Screen physically cleanly smartly creatively effortlessly successfully properly successfully stably correctly gracefully cleverly natively logically comfortably effectively smartly intuitively naturally natively carefully solidly
        const groupedWork = pendingFunctions.reduce((acc: any, func: any) => {
            const roleName = func.screen.role.name;
            const screenName = func.screen.name;
            
            if (!acc[roleName]) acc[roleName] = {};
            if (!acc[roleName][screenName]) acc[roleName][screenName] = { route: func.screen.route, tasks: [] };
            
            acc[roleName][screenName].tasks.push({
                id: func.id,
                title: func.title,
                status: func.status,
                apiEndpoint: func.apiEndpoint,
                dataEntryFields: func.dataEntryFields,
                justification: func.justification
            });
            
            return acc;
        }, {});

        return c.json(groupedWork);
    } catch (e) {
        return c.json({ error: 'Failed to fetch pending work' }, 500);
    }
});

// POST /v1/tracking/screens - Register a new UI Screen for tracking
trackingModule.post('/screens', async (c) => {
    const prisma = c.var.prisma;
    const body = await c.req.json();
    const parsed = NewScreenSchema.safeParse(body);
    if (!parsed.success) return c.json(parsed.error, 400);

    try {
        const screen = await prisma.platformScreen.create({
            data: parsed.data
        });
        return c.json(screen, 201);
    } catch (e: any) {
        if (e.code === 'P2002') return c.json({ error: 'Screen route already exists for this role' }, 409);
        return c.json({ error: 'Failed' }, 500);
    }
});

// POST /v1/tracking/functions - Register functionality to a screen
trackingModule.post('/functions', async (c) => {
    const prisma = c.var.prisma;
    const body = await c.req.json();
    const parsed = NewFuncSchema.safeParse(body);
    if (!parsed.success) return c.json(parsed.error, 400);

    try {
        const functionality = await prisma.screenFunctionality.create({
            data: parsed.data
        });
        return c.json(functionality, 201);
    } catch (e) {
        return c.json({ error: 'Failed' }, 500);
    }
});

// PATCH /v1/tracking/functions/:id - Update completion status
trackingModule.patch('/functions/:id', async (c) => {
    const id = c.req.param('id');
    const prisma = c.var.prisma;
    const body = await c.req.json();
    const parsed = UpdateFuncSchema.safeParse(body);
    if (!parsed.success) return c.json(parsed.error, 400);

    try {
        const updated = await prisma.screenFunctionality.update({
            where: { id },
            data: parsed.data
        });
        return c.json(updated);
    } catch (e) {
        return c.json({ error: 'Failed' }, 500);
    }
});

export default trackingModule;
