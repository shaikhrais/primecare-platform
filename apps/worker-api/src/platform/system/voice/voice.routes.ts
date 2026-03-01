import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const uploadVoiceRoute = createRoute({
    ...ROUTE_METADATA.SYSTEM.VOICE,
    method: 'post',
    path: '/upload',
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
        400: {
            description: 'Bad request (missing file or userId)',
        },
        500: {
            description: 'Internal server error',
        },
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

        const filename = `voice/${userId}/${Date.now()}_${file.name}`;

        await c.env.DOCS_BUCKET.put(filename, await file.arrayBuffer(), {
            httpMetadata: {
                contentType: file.type,
            }
        });

        const publicUrl = `/v1/system/storage/file/${filename}`;

        const id = c.env.CHAT_SERVER.idFromName(userId);
        const stub = c.env.CHAT_SERVER.get(id);
        await stub.fetch(new Request('https:/worker/broadcast', {
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
        console.error('Upload error', e);
        return c.json({ error: 'Upload failed' }, 500);
    }
});

export default r;
