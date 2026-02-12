import { Context, Next } from 'hono';
import { jwt, sign } from 'hono/jwt';
import { Role } from '../generated/client/edge';

export const authMiddleware = (secret: string) => {
    return jwt({ secret, alg: 'HS256' });
};

export const rbacMiddleware = (allowedRoles: Role[]) => {
    return async (c: Context, next: Next) => {
        const payload = c.get('jwtPayload');
        const userRoles = payload?.roles as Role[] || [];
        console.log('RBAC Check:', { payload, userRoles, allowedRoles });

        const hasAccess = userRoles.some(role => allowedRoles.includes(role));

        if (!hasAccess) {
            return c.json({ error: 'Forbidden: Insufficient permissions' }, 403);
        }

        await next();
    };
};

export const generateToken = async (user: { id: string; roles: Role[]; tenantId: string }, secret: string, activeRole?: Role) => {
    const payload = {
        sub: user.id,
        roles: user.roles,
        activeRole: activeRole || user.roles[0],
        tenantId: user.tenantId,
        exp: Math.floor(Date.now() / 1000) + 60 * 60 * 24, // 24 hours
    };
    return await sign(payload, secret);
};
