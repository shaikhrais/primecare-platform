import { Hono } from 'hono';
import { Bindings, Variables } from '../../bindings';
import { logAudit } from '../../_shared/utils/audit';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

r.put('/upload', async (c) => {
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

        return c.json({ key, url: `/v1/storage/file/${key}` });
    } catch (e: any) {
        return c.json({ error: e.message }, 500);
    }
});

r.get('/file/:key', async (c) => {
    const key = c.req.param('key');
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
