import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie, getCookie, deleteCookie } from 'hono/cookie';
import { verify } from 'hono/jwt';
import { Bindings, Variables } from '../../bindings';
import { generateToken } from '../auth.service';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

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

r.openapi(refreshRoute, async (c) => {
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

r.openapi(logoutRoute, (c) => {
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

r.openapi(whoamiRoute, async (c) => {
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

export default r;
