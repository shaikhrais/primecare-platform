import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { flattenObject, detectSection } from '@primecare/infrastructure';
import { AdminRegistry } from 'prime-care-shared';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /registries — list all registry entries
r.get('/', async (c) => {
    const prisma = c.get('prisma');
    const category = c.req.query('category');
    const section = c.req.query('section');
    const search = c.req.query('q');

    try {
        const where: any = {};
        if (category) where.category = category;
        if (section) where.section = section;
        if (search) where.key = { contains: search, mode: 'insensitive' };

        const registries = await prisma.registry.findMany({
            where,
            orderBy: [{ category: 'asc' }, { section: 'asc' }, { key: 'asc' }],
        });

        // Group by category for UI
        const grouped: Record<string, any[]> = {};
        for (const reg of registries) {
            if (!grouped[reg.category]) grouped[reg.category] = [];
            grouped[reg.category]!.push(reg);
        }

        return c.json({ total: registries.length, grouped, items: registries });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
        // R11: Don't leak error.message
        return c.json({ error: 'Failed to fetch registries', items: [], total: 0 });
    }
});

// GET /registries/:id — get single entry
r.get('/:id', async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.param();
    try {
        const reg = await prisma.registry.findUnique({ where: { id } });
        if (!reg) return c.json({ error: 'Not found' }, 404);
        return c.json(reg);
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
        return c.json({ error: 'Failed to fetch registry entry' }, 500);
    }
});

// PUT /registries/:id — update entry
// R11: Added Zod validation schema
const updateRegistrySchema = z.object({
    value: z.string().optional(),
    metadata: z.any().optional(),
    section: z.string().optional(),
    category: z.string().optional(),
});

r.put('/:id', async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.param();
    // R11: Parse and validate body
    const raw = await c.req.json() as any /* Audit 32 SECURED */;
    const parsed = updateRegistrySchema.safeParse(raw);
    if (!parsed.success) return c.json({ error: 'Invalid input' }, 400);
    const body = parsed.data;

    try {
        const reg = await prisma.registry.update({
            where: { id },
            data: {
                ...(body.value !== undefined && { value: body.value }),
                ...(body.metadata !== undefined && { metadata: body.metadata }),
                ...(body.section !== undefined && { section: body.section }),
                ...(body.category !== undefined && { category: body.category }),
            },
        });
        return c.json(reg);
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
        return c.json({ error: 'Failed to update registry' }, 500);
    }
});

// POST /registries — create new entry
const createRegistrySchema = z.object({
    key: z.string().min(1),
    value: z.string().min(1),
    category: z.string().default('content'),
    section: z.string().optional(),
    metadata: z.any().optional(),
    tenantId: z.string().nullable().optional(),
});

r.post('/', async (c) => {
    const prisma = c.get('prisma');
    const raw = await c.req.json() as any /* Audit 32 SECURED */;
    const parsed = createRegistrySchema.safeParse(raw);
    if (!parsed.success) return c.json({ error: 'Invalid input', details: parsed.error.flatten() }, 400);
    const body = parsed.data;

    try {
        const reg = await prisma.registry.create({
            data: {
                key: body.key,
                value: body.value,
                category: body.category || 'content',
                section: body.section || detectSection(body.key),
                metadata: body.metadata || null,
                tenantId: body.tenantId || null,
            },
        });
        return c.json(reg, 201);
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
        return c.json({ error: 'Failed to create registry entry' }, 500);
    }
});

// DELETE /registries/:id
r.delete('/:id', async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.param();
    try {
        await prisma.registry.delete({ where: { id } });
        return c.json({ success: true });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
        return c.json({ error: 'Failed to delete registry entry' }, 500);
    }
});

// POST /registries/seed — populate DB from ContentRegistry
r.post('/seed', async (c) => {
    const prisma = c.get('prisma');
    const { ContentRegistry } = AdminRegistry;

    const entries = flattenObject(ContentRegistry as any);
    let created = 0, skipped = 0, errors = 0;

    for (const entry of entries) {
        const section = detectSection(entry.key);
        try {
            await prisma.registry.upsert({
                where: { key_tenantId: { key: entry.key, tenantId: null as any } },
                update: { value: entry.value, section, category: 'content' },
                create: { key: entry.key, value: entry.value, category: 'content', section },
            });
            created++;
        } catch (e: any /* Audit 63 Notice: Should be unknown */) {
            try {
                const existing = await prisma.registry.findFirst({
                    where: { key: entry.key, tenantId: null }
                });
                if (existing) {
                    await prisma.registry.update({
                        where: { id: existing.id },
                        data: { value: entry.value, section, category: 'content' }
                    });
                    created++;
                } else {
                    await prisma.registry.create({
                        data: { key: entry.key, value: entry.value, category: 'content', section }
                    });
                    created++;
                }
            } catch {
                errors++;
            }
        }
    }

    return c.json({
        success: true, total: entries.length, created, skipped, errors,
        sampleKeys: entries.slice(0, 10).map(e => e.key),
    });
});

export default r;
