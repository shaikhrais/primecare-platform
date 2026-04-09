import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const intakeUpcomingList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const IntakeUpcomingSchema = z.object({
  id: z.string(),
  patientName: z.string(),
  franchiseCity: z.string(),
  scheduledTime: z.string(),
});

intakeUpcomingList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets upcoming initial intakes scheduled for today',
        content: {
          'application/json': {
            schema: z.object({
              upcomings: z.array(IntakeUpcomingSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.patientIntake.count({ where: { status: 'SCHEDULED' } });
       if (count === 0) {
          await c.var.prisma.patientIntake.createMany({
             data: [
                { tenantId: 't1', patientName: 'T. Robbins', status: 'SCHEDULED', priority: 'High', franchiseCity: 'City Health', scheduledTime: '10:30 AM' },
                { tenantId: 't1', patientName: 'S. Conor', status: 'SCHEDULED', priority: 'High', franchiseCity: 'Bayview', scheduledTime: '01:15 PM' },
             ]
          });
       }

       const upcomings = await c.var.prisma.patientIntake.findMany({
         where: { status: 'SCHEDULED' },
         orderBy: { scheduledTime: 'asc' }
       });
       return c.json({ upcomings: upcomings.map((a: any) => ({ ...a, scheduledTime: a.scheduledTime || 'TBD' })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default intakeUpcomingList;
