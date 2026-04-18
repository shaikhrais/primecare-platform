import { IdentityService, PermissionUpdate } from '@primecare/domain/src/services/IdentityService';

export function registerIdentityRoutes(app: any) {
    /**
     * GET /v1/identity/roles
     * Lists all platform roles
     */
    app.get('/v1/identity/roles', async (c: any) => {
        try {
            const roles = await IdentityService.listRoles();
            return c.json({ success: true, data: roles });
        } catch (error: any) {
            console.error('List Roles Error:', error);
            return c.json({ success: false, error: 'Internal Server Error' }, 500);
        }
    });

    /**
     * GET /v1/identity/screens
     * Lists unique screen routes from the platform registry
     */
    app.get('/v1/identity/screens', async (c: any) => {
        try {
            const screens = await IdentityService.getAvailableScreens();
            return c.json({ success: true, data: screens });
        } catch (error: any) {
            console.error('List Screens Error:', error);
            return c.json({ success: false, error: 'Internal Server Error' }, 500);
        }
    });

    /**
     * GET /v1/identity/roles/:roleId/permissions
     * Fetches current permissions for a role
     */
    app.get('/v1/identity/roles/:roleId/permissions', async (c: any) => {
        try {
            const roleId = c.req.param('roleId');
            if (!roleId) return c.json({ success: false, error: 'roleId is required' }, 400);

            const permissions = await IdentityService.getRolePermissions(roleId);
            return c.json({ success: true, data: permissions });
        } catch (error: any) {
            console.error('Get Permissions Error:', error);
            return c.json({ success: false, error: 'Internal Server Error' }, 500);
        }
    });

    /**
     * POST /v1/identity/roles/:roleId/permissions
     * Updates permissions for a role
     */
    app.post('/v1/identity/roles/:roleId/permissions', async (c: any) => {
        try {
            const roleId = c.req.param('roleId');
            if (!roleId) return c.json({ success: false, error: 'roleId is required' }, 400);

            const body = await c.req.json();
            const permissions: PermissionUpdate[] = body.permissions;

            if (!Array.isArray(permissions)) {
                return c.json({ success: false, error: 'permissions must be an array' }, 400);
            }

            const result = await IdentityService.updateRolePermissions(roleId, permissions);
            return c.json({ success: true, ...result });
        } catch (error: any) {
            console.error('Update Permissions Error:', error);
            return c.json({ success: false, error: 'Internal Server Error' }, 500);
        }
    });
}
