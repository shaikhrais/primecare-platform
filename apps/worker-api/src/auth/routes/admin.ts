import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie } from 'hono/cookie';
import { Bindings, Variables } from '../../bindings';
import { generateToken, generateRefreshToken } from '../auth.service';
import { requireAuth } from '../../_shared/middleware/auth';
import { requireRole } from '../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

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

r.openapi(impersonateRoute, async (c) => {
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

export default r;
