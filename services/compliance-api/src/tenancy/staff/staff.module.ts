import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { requireAuth } from '@primecare/security';
import { requireAnyPermission } from '@primecare/security';;
import schedulingRoutes from './scheduling/scheduling.routes';
import supportRoutes from './support/support.routes';
import homeRoutes from './home/home.routes';
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
staff.use('*', requireAnyPermission(['view_home', 'view_ops_home']));

// Routes
staff.route('/home', homeRoutes);
staff.route('/', schedulingRoutes);
staff.route('/', supportRoutes);
staff.route('/', customerRoutes);
staff.route('/ops', opsRoutes);
staff.route('/tasks', tasksRoutes);
staff.route('/ops/incidents', incidentsRoutes);
staff.route('/messages', messagesRoutes);
staff.route('/allied', alliedHealthRoutes);

export default staff;
