import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const marketingContentList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ContentSchema = z.object({
  id: z.string(),
  assetName: z.string(),
  assetType: z.string(),
  author: z.string(),
  status: z.string(),
  thumbnailUrl: z.string().nullable(),
  createdAt: z.string(),
});

marketingContentList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Marketing Digital Content Assets',
        content: {
          'application/json': {
            schema: z.object({
              assets: z.array(ContentSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.contentAssetNode.count();
       if (count === 0) {
          await c.var.prisma.contentAssetNode.createMany({
             data: [
                { tenantId: 't1', assetName: 'Fall Prevention Flyer', assetType: 'Print', author: 'Dr. Evans', status: 'Live', thumbnailUrl: 'https://i.pravatar.cc/150?u=1' },
                { tenantId: 't1', assetName: 'Welcome Email Drip', assetType: 'Email', author: 'Mark T.', status: 'Review', thumbnailUrl: 'https://i.pravatar.cc/150?u=2' },
                { tenantId: 't1', assetName: 'Instagram Awareness', assetType: 'Banner', author: 'Sarah J.', status: 'Draft', thumbnailUrl: 'https://i.pravatar.cc/150?u=3' },
                { tenantId: 't1', assetName: 'Facebook Retargeting', assetType: 'Banner', author: 'Emma L.', status: 'Live', thumbnailUrl: 'https://i.pravatar.cc/150?u=4' },
                { tenantId: 't1', assetName: 'Post-Surgery Survey', assetType: 'Email', author: 'Mark T.', status: 'Draft', thumbnailUrl: 'https://i.pravatar.cc/150?u=5' },
             ]
          });
       }

       const assets = await c.var.prisma.contentAssetNode.findMany({
         orderBy: { createdAt: 'desc' }
       });
       return c.json({ assets: assets.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

// Drag and drop status implementation
marketingContentList.openapi(
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
      200: { description: 'Updated Content' },
    },
  }),
  async (c) => {
    try {
      const { id } = c.req.valid('param');
      const { status } = c.req.valid('json');
      await c.var.prisma.contentAssetNode.update({
        where: { id },
        data: { status }
      });
      return c.json({ success: true });
    } catch (e) {
      return c.json({ error: 'Failed to update' }, 500 as any);
    }
  }
);

export default marketingContentList;
