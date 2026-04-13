import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const healthnetEfficiencyList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const EfficiencySchema = z.object({
  id: z.string(),
  clinicName: z.string(),
  efficiencyScore: z.number(),
  patientsSeen: z.number(),
  waitTimesAvg: z.number(),
});

healthnetEfficiencyList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets HealthNet Efficiency Leaderboard',
        content: {
          'application/json': {
            schema: z.object({
              efficiencyMetrics: z.array(EfficiencySchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.healthNetEfficiencyNode.count();
       if (count === 0) {
          await c.var.prisma.healthNetEfficiencyNode.createMany({
             data: [
                { tenantId: 't1', clinicName: 'Central HQ', efficiencyScore: 0.94, patientsSeen: 4500, waitTimesAvg: 12 },
                { tenantId: 't1', clinicName: 'North Regional', efficiencyScore: 0.88, patientsSeen: 3200, waitTimesAvg: 18 },
                { tenantId: 't1', clinicName: 'South Branch', efficiencyScore: 0.82, patientsSeen: 2100, waitTimesAvg: 24 },
             ]
          });
       }

       const items = await c.var.prisma.healthNetEfficiencyNode.findMany({
         orderBy: { efficiencyScore: 'desc' }
       });
       return c.json({ efficiencyMetrics: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default healthnetEfficiencyList;
