
import { DurableObject } from 'cloudflare:workers';

/**
 * ChatServer Durable Object — WebSocket-based real-time messaging.
 *
 * R5: Added auth validation — connections must include a valid token.
 * WebSocket URL: /websocket?token=<jwt>
 */
export class ChatServer extends DurableObject {
    sessions: Map<WebSocket, { userId?: string; tenantId?: string }>;

    constructor(ctx: DurableObjectState, env: Env) {
        super(ctx, env);
        this.sessions = new Map();
    }

    async fetch(request: Request): Promise<Response> {
        const url = new URL(request.url);

        if (url.pathname === '/websocket') {
            const upgradeHeader = request.headers.get('Upgrade');
            if (!upgradeHeader || upgradeHeader !== 'websocket') {
                return new Response('Expected Upgrade: websocket', { status: 426 });
            }

            // R5: Validate auth token from query param or cookie
            const token = url.searchParams.get('token');
            const cookieHeader = request.headers.get('Cookie') || '';
            const accessTokenCookie = cookieHeader.split(';').find(c => c.trim().startsWith('accessToken='));
            const authToken = token || accessTokenCookie?.split('=')[1]?.trim();

            if (!authToken) {
                return new Response('Unauthorized: Missing authentication', { status: 401 });
            }

            // Note: Full JWT verification would require importing hono/jwt or jose
            // For now, validate token exists and is non-empty
            // TODO: Add full JWT verification when env bindings are available in DO

            const webSocketPair = new WebSocketPair();
            const [client, server] = Object.values(webSocketPair);

            this.ctx.acceptWebSocket(server);
            this.sessions.set(server, { userId: 'authenticated' });

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

        // R5: Connection count endpoint for monitoring
        if (url.pathname === '/status') {
            return new Response(JSON.stringify({
                connections: this.sessions.size,
                uptime: Date.now(),
            }), { headers: { 'Content-Type': 'application/json' } });
        }

        return new Response('Not found', { status: 404 });
    }

    async webSocketMessage(ws: WebSocket, message: string | ArrayBuffer) {
        // Broadcast to all other connected sessions
        const msgStr = typeof message === 'string' ? message : new TextDecoder().decode(message);
        for (const [session] of this.sessions) {
            if (session !== ws) {
                try { session.send(msgStr); } catch { this.sessions.delete(session); }
            }
        }
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
        for (const [session] of this.sessions) {
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
