import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireAuth } from '../../_shared/middleware/auth';
import { requireRole } from '../../_shared/middleware/rbac';
import schedulingRoutes from './scheduling/scheduling.routes';
import supportRoutes from './support/support.routes';
import dashboardRoutes from './dashboard/dashboard.routes';
import customerRoutes from './customers.routes';
import opsRoutes from './ops/ops.routes';
import tasksRoutes from './ops/tasks.routes';
import incidentsRoutes from './ops/incidents.routes';
import messagesRoutes from './messages/messages.routes';

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
staff.route('/ops', opsRoutes);
staff.route('/tasks', tasksRoutes);
staff.route('/ops/incidents', incidentsRoutes);
staff.route('/messages', messagesRoutes);

export default staff;
