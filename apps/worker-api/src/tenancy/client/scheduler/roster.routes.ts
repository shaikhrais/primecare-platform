import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const schedulerRosterList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const RosterSchema = z.object({
  id: z.string(),
  providerName: z.string(),
  specialty: z.string(),
  shiftTime: z.string(),
  isAvailable: z.boolean(),
});

schedulerRosterList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Scheduler Roster',
        content: {
          'application/json': {
            schema: z.object({
              roster: z.array(RosterSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.schedulerRosterNode.count();
       if (count === 0) {
          await c.var.prisma.schedulerRosterNode.createMany({
             data: [
                { tenantId: 't1', providerName: 'Dr. M. Chen', specialty: 'General Practice', shiftTime: '08:00 AM - 04:00 PM', isAvailable: true },
                { tenantId: 't1', providerName: 'Dr. S. Rahman', specialty: 'Cardiology', shiftTime: '09:00 AM - 05:00 PM', isAvailable: false },
                { tenantId: 't1', providerName: 'Dr. T. Lee', specialty: 'Pediatrics', shiftTime: '08:00 AM - 12:00 PM', isAvailable: true },
             ]
          });
       }

       const items = await c.var.prisma.schedulerRosterNode.findMany();
       return c.json({ roster: items });
    } catch (e: any) {
       console.error(e);
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default schedulerRosterList;
