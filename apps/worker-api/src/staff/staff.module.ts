import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';
import { requireRole } from '../_shared/middleware/rbac';
import schedulingRoutes from './scheduling/scheduling.routes';
import supportRoutes from './support/support.routes';
import dashboardRoutes from './dashboard/dashboard.routes';
import customerRoutes from './customers.routes';

const staff = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Staff module-level middleware
staff.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});
staff.use('*', requireRole(['staff', 'coordinator', 'admin']));

// Routes
staff.route('/dashboard', dashboardRoutes);
staff.route('/', schedulingRoutes);
staff.route('/', supportRoutes);
staff.route('/', customerRoutes);

export default staff;
