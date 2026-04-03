import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie } from 'hono/cookie';
import { Bindings, Variables } from '../../bindings';
import { RegisterSchema } from '../auth.validation';
import { generateToken, generateRefreshToken, parseRoles } from '../auth.service';
import { hashPassword } from '../../_shared/utils/crypto';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// R19: Rate limit registration (5 per minute per IP)
import { authRateLimit } from '../../_shared/middleware/rate-limit';
r.use('/register', authRateLimit);

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
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(registerRoute, async (c) => {
    const { email, password, role, tenantName, tenantSlug } = c.req.valid('json');



    const prisma = c.get('prisma');

    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser) return c.json({ error: 'User already exists' }, 400);

    let tenant;
    if (tenantSlug) {
        try { tenant = await prisma.tenant.findUnique({ where: { slug: tenantSlug } }); } catch(e) { console.error("Unhandled UUID Exception", e); }
    }

    if (!tenant) {
        const slug = tenantSlug || 'default';
        tenant = await prisma.tenant.upsert({
            where: { slug: slug },
            update: {},
            create: {
                name: tenantName || 'Default Tenant',
                slug: slug,
                status: 'active',
                allowedVpnRanges: '',
                corsAllowedOrigins: '',
                corsAllowedMethods: '',
                corsAllowedHeaders: ''
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
                roles: role,
                tenantId: tenant?.id
            },
        });

        if (role === 'client') {
            await tx.clientProfile.create({
                data: {
                    userId: newUser.id,
                    fullName: email.split('@')[0],
                    tenantId: tenant?.id
                }
            });
        } else if (role === 'psw') {
            await tx.providerProfile.create({
                data: {
                    userId: newUser.id,
                    fullName: email.split('@')[0],
                    tenantId: tenant?.id,
                    languages: '',
                    serviceAreas: '',
                    skills: ''
                }
            });
        }

        return newUser;
    });

    // R4: Hard fail if JWT_SECRET is missing
    const jwtSecret = c.env.JWT_SECRET;
    if (!jwtSecret) return c.json({ error: 'Server configuration error' }, 500);

    const parsedRoles = parseRoles(user.roles);
    const accessToken = await generateToken({ ...user, roles: parsedRoles, tenantId: tenant?.id }, jwtSecret);
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
    const safeUser = { id: user.id, email: user.email, roles: parsedRoles, tenantId: user.tenantId };
    // R19: Don't return token in body — HttpOnly cookie handles auth
    return c.json({ user: safeUser }, 201);
});

export default r;



