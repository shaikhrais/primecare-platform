import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const opsFacilitiesList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const FacilitySchema = z.object({
  id: z.string(),
  facilityName: z.string(),
  location: z.string(),
  managerName: z.string(),
  status: z.string(),
  satisfaction: z.number(),
  dailyVisits: z.number(),
});

opsFacilitiesList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all Operations Facilities',
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
       const count = await c.var.prisma.facilityNode.count();
       if (count === 0) {
          await c.var.prisma.facilityNode.createMany({
             data: [
                { tenantId: 't1', facilityName: 'Downtown Care', location: 'City Center', managerName: 'J. Doe', status: 'Operational', satisfaction: 4.9, dailyVisits: 120 },
                { tenantId: 't1', facilityName: 'North Regional', location: 'Northern Valley', managerName: 'L. Chen', status: 'Review', satisfaction: 4.3, dailyVisits: 95 },
                { tenantId: 't1', facilityName: 'South Ward', location: 'South District', managerName: 'A. Smith', status: 'Issue', satisfaction: 4.1, dailyVisits: 60 },
             ]
          });
       }

       const facilities = await c.var.prisma.facilityNode.findMany({
         orderBy: { satisfaction: 'desc' }
       });
       return c.json({ facilities });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default opsFacilitiesList;
