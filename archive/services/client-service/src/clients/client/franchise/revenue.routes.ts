import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const franchiseRevenueList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const RevenueSchema = z.object({
  id: z.string(),
  monthYear: z.string(),
  revenueAmt: z.number(),
  patientVisits: z.number(),
  growthPct: z.number(),
  status: z.string(),
  createdAt: z.string(),
});

franchiseRevenueList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Franchise Monthly Revenues',
        content: {
          'application/json': {
            schema: z.object({
              revenue: z.array(RevenueSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.franchiseRevenueNode.count();
       if (count === 0) {
          await c.var.prisma.franchiseRevenueNode.createMany({
             data: [
                { tenantId: 't1', monthYear: 'Oct 2023', revenueAmt: 450000, patientVisits: 3100, growthPct: 9.1, status: 'On Track' },
                { tenantId: 't1', monthYear: 'Nov 2023', revenueAmt: 410000, patientVisits: 3000, growthPct: 2.1, status: 'At Risk' },
                { tenantId: 't1', monthYear: 'Dec 2023', revenueAmt: 470000, patientVisits: 3250, growthPct: 11.2, status: 'On Track' },
             ]
          });
       }

       const items = await c.var.prisma.franchiseRevenueNode.findMany({
         orderBy: { createdAt: 'desc' }
       });

       return c.json({ revenue: items.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default franchiseRevenueList;
