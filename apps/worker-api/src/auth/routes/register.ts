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

    // R5: Wrap user + profile creation in $transaction — prevents orphaned records
    const user = await prisma.$transaction(async (tx: any) => {
        const newUser = await tx.user.create({
            data: {
                email,
                passwordHash,
                roles: [role] as any,
                tenantId: tenant.id
            },
        });

        if (role === 'client') {
            await tx.clientProfile.create({
                data: {
                    userId: newUser.id,
                    fullName: email.split('@')[0],
                    tenantId: tenant.id
                }
            });
        } else if (role === 'psw') {
            await tx.pswProfile.create({
                data: {
                    userId: newUser.id,
                    fullName: email.split('@')[0],
                    tenantId: tenant.id
                }
            });
        }

        return newUser;
    });

    // R4: Hard fail if JWT_SECRET is missing
    const jwtSecret = c.env.JWT_SECRET;
    if (!jwtSecret) return c.json({ error: 'Server configuration error' }, 500);

    const accessToken = await generateToken({ ...user, tenantId: tenant.id }, jwtSecret);
    const refreshToken = await generateRefreshToken(user.id, jwtSecret);

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

    // R4: Return safe user object (no passwordHash)
    const safeUser = { id: user.id, email: user.email, roles: user.roles, tenantId: user.tenantId };
    return c.json({ user: safeUser, token: accessToken }, 201);
});

export default r;



