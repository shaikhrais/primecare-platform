import { ClinicalService } from '@primecare/domain/src/services/ClinicalService';
export function registerClinicalRoutes(app) {
    /**
     * POST /v1/clinical/vitals
     * Captures a new set of vitals.
     */
    app.post('/v1/clinical/vitals', async (c) => {
        const tenantId = c.req.header('x-tenant-id');
        if (!tenantId) {
            return c.json({ error: 'Missing x-tenant-id header' }, 400);
        }
        try {
            const body = await c.req.json();
            const result = await ClinicalService.captureVitals({
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
     * POST /v1/clinical/patient-intake
     * Processes a new patient intake.
     */
    app.post('/v1/clinical/patient-intake', async (c) => {
        const tenantId = c.req.header('x-tenant-id');
        if (!tenantId) {
            return c.json({ error: 'Missing x-tenant-id header' }, 400);
        }
        try {
            const body = await c.req.json();
            const result = await ClinicalService.processPatientIntake({
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
     * GET /v1/clinical/check-email
     * Checks if an email is available for a patient in the current tenant.
     */
    app.get('/v1/clinical/check-email', async (c) => {
        const tenantId = c.req.header('x-tenant-id');
        const email = c.req.query('email');
        if (!tenantId || !email) {
            return c.json({ error: 'Missing x-tenant-id header or email query param' }, 400);
        }
        const result = await ClinicalService.checkPatientEmail(tenantId, email);
        return result.fold((data) => c.json(data), (error) => c.json({ error }, 400));
    });
}
