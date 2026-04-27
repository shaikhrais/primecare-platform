import { IdentityService } from '@primecare/domain/src/services/IdentityService';

export class IdentityController {
  static async listRoles(c: any) {
    const result = await IdentityService.listRoles(c.get('prisma'));
    return result.fold(
      (data) => c.json(data),
      (error) => c.json({ error }, 500)
    );
  }

  static async getAvailableScreens(c: any) {
    const result = await IdentityService.getAvailableScreens(c.get('prisma'));
    return result.fold(
      (data) => c.json(data),
      (error) => c.json({ error }, 500)
    );
  }

  static async getPermissionsForRole(c: any) {
    const roleName = c.req.param('roleName');
    const result = await IdentityService.getPermissionsForRole(c.get('prisma'), roleName);
    return result.fold(
      (data) => c.json(data),
      (error) => c.json({ error }, 400)
    );
  }

  static async updateRolePermissions(c: any) {
    const tenantId = c.req.header('x-tenant-id') || 'tenant-hq';
    try {
      const body = await c.req.json();
      const result = await IdentityService.updateRolePermissions(c.get('prisma'), {
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
  }
}
