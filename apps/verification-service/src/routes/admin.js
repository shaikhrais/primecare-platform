import { AdminService } from '@primecare/domain/src/services/AdminService';
export function registerAdminRoutes(app) {
    /**
     * POST /v1/admin/provision-staff
     * Onboards a new staff member and assigns their platform role.
     */
    app.post('/v1/admin/provision-staff', async (c) => {
        const tenantId = c.req.header('x-tenant-id');
        if (!tenantId) {
            return c.json({ error: 'Missing x-tenant-id header' }, 400);
        }
        try {
            const body = await c.req.json();
            const result = await AdminService.provisionStaff({
                ...body,
                tenantId,
                actorUserId: c.get('user')?.id || 'SYSTEM'
            });
            return result.fold((data) => c.json(data, 201), (error) => c.json({ error }, 400));
        }
        catch (e) {
            return c.json({ error: 'Invalid request body' }, 400);
        }
    });
    /**
     * GET /v1/admin/staff
     * Lists all staff members for the current tenant.
     */
    app.get('/v1/admin/staff', async (c) => {
        const tenantId = c.req.header('x-tenant-id');
        if (!tenantId) {
            return c.json({ error: 'Missing x-tenant-id header' }, 400);
        }
        const result = await AdminService.listStaffMembers(tenantId);
        return result.fold((data) => c.json(data), (error) => c.json({ error }, 500));
    });
    /**
     * POST /v1/admin/staff/:userId/deactivate
     * Deactivates a staff member and records the audit log.
     */
    app.post('/v1/admin/staff/:userId/deactivate', async (c) => {
        const id = c.req.param('userId');
        const tenantId = c.req.header('x-tenant-id');
        if (!tenantId) {
            return c.json({ error: 'Missing x-tenant-id header' }, 400);
        }
        const result = await AdminService.deactivateStaff(id, c.get('user')?.id || 'SYSTEM');
        return result.fold((data) => c.json(data), (error) => c.json({ error }, 400));
    });
    /**
     * GET /v1/admin/departments
     * Returns available organizational departments.
     */
    app.get('/v1/admin/departments', async (c) => {
        const result = await AdminService.getAvailableDepartments();
        return result.fold((data) => c.json({ success: true, data }), (error) => c.json({ error }, 500));
    });
}
