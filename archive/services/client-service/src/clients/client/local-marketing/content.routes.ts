import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const localContentList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ContentSchema = z.object({
  id: z.string(),
  assetTitle: z.string(),
  assetType: z.string(),
  deployedDate: z.string(),
});

localContentList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Local Content Audit Trail',
        content: {
          'application/json': {
            schema: z.object({
              content: z.array(ContentSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.localContentNode.count();
       if (count === 0) {
          await c.var.prisma.localContentNode.createMany({
             data: [
                { tenantId: 't1', assetTitle: 'Conrticezated Poster', assetType: 'Print', deployedDate: '6utMay 2023-, May 2023 and May 2023' },
                { tenantId: 't1', assetTitle: 'Facebook Ad Banner', assetType: 'Digital', deployedDate: 'Jan 17, 2023' },
             ]
          });
       }

       const items = await c.var.prisma.localContentNode.findMany({
         orderBy: { createdAt: 'desc' }
       });
       return c.json({ content: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default localContentList;
