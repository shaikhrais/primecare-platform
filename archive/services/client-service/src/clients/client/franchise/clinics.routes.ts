import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const franchiseClinicsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ClinicSchema = z.object({
  id: z.string(),
  locationName: z.string(),
  managerName: z.string(),
  revenue: z.string(),
  visits: z.number(),
  growth: z.string(),
  status: z.string(),
});

franchiseClinicsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets clinic performance data',
        content: {
          'application/json': {
            schema: z.object({
              clinics: z.array(ClinicSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.clinicPerformanceNode.count();
       if (count === 0) {
          await c.var.prisma.clinicPerformanceNode.createMany({
             data: [
                { tenantId: 't1', locationName: 'Boston Central', managerName: 'Sarah Jenser', revenue: '$410K', visits: 3100, growth: '+9.1%', status: 'On Track' },
                { tenantId: 't1', locationName: 'Chicago Metro', managerName: 'Marcus Cole', revenue: '$420K', visits: 3150, growth: '+8.4%', status: 'On Track' },
                { tenantId: 't1', locationName: 'Downtown Care', managerName: 'Linda Vue', revenue: '$390K', visits: 2900, growth: '-2.1%', status: 'At Risk' },
             ]
          });
       }

       const items = await c.var.prisma.clinicPerformanceNode.findMany({
         orderBy: { visits: 'desc' }
       });
       
       return c.json({ clinics: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default franchiseClinicsList;
