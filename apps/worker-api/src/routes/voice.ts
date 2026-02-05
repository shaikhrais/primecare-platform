
import { Hono } from 'hono';

type Bindings = {
    DOCS_BUCKET: R2Bucket;
    CHAT_SERVER: DurableObjectNamespace;
};

const app = new Hono<{ Bindings: Bindings }>();

app.post('/upload', async (c) => {
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

        // Generate unique filename
        const filename = `voice/${userId}/${Date.now()}_${file.name}`;

        // Upload to R2
        await c.env.DOCS_BUCKET.put(filename, await file.arrayBuffer(), {
            httpMetadata: {
                contentType: file.type,
            }
        });

        // Construct Public URL (Assuming standard R2 public access or custom domain)
        // You might need to configure a custom domain for R2 in dashboard
        // For now, let's assume a placeholder or mapped domain
        const publicUrl = `https://pub-your-r2-domain.dev/${filename}`;

        // Trigger n8n Webhook
        // We can do this here, or rely on the frontend to send the link?
        // Better to do it here to ensure backend verification
        const n8nWebhookUrl = 'https://YOUR_N8N_INSTANCE/webhook/voice-chat'; // Replace with actual

        // Optional: Call n8n. If n8n is not set up yet, we just return the URL
        // await fetch(n8nWebhookUrl, {
        //     method: 'POST',
        //     headers: {'Content-Type': 'application/json'},
        //     body: JSON.stringify({ userId, audioUrl: publicUrl })
        // });

        // Also broadcast to the user's chat (echo)
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

export default app;
