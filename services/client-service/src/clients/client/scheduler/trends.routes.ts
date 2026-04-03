import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const schedulerTrendsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const TrendSchema = z.object({
  id: z.string(),
  dayLabel: z.string(),
  apptCount: z.number(),
});

schedulerTrendsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Scheduler Trends',
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
       const count = await c.var.prisma.schedulerTrendNode.count();
       if (count === 0) {
          await c.var.prisma.schedulerTrendNode.createMany({
             data: [
                { tenantId: 't1', dayLabel: 'Mon', apptCount: 15 },
                { tenantId: 't1', dayLabel: 'Tue', apptCount: 18 },
                { tenantId: 't1', dayLabel: 'Wed', apptCount: 22 },
                { tenantId: 't1', dayLabel: 'Thu', apptCount: 17 },
                { tenantId: 't1', dayLabel: 'Fri', apptCount: 26 },
                { tenantId: 't1', dayLabel: 'Sat', apptCount: 8 },
             ]
          });
       }

       const items = await c.var.prisma.schedulerTrendNode.findMany({
         orderBy: { dayLabel: 'asc' }
       });
       return c.json({ trends: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default schedulerTrendsList;
