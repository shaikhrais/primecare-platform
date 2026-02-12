import { Context, Next } from 'hono';
import { jwt, sign } from 'hono/jwt';
import { Role } from '../generated/client/edge';

export const authMiddleware = (secret: string) => {
    return jwt({ secret, alg: 'HS256' });
};

export const rbacMiddleware = (allowedRoles: Role[]) => {
    return async (c: Context, next: Next) => {
        const payload = c.get('jwtPayload');
        const userRole = payload?.role as Role;
        console.log('RBAC Check:', { payload, userRole, allowedRoles });

        if (!userRole || !allowedRoles.includes(userRole)) {
            return c.json({ error: 'Forbidden: Insufficient permissions' }, 403);
        }

        await next();
    };
};

export const generateToken = async (user: { id: string; role: Role; tenantId: string }, secret: string) => {
    const payload = {
        sub: user.id,
        role: user.role,
        tenantId: user.tenantId,
        exp: Math.floor(Date.now() / 1000) + 60 * 60 * 24, // 24 hours
    };
    return await sign(payload, secret);
};
