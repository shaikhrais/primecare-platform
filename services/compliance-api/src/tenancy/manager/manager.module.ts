import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { requireAuth } from '@primecare/security';
import { requireAnyPermission } from '@primecare/security';;
import homeRoutes from './home/home.routes';
import financeRoutes from './finance/finance.routes';
import managerOpsRoutes from './manager_ops.routes';
import reviewRoutes from './reviews/reviews.routes';
import trainingAdminRoutes from './training/training.routes';
import payrollRoutes from './payroll/payroll.routes';
import incidentsRoutes from './incidents/incidents.routes';
import teamsRoutes from './teams/teams.routes';

const manager = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Manager module-level middleware
manager.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});
manager.use('*', requireAnyPermission(['view_home', 'manage_schedule']));

// Routes
manager.route('/home', homeRoutes);
manager.route('/finance', financeRoutes);
manager.route('/ops', managerOpsRoutes);
manager.route('/reviews', reviewRoutes);
manager.route('/training', trainingAdminRoutes);
manager.route('/payroll', payrollRoutes);
manager.route('/incidents', incidentsRoutes);
manager.route('/teams', teamsRoutes);

export default manager;
