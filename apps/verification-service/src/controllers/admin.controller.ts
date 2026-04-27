import { AdminService } from '@primecare/domain/src/services/AdminService';

export class AdminController {
  static async provisionStaff(c: any) {
    const tenantId = c.req.header('x-tenant-id');
    if (!tenantId) {
      return c.json({ error: 'Missing x-tenant-id header' }, 400);
    }

    try {
      const body = await c.req.json();
      const result = await AdminService.provisionStaff(c.get('prisma'), {
        ...body,
        tenantId,
        actorUserId: (c.get('user') as any)?.id || 'SYSTEM'
      });

      return result.fold(
        (data) => c.json(data, 201),
        (error) => c.json({ error }, 400)
      );
    } catch (e: any) {
      return c.json({ error: 'Invalid request body' }, 400);
    }
  }

  static async listStaff(c: any) {
    const tenantId = c.req.header('x-tenant-id');
    if (!tenantId) {
      return c.json({ error: 'Missing x-tenant-id header' }, 400);
    }

    const result = await AdminService.listStaffMembers(c.get('prisma'), tenantId);

    return result.fold(
      (data) => c.json(data),
      (error) => c.json({ error }, 500)
    );
  }

  static async deactivateStaff(c: any) {
    const id = c.req.param('userId');
    const tenantId = c.req.header('x-tenant-id');
    if (!tenantId) {
      return c.json({ error: 'Missing x-tenant-id header' }, 400);
    }

    const result = await AdminService.deactivateStaff(c.get('prisma'), id, (c.get('user') as any)?.id || 'SYSTEM');

    return result.fold(
      (data) => c.json(data),
      (error) => c.json({ error }, 400)
    );
  }

  static async getDepartments(c: any) {
    const result = await AdminService.getAvailableDepartments(c.get('prisma'));

    return result.fold(
      (data: any[]) => c.json({ success: true, data }),
      (error: string) => c.json({ error }, 500)
    );
  }
}
