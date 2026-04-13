import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const financialsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const FinanceRecordSchema = z.object({
  id: z.string(),
  month: z.string(),
  revenue: z.number(),
  expenses: z.number(),
});

financialsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets full Revenue vs Expenses dataset',
        content: {
          'application/json': {
            schema: z.object({
              records: z.array(FinanceRecordSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       // Seed if empty
       const count = await c.var.prisma.financialRecord.count();
       if (count === 0) {
          await c.var.prisma.financialRecord.createMany({
             data: [
                { month: 'Jan', revenue: 120000, expenses: 85000 },
                { month: 'Feb', revenue: 135000, expenses: 84000 },
                { month: 'Mar', revenue: 150000, expenses: 90000 },
                { month: 'Apr', revenue: 145000, expenses: 88000 },
                { month: 'May', revenue: 170000, expenses: 95000 },
                { month: 'Jun', revenue: 185000, expenses: 100000 },
                { month: 'Jul', revenue: 210000, expenses: 110000 },
             ]
          });
       }

       const records = await c.var.prisma.financialRecord.findMany({
         orderBy: { createdAt: 'asc' }
       });
       return c.json({ records });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default financialsList;
