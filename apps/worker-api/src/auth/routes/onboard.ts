import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie } from 'hono/cookie';
import { Bindings, Variables } from '../../bindings';
import { BusinessOnboardSchema } from '../auth.validation';
import { generateToken, generateRefreshToken } from '../auth.service';
import { hashPassword } from '../../_shared/utils/crypto';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// POST /v1/auth/onboard-business
const onboardRoute = createRoute({
    method: 'post',
    path: '/onboard-business',
    summary: 'Onboard a new business (Tenant)',
    description: 'Creates a new Tenant and the initial admin user.',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: BusinessOnboardSchema,
                },
            },
        },
    },
    responses: {
        201: {
            content: {
                'application/json': {
                    schema: z.object({
                        user: z.any(),
                        tenant: z.any(),
                        token: z.string(),
                    }),
                },
            },
            description: 'Business onboarded successfully',
        },
        400: {
            description: 'Email or Slug already in use',
        },
    },
});

r.openapi(onboardRoute, async (c) => {
    const prisma = c.get('prisma');
    const { email, password, tenantName, tenantSlug } = c.req.valid('json');

    // 1. Check if user or tenant already exists
    const [existingUser, existingTenant] = await Promise.all([
        prisma.user.findUnique({ where: { email } }),
        prisma.tenant.findUnique({ where: { slug: tenantSlug } })
    ]);

    if (existingUser) return c.json({ error: 'Email already registered' }, 400);
    if (existingTenant) return c.json({ error: 'Tenant slug already in use' }, 400);

    // 2. Create Tenant
    const tenant = await prisma.tenant.create({
        data: {
            name: tenantName,
            slug: tenantSlug,
            status: 'active'
        }
    });

    // 3. Create Admin User
    const passwordHash = await hashPassword(password);
    const user = await prisma.user.create({
        data: {
            email,
            passwordHash,
            roles: ['admin'] as any,
            tenantId: tenant.id
        },
    });

    // 4. Generate Auth
    // R4: Hard fail if JWT_SECRET is missing
    const jwtSecret = c.env.JWT_SECRET;
    if (!jwtSecret) return c.json({ error: 'Server configuration error' }, 500);

    const accessToken = await generateToken({ ...user, tenantId: tenant.id }, jwtSecret);
    const refreshToken = await generateRefreshToken(user.id, jwtSecret);

    setCookie(c, 'accessToken', accessToken, {
        httpOnly: true, secure: true, sameSite: 'None', maxAge: 60 * 60 * 24, path: '/'
    });

    setCookie(c, 'refreshToken', refreshToken, {
        httpOnly: true, secure: true, sameSite: 'None', maxAge: 60 * 60 * 24 * 7, path: '/v1/auth/refresh'
    });

    // R4: Return safe objects (no passwordHash)
    const safeUser = { id: user.id, email: user.email, roles: user.roles, tenantId: user.tenantId };
    return c.json({ user: safeUser, tenant, token: accessToken }, 201);
});

export default r;
