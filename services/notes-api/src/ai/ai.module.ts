import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { requireAuth, requireRole } from '@primecare/security';
import { Bindings, Variables } from '@primecare/contracts';

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Baseline security
app.use('*', async (c, next) => {
    const auth = requireAuth(c.env.JWT_SECRET);
    return await auth(c, next);
});

// AI Insights require COORDINATOR or superior authority
app.use('*', requireRole('COORDINATOR'));

app.openapi(createRoute({
    method: 'get',
    path: '/optimizer-preview',
    responses: { 200: { description: 'Optimizer Results', content: { 'application/json': { schema: z.any() } } } }
}), async (c) => {
    return c.json({ status: 'Optimizer engine active', insights: [] }, 200);
});

export default app;
