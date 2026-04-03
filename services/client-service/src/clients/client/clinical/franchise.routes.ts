import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const clinicalFranchiseList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const AnalyticsSchema = z.object({
  id: z.string(),
  regionCode: z.string(),
  survivalRate: z.number(),
  readmissionRate: z.number(),
  averageWaitTime: z.number(),
});

clinicalFranchiseList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Medical Performance Analytics',
        content: {
          'application/json': {
            schema: z.object({
              analytics: z.array(AnalyticsSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.medicalAuditNode.count();
       if (count === 0) {
          await c.var.prisma.medicalAuditNode.createMany({
             data: [
                { tenantId: 't1', regionCode: 'Ill (Chicago)', survivalRate: 98.2, readmissionRate: 4.1, averageWaitTime: 14 },
                { tenantId: 't1', regionCode: 'NY (Metro)', survivalRate: 99.1, readmissionRate: 2.8, averageWaitTime: 8 },
                { tenantId: 't1', regionCode: 'CA (SF)', survivalRate: 97.5, readmissionRate: 5.6, averageWaitTime: 22 },
             ]
          });
       }

       const records = await c.var.prisma.medicalAuditNode.findMany({
         orderBy: { survivalRate: 'desc' }
       });
       return c.json({ analytics: records });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default clinicalFranchiseList;
