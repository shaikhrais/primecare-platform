import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const healthnetRevenueList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const RevenueSchema = z.object({
  id: z.string(),
  quarterLabel: z.string(),
  revenueValue: z.number(),
  grossMargin: z.number(),
});

healthnetRevenueList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets HealthNet Revenue metrics',
        content: {
          'application/json': {
            schema: z.object({
              revenueMetrics: z.array(RevenueSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.healthNetRevenueNode.count();
       if (count === 0) {
          await c.var.prisma.healthNetRevenueNode.createMany({
             data: [
                { tenantId: 't1', quarterLabel: 'Q1', revenueValue: 1250000, grossMargin: 0.35 },
                { tenantId: 't1', quarterLabel: 'Q2', revenueValue: 1450000, grossMargin: 0.38 },
                { tenantId: 't1', quarterLabel: 'Q3', revenueValue: 1300000, grossMargin: 0.34 },
                { tenantId: 't1', quarterLabel: 'Q4', revenueValue: 1600000, grossMargin: 0.42 },
             ]
          });
       }

       const items = await c.var.prisma.healthNetRevenueNode.findMany({
         orderBy: { quarterLabel: 'asc' }
       });
       return c.json({ revenueMetrics: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default healthnetRevenueList;
