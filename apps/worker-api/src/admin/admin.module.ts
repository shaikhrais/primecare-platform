import { Hono } from 'hono';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';
import { tenantMiddleware } from '../_shared/middleware/tenant';
import { requireRole } from '../_shared/middleware/rbac';
import userRoutes from './users/users.routes';
import visitRoutes from './visits/visits.routes';
import leadRoutes from './leads/leads.routes';
import incidentRoutes from './incidents/incidents.routes';
import timesheetRoutes from './timesheets/timesheets.routes';
import serviceRoutes from './services/services.routes';
import contentRoutes from './content/content.routes';

const admin = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// Admin module-level middleware
admin.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    await middleware(c, next);
});
admin.use('*', tenantMiddleware());
admin.use('*', requireRole(['admin']));

// Routes
admin.route('/users', userRoutes);
admin.route('/visits', visitRoutes);
admin.route('/leads', leadRoutes);
admin.route('/incidents', incidentRoutes);
admin.route('/timesheets', timesheetRoutes);
admin.route('/services', serviceRoutes);
admin.route('/', contentRoutes);

export default admin;
