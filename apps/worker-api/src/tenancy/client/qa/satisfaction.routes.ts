import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const qaSatisfactionList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const SatisfactionSchema = z.object({
  id: z.string(),
  franchise: z.string(),
  score: z.number(),
  comments: z.string().nullable(),
  type: z.string(),
  createdAt: z.string(),
});

qaSatisfactionList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all QA Satisfaction Trackers',
        content: {
          'application/json': {
            schema: z.object({
              satisfactions: z.array(SatisfactionSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.patientSatisfactionNode.count();
       if (count === 0) {
          await c.var.prisma.patientSatisfactionNode.createMany({
             data: [
                { tenantId: 't1', franchise: 'NY Clinic', score: 5.0, comments: 'Excellent care and fast support!', type: 'Commendation' },
                { tenantId: 't1', franchise: 'North Ward', score: 1.0, comments: 'Rude staff at reception desk.', type: 'Complaint' },
                { tenantId: 't1', franchise: 'Downtown Hub', score: 3.5, comments: 'Wait was a bit long.', type: 'Neutral' },
                { tenantId: 't1', franchise: 'South Ward', score: 4.8, comments: 'Very clean facility.', type: 'Commendation' },
             ]
          });
       }

       const satisfactions = await c.var.prisma.patientSatisfactionNode.findMany({
         orderBy: { createdAt: 'desc' }
       });
       return c.json({ satisfactions: satisfactions.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any) {
       console.error(e);
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default qaSatisfactionList;
