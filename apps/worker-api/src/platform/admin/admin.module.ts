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
import searchRoutes from './search/search.routes';
import reportRoutes from './reports/export.routes';
import scrumRoutes from './scrum/scrum.routes';
import { platformStats } from './routes/platform-stats.routes';
import { predictiveStaffingRoutes } from './routes/predictive-staffing.routes';
import { riskSurveillanceRoutes } from './routes/risk-surveillance.routes';
import { clinicalAutopilotRoutes } from './routes/clinical-autopilot.routes';
import { resellerRoutes } from './routes/reseller.routes';
import financialRoutes from './financial/financial.routes';
import registryRoutes from './registries/registries.routes';
import evvRoutes from './evv/evv.routes';
import authorizationRoutes from './authorizations/authorizations.routes';
import referralRoutes from './referrals/referrals.routes';
import consentRoutes from './consent/consent.routes';
import claimRoutes from './claims/claims.routes';
import webhookRoutes from './webhooks/webhooks.routes';
import auditExportRoutes from './audit-export/audit-export.routes';
import aiStubRoutes from './ai-stubs/ai-stubs.routes';
import notificationRoutes from './notifications/notifications.routes';
import documentRoutes from './documents/documents.routes';
import payrollRoutes from './payroll/payroll.routes';
import dischargeRoutes from './discharge/discharge.routes';
import bookingRequestRoutes from './booking-requests/booking-requests.routes';
import referenceDataRoutes from './reference-data/reference-data.routes';
import interopRoutes from './interop/interop.routes';
import cronRoutes from './cron/cron.routes';
import marketingRoutes from './marketing/marketing.routes';
import telehealthRoutes from './telehealth/telehealth.routes';
import pharmacyRoutes from './pharmacy/pharmacy.routes';
import erpRoutes from './erp/erp.routes';
import damRoutes from './dam/dam.routes';
import { systemDataRoutes } from './system-data/system-data.routes';
import staffGroupsRoutes from './staff-groups/staff-groups.routes';
import adminActionsRoutes from './actions/admin-actions.routes';

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
admin.route('/search', searchRoutes);
admin.route('/reports', reportRoutes);
admin.route('/scrum', scrumRoutes);
admin.route('/financial', financialRoutes);
admin.route('/registries', registryRoutes);
admin.route('/', contentRoutes);

// Platform/Company Specific Routes (Restricted to Super Admin in middleware if necessary)
admin.route('/system/platform', platformStats);
admin.route('/system/risk-surveillance', riskSurveillanceRoutes);
admin.route('/system/marketing', marketingRoutes);

// Insights Routes
admin.route('/insights/predictive-staffing', predictiveStaffingRoutes);

// Automation Routes
admin.route('/automation/clinical-autopilot', clinicalAutopilotRoutes);

// Reseller // Sub-Tenant Routes
admin.route('/reseller', resellerRoutes);

// Domain Feature Extensions
admin.route('/evv', evvRoutes);
admin.route('/authorizations', authorizationRoutes);
admin.route('/referrals', referralRoutes);
admin.route('/consent', consentRoutes);
admin.route('/claims', claimRoutes);
admin.route('/webhooks', webhookRoutes);
admin.route('/audit-export', auditExportRoutes);
admin.route('/ai-iot', aiStubRoutes);
admin.route('/notifications', notificationRoutes);
admin.route('/documents', documentRoutes);
admin.route('/payroll', payrollRoutes);
admin.route('/clients', dischargeRoutes);
admin.route('/booking-requests', bookingRequestRoutes);
admin.route('/', referenceDataRoutes);
admin.route('/interop', interopRoutes);
admin.route('/cron', cronRoutes);
admin.route('/telehealth', telehealthRoutes);
admin.route('/pharmacy', pharmacyRoutes);
adminModule.route('/claims', claimRoutes);
adminModule.route('/erp', erpRoutes);
adminModule.route('/dam', damRoutes);
admin.route('/system-data', systemDataRoutes);
admin.route('/staff-groups', staffGroupsRoutes);
admin.route('/actions', adminActionsRoutes);

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

    // Parallelize queries for performance with resilience
    let totalUsers = 0, pendingVisits = 0, totalVisits = 0, totalLeads = 0;
    let complianceRisk = 0, coverageGap = 0, pipelineStagnation = 0;

    try {
        const results = await Promise.all([
            prisma.user.count(),
            prisma.visit.count({ where: { status: 'requested' } }),
            prisma.visit.count(),
            prisma.lead.count(),
            prisma.pswDocument.count({ where: { status: 'pending' } }),
            prisma.visit.count({
                where: {
                    status: 'requested',
                    requestedStartAt: { lte: sevenDaysFromNow }
                }
            }),
            prisma.lead.count({
                where: {
                    status: 'new',
                    createdAt: { lte: threeDaysAgo }
                }
            })
        ]);
        [totalUsers, pendingVisits, totalVisits, totalLeads, complianceRisk, coverageGap, pipelineStagnation] = results;
    } catch (e) {
        // R15: Don't leak internal errors
    }

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
        // R15: Don't leak schema sync details
    }

    return c.json({
        totalUsers,
        pendingVisits,
        totalVisits,
        totalLeads,
        modelScore,
        MTD_REVENUE: "0.00", // Hardcoded for now until billing sync
        healthAlerts: {
            complianceRisk,
            coverageGap,
            pipelineStagnation
        }
    }, 200);
});

export default admin;
