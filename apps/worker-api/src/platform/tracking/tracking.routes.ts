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
                    include: {
                        functions: true
                    }
                }
            }
        });
        return c.json(matrix);
    } catch (e) {
        return c.json({ error: 'Failed to fetch matrix' }, 500);
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
