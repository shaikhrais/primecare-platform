import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const supportAgentsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const AgentSchema = z.object({
  id: z.string(),
  agentName: z.string(),
  shiftTime: z.string(),
  activeTickets: z.number(),
  status: z.string(),
});

supportAgentsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Support Agents availability',
        content: {
          'application/json': {
            schema: z.object({
              agents: z.array(AgentSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.supportAgentNode.count();
       if (count === 0) {
          await c.var.prisma.supportAgentNode.createMany({
             data: [
                { tenantId: 't1', agentName: 'Dr. Sarah Chen', shiftTime: '08:00 AM - 04:00 PM', activeTickets: 3, status: 'Online' },
                { tenantId: 't1', agentName: 'Marcus T', shiftTime: '10:00 AM - 06:00 PM', activeTickets: 1, status: 'Online' },
                { tenantId: 't1', agentName: 'Jessica R', shiftTime: '12:00 PM - 08:00 PM', activeTickets: 4, status: 'Busy' },
                { tenantId: 't1', agentName: 'Tom Harding', shiftTime: '04:00 PM - 12:00 AM', activeTickets: 0, status: 'Offline' },
             ]
          });
       }

       const items = await c.var.prisma.supportAgentNode.findMany({
         orderBy: { agentName: 'asc' }
       });
       return c.json({ agents: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default supportAgentsList;
