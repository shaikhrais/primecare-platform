import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../';
import { requireAuth } from '../../middleware/auth';
import { requireRole } from '../../middleware/rbac';
import dashboardRoutes from './dashboard/dashboard.routes';

const manager = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

/ Manager module-level middleware
manager.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});
manager.use('*', requireRole(['manager', 'admin']));

/ Routes
manager.route('/dashboard', dashboardRoutes);

export default manager;
