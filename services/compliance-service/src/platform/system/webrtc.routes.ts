import { Hono } from 'hono';
import { Bindings } from '../../bindings';

const webrtcModule = new Hono<{ Bindings: Bindings }>();

/**
 * @route GET /v1/webrtc/signal
 * @description Cloudflare Durable Object WebSocket Forwarder for WebRTC Signaling.
 * Maps SDP (Offer/Answer) and ICE Candidates securely across the Edge.
 */
webrtcModule.get('/signal', async (c) => {
    const upgradeHeader = c.req.header('Upgrade');
    if (upgradeHeader !== 'websocket') {
        return c.json({ error: 'Expected Upgrade: websocket header for signaling.' }, 426);
    }
    
    // Mount the singular Global Triage Room instance 
    const id = c.env.CHAT_SERVER.idFromName('global-triage-room');
    const stub = c.env.CHAT_SERVER.get(id);
    
    // Forward the precise HTTP context into the Durable Object Sandbox
    return await stub.fetch(c.req.raw);
});

export default webrtcModule;
