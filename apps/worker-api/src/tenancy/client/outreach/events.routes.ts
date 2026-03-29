import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const outreachEventsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const EventSchema = z.object({
  id: z.string(),
  eventName: z.string(),
  location: z.string(),
  scheduledDate: z.string(),
  status: z.string(),
  participantGoal: z.number(),
  createdAt: z.string(),
});

outreachEventsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Outreach Events',
        content: {
          'application/json': {
            schema: z.object({
              events: z.array(EventSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.outreachEventNode.count();
       if (count === 0) {
          const now = new Date();
          await c.var.prisma.outreachEventNode.createMany({
             data: [
                { tenantId: 't1', eventName: 'City Health Fair', location: 'Downtown Square', scheduledDate: new Date(now.setHours(now.getHours() - 17)), status: 'Active', participantGoal: 1650 },
                { tenantId: 't1', eventName: 'Vaccination Drive', location: 'North High School', scheduledDate: new Date(now.setDate(now.getDate() + 12)), status: 'Upcoming', participantGoal: 1176 },
                { tenantId: 't1', eventName: 'Seniors Nutrition', location: 'River Valley Center', scheduledDate: new Date(now.setDate(now.getDate() - 30)), status: 'Completed', participantGoal: 355 },
             ]
          });
       }

       const items = await c.var.prisma.outreachEventNode.findMany({
         orderBy: { scheduledDate: 'asc' }
       });

       return c.json({ events: items.map((a: any) => ({ ...a, scheduledDate: a.scheduledDate.toISOString(), createdAt: a.createdAt.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default outreachEventsList;
