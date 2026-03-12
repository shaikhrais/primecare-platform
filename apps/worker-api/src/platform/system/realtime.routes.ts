import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const connectRoute = createRoute({
    method: 'get',
    path: '/connect',
    summary: 'Upgrade connection to standard WebSocket',
    responses: {
        101: { description: 'Switching Protocols' },
        400: { description: 'Missing Tenant ID' }
    }
});

r.openapi(connectRoute, async (c) => {
    // We expect the tenantId to be inferred from the user session. 
    // In our case we can use `c.get('jwtPayload').tenantId`.
    const tenantId = c.get('jwtPayload')?.tenantId || 'global';
    
    // Grab the Durable Object stub for this specific tenant namespace
    const id = c.env.REALTIME_SYNC.idFromName(tenantId);
    const stub = c.env.REALTIME_SYNC.get(id);

    // Forward the initial HTTP upgrade request to the DO's fetch handler
    // We rewrite the URL path so the DO sees `/websocket`.
    const url = new URL(c.req.url);
    url.pathname = '/websocket';
    
    // Append user identity into query params for the DO to read
    url.searchParams.set('userId', c.get('jwtPayload')?.sub || '');
    url.searchParams.set('role', c.get('jwtPayload')?.activeRole || '');
    url.searchParams.set('token', 'validated'); // JWT already checked by system middleware

    return stub.fetch(new Request(url.toString(), c.req.raw));
});

export default r;
