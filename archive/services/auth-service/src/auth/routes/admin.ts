import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie } from 'hono/cookie';
import { Bindings, Variables } from '@primecare/contracts';
import { generateToken, generateRefreshToken, parseRoles } from '../auth.service';
import { requireAuth } from '@primecare/security';
import { requireRole } from '@primecare/security';
import { ROUTE_METADATA } from '@primecare/infrastructure';
import { logAudit } from '@primecare/infrastructure';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Impersonate
const impersonateRoute = createRoute({
    ...ROUTE_METADATA.AUTH.IMPERSONATE,
    method: 'post',
    path: '/impersonate',
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
        401: { description: 'Unauthorized' },
        403: { description: 'Forbidden: Super Admin role required' },
        404: {
            content: { 'application/json': { schema: z.object({ error: z.string() }) } },
            description: 'Target user not found',
        },
        500: {
            content: { 'application/json': { schema: z.object({ error: z.string() }) } },
            description: 'Server error',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(impersonateRoute, async (c) => {
    // R6: Hard fail if JWT_SECRET is missing
    const secret = c.env.JWT_SECRET;
    if (!secret) return c.json({ error: 'Server configuration error' }, 500);

    // Manual auth + role checks
    const authMiddleware = requireAuth(secret);
    let authPassed = false;
    await authMiddleware(c, async () => { authPassed = true; });
    if (!authPassed) return c.json({ error: 'Unauthorized' }, 401);

    // R6: Require super_admin — regular admins should NOT impersonate
    const roleMiddleware = requireRole(['super_admin']);
    let rolePassed = false;
    await roleMiddleware(c, async () => { rolePassed = true; });
    if (!rolePassed) return c.json({ error: 'Forbidden: Super Admin role required' }, 403);

    const { targetUserId } = c.req.valid('json');
    const prisma = c.get('prisma');
    const payload = c.get('jwtPayload') as any;

    const targetUser = await prisma.user.findUnique({
        where: { id: targetUserId },
        // R18: Only need roles/email/tenantId for impersonation — not passwordHash
        select: { id: true, email: true, roles: true, tenantId: true, status: true },
    });

    if (!targetUser) return c.json({ error: 'Target user not found' }, 404);

    const parsedRoles = parseRoles(targetUser.roles);

    // R6: Prevent impersonating other super_admins
    if (parsedRoles.includes('super_admin')) {
        return c.json({ error: 'Cannot impersonate another Super Admin' }, 403);
    }

    // R6: Audit log — impersonation is a sensitive action
    await logAudit(prisma, payload?.sub, 'impersonate', 'user', targetUserId, {
        tenantId: payload?.tenantId || 'system',
        impersonatedEmail: targetUser.email,
    });

    const accessToken = await generateToken({
        id: targetUser.id,
        roles: parsedRoles,
        tenantId: targetUser.tenantId,
    }, secret);
    const refreshToken = await generateRefreshToken(targetUser.id, secret);

    setCookie(c, 'accessToken', accessToken, {
        httpOnly: true, secure: true, sameSite: 'None',
        maxAge: 60 * 60 * 24, path: '/'
    });

    setCookie(c, 'refreshToken', refreshToken, {
        httpOnly: true, secure: true, sameSite: 'None',
        maxAge: 60 * 60 * 24 * 7, path: '/v1/auth/refresh'
    });

    // R6: Return safe user object — no passwordHash
    const safeUser = {
        id: targetUser.id,
        email: targetUser.email,
        roles: parsedRoles,
        tenantId: targetUser.tenantId,
    };

    // R19: Don't return token in body — HttpOnly cookie handles auth
    return c.json({ user: safeUser }, 200);
});

export default r;
