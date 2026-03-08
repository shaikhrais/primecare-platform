import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireAuth } from '../../_shared/middleware/auth';
import { requireRole } from '../../_shared/middleware/rbac';
import dashboardRoutes from './dashboard/dashboard.routes';
import financeRoutes from './finance/finance.routes';
import managerOpsRoutes from './manager_ops.routes';
import reviewRoutes from './reviews/reviews.routes';

const manager = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Manager module-level middleware
manager.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});
manager.use('*', requireRole(['manager', 'admin']));

// Routes
manager.route('/dashboard', dashboardRoutes);
manager.route('/finance', financeRoutes);
manager.route('/ops', managerOpsRoutes);
manager.route('/reviews', reviewRoutes);

export default manager;
