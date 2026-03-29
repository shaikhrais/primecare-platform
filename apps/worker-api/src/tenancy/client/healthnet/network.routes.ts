import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const healthnetNetworkList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const NetworkSchema = z.object({
  id: z.string(),
  regionName: z.string(),
  clinicCount: z.number(),
  demographicCat: z.string(),
});

healthnetNetworkList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets HealthNet Network map stats',
        content: {
          'application/json': {
            schema: z.object({
              networkStats: z.array(NetworkSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.healthNetNetworkNode.count();
       if (count === 0) {
          await c.var.prisma.healthNetNetworkNode.createMany({
             data: [
                { tenantId: 't1', regionName: 'West Coast', clinicCount: 12, demographicCat: 'Mixed Urban' },
                { tenantId: 't1', regionName: 'Midwest', clinicCount: 8, demographicCat: 'Suburban' },
                { tenantId: 't1', regionName: 'East Coast', clinicCount: 15, demographicCat: 'High Density' },
             ]
          });
       }

       const items = await c.var.prisma.healthNetNetworkNode.findMany();
       return c.json({ networkStats: items });
    } catch (e: any) {
       console.error(e);
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default healthnetNetworkList;
