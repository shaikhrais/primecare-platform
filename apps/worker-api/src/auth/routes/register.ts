import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie } from 'hono/cookie';
import { Bindings, Variables } from '../../bindings';
import { RegisterSchema } from '../auth.validation';
import { generateToken, generateRefreshToken } from '../auth.service';
import { hashPassword } from '../../_shared/utils/crypto';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Register
const registerRoute = createRoute({
    ...ROUTE_METADATA.AUTH.REGISTER,
    method: 'post',
    path: '/register',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: RegisterSchema,
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
                        token: z.string(),
                    }),
                },
            },
            description: 'User registered successfully',
        },
        400: {
            description: 'User already exists or validation error',
        },
    },
});

r.openapi(registerRoute, async (c) => {
    const prisma = c.get('prisma');
    const { email, password, role, tenantName, tenantSlug } = c.req.valid('json');

    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser) return c.json({ error: 'User already exists' }, 400);

    let tenant;
    if (tenantSlug) {
        tenant = await prisma.tenant.findUnique({ where: { slug: tenantSlug } });
    }

    if (!tenant) {
        const slug = tenantSlug || 'default';
        tenant = await prisma.tenant.upsert({
            where: { slug: slug },
            update: {},
            create: {
                name: tenantName || 'Default Tenant',
                slug: slug,
                status: 'active'
            }
        });
    }

    const passwordHash = await hashPassword(password);

    const user = await prisma.user.create({
        data: {
            email,
            passwordHash,
            roles: [role] as any,
            tenantId: tenant.id
        },
    });

    if (role === 'client') {
        await prisma.clientProfile.create({
            data: {
                userId: user.id,
                fullName: email.split('@')[0],
                tenantId: tenant.id
            }
        });
    } else if (role === 'psw') {
        await prisma.pswProfile.create({
            data: {
                userId: user.id,
                fullName: email.split('@')[0],
                tenantId: tenant.id
            }
        });
    }

    const accessToken = await generateToken({ ...user, tenantId: tenant.id }, c.env.JWT_SECRET || 'fallback_secret');
    const refreshToken = await generateRefreshToken(user.id, c.env.JWT_SECRET || 'fallback_secret');

    setCookie(c, 'accessToken', accessToken, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24,
        path: '/'
    });

    setCookie(c, 'refreshToken', refreshToken, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24 * 7,
        path: '/v1/auth/refresh'
    });

    return c.json({ user, token: accessToken }, 201);
});

export default r;



