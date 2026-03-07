import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie, getCookie, deleteCookie } from 'hono/cookie';
import { verify } from 'hono/jwt';
import { Bindings, Variables } from '../../bindings';
import { generateToken } from '../auth.service';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Refresh
const refreshRoute = createRoute({
    ...ROUTE_METADATA.AUTH.REFRESH,
    method: 'post',
    path: '/refresh',
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
    ...ROUTE_METADATA.AUTH.LOGOUT,
    method: 'post',
    path: '/logout',
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
    ...ROUTE_METADATA.AUTH.WHOAMI,
    method: 'get',
    path: '/whoami',
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
    try {
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
            return c.json({ error: 'Not authenticated', message: 'No session found' }, 401);
        }

        const prisma = c.get('prisma');
        const user = await prisma.user.findUnique({
            where: { id: userId as string },
            select: { id: true, email: true, roles: true, tenantId: true }
        });

        if (!user) return c.json({ error: 'User not found', message: 'User does not exist in database' }, 404);
        return c.json({ user }, 200);
    } catch (err: any) {
        console.error('Whoami Error:', err);
        return c.json({ error: 'Internal Server Error', message: err.message }, 500);
    }
});

export default r;



