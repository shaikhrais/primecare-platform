import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const franchiseNetworkList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const NetworkSchema = z.object({
  id: z.string(),
  locationName: z.string(),
  occupancyRate: z.number(),
  serverLoadScore: z.number(),
  staffActive: z.number(),
  status: z.string(),
});

franchiseNetworkList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Franchise Network Uptime',
        content: {
          'application/json': {
            schema: z.object({
              network: z.array(NetworkSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.localNetworkNode.count();
       if (count === 0) {
          await c.var.prisma.localNetworkNode.createMany({
             data: [
                { tenantId: 't1', locationName: 'Hamilton Central', occupancyRate: 92.4, serverLoadScore: 84.5, staffActive: 42, status: 'Online' },
                { tenantId: 't1', locationName: 'North Park', occupancyRate: 88.1, serverLoadScore: 71.2, staffActive: 36, status: 'Active' },
                { tenantId: 't1', locationName: 'East Park', occupancyRate: 96.8, serverLoadScore: 92.5, staffActive: 51, status: 'Active' },
             ]
          });
       }

       const items = await c.var.prisma.localNetworkNode.findMany({
         orderBy: { occupancyRate: 'desc' }
       });
       return c.json({ network: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default franchiseNetworkList;
