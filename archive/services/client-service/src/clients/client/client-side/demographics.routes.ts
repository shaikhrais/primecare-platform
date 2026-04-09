import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const clientDemographicsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const DemographicSchema = z.object({
  id: z.string(),
  cohortGroup: z.string(),
  percentage: z.number(),
});

clientDemographicsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Client Demographics Pie',
        content: {
          'application/json': {
            schema: z.object({
              demographics: z.array(DemographicSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.clientDemographicNode.count();
       if (count === 0) {
          await c.var.prisma.clientDemographicNode.createMany({
             data: [
                { tenantId: 't1', cohortGroup: 'Adults (18-64)', percentage: 0.55 },
                { tenantId: 't1', cohortGroup: 'Seniors (65+)', percentage: 0.30 },
                { tenantId: 't1', cohortGroup: 'Pediatrics (<18)', percentage: 0.15 },
             ]
          });
       }

       const items = await c.var.prisma.clientDemographicNode.findMany({
         orderBy: { percentage: 'desc' }
       });
       return c.json({ demographics: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default clientDemographicsList;
