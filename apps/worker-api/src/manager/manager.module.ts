import { Hono } from 'hono';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';
import { tenantMiddleware } from '../_shared/middleware/tenant';
import { requireRole } from '../_shared/middleware/rbac';
import dashboardRoutes from './dashboard/dashboard.routes';

const manager = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// Manager module-level middleware
manager.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});
manager.use('*', tenantMiddleware());
manager.use('*', requireRole(['manager', 'admin']));

// Routes
manager.route('/dashboard', dashboardRoutes);

export default manager;
