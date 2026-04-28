import { DurableObject } from 'cloudflare:workers';

/**
 * RealtimeSync Durable Object 
 * Acts as a centralized WebSocket hub for a specific Tenant, forwarding 
 * real-time REST API mutations (visits, dispatch, telemetry) to connected 
 * web-admin frontend homes.
 */
export class RealtimeSync extends DurableObject {
    sessions: Map<WebSocket, { userId: string; role: string }>;

    constructor(ctx: DurableObjectState, env: Env) {
        super(ctx, env);
        this.sessions = new Map();
    }

    async fetch(request: Request): Promise<Response> {
        const url = new URL(request.url);

        // 1) WebSocket Upgrade Connection from Frontend clients
        if (url.pathname === '/websocket') {
            const upgradeHeader = request.headers.get('Upgrade');
            if (!upgradeHeader || upgradeHeader !== 'websocket') {
                return new Response('Expected Upgrade: websocket', { status: 426 });
            }

            // Authentication validation
            const token = url.searchParams.get('token');
            const userId = url.searchParams.get('userId') || 'system';
            const role = url.searchParams.get('role') || 'unknown';

            if (!token) {
                return new Response('Unauthorized: Missing token', { status: 401 });
            }

            const webSocketPair = new WebSocketPair();
            const [client, server] = Object.values(webSocketPair) as [WebSocket, WebSocket];

            this.ctx.acceptWebSocket(server);
            this.sessions.set(server, { userId, role });

            return new Response(null, {
                status: 101,
                webSocket: client,
            });
        }

        // 2) Internal REST Broadcast (API hits this to push changes to the map)
        if (url.pathname === '/broadcast') {
            const body = await request.text();
            this.broadcast(body);
            return new Response('Broadcast successful', { status: 200 });
        }

        if (url.pathname === '/status') {
            return new Response(JSON.stringify({
                activeConnections: this.sessions.size,
                memoryUsage: process.memoryUsage?.() || {},
            }), { headers: { 'Content-Type': 'application/json' } });
        }

        return new Response('Not found', { status: 404 });
    }

    async webSocketMessage(ws: WebSocket, message: string | ArrayBuffer) {
        // Echo or process client messages if interactive WebSocket is needed
        // For basic telemetry syncs, clients usually only listen.
    }

    async webSocketClose(ws: WebSocket, code: number, reason: string, wasClean: boolean) {
        this.sessions.delete(ws);
        ws.close(code, "Connection closed");
    }

    async webSocketError(ws: WebSocket, error: any) {
        this.sessions.delete(ws);
        ws.close(1011, "Internal Error");
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
    // Environment bindings specific to this DO
}
