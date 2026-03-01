import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../';
import { logAudit } from '../../../utils/audit';
import { ROUTE_METADATA } from '../../../constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const StorageParamsSchema = z.object({
    key: z.string().openapi({ param: { name: 'key', in: 'path' } }),
});

const uploadFileRoute = createRoute({
    ...ROUTE_METADATA.SYSTEM.STORAGE_UPLOAD,
    method: 'put',
    path: '/upload',
    request: {
        body: {
            content: {
                'application/octet-stream': {
                    schema: z.object({}), // Binary data
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        key: z.string(),
                        url: z.string(),
                    }),
                },
            },
            description: 'File uploaded successfully',
        },
        500: {
            description: 'Internal server error',
        },
    },
});

r.openapi(uploadFileRoute, async (c) => {
    const bucket = c.env.DOCS_BUCKET;
    const key = `${Date.now()}-${Math.random().toString(36).substring(7)}`;
    const body = await c.req.arrayBuffer();
    const contentType = c.req.header('content-type') || 'application/octet-stream';

    try {
        await bucket.put(key, body, {
            httpMetadata: { contentType },
        });

        const payload = c.get('jwtPayload');
        const prisma = c.get('prisma');
        await logAudit(prisma, payload.sub, 'UPLOAD_FILE', 'DOCS', key, { filename: c.req.header('x-filename') || key });

        return c.json({ key, url: `/v1/storage/file/${key}` }, 200);
    } catch (e: any) {
        return c.json({ error: e.message }, 500);
    }
});

const getFileRoute = createRoute({
    ...ROUTE_METADATA.SYSTEM.STORAGE_GET,
    method: 'get',
    path: '/file/{key}',
    request: {
        params: StorageParamsSchema,
    },
    responses: {
        200: {
            description: 'File content',
        },
        404: {
            description: 'File not found',
        },
    },
});

r.openapi(getFileRoute, async (c) => {
    const { key } = c.req.valid('param');
    const bucket = c.env.DOCS_BUCKET;

    const object = await bucket.get(key);
    if (!object) {
        return c.json({ error: 'File not found' }, 404);
    }

    const headers = new Headers();
    object.writeHttpMetadata(headers);
    headers.set('etag', object.httpEtag);

    return new Response(object.body, {
        headers,
    });
});

export default r;
