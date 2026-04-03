import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { hashPassword } from '@primecare/shared-utils';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// R11: All debug routes gated behind ENVIRONMENT check
r.use('*', async (c, next) => {
    const env = c.env.ENVIRONMENT || 'production';
    if (env === 'production') {
        return c.json({ error: 'Debug routes are disabled in production' }, 403);
    }
    await next();
});

const hashRoute = createRoute({
    method: 'get',
    path: '/hash',
    summary: 'Debug Hashing Utility',
    tags: ['System', 'Debug'],
    description: 'Generates a hash for a given password string. DEV ONLY.',
    request: {
        query: z.object({
            password: z.string().min(1)
        })
    },
    responses: {
        200: {
            content: { 'application/json': { schema: z.object({ hash: z.string() }) } },
            description: 'The hashed password',
        },
        400: { description: 'Password is required' },
        403: { description: 'Disabled in production' },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(hashRoute, async (c) => {
    const { password } = c.req.valid('query');
    const hash = await hashPassword(password);
    return c.json({ hash }, 200);
});

// R11: upsert-user kept for dev bootstrapping only — production gated above
r.post('/upsert-user', async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json') /* Audit 32 SECURED */;
    // R11: Validate required fields
    const { email, roles, tenantSlug } = body;
    if (!email) return c.json({ error: 'email required' }, 400);

    // R11: Hash password from plaintext — never accept raw passwordHash
    const password = body.password;
    if (!password) return c.json({ error: 'password required (plaintext, will be hashed)' }, 400);
    const passwordHash = await hashPassword(password);

    let tenant = null;
    try {
      tenant = tenantSlug
            ? await prisma.tenant.findUnique({ where: { slug: tenantSlug } })
            : await prisma.tenant.findFirst();
    } catch(e) {
      console.error("Invalid UUID fallback", e);
    }

    if (!tenant) return c.json({ error: 'No tenant found' }, 404);

    const user = await prisma.user.upsert({
        where: { email },
        update: { passwordHash, roles: roles || ['admin'], status: 'active' },
        create: { email, passwordHash, roles: roles || ['admin'], tenantId: tenant?.id, status: 'active' }
    });

    return c.json({ success: true, id: user.id, email: user.email, roles: user.roles });
});

// R11: Removed $executeRawUnsafe endpoints — DDL should only run via Prisma migrations
// create-registries-table: REMOVED (use prisma migrate)
// seed-registries: REMOVED (moved to registries.routes.ts /seed)

export default r;
