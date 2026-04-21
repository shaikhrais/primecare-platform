import { ComplianceService } from '@primecare/domain/src/services/ComplianceService';
import { TrainingService } from '@primecare/domain/src/services/TrainingService';

export function registerComplianceRoutes(app: any) {
    /**
     * GET /v1/compliance/training/summary
     * Returns aggregated training and certification metrics for the dashboard.
     */
    app.get('/compliance/training/summary', async (c: any) => {
        const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';

        const result = await TrainingService.getTrainingComplianceSummary(
            c.get('prisma'),
            tenantId as string
        );

        return result.fold(
            (data) => c.json({
                success: true,
                data,
                timestamp: new Date().toISOString()
            }),
            (error) => c.json({ success: false, error }, 500)
        );
    });

    /**
     * POST /v1/compliance/training/verify-certificate
     * Verifies a certificate against the internal training registry.
     */
    app.post('/compliance/training/verify-certificate', async (c: any) => {
        const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
        const body = await c.req.json();

        const result = await TrainingService.verifyCertificate(
            c.get('prisma'),
            tenantId as string,
            {
                staffName: body.staffName,
                certName: body.certName
            }
        );

        return result.fold(
            (data) => c.json({
                success: true,
                ...data,
                timestamp: new Date().toISOString()
            }),
            (error) => c.json({ success: false, error: error.message || error }, 500)
        );
    });

    /**
     * GET /v1/compliance/training/activity
     * Returns the most recent training assignments and certifications.
     */
    app.get('/compliance/training/activity', async (c: any) => {
        const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
        const { limit } = c.req.query();

        const result = await TrainingService.getRecentActivity(
            c.get('prisma'),
            tenantId as string,
            limit ? parseInt(limit as string) : 10
        );

        return result.fold(
            (data) => c.json({
                success: true,
                count: data.length,
                data,
                timestamp: new Date().toISOString()
            }),
            (error) => c.json({ success: false, error }, 500)
        );
    });

    /**
     * GET /v1/compliance/reports/audit
     * Returns a structured list of audit logs for export.
     */
    app.get('/compliance/reports/audit', async (c: any) => {
        const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
        const { startDate, endDate } = c.req.query();

        const result = await ComplianceService.getAuditReportData(
            c.get('prisma'),
            tenantId as string,
            startDate,
            endDate
        );

        return result.fold(
            (data) => c.json({
                success: true,
                count: data.length,
                data,
                timestamp: new Date().toISOString()
            }),
            (error) => c.json({ success: false, error }, 500)
        );
    });

    /**
     * GET /v1/compliance/reports/clinical
     * Returns clinical metrics (vitals) for compliance reporting.
     */
    app.get('/compliance/reports/clinical', async (c: any) => {
        const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
        const { startDate, endDate } = c.req.query();

        const result = await ComplianceService.getClinicalComplianceData(
            c.get('prisma'),
            tenantId as string,
            startDate,
            endDate
        );

        return result.fold(
            (data) => c.json({
                success: true,
                count: data.length,
                data,
                timestamp: new Date().toISOString()
            }),
            (error) => c.json({ success: false, error }, 500)
        );
    });

    /**
     * GET /v1/compliance/training/staff-activity
     * Returns staff provisioning and role changes for HR compliance.
     */
    app.get('/compliance/reports/staff-activity', async (c: any) => {
        const tenantId = c.req.header('x-tenant-id') || '00000000-0000-0000-0000-000000000000';
        const { startDate, endDate } = c.req.query();

        const result = await ComplianceService.getStaffActivityReport(
            c.get('prisma'),
            tenantId as string,
            startDate,
            endDate
        );

        return result.fold(
            (data) => c.json({
                success: true,
                count: data.length,
                data,
                timestamp: new Date().toISOString()
            }),
            (error) => c.json({ success: false, error }, 500)
        );
    });

    /**
     * GET /v1/compliance/training/curricula
     * Returns all curricula for a tenant.
     */
    app.get('/compliance/training/curricula', async (c: any) => {
        const tenantId = c.req.header('x-tenant-id');
        if (!tenantId) return c.json({ success: false, error: 'Missing x-tenant-id' }, 400);

        const result = await TrainingService.getCurricula(c.get('prisma'), tenantId as string);
        return result.fold(
            (data) => c.json({ success: true, count: data.length, data }),
            (error) => c.json({ success: false, error }, 500)
        );
    });

    /**
     * GET /v1/compliance/training/certifications
     * Returns all certifications for a tenant.
     */
    app.get('/compliance/training/certifications', async (c: any) => {
        const tenantId = c.req.header('x-tenant-id');
        if (!tenantId) return c.json({ success: false, error: 'Missing x-tenant-id' }, 400);

        const result = await TrainingService.getCertifications(c.get('prisma'), tenantId as string);
        return result.fold(
            (data) => c.json({ success: true, count: data.length, data }),
            (error) => c.json({ success: false, error }, 500)
        );
    });

    /**
     * POST /v1/compliance/training/modules
     * Creates a new training module.
     */
    app.post('/compliance/training/modules', async (c: any) => {
        const tenantId = c.req.header('x-tenant-id');
        const body = await c.req.json();
        if (!tenantId) return c.json({ success: false, error: 'Missing x-tenant-id' }, 400);

        const result = await TrainingService.createModule(c.get('prisma'), tenantId as string, body);
        return result.fold(
            (data) => c.json({ success: true, data }),
            (error) => c.json({ success: false, error: error.message || error }, 500)
        );
    });

    /**
     * PUT /v1/compliance/training/modules/:id
     * Updates an existing training module.
     */
    app.put('/compliance/training/modules/:id', async (c: any) => {
        const tenantId = c.req.header('x-tenant-id');
        const id = c.req.param('id');
        const body = await c.req.json();
        if (!tenantId) return c.json({ success: false, error: 'Missing x-tenant-id' }, 400);

        const result = await TrainingService.updateModule(c.get('prisma'), tenantId as string, id, body);
        return result.fold(
            (data) => c.json({ success: true, data }),
            (error) => c.json({ success: false, error: error.message || error }, 500)
        );
    });
}
