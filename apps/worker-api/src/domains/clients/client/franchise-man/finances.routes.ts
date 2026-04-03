import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const franchiseFinancesList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const FinanceSchema = z.object({
  id: z.string(),
  monthLabel: z.string(),
  grossRevenue: z.number(),
  netMargin: z.number(),
  growthYoY: z.number(),
});

franchiseFinancesList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Branch Fiscal Ledger',
        content: {
          'application/json': {
            schema: z.object({
              finances: z.array(FinanceSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.localFinanceNode.count();
       if (count === 0) {
          await c.var.prisma.localFinanceNode.createMany({
             data: [
                { tenantId: 't1', monthLabel: 'July', grossRevenue: 400000, netMargin: 450000, growthYoY: 2.1 },
                { tenantId: 't1', monthLabel: 'August', grossRevenue: 450000, netMargin: 400000, growthYoY: 1.8 },
                { tenantId: 't1', monthLabel: 'September', grossRevenue: 500000, netMargin: 550000, growthYoY: 3.4 },
             ]
          });
       }

       const items = await c.var.prisma.localFinanceNode.findMany({
         orderBy: { monthLabel: 'desc' }
       });
       return c.json({ finances: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default franchiseFinancesList;
