import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireAuth } from '../../_shared/middleware/auth';
import { requireRole } from '../../_shared/middleware/rbac';
import userRoutes from './users/users.routes';
import visitRoutes from './visits/visits.routes';
import leadRoutes from './leads/leads.routes';
import incidentRoutes from './incidents/incidents.routes';
import timesheetRoutes from './timesheets/timesheets.routes';
import serviceRoutes from './services/services.routes';
import contentRoutes from './content/content.routes';
import settingsRoutes from './settings/settings.routes';
import clientRoutes from './clients/clients.routes';
import developerRoutes from './developer/developer.routes';
import { platformStats } from './routes/platform-stats.routes';
import { predictiveStaffingRoutes } from './routes/predictive-staffing.routes';
import { riskSurveillanceRoutes } from './routes/risk-surveillance.routes';
import { clinicalAutopilotRoutes } from './routes/clinical-autopilot.routes';
import { resellerRoutes } from './routes/reseller.routes';

const admin = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();
const adminModule = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Admin module-level middleware
admin.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});
admin.use('*', requireRole(['admin']));

// Routes
admin.route('/users', userRoutes);
admin.route('/visits', visitRoutes);
admin.route('/leads', leadRoutes);
admin.route('/incidents', incidentRoutes);
admin.route('/timesheets', timesheetRoutes);
admin.route('/services', serviceRoutes);
admin.route('/settings', settingsRoutes);
admin.route('/clients', clientRoutes);
admin.route('/developer', developerRoutes); // Keep in Tenant Admin for now as it's for their API Keys
admin.route('/', contentRoutes);

// Platform/Company Specific Routes (Restricted to Super Admin in middleware if necessary)
admin.route('/system/platform', platformStats);
admin.route('/system/risk-surveillance', riskSurveillanceRoutes);

// Insights Routes
admin.route('/insights/predictive-staffing', predictiveStaffingRoutes);

// Automation Routes
admin.route('/automation/clinical-autopilot', clinicalAutopilotRoutes);

// Reseller // Sub-Tenant Routes
admin.route('/reseller', resellerRoutes);

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

    const sevenDaysFromNow = new Date();
    sevenDaysFromNow.setDate(sevenDaysFromNow.getDate() + 7);

    const threeDaysAgo = new Date();
    threeDaysAgo.setDate(threeDaysAgo.getDate() - 3);

    // Parallelize queries for performance
    const [totalUsers, pendingVisits, totalVisits, totalLeads, complianceRisk, coverageGap, pipelineStagnation] = await Promise.all([
        prisma.user.count(),
        prisma.visit.count({ where: { status: 'requested' } }),
        prisma.visit.count(), // Safely handle total visits
        prisma.lead.count(),
        // Compliance: Users with no documents or expired ones (simplified for this step)
        prisma.pswDocument.count({ where: { status: 'pending' } }),
        // Coverage: Unassigned visits in the next 7 days
        prisma.visit.count({
            where: {
                status: 'requested',
                requestedStartAt: { lte: sevenDaysFromNow }
            }
        }),
        // Pipeline: Leads with 'new' status older than 3 days
        prisma.lead.count({
            where: {
                status: 'new',
                createdAt: { lte: threeDaysAgo }
            }
        })
    ]);

    // Calculate Business Model Score
    let modelScore = 0;
    try {
        const tenant = await prisma.tenant.findFirst({
            select: {
                businessNumber: true,
                supportEmail: true,
                logoUrl: true,
                taxSettings: true
            }
        });
        if (tenant) {
            if (tenant.businessNumber) modelScore += 25;
            if (tenant.supportEmail) modelScore += 25;
            if (tenant.logoUrl) modelScore += 25;
            if (tenant.taxSettings) modelScore += 25;
        }
    } catch (e) {
        console.error('Schema sync pending - business model fields missing');
    }

    return c.json({
        totalUsers,
        pendingVisits,
        totalVisits,
        totalLeads,
        modelScore,
        healthAlerts: {
            complianceRisk,
            coverageGap,
            pipelineStagnation
        }
    }, 200);
});

export default admin;
