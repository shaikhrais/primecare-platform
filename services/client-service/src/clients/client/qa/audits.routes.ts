import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const qaAuditsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const AuditSchema = z.object({
  id: z.string(),
  franchise: z.string(),
  auditDate: z.string(),
  auditorName: z.string(),
  score: z.number(),
  compliancePct: z.number(),
  status: z.string(),
});

qaAuditsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all QA Audit Logs',
        content: {
          'application/json': {
            schema: z.object({
              audits: z.array(AuditSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.auditLogNode.count();
       if (count === 0) {
          const now = new Date();
          await c.var.prisma.auditLogNode.createMany({
             data: [
                { tenantId: 't1', franchise: 'NY Clinic', auditDate: now, auditorName: 'Dr. Evans', score: 95.0, compliancePct: 98.0, status: 'Passed' },
                { tenantId: 't1', franchise: 'South Ward', auditDate: new Date(now.getTime() - 86400000 * 5), auditorName: 'N. Foster', score: 72.0, compliancePct: 75.0, status: 'Failed' },
                { tenantId: 't1', franchise: 'Downtown Hub', auditDate: new Date(now.getTime() - 86400000 * 2), auditorName: 'M. Reid', score: 85.0, compliancePct: 88.0, status: 'Warning' },
             ]
          });
       }

       const audits = await c.var.prisma.auditLogNode.findMany({
         orderBy: { auditDate: 'desc' }
       });
       return c.json({ audits: audits.map((a: any) => ({ ...a, auditDate: a.auditDate.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default qaAuditsList;
