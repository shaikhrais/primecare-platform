import { AdminService, ProvisionStaffInput } from '@primecare/domain/src/services/AdminService';

export function registerAdminRoutes(app: any) {
    /**
     * POST /v1/admin/provision-staff
     * Onboards a new staff member and assigns their platform role.
     */
    app.post('/v1/admin/provision-staff', async (c: any) => {
        try {
            const tenantId = c.req.header('x-tenant-id');
            const jwtPayload = c.get('jwtPayload');

            if (!tenantId) {
                return c.json({ success: false, error: 'Missing x-tenant-id header' }, 400);
            }

            const body = await c.req.json();
            
            const input: ProvisionStaffInput = {
                tenantId: tenantId as string,
                firstName: body.firstName,
                lastName: body.lastName,
                email: body.email,
                roleId: body.roleId || body.role, // Handle both 'roleId' and legacy 'role' label
                department: body.department,
                additionalNotes: body.additionalNotes,
                actorUserId: jwtPayload?.sub || 'SYSTEM'
            };

            if (!input.email || !input.firstName || !input.roleId) {
                return c.json({ success: false, error: 'Missing required fields (email, firstName, roleId)' }, 400);
            }

            const result = await AdminService.provisionStaff(input);
            return c.json({ success: true, ...result }, 201);
        } catch (error: any) {
            console.error('Provision Staff Error:', error);
            return c.json({ success: false, error: error.message || 'Internal Server Error' }, 500);
        }
    });
}
