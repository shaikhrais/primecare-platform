import { Context, Next } from 'hono';
import { Role } from '../../../generated/client/edge';
import { Permission } from '../rbac/permissions';
import { ROLE_PERMISSIONS } from '../rbac/policies';

export const requireRole = (allowedRoles: Role[]) => {
    return async (c: Context, next: Next) => {
        const payload = c.get('jwtPayload');
        const userRoles = payload?.roles as Role[] || [];

        const hasAccess = userRoles.some(role => allowedRoles.includes(role));

        if (!hasAccess) {
            return c.json({ error: 'Forbidden: Insufficient Role Permissions' }, 403);
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
            return c.json({ error: 'Forbidden: Missing Required Permission' }, 403);
        }

        await next();
    };
};
