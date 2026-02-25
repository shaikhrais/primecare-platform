import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie, getCookie, deleteCookie } from 'hono/cookie';
import { verify } from 'hono/jwt';
import { Bindings, Variables } from '../bindings';
import { LoginSchema, RegisterSchema } from './auth.validation';
import { generateToken, generateRefreshToken } from './auth.service';
import { hashPassword } from '../_shared/utils/crypto';
import { requireAuth } from '../_shared/middleware/auth';
import { requireRole } from '../_shared/middleware/rbac';

const auth = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Register
const registerRoute = createRoute({
    method: 'post',
    path: '/register',
    summary: 'Register User',
    description: 'Register a new user and create a tenant if necessary.',
    tags: ['Authentication'],
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

auth.openapi(registerRoute, async (c) => {
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

// Login
const loginRoute = createRoute({
    method: 'post',
    path: '/login',
    summary: 'Login User',
    description: 'Authenticate user and set session cookies.',
    tags: ['Authentication'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: LoginSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        user: z.any(),
                        token: z.string(),
                    }),
                },
            },
            description: 'Login successful',
        },
        401: {
            description: 'Invalid credentials',
        },
    },
});

auth.openapi(loginRoute, async (c) => {
    const { email, password } = c.req.valid('json');
    const prisma = c.get('prisma');

    const user = await prisma.user.findUnique({ where: { email } });
    const passwordHash = await hashPassword(password);

    if (!user || user.passwordHash !== passwordHash) {
        return c.json({ error: 'Invalid credentials' }, 401);
    }

    const accessToken = await generateToken({
        id: user.id,
        roles: user.roles as any,
        tenantId: user.tenantId
    }, c.env.JWT_SECRET || 'fallback_secret');

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

    return c.json({ user, token: accessToken }, 200);
});

// Switch Role
const switchRoleRoute = createRoute({
    method: 'post',
    path: '/switch-role',
    summary: 'Switch User Role',
    description: 'Switch the active role for the session.',
    tags: ['Authentication'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({ targetRole: z.string() }),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        token: z.string(),
                        activeRole: z.string(),
                    }),
                },
            },
            description: 'Role switched successfully',
        },
        401: {
            description: 'Unauthorized',
        },
        403: {
            description: 'Role not assigned to user',
        },
        404: {
            description: 'User not found',
        },
    },
});

auth.openapi(switchRoleRoute, async (c) => {
    const payload = c.get('jwtPayload');
    if (!payload) return c.json({ error: 'Unauthorized' }, 401);

    const { targetRole } = c.req.valid('json');
    const prisma = c.get('prisma');

    if (!payload.roles.includes(targetRole)) {
        return c.json({ error: 'Forbidden: Role not assigned to user' }, 403);
    }

    const user = await prisma.user.findUnique({ where: { id: payload.sub } });
    if (!user) return c.json({ error: 'User not found' }, 404);

    const token = await generateToken({
        id: user.id,
        roles: user.roles as any,
        tenantId: user.tenantId
    }, c.env.JWT_SECRET || 'fallback_secret', targetRole as any);

    setCookie(c, 'accessToken', token, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24,
        path: '/'
    });

    return c.json({ token, activeRole: targetRole }, 200);
});

// Refresh
const refreshRoute = createRoute({
    method: 'post',
    path: '/refresh',
    summary: 'Refresh Token',
    description: 'Refresh the access token using the refresh token cookie.',
    tags: ['Authentication'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ token: z.string() }),
                },
            },
            description: 'Token refreshed successfully',
        },
        401: {
            description: 'No refresh token or invalid refresh token',
        },
    },
});

