import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireAuth } from '../../_shared/middleware/auth';
import coordinatorRoutes from './coordinator.routes';

const coordinator = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Coordinator module-level middleware
coordinator.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});

// Routes
coordinator.route('/', coordinatorRoutes);

export default coordinator;
