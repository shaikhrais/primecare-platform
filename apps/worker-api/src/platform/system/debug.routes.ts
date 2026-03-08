import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { hashPassword } from '../../_shared/utils/crypto';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const hashRoute = createRoute({
    method: 'get',
    path: '/hash',
    summary: 'Debug Hashing Utility',
    description: 'Generates a hash for a given password string. FOR DEBUGGING ONLY.',
    request: {
        query: z.object({
            password: z.string().min(1)
        })
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        hash: z.string()
                    }),
                },
            },
            description: 'The hashed password',
        },
        400: {
            description: 'Password is required'
        }
    },
});

r.openapi(hashRoute, async (c) => {
    const { password } = c.req.valid('query');
    const hash = await hashPassword(password);
    return c.json({ hash }, 200);
});

// Debug: upsert user (for production bootstrapping)
r.post('/upsert-user', async (c) => {
    const prisma = c.get('prisma');
    const { email, passwordHash, roles, tenantSlug } = await c.req.json();
    if (!email || !passwordHash) return c.json({ error: 'email and passwordHash required' }, 400);

    const tenant = tenantSlug
        ? await prisma.tenant.findUnique({ where: { slug: tenantSlug } })
        : await prisma.tenant.findFirst();

    if (!tenant) return c.json({ error: 'No tenant found' }, 404);

    const user = await prisma.user.upsert({
        where: { email },
        update: { passwordHash, roles: roles || ['admin'], status: 'active' },
        create: { email, passwordHash, roles: roles || ['admin'], tenantId: tenant.id, status: 'active' }
    });

    return c.json({ success: true, id: user.id, email: user.email, roles: user.roles });
});

// Debug: create registries table via raw SQL
r.post('/create-registries-table', async (c) => {
    const prisma = c.get('prisma');
    try {
        await prisma.$executeRawUnsafe(`
            CREATE TABLE IF NOT EXISTS registries (
                id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
                key TEXT NOT NULL,
                value TEXT NOT NULL,
                category TEXT NOT NULL DEFAULT 'content',
                section TEXT,
                metadata JSONB,
                tenant_id TEXT REFERENCES tenants(id),
                created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
                updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
                UNIQUE(key, tenant_id)
            )
        `);
        await prisma.$executeRawUnsafe(`CREATE INDEX IF NOT EXISTS idx_registries_category ON registries(category)`);
        await prisma.$executeRawUnsafe(`CREATE INDEX IF NOT EXISTS idx_registries_section ON registries(section)`);
        await prisma.$executeRawUnsafe(`CREATE INDEX IF NOT EXISTS idx_registries_tenant ON registries(tenant_id)`);
        return c.json({ success: true, message: 'registries table created' });
    } catch (e: any) {
        return c.json({ error: e.message }, 500);
    }
});

// Debug: seed registries from ContentRegistry (no auth required)
r.post('/seed-registries', async (c) => {
    const prisma = c.get('prisma');
    const { AdminRegistry } = await import('prime-care-shared');
    const { flattenObject, detectSection } = await import('../../_shared/utils/registry-seeder');
    const { ContentRegistry } = AdminRegistry;

    const entries = flattenObject(ContentRegistry as any);
    let created = 0, errors = 0;

    for (const entry of entries) {
        const section = detectSection(entry.key);
        try {
            const existing = await prisma.registry.findFirst({
                where: { key: entry.key, tenantId: null }
            });
            if (existing) {
                await prisma.registry.update({
                    where: { id: existing.id },
                    data: { value: entry.value, section, category: 'content' }
                });
            } else {
                await prisma.registry.create({
                    data: { key: entry.key, value: entry.value, category: 'content', section }
                });
            }
            created++;
        } catch (e: any) {
            errors++;
        }
    }

    return c.json({ success: true, total: entries.length, created, errors, sampleKeys: entries.slice(0, 5).map(e => e.key) });
});

export default r;
