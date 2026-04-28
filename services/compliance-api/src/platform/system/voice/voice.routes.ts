import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { ROUTE_METADATA } from '@primecare/infrastructure';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// R10: Voice upload validation constants
const MAX_VOICE_SIZE = 5 * 1024 * 1024; // 5MB
const ALLOWED_VOICE_TYPES = ['audio/webm', 'audio/ogg', 'audio/mp4', 'audio/mpeg', 'audio/wav', 'audio/x-wav'];

const uploadVoiceRoute = createRoute({
    ...ROUTE_METADATA.SYSTEM.VOICE,
    method: 'post',
    path: '/upload',
    summary: 'Upload Voice',
    tags: ['System', 'Voice'],
    request: {
        body: {
            content: {
                'multipart/form-data': {
                    schema: z.object({
                        file: z.instanceof(File).openapi({ type: 'string', format: 'binary' }),
                        userId: z.string(),
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        success: z.boolean(),
                        url: z.string(),
                    }),
                },
            },
            description: 'Voice note uploaded successfully',
        },
        400: { description: 'Bad request' },
        413: { description: 'File too large' },
        500: { description: 'Internal server error' },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(uploadVoiceRoute, async (c) => {
    try {
        const body = await c.req.parseBody();
        const file = body['file'];
        const userId = body['userId'] as string;

        if (!file || !(file instanceof File)) {
            return c.json({ error: 'No file uploaded' }, 400);
        }

        if (!userId) {
            return c.json({ error: 'Missing userId' }, 400);
        }

        // R10: Validate file size
        if (file.size > MAX_VOICE_SIZE) {
            return c.json({ error: `File too large. Maximum: ${MAX_VOICE_SIZE / 1024 / 1024}MB` }, 413);
        }

        // R10: Validate content type
        if (!ALLOWED_VOICE_TYPES.includes(file.type)) {
            return c.json({ error: 'Invalid file type. Only audio files allowed.' }, 400);
        }

        // R10: Generate safe filename — NO user-controlled input in storage path
        const ext = file.type.split('/')[1] || 'webm';
        const safeFilename = `voice/${userId}/${Date.now()}_${crypto.randomUUID().slice(0, 8)}.${ext}`;

        await c.env.DOCS_BUCKET.put(safeFilename, await file.arrayBuffer(), {
            httpMetadata: {
                contentType: file.type,
            }
        });

        const publicUrl = `/v1/system/storage/file/${safeFilename}`;

        const id = c.env.CHAT_SERVER.idFromName(userId);
        const stub = c.env.CHAT_SERVER.get(id);
        await stub.fetch(new Request('https://worker/broadcast', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                message: publicUrl,
                type: 'audio',
                sender: 'user'
            })
        }));

        return c.json({ success: true, url: publicUrl }, 200);

    } catch (e) {
        // R10: Don't leak internal errors
        return c.json({ error: 'Upload failed' }, 500);
    }
});

export default r;
