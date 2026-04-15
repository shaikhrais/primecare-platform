import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { logAudit } from '@primecare/infrastructure';
import { ROUTE_METADATA } from '@primecare/infrastructure';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// R9: File upload validation constants
const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
const ALLOWED_CONTENT_TYPES = [
    'image/jpeg', 'image/png', 'image/gif', 'image/webp', 'image/svg+xml',
    'application/pdf',
    'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'text/csv', 'text/plain',
    'application/octet-stream', // fallback for unknown types
];

const StorageParamsSchema = z.object({
    key: z.string().openapi({ param: { name: 'key', in: 'path' } }),
});

const uploadFileRoute = createRoute({
    ...ROUTE_METADATA.SYSTEM.STORAGE_UPLOAD,
    method: 'put',
    path: '/upload',
    summary: 'Upload File',
    tags: ['System', 'Storage'],
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
        400: { description: 'Invalid file' },
        413: { description: 'File too large' },
        500: { description: 'Internal server error' },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(uploadFileRoute, async (c) => {
    const bucket = c.env.DOCS_BUCKET;
    const contentType = c.req.header('content-type') || 'application/octet-stream';

    // R9: Validate content type
    if (!ALLOWED_CONTENT_TYPES.includes(contentType)) {
        return c.json({ error: 'File type not allowed', allowed: ALLOWED_CONTENT_TYPES }, 400);
    }

    const body = await c.req.arrayBuffer();

    // R9: Validate file size
    if (body.byteLength > MAX_FILE_SIZE) {
        return c.json({ error: `File too large. Maximum size: ${MAX_FILE_SIZE / 1024 / 1024}MB` }, 413);
    }

    if (body.byteLength === 0) {
        return c.json({ error: 'Empty file' }, 400);
    }

    // R9: Generate safe key — no user-controlled filenames in storage path
    const ext = contentType.split('/')[1]?.replace('vnd.openxmlformats-officedocument.wordprocessingml.document', 'docx')
        .replace('vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'xlsx')
        .replace('vnd.ms-excel', 'xls')
        .replace('msword', 'doc') || 'bin';
    const key = `${Date.now()}-${crypto.randomUUID().slice(0, 8)}.${ext}`;

    try {
        await bucket.put(key, body, {
            httpMetadata: { contentType },
        });

        const payload = c.get('jwtPayload');
        const prisma = c.get('prisma');
        await logAudit(prisma, payload.sub, 'UPLOAD_FILE', 'DOCS', key, {
            filename: c.req.header('x-filename') || key,
            size: body.byteLength,
            contentType,
        });

        return c.json({ key, url: `/v1/storage/file/${key}` }, 200);
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
        // R9: Don't leak internal errors
        return c.json({ error: 'File upload failed' }, 500);
    }
});

const getFileRoute = createRoute({
    ...ROUTE_METADATA.SYSTEM.STORAGE_GET,
    method: 'get',
    path: '/file/{key}',
    summary: 'Get File',
    tags: ['System', 'Storage'],
    request: {
        params: StorageParamsSchema,
    },
    responses: {
        200: { description: 'File content' },
        404: { description: 'File not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(getFileRoute, async (c) => {
    const { key } = c.req.valid('param');
    const bucket = c.env.DOCS_BUCKET;

    // R9: Prevent path traversal in key
    if (key.includes('..') || key.includes('/') || key.includes('\\')) {
        return c.json({ error: 'Invalid file key' }, 400);
    }

    const object = await bucket.get(key);
    if (!object) {
        return c.json({ error: 'File not found' }, 404);
    }

    const headers = new Headers();
    object.writeHttpMetadata(headers);
    headers.set('etag', object.httpEtag);
    // R9: Prevent inline execution of uploaded files
    headers.set('Content-Disposition', 'attachment');
    headers.set('X-Content-Type-Options', 'nosniff');

    return new Response(object.body, { headers });
});

export default r;
