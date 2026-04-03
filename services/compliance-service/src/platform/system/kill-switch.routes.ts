import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireRole } from '@primecare/shared-auth';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const engageRoute = createRoute({
    method: 'post',
    path: '/engage',
    summary: 'Engage Digital Kill Switch',
    description: 'Triggers emergency shutdown of active node connections (Simulated).',
    tags: ['System', 'Security'],
    middleware: [requireRole(['admin'])],
    responses: {
        200: {
            content: { 'application/json': { schema: z.object({ message: z.string(), status: z.string() }) } },
            description: 'Shutdown Engaged',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

const disengageRoute = createRoute({
    method: 'post',
    path: '/disengage',
    summary: 'Disengage Digital Kill Switch',
    description: 'Attempts to restart the cluster safely (Simulated).',
    tags: ['System', 'Security'],
    middleware: [requireRole(['admin'])],
    responses: {
        200: {
            content: { 'application/json': { schema: z.object({ message: z.string(), status: z.string() }) } },
            description: 'Reboot Initiated',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(engageRoute, async (c) => {
    // In reality this would sever websocket pools and instruct cloudflare D1 to zero-scale down or similar 
    return c.json({ message: 'CRITICAL SECURITY PROTOCOL ENGAGED. Connections severed.', status: 'STATIC_MODE' }, 200);
});

r.openapi(disengageRoute, async (c) => {
    // Allows traffic to route normally once again
    return c.json({ message: 'Digital kill switch disengaged. Re-establishing routing...', status: 'ONLINE' }, 200);
});

export default r;
