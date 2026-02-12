import { Context, Next } from 'hono';
import { jwt, sign } from 'hono/jwt';
import { getCookie } from 'hono/cookie';
import { Role } from '../generated/client/edge';
import { Permission, ROLE_PERMISSIONS } from './rbac/policies';

export const authMiddleware = (secret: string) => {
    return jwt({
        secret,
        alg: 'HS256',
        cookie: 'accessToken'
    });
};

export const rbacMiddleware = (allowedRoles: Role[]) => {
    return async (c: Context, next: Next) => {
        const payload = c.get('jwtPayload');
        const userRoles = payload?.roles as Role[] || [];

        const hasAccess = userRoles.some(role => allowedRoles.includes(role));

        if (!hasAccess) {
            return c.json({ error: 'Forbidden: Insufficient permissions' }, 403);
        }

        await next();
    };
};

export const requirePermission = (permission: Permission) => {
    return async (c: Context, next: Next) => {
        const payload = c.get('jwtPayload');
        const userRoles = payload?.roles as Role[] || [];

        const hasPermission = userRoles.some(role => {
            const perms = ROLE_PERMISSIONS[role] || [];
            return perms.includes(permission);
        });

        if (!hasPermission) {
            return c.json({ error: 'Forbidden: Missing Role Permission' }, 403);
        }

        await next();
    };
};

export const generateToken = async (user: { id: string; roles: Role[]; tenantId: string }, secret: string, activeRole?: Role, expiresInMinutes: number = 60) => {
    const payload = {
        sub: user.id,
        roles: user.roles,
        activeRole: activeRole || user.roles[0],
        tenantId: user.tenantId,
        exp: Math.floor(Date.now() / 1000) + (expiresInMinutes * 60),
    };
    return await sign(payload, secret);
};

export const generateRefreshToken = async (userId: string, secret: string) => {
    const payload = {
        sub: userId,
        exp: Math.floor(Date.now() / 1000) + 60 * 60 * 24 * 7, // 7 days
    };
    return await sign(payload, secret);
};
