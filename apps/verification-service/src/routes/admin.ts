import { AdminService } from '@primecare/domain/src/services/AdminService';

export function registerAdminRoutes(app: any) {
    /**
     * POST /v1/admin/provision-staff
     * Onboards a new staff member and assigns their platform role.
     */
    app.post('/v1/admin/provision-staff', async (c: any) => {
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
    });

    /**
     * GET /v1/admin/staff
     * Lists all staff members for the current tenant.
     */
    app.get('/v1/admin/staff', async (c: any) => {
        const tenantId = c.req.header('x-tenant-id');
        if (!tenantId) {
            return c.json({ error: 'Missing x-tenant-id header' }, 400);
        }

        const result = await AdminService.listStaffMembers(c.get('prisma'), tenantId);

        return result.fold(
            (data) => c.json(data),
            (error) => c.json({ error }, 500)
        );
    });

    /**
     * POST /v1/admin/staff/:userId/deactivate
     * Deactivates a staff member and records the audit log.
     */
    app.post('/v1/admin/staff/:userId/deactivate', async (c: any) => {
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
    });

    /**
     * GET /v1/admin/departments
     * Returns available organizational departments.
     */
    app.get('/v1/admin/departments', async (c: any) => {
        const result = await AdminService.getAvailableDepartments(c.get('prisma'));

        return result.fold(
            (data: any[]) => c.json({ success: true, data }),
            (error: string) => c.json({ error }, 500)
        );
    });
}
