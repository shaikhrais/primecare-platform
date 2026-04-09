import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const clientTrendsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const TrendSchema = z.object({
  id: z.string(),
  monthLabel: z.string(),
  revenueAmount: z.number(),
  apptCount: z.number(),
});

clientTrendsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Client Side Trends',
        content: {
          'application/json': {
            schema: z.object({
              trends: z.array(TrendSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.clientTrendNode.count();
       if (count === 0) {
          await c.var.prisma.clientTrendNode.createMany({
             data: [
                { tenantId: 't1', monthLabel: 'Jan', revenueAmount: 200000, apptCount: 150 },
                { tenantId: 't1', monthLabel: 'Feb', revenueAmount: 220000, apptCount: 160 },
                { tenantId: 't1', monthLabel: 'Mar', revenueAmount: 210000, apptCount: 155 },
                { tenantId: 't1', monthLabel: 'Apr', revenueAmount: 250000, apptCount: 180 },
                { tenantId: 't1', monthLabel: 'May', revenueAmount: 240000, apptCount: 175 },
             ]
          });
       }

       const items = await c.var.prisma.clientTrendNode.findMany({
         orderBy: { monthLabel: 'asc' }
       });
       return c.json({ trends: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default clientTrendsList;
