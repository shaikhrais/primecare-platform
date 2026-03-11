import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireAuth } from '../../_shared/middleware/auth';
import { requireRole } from '../../_shared/middleware/rbac';
import auditRoutes from './audit.routes';
import responseBotRoutes from './response-bot.routes';

const sm = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Scrum Master module-level middleware
sm.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});
sm.use('*', requireRole(['admin', 'scrum_master']));

// Routes
sm.route('/', auditRoutes);
sm.route('/registry', responseBotRoutes);

export default sm;
