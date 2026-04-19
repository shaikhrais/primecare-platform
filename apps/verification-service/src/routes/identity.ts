import { IdentityService } from '@primecare/domain/src/services/IdentityService';

export function registerIdentityRoutes(app: any) {
    /**
     * GET /v1/identity/roles
     * Lists all platform roles.
     */
    app.get('/v1/identity/roles', async (c: any) => {
        const result = await IdentityService.listRoles();

        return result.fold(
            (data) => c.json(data),
            (error) => c.json({ error }, 500)
        );
    });

    /**
     * GET /v1/identity/screens
     * Lists unique screen routes from the platform registry.
     */
    app.get('/v1/identity/screens', async (c: any) => {
        const result = await IdentityService.getAvailableScreens();

        return result.fold(
            (data) => c.json(data),
            (error) => c.json({ error }, 500)
        );
    });

    /**
     * GET /v1/identity/roles/:roleName/permissions
     * Retrieves permissions for a specific role.
     */
    app.get('/v1/identity/roles/:roleName/permissions', async (c: any) => {
        const roleName = c.req.param('roleName');
        const result = await IdentityService.getPermissionsForRole(roleName);

        return result.fold(
            (data) => c.json(data),
            (error) => c.json({ error }, 400)
        );
    });

    /**
     * POST /v1/identity/update-permissions
     * Updates permissions for a role.
     */
    app.post('/v1/identity/update-permissions', async (c: any) => {
        const tenantId = c.req.header('x-tenant-id') || 'tenant-hq';
        
        try {
            const body = await c.req.json();
            const result = await IdentityService.updateRolePermissions({
                ...body,
                tenantId,
                actorUserId: (c.get('user') as any)?.id || 'SYSTEM'
            });

            return result.fold(
                (data) => c.json(data),
                (error) => c.json({ error }, 400)
            );
        } catch (e: any) {
            return c.json({ error: 'Invalid request body' }, 400);
        }
    });
}
