import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const franchiseActivitiesList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ActivitySchema = z.object({
  id: z.string(),
  eventTitle: z.string(),
  eventType: z.string(),
  eventTime: z.string(),
});

franchiseActivitiesList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Local Audit Trail',
        content: {
          'application/json': {
            schema: z.object({
              activities: z.array(ActivitySchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.localActivityNode.count();
       if (count === 0) {
          await c.var.prisma.localActivityNode.createMany({
             data: [
                { tenantId: 't1', eventTitle: 'Clinic updates Hamilton Healthcare.', eventType: 'Business', eventTime: '11 minutes ago' },
                { tenantId: 't1', eventTitle: 'Clinic updates staff changed themes.', eventType: 'Edit', eventTime: '20 minutes ago' },
                { tenantId: 't1', eventTitle: 'Security clearance review passed.', eventType: 'Audit', eventTime: '1 hour ago' },
             ]
          });
       }

       const items = await c.var.prisma.localActivityNode.findMany({
         orderBy: { createdAt: 'desc' }
       });
       return c.json({ activities: items });
    } catch (e: any) {
       console.error(e);
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default franchiseActivitiesList;
