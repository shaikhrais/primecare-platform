import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const bdAccountsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const AccountSchema = z.object({
  id: z.string(),
  accountName: z.string(),
  contactName: z.string(),
  stage: z.string(),
  potentialValue: z.number(),
  probability: z.number(),
});

bdAccountsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all Key Account CRM Data',
        content: {
          'application/json': {
            schema: z.object({
              accounts: z.array(AccountSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.keyAccountNode.count();
       if (count === 0) {
          await c.var.prisma.keyAccountNode.createMany({
             data: [
                { tenantId: 't1', accountName: 'MedLife Network', contactName: 'Contact J.', stage: 'Success', potentialValue: 33100000, probability: 80 },
                { tenantId: 't1', accountName: 'Regional Health Partners', contactName: 'Costonier R.', stage: 'Discovery', potentialValue: 22600000, probability: 40 },
                { tenantId: 't1', accountName: 'East Coast Medical Group', contactName: 'Danad J.', stage: 'Success', potentialValue: 32600000, probability: 90 },
                { tenantId: 't1', accountName: 'Northern Clinic Assoc.', contactName: 'Michael P.', stage: 'Evaluation', potentialValue: 23500000, probability: 50 },
             ]
          });
       }

       const accounts = await c.var.prisma.keyAccountNode.findMany({
         orderBy: { potentialValue: 'desc' }
       });
       
       return c.json({ accounts });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default bdAccountsList;
