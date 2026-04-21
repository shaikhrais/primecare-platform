import { AuditService } from '@primecare/domain/src/services/AuditService';
import { z } from 'zod';

const AuditQuerySchema = z.object({
    tenantId: z.string().default('system-tenant'),
    actorUserId: z.string().optional(),
    action: z.string().optional(),
    resourceType: z.string().optional(),
    startDate: z.string().datetime().optional(),
    endDate: z.string().datetime().optional(),
    limit: z.string().regex(/^\d+$/).transform(Number).default('50'),
    offset: z.string().regex(/^\d+$/).transform(Number).default('0'),
    q: z.string().optional(),
});

export function registerAuditRoutes(app: any) {
    /**
     * GET /v1/audit/logs
     * Lists audit logs with filtering and pagination
     */
    app.get('/v1/audit/logs', async (c: any) => {
        const query = c.req.query();
        const validated = AuditQuerySchema.safeParse(query);

        if (!validated.success) {
            return c.json({ 
                error: 'INVALID_PARAMETERS',
                details: validated.error.format()
            }, 400);
        }

        const { tenantId, q, ...filters } = validated.data;
        
        const result = await AuditService.listLogs(c.get('prisma'), tenantId, {
            ...filters,
            searchTerm: q
        });

        return result.fold(
            (data) => c.json(data),
            (error) => c.json({ error }, 500)
        );
    });

    /**
     * POST /v1/audit/logs
     * Records a new audit log entry
     */
    app.post('/v1/audit/logs', async (c: any) => {
        try {
            const body = await c.req.json();
            const result = await AuditService.recordLog(c.get('prisma'), body);
            
            return result.fold(
                (data) => c.json(data, 201),
                (error: string) => c.json({ error }, 400)
            );
        } catch (e: any) {
            return c.json({ error: 'Invalid request body' }, 400);
        }
    });
}
