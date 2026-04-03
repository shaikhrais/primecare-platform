import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const supportVolumeList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const VolumeSchema = z.object({
  id: z.string(),
  hourlyMark: z.string(),
  inboundCount: z.number(),
  resolvedCount: z.number(),
});

supportVolumeList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Ticket Volume logs',
        content: {
          'application/json': {
            schema: z.object({
              volumes: z.array(VolumeSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.ticketVolumeNode.count();
       if (count === 0) {
          await c.var.prisma.ticketVolumeNode.createMany({
             data: [
                { tenantId: 't1', hourlyMark: '08:00 AM', inboundCount: 12, resolvedCount: 5 },
                { tenantId: 't1', hourlyMark: '10:00 AM', inboundCount: 25, resolvedCount: 18 },
                { tenantId: 't1', hourlyMark: '12:00 PM', inboundCount: 15, resolvedCount: 20 },
                { tenantId: 't1', hourlyMark: '02:00 PM', inboundCount: 8, resolvedCount: 10 },
             ]
          });
       }

       const items = await c.var.prisma.ticketVolumeNode.findMany({
         orderBy: { hourlyMark: 'asc' }
       });
       return c.json({ volumes: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default supportVolumeList;
