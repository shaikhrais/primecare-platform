import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireAuth } from '../../_shared/middleware/auth';
import { requireAnyPermission } from '../../_shared/middleware/rbac';
import schedulingRoutes from './scheduling/scheduling.routes';
import supportRoutes from './support/support.routes';
import operationsRoutes from './operations/operations.routes';
import customerRoutes from './customers.routes';
import opsRoutes from './ops/ops.routes';
import tasksRoutes from './ops/tasks.routes';
import incidentsRoutes from './ops/incidents.routes';
import messagesRoutes from './messages/messages.routes';
import alliedHealthRoutes from './allied-health.routes';

const staff = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Staff module-level middleware
staff.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});
staff.use('*', requireAnyPermission(['view_operations', 'view_ops_operations']));

// Routes
staff.route('/operations', operationsRoutes);
staff.route('/', schedulingRoutes);
staff.route('/', supportRoutes);
staff.route('/', customerRoutes);
staff.route('/ops', opsRoutes);
staff.route('/tasks', tasksRoutes);
staff.route('/ops/incidents', incidentsRoutes);
staff.route('/messages', messagesRoutes);
staff.route('/allied', alliedHealthRoutes);

export default staff;
