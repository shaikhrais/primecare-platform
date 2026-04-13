import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const supportTicketsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const TicketSchema = z.object({
  id: z.string(),
  franchiseName: z.string(),
  patientRef: z.string(),
  issueType: z.string(),
  status: z.string(),
  assignedTo: z.string(),
  createdAt: z.string(),
});

supportTicketsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all active Helpdesk Tickets',
        content: {
          'application/json': {
            schema: z.object({
              tickets: z.array(TicketSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.supportTicketNode.count();
       if (count === 0) {
          await c.var.prisma.supportTicketNode.createMany({
             data: [
                { tenantId: 't1', franchiseName: 'GreenValley Health', patientRef: 'John D.', issueType: 'Appointment Scheduling', status: 'In Progress', assignedTo: 'Alex R.' },
                { tenantId: 't1', franchiseName: 'Oakwood Clinic', patientRef: 'Maria L.', issueType: 'Billing Dispute', status: 'Pending', assignedTo: 'Sarah J.' },
                { tenantId: 't1', franchiseName: 'Pioneer Care', patientRef: 'James T.', issueType: 'Clinical Software Bug', status: 'Resolved', assignedTo: 'Tech Team' },
             ]
          });
       }

       const items = await c.var.prisma.supportTicketNode.findMany({
         orderBy: { createdAt: 'desc' }
       });

       return c.json({ tickets: items.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default supportTicketsList;