auth.openapi(refreshRoute, async (c) => {
    const refreshToken = getCookie(c, 'refreshToken');
    if (!refreshToken) return c.json({ error: 'No refresh token' }, 401);

    const prisma = c.get('prisma');

    try {
        const payload = await verify(refreshToken, c.env.JWT_SECRET || 'fallback_secret', 'HS256');
        const user = await prisma.user.findUnique({ where: { id: payload.sub as string } });

        if (!user) return c.json({ error: 'User not found' }, 401);

        const accessToken = await generateToken({
            id: user.id,
            roles: user.roles as any,
            tenantId: user.tenantId
        }, c.env.JWT_SECRET || 'fallback_secret');

        setCookie(c, 'accessToken', accessToken, {
            httpOnly: true,
            secure: true,
            sameSite: 'None',
            maxAge: 60 * 60 * 24,
            path: '/'
        });

        return c.json({ token: accessToken }, 200);
    } catch (e) {
        return c.json({ error: 'Invalid refresh token' }, 401);
    }
});

// Logout
const logoutRoute = createRoute({
    method: 'post',
    path: '/logout',
    summary: 'Logout',
    description: 'Clear session cookies.',
    tags: ['Authentication'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean() }),
                },
            },
            description: 'Logged out successfully',
        },
    },
});

auth.openapi(logoutRoute, (c) => {
    deleteCookie(c, 'accessToken');
    deleteCookie(c, 'refreshToken', { path: '/v1/auth/refresh' });
    return c.json({ success: true }, 200);
});

// Whoami
const whoamiRoute = createRoute({
    method: 'get',
    path: '/whoami',
    summary: 'Get Current User',
    description: 'Retrieve details of the currently authenticated user.',
    tags: ['Authentication'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ user: z.any() }),
                },
            },
            description: 'User details',
        },
        401: {
            description: 'Not authenticated or invalid session',
        },
        404: {
            description: 'User not found',
        },
    },
});

auth.openapi(whoamiRoute, async (c) => {
    const payload = c.get('jwtPayload') as any;
    let userId: string | undefined = payload?.sub;

    if (!userId) {
        const accessToken = getCookie(c, 'accessToken') || c.req.header('Authorization')?.replace('Bearer ', '');
        if (accessToken) {
            try {
                const decoded = await verify(accessToken, c.env.JWT_SECRET || 'fallback_secret', 'HS256');
                userId = decoded.sub as string;
            } catch (e) {
                return c.json({ error: 'Unauthorized', message: 'Invalid or expired session' }, 401);
            }
        }
    }

    if (!userId) {
        return c.json({ error: 'Not authenticated' }, 401);
    }

    const prisma = c.get('prisma');
    const user = await prisma.user.findUnique({
        where: { id: userId as string },
        select: { id: true, email: true, roles: true, tenantId: true }
    });

    if (!user) return c.json({ error: 'User not found' }, 404);
    return c.json({ user }, 200);
});

// Impersonate
const impersonateRoute = createRoute({
    method: 'post',
    path: '/impersonate',
    summary: 'Impersonate User',
    description: 'As an admin, impersonate another user.',
    tags: ['Authentication'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({ targetUserId: z.string() }),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        user: z.any(),
                        token: z.string(),
                    }),
                },
            },
            description: 'Successfully impersonating target user',
        },
        401: {
            description: 'Unauthorized',
        },
        403: {
            description: 'Forbidden: Admin role required',
        },
        404: {
            description: 'Target user not found',
        },
    },
});

auth.openapi(impersonateRoute, async (c) => {
    const secret = c.env.JWT_SECRET || 'fallback_secret';

    // Manual checks because we don't have middleware property in createRoute for sub-routes if it needs closure over secret
    const authMiddleware = requireAuth(secret);
    let authPassed = false;
    await authMiddleware(c, async () => { authPassed = true; });
    if (!authPassed) return;

    const roleMiddleware = requireRole(['admin']);
    let rolePassed = false;
    await roleMiddleware(c, async () => { rolePassed = true; });
    if (!rolePassed) return;

    const { targetUserId } = c.req.valid('json');
    const prisma = c.get('prisma');

    const targetUser = await prisma.user.findUnique({
        where: { id: targetUserId }
    });

    if (!targetUser) return c.json({ error: 'Target user not found' }, 404);

    const accessToken = await generateToken(targetUser, secret);
    const refreshToken = await generateRefreshToken(targetUser.id, secret);

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

    return c.json({ user: targetUser, token: accessToken }, 200);
});

export default auth;
