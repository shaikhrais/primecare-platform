import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const outreachBudgetsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const BudgetSchema = z.object({
  id: z.string(),
  projectName: z.string(),
  allocatedFunds: z.number(),
  fundsUsed: z.number(),
  sponsor: z.string(),
  status: z.string(),
});

outreachBudgetsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Outreach Budgets',
        content: {
          'application/json': {
            schema: z.object({
              budgets: z.array(BudgetSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.outreachBudgetNode.count();
       if (count === 0) {
          await c.var.prisma.outreachBudgetNode.createMany({
             data: [
                { tenantId: 't1', projectName: 'City Health Fair', allocatedFunds: 25000, fundsUsed: 21000, sponsor: 'City Health Dept', status: 'Active' },
                { tenantId: 't1', projectName: 'Vaccination Drive', allocatedFunds: 15000, fundsUsed: 12000, sponsor: 'State Gov', status: 'At Risk' },
                { tenantId: 't1', projectName: 'Seniors Nutrition', allocatedFunds: 8000, fundsUsed: 8000, sponsor: 'Regional Food Bank', status: 'Completed' },
             ]
          });
       }

       const records = await c.var.prisma.outreachBudgetNode.findMany({
         orderBy: { allocatedFunds: 'desc' }
       });
       return c.json({ budgets: records });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default outreachBudgetsList;
