import { ComplianceService } from '@primecare/domain/src/services/ComplianceService';
export function registerComplianceRoutes(app) {
    /**
     * GET /v1/compliance/reports/audit
     * Returns a structured list of audit logs for export.
     */
    app.get('/v1/compliance/reports/audit', async (c) => {
        const tenantId = c.req.header('x-tenant-id');
        const { startDate, endDate } = c.req.query();
        if (!tenantId) {
            return c.json({ success: false, error: 'Missing x-tenant-id header' }, 400);
        }
        const result = await ComplianceService.getAuditReportData(tenantId, startDate, endDate);
        return result.fold((data) => c.json({
            success: true,
            count: data.length,
            data,
            timestamp: new Date().toISOString()
        }), (error) => c.json({ success: false, error }, 500));
    });
    /**
     * GET /v1/compliance/reports/clinical
     * Returns clinical metrics (vitals) for compliance reporting.
     */
    app.get('/v1/compliance/reports/clinical', async (c) => {
        const tenantId = c.req.header('x-tenant-id');
        const { startDate, endDate } = c.req.query();
        if (!tenantId) {
            return c.json({ success: false, error: 'Missing x-tenant-id header' }, 400);
        }
        const result = await ComplianceService.getClinicalComplianceData(tenantId, startDate, endDate);
        return result.fold((data) => c.json({
            success: true,
            count: data.length,
            data,
            timestamp: new Date().toISOString()
        }), (error) => c.json({ success: false, error }, 500));
    });
    /**
     * GET /v1/compliance/reports/staff-activity
     * Returns staff provisioning and role changes for HR compliance.
     */
    app.get('/v1/compliance/reports/staff-activity', async (c) => {
        const tenantId = c.req.header('x-tenant-id');
        const { startDate, endDate } = c.req.query();
        if (!tenantId) {
            return c.json({ success: false, error: 'Missing x-tenant-id header' }, 400);
        }
        const result = await ComplianceService.getStaffActivityReport(tenantId, startDate, endDate);
        return result.fold((data) => c.json({
            success: true,
            count: data.length,
            data,
            timestamp: new Date().toISOString()
        }), (error) => c.json({ success: false, error }, 500));
    });
}
