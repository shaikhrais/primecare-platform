import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const opsIssuesList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const IssueSchema = z.object({
  id: z.string(),
  title: z.string(),
  description: z.string(),
  facilityName: z.string(),
  severity: z.string(),
  status: z.string(),
  createdAt: z.string(),
});

opsIssuesList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all Operations Issues',
        content: {
          'application/json': {
            schema: z.object({
              issues: z.array(IssueSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.opsIssueTicket.count();
       if (count === 0) {
          await c.var.prisma.opsIssueTicket.createMany({
             data: [
                { tenantId: 't1', title: 'HVAC Failure in Lobby', description: 'AC unit blowing hot air', facilityName: 'Downtown Care', severity: 'High', status: 'Reported' },
                { tenantId: 't1', title: 'Network Outage (Ward 3)', description: 'WiFi disconnects every 5 mins', facilityName: 'South Ward', severity: 'Critical', status: 'Dispatched' },
                { tenantId: 't1', title: 'Plumbing Leak', description: 'Restroom sink leaking', facilityName: 'North Regional', severity: 'Medium', status: 'Resolved' },
                { tenantId: 't1', title: 'Bio-waste Pickup Delayed', description: 'Schedule pickup missed', facilityName: 'Downtown Care', severity: 'Medium', status: 'Reported' },
             ]
          });
       }

       const issues = await c.var.prisma.opsIssueTicket.findMany({
         orderBy: { createdAt: 'desc' }
       });
       return c.json({ issues: issues.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any) {
       console.error(e);
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

// Bonus functionality: Kanban Drag & Drop state
opsIssuesList.openapi(
  createRoute({
    method: 'put',
    path: '/{id}',
    request: {
      params: z.object({ id: z.string() }),
      body: {
        content: {
          'application/json': { schema: z.object({ status: z.string() }) },
        },
      },
    },
    responses: {
      200: { description: 'Updated Issue' },
    },
  }),
  async (c) => {
    try {
      const { id } = c.req.valid('param');
      const { status } = c.req.valid('json');
      await c.var.prisma.opsIssueTicket.update({
        where: { id },
        data: { status }
      });
      return c.json({ success: true });
    } catch (e) {
      return c.json({ error: 'Failed to update' }, 500 as any);
    }
  }
);

export default opsIssuesList;
