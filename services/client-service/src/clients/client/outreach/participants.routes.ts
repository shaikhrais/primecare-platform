import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const outreachParticipantsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ParticipantMetricSchema = z.object({
  id: z.string(),
  metricDate: z.string(),
  totalReached: z.number(),
  engagementScore: z.number(),
  healthScreened: z.number(),
});

outreachParticipantsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets outreach participant engagement metrics',
        content: {
          'application/json': {
            schema: z.object({
              metrics: z.array(ParticipantMetricSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.participantMetricNode.count();
       if (count === 0) {
          await c.var.prisma.participantMetricNode.createMany({
             data: [
                { tenantId: 't1', metricDate: 'Oct 2023', totalReached: 12500, engagementScore: 84.5, healthScreened: 3500 },
                { tenantId: 't1', metricDate: 'Nov 2023', totalReached: 13200, engagementScore: 86.2, healthScreened: 4100 },
                { tenantId: 't1', metricDate: 'Dec 2023', totalReached: 14892, engagementScore: 89.1, healthScreened: 4900 },
             ]
          });
       }

       const items = await c.var.prisma.participantMetricNode.findMany({
         orderBy: { metricDate: 'desc' }
       });
       
       return c.json({ metrics: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default outreachParticipantsList;
