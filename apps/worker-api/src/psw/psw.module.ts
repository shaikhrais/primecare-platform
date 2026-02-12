import { Hono } from 'hono';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';
import { tenantMiddleware } from '../_shared/middleware/tenant';
import dashboardRoutes from './dashboard/dashboard.routes';
import scheduleRoutes from './schedule/schedule.routes';
import dailyEntryRoutes from './dailyEntry/dailyEntry.routes';
import incidentsRoutes from './incidents/incidents.routes';

const psw = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// PSW module-level middleware
psw.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});
psw.use('*', tenantMiddleware());

// Routes
psw.route('/dashboard', dashboardRoutes);
psw.route('/schedule', scheduleRoutes);
psw.route('/daily-entry', dailyEntryRoutes);
psw.route('/incidents', incidentsRoutes);

export default psw;
