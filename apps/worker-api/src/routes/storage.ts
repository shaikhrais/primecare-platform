import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../bindings';
import { authMiddleware } from '../auth';
import { tenantMiddleware } from '../middleware/tenant';
import { logAudit } from '../utils/audit';

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

app.use('*', async (c, next) => {
    const middleware = authMiddleware(c.env.JWT_SECRET);
    await middleware(c, next);
});
app.use('*', tenantMiddleware());

const UploadSchema = z.object({
    filename: z.string(),
    contentType: z.string(),
});

// Generate Signed URL for Upload (Simplified: Direct PUT to Worker for now, or R2 Presigned if using AWS SDK which is heavy. 
// For Workers R2, usually we stream body directly to bucket in a PUT endpoint).
app.put('/upload', async (c) => {
    const bucket = c.env.DOCS_BUCKET;
    const key = `${Date.now()}-${Math.random().toString(36).substring(7)}`; // Simple unique key
    const body = await c.req.arrayBuffer();

    // Header metadata
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

app.get('/file/:key', async (c) => {
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

export default app;
