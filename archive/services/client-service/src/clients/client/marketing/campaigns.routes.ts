import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const marketingCampaignsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const CampaignSchema = z.object({
  id: z.string(),
  campaignName: z.string(),
  platform: z.string(),
  spend: z.number(),
  revenue: z.number(),
  leads: z.number(),
  status: z.string(),
  createdAt: z.string(),
});

marketingCampaignsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all active Marketing Campaigns',
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
       const count = await c.var.prisma.marketingCampaignNode.count();
       if (count === 0) {
          await c.var.prisma.marketingCampaignNode.createMany({
             data: [
                { tenantId: 't1', campaignName: 'Q4 Healthcare Open Enrollment', platform: 'Google Ads', spend: 45000, revenue: 185000, leads: 540, status: 'Active' },
                { tenantId: 't1', campaignName: 'Family Wellness Retargeting', platform: 'Social', spend: 12000, revenue: 42000, leads: 310, status: 'Active' },
                { tenantId: 't1', campaignName: 'Geriatric Fall Prevention', platform: 'Email', spend: 800, revenue: 17000, leads: 85, status: 'Active' },
                { tenantId: 't1', campaignName: 'Q3 Brand Awareness', platform: 'Social', spend: 55000, revenue: 98000, leads: 1120, status: 'Completed' },
             ]
          });
       }

       const camps = await c.var.prisma.marketingCampaignNode.findMany({
         orderBy: { spend: 'desc' }
       });

       return c.json({ campaigns: camps.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default marketingCampaignsList;
