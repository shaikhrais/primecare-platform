import { Context, Next } from 'hono';
import { Role } from '../../../generated/client/edge';
import { Permission } from '../rbac/permissions';
import { ROLE_PERMISSIONS } from '../rbac/policies';

export const requireRole = (allowedRoles: Role[]) => {
    return async (c: Context, next: Next) => {
        const payload = c.get('jwtPayload') as { sub: string; roles: string[]; activeRole?: string } | undefined;
        const userRoles = payload?.roles as Role[] || [];

        const SERVICE_PROVIDERS = ['psw', 'rn', 'rmt', 'rpt', 'rch'];

        const hasAccess = userRoles.some(role => {
            const lowerRole = role.toLowerCase();
            if (allowedRoles.includes(role)) return true;

            // 1. Manager Umbrella: if 'manager' is an allowed role, 
            // any role string containing 'manager' is permitted.
            const isManagerAllowed = allowedRoles.includes('manager' as Role);
            if (isManagerAllowed && lowerRole.includes('manager')) return true;

            // 2. Service Provider Umbrella: if 'service_provider' is allowed,
            // any of the specific caregiver roles are permitted.
            const isSPAllowed = allowedRoles.includes('service_provider' as any);
            if (isSPAllowed && SERVICE_PROVIDERS.includes(lowerRole)) return true;

            return false;
        });

        if (!hasAccess) {
            return c.json({ error: 'Forbidden: Insufficient Role Permissions' }, 403);
        }

        await next();
    };
};

export const requirePermission = (permission: Permission) => {
    return async (c: Context, next: Next) => {
        const payload = c.get('jwtPayload') as { sub: string; roles: string[]; activeRole?: string } | undefined;
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

