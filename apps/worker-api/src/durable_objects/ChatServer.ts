
import { DurableObject } from 'cloudflare:workers';

export class ChatServer extends DurableObject {
    sessions: Set<WebSocket>;

    constructor(ctx: DurableObjectState, env: Env) {
        super(ctx, env);
        this.sessions = new Set();
    }

    async fetch(request: Request): Promise<Response> {
        const url = new URL(request.url);

        if (url.pathname === '/websocket') {
            const upgradeHeader = request.headers.get('Upgrade');
            if (!upgradeHeader || upgradeHeader !== 'websocket') {
                return new Response('Expected Upgrade: websocket', { status: 426 });
            }

            const webSocketPair = new WebSocketPair();
            const [client, server] = Object.values(webSocketPair);

            this.ctx.acceptWebSocket(server);
            this.sessions.add(server);

            return new Response(null, {
                status: 101,
                webSocket: client,
            });
        }

        if (url.pathname === '/broadcast') {
            const body = await request.json() as { message: string, sender: string };
            this.broadcast(JSON.stringify(body));
            return new Response('Sent', { status: 200 });
        }

        return new Response('Not found', { status: 404 });
    }

    async webSocketMessage(ws: WebSocket, message: string | ArrayBuffer) {
        // Simply echo back for now or broadcast to others (optional)
        // For n8n integration, we might want to forward this to n8n webhook
        // via a separate queue or logic if n8n needs to receive user messages.
        // For now, let's assume the client sends to n8n directly via API or 
        // we forward it here.

        // Let's implement basic echo for confirmation
        // ws.send(message); 

        // If we want to forward to n8n from here:
        // await fetch(this.env.N8N_WEBHOOK_URL, { method: 'POST', body: message ... })
    }

    async webSocketClose(ws: WebSocket, code: number, reason: string, wasClean: boolean) {
        this.sessions.delete(ws);
        ws.close(code, "Durable Object is closing WebSocket");
    }

    async webSocketError(ws: WebSocket, error: any) {
        this.sessions.delete(ws);
        ws.close(1011, "Durable Object is closing WebSocket due to error");
    }

    broadcast(message: string) {
        for (const session of this.sessions) {
            try {
                session.send(message);
            } catch (err) {
                this.sessions.delete(session);
            }
        }
    }
}

interface Env {
    // Add bindings if needed here, but main Env is in index.ts
}
