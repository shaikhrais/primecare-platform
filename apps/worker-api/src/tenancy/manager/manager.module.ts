import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireAuth } from '../../_shared/middleware/auth';
import { requireAnyPermission } from '../../_shared/middleware/rbac';
import dashboardRoutes from './dashboard/dashboard.routes';
import financeRoutes from './finance/finance.routes';
import managerOpsRoutes from './manager_ops.routes';
import reviewRoutes from './reviews/reviews.routes';
import trainingAdminRoutes from './training/training.routes';

const manager = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Manager module-level middleware
manager.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});
manager.use('*', requireAnyPermission(['view_dashboard', 'manage_schedule']));

// Routes
manager.route('/dashboard', dashboardRoutes);
manager.route('/finance', financeRoutes);
manager.route('/ops', managerOpsRoutes);
manager.route('/reviews', reviewRoutes);
manager.route('/training', trainingAdminRoutes);

export default manager;
