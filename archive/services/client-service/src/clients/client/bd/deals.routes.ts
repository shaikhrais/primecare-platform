import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const bdDealsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const DealSchema = z.object({
  id: z.string(),
  dealName: z.string(),
  facilityTarget: z.string(),
  amount: z.number(),
  stage: z.string(),
  repName: z.string(),
  createdAt: z.string(),
});

bdDealsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all active BD Deals',
        content: {
          'application/json': {
            schema: z.object({
              deals: z.array(DealSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.salesDealNode.count();
       if (count === 0) {
          await c.var.prisma.salesDealNode.createMany({
             data: [
                { tenantId: 't1', dealName: 'Regional Network Expansion', facilityTarget: 'NY Clinic 5', amount: 3100000, stage: 'Discovery', repName: 'Sarah J.' },
                { tenantId: 't1', dealName: 'South Ward takeover', facilityTarget: 'South Ward 2', amount: 2600000, stage: 'Evaluation', repName: 'Michael R.' },
                { tenantId: 't1', dealName: 'East Coast Licensing', facilityTarget: 'East Clinic', amount: 1900000, stage: 'Proposal', repName: 'Sarah J.' },
                { tenantId: 't1', dealName: 'Downtown Partnership', facilityTarget: 'Downtown Hub 3', amount: 1020000, stage: 'Closed Won', repName: 'Emma L.' },
             ]
          });
       }

       const dealsRaw = await c.var.prisma.salesDealNode.findMany({
         orderBy: { amount: 'desc' }
       });

       return c.json({ deals: dealsRaw.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

// Drag and drop status implementation
bdDealsList.openapi(
  createRoute({
    method: 'put',
    path: '/{id}',
    request: {
      params: z.object({ id: z.string() }),
      body: {
        content: {
          'application/json': { schema: z.object({ stage: z.string() }) },
        },
      },
    },
    responses: {
      200: { description: 'Updated Deal' },
    },
  }),
  async (c) => {
    try {
      const { id } = c.req.valid('param');
      const { stage } = c.req.valid('json');
      await c.var.prisma.salesDealNode.update({
        where: { id },
        data: { stage }
      });
      return c.json({ success: true });
    } catch (e) {
      return c.json({ error: 'Failed to update' }, 500 as any);
    }
  }
);

export default bdDealsList;
