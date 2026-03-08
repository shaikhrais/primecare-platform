import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie, getCookie, deleteCookie } from 'hono/cookie';
import { verify } from 'hono/jwt';
import { Bindings, Variables } from '../../bindings';
import { generateToken } from '../auth.service';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';
import { logAudit } from '../../_shared/utils/audit';

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
        500: {
            description: 'Server configuration error',
        },
    },
});

r.openapi(refreshRoute, async (c) => {
    const refreshToken = getCookie(c, 'refreshToken');
    if (!refreshToken) return c.json({ error: 'No refresh token' }, 401);

    // R4: Hard fail if JWT_SECRET is missing
    const jwtSecret = c.env.JWT_SECRET;
    if (!jwtSecret) return c.json({ error: 'Server configuration error' }, 500);

    const prisma = c.get('prisma');

    try {
        const payload = await verify(refreshToken, jwtSecret, 'HS256');

        // R21: Validate this is actually a refresh token — not an access token being replayed
        if (payload.type !== 'refresh') {
            return c.json({ error: 'Invalid token type' }, 401);
        }

        const user = await prisma.user.findUnique({
            where: { id: payload.sub as string },
            // R18: Only load what's needed — not passwordHash
            select: { id: true, email: true, roles: true, tenantId: true, status: true },
        });

        if (!user) return c.json({ error: 'User not found' }, 401);

        // R4: Check user status — don't refresh for disabled/suspended accounts
        if (user.status && user.status !== 'active') {
            return c.json({ error: 'Account disabled' }, 401);
        }

        const accessToken = await generateToken({
            id: user.id,
            roles: user.roles as any,
            tenantId: user.tenantId
        }, jwtSecret);

        setCookie(c, 'accessToken', accessToken, {
            httpOnly: true,
            secure: true,
            sameSite: 'None',
            maxAge: 60 * 60 * 24,
            path: '/'
        });

        // R19: Don't return token in body — HttpOnly cookie handles auth
        return c.json({ refreshed: true }, 200);
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

r.openapi(logoutRoute, async (c) => {
    // R4: Wipe all auth cookies with matching options
    deleteCookie(c, 'accessToken', { path: '/', secure: true, sameSite: 'None' });
    deleteCookie(c, 'refreshToken', { path: '/v1/auth/refresh', secure: true, sameSite: 'None' });

    // R23: Write token's jti to KV denylist so stolen tokens can't be replayed
    try {
        const payload = c.get('jwtPayload') as any;
        if (payload?.jti && payload?.exp) {
            const kv = (c.env as any)?.TOKEN_DENYLIST;
            if (kv) {
                const remainingSecs = Math.max(0, payload.exp - Math.floor(Date.now() / 1000));
                await kv.put(`deny:${payload.jti}`, '1', { expirationTtl: Math.max(60, remainingSecs) });
            }
        }

        // R4: Log the logout event for audit trail
        if (payload?.sub) {
            const prisma = c.get('prisma');
            await logAudit(prisma, payload.sub, 'logout', 'session', null, { tenantId: payload.tenantId || 'system' });
        }
    } catch { /* best effort */ }

    return c.json({ success: true }, 200);
});

// R23: Safe user schema — explicit fields only (no z.any())
const SafeUserSchema = z.object({
    id: z.string(),
    email: z.string(),
    roles: z.array(z.string()),
    tenantId: z.string(),
    status: z.string().nullable().optional(),
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
                    schema: z.object({ user: SafeUserSchema }),
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
            // R4: Hard fail if JWT_SECRET is missing
            const jwtSecret = c.env.JWT_SECRET;
            if (!jwtSecret) return c.json({ error: 'Server configuration error' }, 500);

            // R23: Cookie-only — removed Authorization header fallback (was defeating HttpOnly protection)
            const accessToken = getCookie(c, 'accessToken');
            if (accessToken) {
                try {
                    const decoded = await verify(accessToken, jwtSecret, 'HS256');
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
            select: { id: true, email: true, roles: true, tenantId: true, status: true }
        });

        if (!user) return c.json({ error: 'User not found', message: 'User does not exist in database' }, 404);

        // R4: Block suspended/disabled accounts on session check
        if (user.status && user.status !== 'active') {
            return c.json({ error: 'Account disabled' }, 401);
        }

        return c.json({ user }, 200);
    } catch (err: any) {
        // R4: Don't log full error, just message
        return c.json({ error: 'Internal Server Error' }, 500);
    }
});

export default r;
