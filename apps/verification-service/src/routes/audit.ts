import { AuditService, AuditLogFilters } from '@primecare/domain/src/services/AuditService';

export function registerAuditRoutes(app: any) {
    /**
     * GET /v1/audit/logs
     * Lists audit logs with filtering and pagination
     */
    app.get('/v1/audit/logs', async (c: any) => {
        try {
            // In a real multi-tenant app, tenantId would come from the auth context
            // For now, we'll allow it as a query param or default to a system tenant
            const tenantId = c.req.query('tenantId') || 'system-tenant';
            
            const filters: AuditLogFilters = {
                actorUserId: c.req.query('actorUserId'),
                action: c.req.query('action'),
                resourceType: c.req.query('resourceType'),
                startDate: c.req.query('startDate'),
                endDate: c.req.query('endDate'),
                limit: c.req.query('limit') ? parseInt(c.req.query('limit')) : 50,
                offset: c.req.query('offset') ? parseInt(c.req.query('offset')) : 0
            };

            const result = await AuditService.listLogs(tenantId, filters);
            return c.json({ success: true, data: result });
        } catch (error: any) {
            console.error('List Audit Logs Error:', error);
            return c.json({ success: false, error: 'Internal Server Error' }, 500);
        }
    });

    /**
     * POST /v1/audit/logs
     * Records a new audit log entry (for internal systems calling the service)
     */
    app.post('/v1/audit/logs', async (c: any) => {
        try {
            const body = await c.req.json();
            const log = await AuditService.recordLog(body);
            return c.json({ success: true, data: log });
        } catch (error: any) {
            console.error('Record Audit Log Error:', error);
            return c.json({ success: false, error: 'Internal Server Error' }, 500);
        }
    });
}
