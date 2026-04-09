import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const localCampaignsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const CampaignSchema = z.object({
  id: z.string(),
  campaignName: z.string(),
  managerName: z.string(),
  roiFactor: z.number(),
  status: z.string(),
});

localCampaignsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Local Marketing Campaigns',
        content: {
          'application/json': {
            schema: z.object({
              campaigns: z.array(CampaignSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.localCampaignNode.count();
       if (count === 0) {
          await c.var.prisma.localCampaignNode.createMany({
             data: [
                { tenantId: 't1', campaignName: 'Q3 Flu Shots', managerName: 'Sarah Jenkins', roiFactor: 50.2, status: 'Active' },
                { tenantId: 't1', campaignName: 'Back to School', managerName: 'Sarah Jenkins', roiFactor: 45.1, status: 'Pending' },
                { tenantId: 't1', campaignName: 'Summer Checkup', managerName: 'Sarah Jenkins', roiFactor: 50.0, status: 'Active' },
             ]
          });
       }

       const items = await c.var.prisma.localCampaignNode.findMany({
         orderBy: { roiFactor: 'desc' }
       });
       return c.json({ campaigns: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default localCampaignsList;
