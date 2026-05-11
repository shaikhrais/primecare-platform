import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const billingReportsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const FinancialGoalSchema = z.object({
  id: z.string(),
  month: z.number(),
  year: z.number(),
  label: z.string(),
  targetRevenue: z.number(),
  actualRevenue: z.number(),
});

billingReportsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all Monthly Goals',
        content: {
          'application/json': {
            schema: z.object({
              goals: z.array(FinancialGoalSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.financialGoal.count();
       if (count === 0) {
          await c.var.prisma.financialGoal.createMany({
             data: [
                { tenantId: 't1', month: 1, year: 2026, label: 'Jan', targetRevenue: 50000, actualRevenue: 45000 },
                { tenantId: 't1', month: 2, year: 2026, label: 'Feb', targetRevenue: 55000, actualRevenue: 50000 },
                { tenantId: 't1', month: 3, year: 2026, label: 'Mar', targetRevenue: 60000, actualRevenue: 62000 },
                { tenantId: 't1', month: 4, year: 2026, label: 'Apr', targetRevenue: 65000, actualRevenue: 60000 },
             ]
          });
       }

       const goals = await c.var.prisma.financialGoal.findMany({
         orderBy: [ { year: 'asc' }, { month: 'asc'} ]
       });
       return c.json({ goals });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default billingReportsList;
