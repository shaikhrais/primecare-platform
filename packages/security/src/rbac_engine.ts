/**
 * RBAC Middleware — Permission and Role guards for API endpoints
 *
 * Uses the centralized PermissionRegistry from the shared package.
 *
 * Usage:
 *   app.get('/users', requirePermission('view_users'), handler)
 *   app.post('/users', requirePermission('create_users'), handler)
 *   app.delete('/users/:id', requireRole(['admin', 'super_admin']), handler)
 */
import { Context, Next } from 'hono';
import { Permission, can, canAny } from '@primecare/domain';

// ── requireRole (Upgraded) ───────────────────────────────────────────────────
export const requireRole = (allowedRoles: string[]) => {
    return async (c: Context, next: Next) => {
        const payload = c.get('jwtPayload') as { sub: string; roles: string[]; activeRole?: string } | undefined;
        const userRoles = Array.isArray(payload?.roles) ? payload.roles : (payload?.roles ? [payload.roles as unknown as string] : []);

        const SERVICE_PROVIDERS = ['psw', 'rn', 'rmt', 'rpt', 'rch'];
        const STAFF_SUBROLES = ['staff', 'finance', 'hr', 'compliance', 'finance_manager', 'hr_manager'];
        const MANAGER_SUBROLES = ['manager', 'marketing_manager', 'operations_manager', 'clinical_manager', 'regional_manager', 'recruiting_manager', 'coordinator', 'crm', 'training'];

        const hasAccess = userRoles.some(role => {
            const lowerRole = role.toLowerCase();

            // super_admin and scrum_master always bypass
            if (lowerRole === 'super_admin' || lowerRole === 'scrum_master') return true;

            if (allowedRoles.includes(role)) return true;

            // Umbrella matching
            if (allowedRoles.includes('manager') && MANAGER_SUBROLES.includes(lowerRole)) return true;
            if (allowedRoles.includes('service_provider' as any) && SERVICE_PROVIDERS.includes(lowerRole)) return true;
            if (allowedRoles.includes('staff') && STAFF_SUBROLES.includes(lowerRole)) return true;

            return false;
        });

        if (!hasAccess) {
            return c.json({ error: 'Forbidden: Insufficient Role Permissions' }, 403);
        }

        await next();
    };
};

// ── requirePermission (New — from shared PermissionRegistry) ─────────────────
export const requirePermission = (permission: Permission) => {
    return async (c: Context, next: Next) => {
        const payload = c.get('jwtPayload') as { sub: string; roles: string[]; activeRole?: string } | undefined;

        if (!payload) {
            return c.json({ error: 'Unauthorized: Authentication required' }, 401);
        }

        const userRoles = Array.isArray(payload?.roles) ? payload.roles : (payload?.roles ? [payload.roles as unknown as string] : []);

        // super_admin and scrum_master always bypass
        if (userRoles.some(r => r === 'super_admin' || r === 'scrum_master')) {
            return await next();
        }

        const hasPermission = userRoles.some(role => can(role, permission));

        if (!hasPermission) {
            return c.json({
                error: 'Forbidden: Missing Required Permission',
                required: permission
            }, 403);
        }

        await next();
    };
};

// ── requireAnyPermission ─────────────────────────────────────────────────────
export const requireAnyPermission = (permissions: Permission[]) => {
    return async (c: Context, next: Next) => {
        const payload = c.get('jwtPayload') as { sub: string; roles: string[]; activeRole?: string } | undefined;

        if (!payload) {
            return c.json({ error: 'Unauthorized: Authentication required' }, 401);
        }

        const userRoles = Array.isArray(payload?.roles) ? payload.roles : (payload?.roles ? [payload.roles as unknown as string] : []);

        if (userRoles.some(r => r === 'super_admin' || r === 'scrum_master')) {
            return await next();
        }

        const hasAny = userRoles.some(role => canAny(role, permissions));

        if (!hasAny) {
            return c.json({
                error: 'Forbidden: Missing Required Permissions',
                required: permissions,
            }, 403);
        }

        await next();
    };
};


