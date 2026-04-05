import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie } from 'hono/cookie';
import { Bindings, Variables } from '@primecare/shared-types';
import { BusinessOnboardSchema } from '../auth.validation';
import { generateToken, generateRefreshToken, parseRoles } from '../auth.service';
import { hashPassword } from '@primecare/shared-utils';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// R19: Rate limit onboarding (5 per minute per IP)
import { authRateLimit } from '@primecare/shared-utils';
r.use('/onboard-business', authRateLimit);

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
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(onboardRoute, async (c) => {
    const prisma = c.get('prisma');
    const { email, password, tenantName, tenantSlug } = c.req.valid('json');

    // 1. Check if user or tenant already exists
    let existingUser = null;
    let existingTenant = null;
    try {
      const results = await Promise.all([
          prisma.user.findUnique({ where: { email } }),
          prisma.tenant.findUnique({ where: { slug: tenantSlug } })
      ]);
      existingUser = results[0];
      existingTenant = results[1];
    } catch(e) {
      console.error("Invalid UUID fallback", e);
    }

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
            roles: 'admin',
            tenantId: tenant?.id
        },
    });

    // 4. Generate Auth
    // R4: Hard fail if JWT_SECRET is missing
    const jwtSecret = c.env.JWT_SECRET;
    if (!jwtSecret) return c.json({ error: 'Server configuration error' }, 500);

    const parsedRoles = parseRoles(user.roles);

    const accessToken = await generateToken({ ...user, roles: parsedRoles, tenantId: tenant?.id }, jwtSecret);
    const refreshToken = await generateRefreshToken(user.id, jwtSecret);

    setCookie(c, 'accessToken', accessToken, {
        httpOnly: true, secure: true, sameSite: 'None', maxAge: 60 * 60 * 24, path: '/'
    });

    setCookie(c, 'refreshToken', refreshToken, {
        httpOnly: true, secure: true, sameSite: 'None', maxAge: 60 * 60 * 24 * 7, path: '/v1/auth/refresh'
    });

    // R4: Return safe objects (no passwordHash)
    const safeUser = { id: user.id, email: user.email, roles: parsedRoles, tenantId: user.tenantId };
    // R19: Don't return token in body — HttpOnly cookie handles auth
    return c.json({ user: safeUser, tenant }, 201);
});

export default r;
