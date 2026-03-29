import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const supportFeedbackList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const FeedbackSchema = z.object({
  id: z.string(),
  patientName: z.string(),
  csatScore: z.number(),
  feedbackText: z.string(),
});

supportFeedbackList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets QA resolution feedback logs',
        content: {
          'application/json': {
            schema: z.object({
              feedback: z.array(FeedbackSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.resolutionFeedbackNode.count();
       if (count === 0) {
          await c.var.prisma.resolutionFeedbackNode.createMany({
             data: [
                { tenantId: 't1', patientName: 'Alyssa K.', csatScore: 5.0, feedbackText: 'Exceptional RN assistance during the transfer.' },
                { tenantId: 't1', patientName: 'John M.', csatScore: 4.5, feedbackText: 'Very helpful, but wait time was slightly long.' },
                { tenantId: 't1', patientName: 'Clara S.', csatScore: 5.0, feedbackText: 'Resolved billing discrepancy completely.' },
                { tenantId: 't1', patientName: 'Unknown', csatScore: 2.0, feedbackText: 'System disconnect on live call.' },
             ]
          });
       }

       const items = await c.var.prisma.resolutionFeedbackNode.findMany({
         orderBy: { createdAt: 'desc' }
       });
       return c.json({ feedback: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default supportFeedbackList;
