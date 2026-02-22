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

admin.get('/stats', async (c) => {
    try {
        const prisma = c.get('prisma');

        // Parallelize queries for performance
        const [totalUsers, pendingVisits, totalVisits, totalLeads] = await Promise.all([
            prisma.user.count(),
            prisma.visit.count({ where: { status: 'pending' } }),
            prisma.visit.count(), // Total visits (all statuses)
            prisma.lead.count()
        ]);

        return c.json({
            totalUsers,
            pendingVisits,
            totalVisits,
            totalLeads
        });
    } catch (error: any) {
        console.error('Error fetching admin stats:', error);
        return c.json({ error: 'Failed to fetch stats', details: error.message }, 500);
    }
});

export default admin;
