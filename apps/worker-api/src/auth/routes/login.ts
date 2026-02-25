import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie } from 'hono/cookie';
import { Bindings, Variables } from '../../bindings';
import { LoginSchema } from '../auth.validation';
import { generateToken, generateRefreshToken } from '../auth.service';
import { hashPassword } from '../../_shared/utils/crypto';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

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
            content: {
                'application/json': {
                    schema: z.object({ error: z.string() }),
                },
            },
            description: 'Unauthorized',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.object({ error: z.string() }),
                },
            },
            description: 'Internal server error',
        },
    },
});

r.openapi(loginRoute, async (c) => {
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

r.openapi(switchRoleRoute, async (c) => {
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

export default r;



