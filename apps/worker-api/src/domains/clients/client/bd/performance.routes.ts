import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const bdPerformanceList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const PerformanceSchema = z.object({
  id: z.string(),
  repName: z.string(),
  quota: z.number(),
  attainment: z.number(),
  meetings: z.number(),
  pipelineValue: z.number(),
  createdAt: z.string(),
});

bdPerformanceList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all BD Rep Performance Tracking Metrics',
        content: {
          'application/json': {
            schema: z.object({
              reps: z.array(PerformanceSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.repPerformanceNode.count();
       if (count === 0) {
          await c.var.prisma.repPerformanceNode.createMany({
             data: [
                { tenantId: 't1', repName: 'Sarah J.', quota: 5000000, attainment: 5200000, meetings: 45, pipelineValue: 12500000 },
                { tenantId: 't1', repName: 'Michael R.', quota: 4000000, attainment: 3100000, meetings: 28, pipelineValue: 8000000 },
                { tenantId: 't1', repName: 'Emma L.', quota: 4000000, attainment: 4400000, meetings: 32, pipelineValue: 9500000 },
                { tenantId: 't1', repName: 'David K.', quota: 3500000, attainment: 2100000, meetings: 19, pipelineValue: 4500000 },
             ]
          });
       }

       const reps = await c.var.prisma.repPerformanceNode.findMany({
         orderBy: { attainment: 'desc' }
       });
       return c.json({ reps: reps.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default bdPerformanceList;
