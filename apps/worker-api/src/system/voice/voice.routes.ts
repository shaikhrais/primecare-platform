import { Hono } from 'hono';
import { Bindings, Variables } from '../../bindings';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

r.post('/upload', async (c) => {
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

        // Dummy R2 domain or custom worker endpoint
        const publicUrl = `/v1/system/storage/file/${filename}`;

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

        return c.json({ success: true, url: publicUrl });

    } catch (e) {
        console.error('Upload error', e);
        return c.json({ error: 'Upload failed' }, 500);
    }
});

export default r;
