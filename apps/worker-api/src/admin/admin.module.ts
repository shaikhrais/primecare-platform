import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
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

const admin = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Admin module-level middleware
admin.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
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

const statsRoute = createRoute({
    method: 'get',
    path: '/stats',
    summary: 'Get Admin Dashboard Statistics',
    description: 'Returns total counts for users, pending visits, total visits, and leads.',
    tags: ['Admin'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        totalUsers: z.number(),
                        pendingVisits: z.number(),
                        totalVisits: z.number(),
                        totalLeads: z.number(),
                    }),
                },
            },
            description: 'Success',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.object({
                        error: z.string(),
                        details: z.string().optional(),
                    }),
                },
            },
            description: 'Internal Server Error',
        },
    },
});

admin.openapi(statsRoute, async (c) => {
    const prisma = c.get('prisma');

    // Parallelize queries for performance
    const [totalUsers, pendingVisits, totalVisits, totalLeads] = await Promise.all([
        prisma.user.count(),
        prisma.visit.count({ where: { status: 'requested' } }),
        prisma.visit.count(), // Total visits (all statuses)
        prisma.lead.count()
    ]);

    return c.json({
        totalUsers,
        pendingVisits,
        totalVisits,
        totalLeads
    }, 200);
});

export default admin;
