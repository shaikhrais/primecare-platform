import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const schedulerFacilityList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const FacilitySchema = z.object({
  id: z.string(),
  facilityName: z.string(),
  occupancyRate: z.number(),
  status: z.string(),
});

schedulerFacilityList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Scheduler Facilities',
        content: {
          'application/json': {
            schema: z.object({
              facilities: z.array(FacilitySchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.schedulerFacilityNode.count();
       if (count === 0) {
          await c.var.prisma.schedulerFacilityNode.createMany({
             data: [
                { tenantId: 't1', facilityName: 'Aurora West', occupancyRate: 0.85, status: 'At Capacity' },
                { tenantId: 't1', facilityName: 'Aurora East', occupancyRate: 0.45, status: 'Available' },
                { tenantId: 't1', facilityName: 'Aurora Central', occupancyRate: 0.95, status: 'Overbooked' },
             ]
          });
       }

       const items = await c.var.prisma.schedulerFacilityNode.findMany();
       return c.json({ facilities: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default schedulerFacilityList;
