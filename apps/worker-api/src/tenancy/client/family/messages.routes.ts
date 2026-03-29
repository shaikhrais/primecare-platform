import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const familyMessagesList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const FamilyMessageSchema = z.object({
  id: z.string(),
  threadId: z.string(),
  senderName: z.string(),
  senderRole: z.string(),
  content: z.string(),
  timestamp: z.string(),
  isRead: z.boolean(),
});

familyMessagesList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all messages in Family Telehealth Feed',
        content: {
          'application/json': {
            schema: z.object({
              messages: z.array(FamilyMessageSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.familyClinicalMessage.count();
       if (count === 0) {
          const now = new Date();
          await c.var.prisma.familyClinicalMessage.createMany({
             data: [
                { threadId: '1', senderName: 'Dr. Evans', senderRole: 'DOCTOR', content: 'Liams lab results look completely normal. No further action needed.', timestamp: new Date(now.getTime() - 86400000 * 2), isRead: true },
                { threadId: '1', senderName: 'Sarah Jensen', senderRole: 'FAMILY', content: 'Thank you Dr. Evans. Should we still continue the multivitamin?', timestamp: new Date(now.getTime() - 86400000 * 1.8), isRead: true },
                { threadId: '1', senderName: 'Dr. Evans', senderRole: 'DOCTOR', content: 'Yes, continue the multivitamin through winter.', timestamp: new Date(now.getTime() - 86400000 * 1.5), isRead: false },
                { threadId: '2', senderName: 'Nurse Patel', senderRole: 'NURSE', content: 'Routine check-in for Emily. She complained of minor headache yesterday.', timestamp: new Date(now.getTime() - 3600000), isRead: false },
             ]
          });
       }

       const messages = await c.var.prisma.familyClinicalMessage.findMany({
         orderBy: { timestamp: 'desc' }
       });
       return c.json({ messages: messages.map((m: any) => ({ ...m, timestamp: m.timestamp.toISOString() })) });
    } catch (e: any) {
       console.error(e);
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default familyMessagesList;
