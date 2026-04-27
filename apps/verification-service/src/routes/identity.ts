import { IdentityController } from '../controllers/identity.controller';

export function registerIdentityRoutes(app: any) {
    app.get('/v1/identity/roles', (c: any) => IdentityController.listRoles(c));
    app.get('/v1/identity/screens', (c: any) => IdentityController.getAvailableScreens(c));
    app.get('/v1/identity/roles/:roleName/permissions', (c: any) => IdentityController.getPermissionsForRole(c));
    app.post('/v1/identity/update-permissions', (c: any) => IdentityController.updateRolePermissions(c));
}
