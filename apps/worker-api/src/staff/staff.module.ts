import { Hono } from 'hono';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';
import { tenantMiddleware } from '../_shared/middleware/tenant';
import { requireRole } from '../_shared/middleware/rbac';
import schedulingRoutes from './scheduling/scheduling.routes';
import supportRoutes from './support/support.routes';

const staff = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// Staff module-level middleware
staff.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});
staff.use('*', tenantMiddleware());
staff.use('*', requireRole(['staff', 'coordinator', 'admin']));

// Routes
staff.route('/', schedulingRoutes);
staff.route('/', supportRoutes);

export default staff;
