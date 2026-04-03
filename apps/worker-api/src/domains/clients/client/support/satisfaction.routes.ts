import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const supportSatisfactionList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const SatisfactionSchema = z.object({
  id: z.string(),
  franchiseName: z.string(),
  patientName: z.string(),
  rating: z.number(),
  comments: z.string(),
  status: z.string(),
});

supportSatisfactionList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets patient satisfaction metrics',
        content: {
          'application/json': {
            schema: z.object({
              feedbacks: z.array(SatisfactionSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.patientFeedbackNode.count();
       if (count === 0) {
          await c.var.prisma.patientFeedbackNode.createMany({
             data: [
                { tenantId: 't1', franchiseName: 'Oakwood Clinic', patientName: 'Maria L.', rating: 5, comments: 'Excellent care and very cleanly facility.', status: 'Reviewed' },
                { tenantId: 't1', franchiseName: 'GreenValley Health', patientName: 'John D.', rating: 2, comments: 'Wait times were excessively long.', status: 'Pending' },
                { tenantId: 't1', franchiseName: 'Riverfront Auto Care', patientName: 'Tim B.', rating: 4, comments: 'Good experience but billing was confusing.', status: 'Pending' },
             ]
          });
       }

       const items = await c.var.prisma.patientFeedbackNode.findMany({
         orderBy: { createdAt: 'desc' }
       });
       
       return c.json({ feedbacks: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default supportSatisfactionList;
