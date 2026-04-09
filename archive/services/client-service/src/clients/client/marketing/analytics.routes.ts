import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const marketingAnalyticsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const AnalyticsSchema = z.object({
  id: z.string(),
  regionName: z.string(),
  patientAcqCost: z.number(),
  newPatients: z.number(),
  totalRevenue: z.number(),
});

marketingAnalyticsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets local growth mapping metrics',
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
       const count = await c.var.prisma.localGrowthNode.count();
       if (count === 0) {
          await c.var.prisma.localGrowthNode.createMany({
             data: [
                { tenantId: 't1', regionName: 'Northeast Territory', patientAcqCost: 85.50, newPatients: 450, totalRevenue: 1850000 },
                { tenantId: 't1', regionName: 'Midwest Metro', patientAcqCost: 112.00, newPatients: 210, totalRevenue: 850000 },
                { tenantId: 't1', regionName: 'Southern District', patientAcqCost: 65.20, newPatients: 680, totalRevenue: 2400000 },
             ]
          });
       }

       const items = await c.var.prisma.localGrowthNode.findMany({
         orderBy: { newPatients: 'desc' }
       });
       
       return c.json({ analytics: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default marketingAnalyticsList;
