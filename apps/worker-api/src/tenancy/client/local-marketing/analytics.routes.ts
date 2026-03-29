import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const localAnalyticsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const AnalyticSchema = z.object({
  id: z.string(),
  metricType: z.string(),
  value: z.number(),
  growthYoY: z.number(),
});

localAnalyticsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Local Marketing Analytics',
        content: {
          'application/json': {
            schema: z.object({
              analytics: z.array(AnalyticSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.localMarketingAnalyticNode.count();
       if (count === 0) {
          await c.var.prisma.localMarketingAnalyticNode.createMany({
             data: [
                { tenantId: 't1', metricType: 'Patient Reach', value: 8412, growthYoY: 12.5 },
                { tenantId: 't1', metricType: 'Conversion Flux', value: 24, growthYoY: 8.2 },
                { tenantId: 't1', metricType: 'Revenue Pull', value: 198000, growthYoY: 8.0 },
             ]
          });
       }

       const items = await c.var.prisma.localMarketingAnalyticNode.findMany({
         orderBy: { value: 'desc' }
       });
       return c.json({ analytics: items });
    } catch (e: any) {
       console.error(e);
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default localAnalyticsList;
