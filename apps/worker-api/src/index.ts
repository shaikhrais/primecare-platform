import { OpenAPIHono } from '@hono/zod-openapi';
import { swaggerUI } from '@hono/swagger-ui';
import { secureHeaders } from 'hono/secure-headers';
import { prismaMiddleware } from './_shared/middleware/prisma';
import { governanceMiddleware } from './_shared/middleware/governance';
import { tenantIsolation, csrfProtection, sanitizeInput } from './_shared/middleware/security';
import { correlationId, requestLogger } from './_shared/middleware/observability';
import { rateLimiter } from './_shared/middleware/rate-limiter';
import { Bindings, Variables } from './bindings';

// Modular Module Imports
import authModule from './auth/auth.routes';
import adminModule from './platform/admin/admin.module';
import managerModule from './tenancy/manager/manager.module';
import staffModule from './tenancy/staff/staff.module';
import rnModule from './domains/providers/rn/rn.module';
import pswModule from './domains/providers/psw/psw.module';
import clientModule from './domains/clients/client/client.module';
import coordinatorModule from './domains/scheduling/coordinator/coordinator.module';
import userModule from './user/user.routes';
import systemModule from './platform/system/system.module';
import scrumMasterModule from './platform/scrum_master/scrum_master.module';
import superuserModule from './platform/superuser/superuser.module';
import debugModule from './platform/system/debug.routes';
import cronRoutes from './platform/system/cron.routes';
import missingApisModule from './platform/missing_apis/missing_apis.module';
import webrtcModule from './platform/system/webrtc.routes';
import ledgerModule from './domains/billing/finance/ledger/journal.routes';
import sduiModule from './sdui/sdui.routes';
import { ecosystemModule } from './ecosystem/ecosystem.routes';
import { diagnosticsModule } from './ecosystem/diagnostics.routes';
import { behavioralModule } from './ecosystem/behavioral.routes';
import activitiesModule from './activities/activities.routes';
import inboxModule from './inbox/inbox.routes';
import narrowPathRoutes from './narrow-path/narrow-path.routes';
import trackingRoutes from './platform/tracking/tracking.routes';
import gmModule from './routes/gm/index';
import mtModule from './routes/mt/index';
import pswDashboardModule from './routes/psw_dashboard';
import dashboardModule from './platform/dashboard.routes';

// Phase 2: Growth & Compliance Imports
import intakeModule from './domains/intake/intake.module';
import carePlansModule from './domains/care-plans/care-plans.module';
import complianceModule from './domains/compliance/compliance.module';
import trainingModule from './domains/training/training.module';
import supportModule from './domains/support/support.module';
import franchiseModule from './domains/franchise/franchise.module';
import reportingModule from './domains/reporting/reporting.module';

import { ChatServer } from './durable_objects/ChatServer';
import { RealtimeSync } from './durable_objects/RealtimeSync';
export { ChatServer, RealtimeSync };

// Extracted sub-modules
import { registerCorsMiddleware, registerErrorHandler, createFetchWrapper } from './cors-wrapper';
import { registerPublicRoutes } from './public-routes';
import { withSentryWorker } from './_shared/middleware/sentry';

// Phase 4: Pub/Sub Listener Bootstrapping
import { registerBillingEventListeners } from './domains/billing/finance/finance.listeners';
import { registerComplianceEventListeners } from './domains/compliance/compliance.listeners';
import { registerReportingEventListeners } from './domains/reporting/reporting.listeners';
registerBillingEventListeners();
registerComplianceEventListeners();
registerReportingEventListeners();

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// 1. CORS + Error handling (extracted)
registerCorsMiddleware(app);
registerErrorHandler(app);

// 2. Public routes: health, branding, stats, leads, registries (extracted)
registerPublicRoutes(app);

// 3. OpenAPI Documentation (before middlewares so /openapi.json is publicly accessible)
app.doc('/openapi.json', { openapi: '3.0.0', info: { title: 'PrimeCare Worker API', version: '1.0.0', description: 'Comprehensive API for the PrimeCare home healthcare platform. 375+ endpoints across Admin, Manager, Coordinator, PSW, RN, Client, Staff, and System domains.' } });
app.get('/doc', swaggerUI({ url: '/openapi.json' }));

// 4. Middlewares
import { edgeTranslator } from './_shared/middleware/i18n';

app.use('*', correlationId());
app.use('*', requestLogger());
app.use('*', rateLimiter());
app.use('*', secureHeaders());
app.use('*', prismaMiddleware());
app.use('*', governanceMiddleware());
app.use('*', tenantIsolation());
app.use('*', csrfProtection());
app.use('*', sanitizeInput());
app.use('*', edgeTranslator());

app.use('*', async (c, next) => { await next(); c.header('X-API-Version', '1.0.0'); });


// 5. Mount Modules
app.route('/v1/auth', authModule);
app.route('/v1/admin', adminModule);
app.route('/v1/manager', managerModule);
app.route('/v1/staff', staffModule);

// --- Phase 2: Unified Provider Domain Routing ---
app.route('/v1/providers/rn', rnModule);
app.route('/v1/providers/psw', pswModule);
app.route('/v1/providers/mt', mtModule);
app.route('/v1/providers/psw/dashboard', pswDashboardModule);
// ------------------------------------------------

app.route('/v1/client', clientModule);
app.route('/v1/coordinator', coordinatorModule);
app.route('/v1/user', userModule);
app.route('/v1/system', systemModule);
app.route('/v1/scrum-master', scrumMasterModule);
app.route('/v1/superuser', superuserModule);
app.route('/v1/cron', cronRoutes);
app.use('/v1/debug/*', async (c, next) => { const env = c.env?.ENVIRONMENT || 'development'; if (env === 'production') return c.json({ error: 'Debug routes disabled in production' }, 403); return await next(); });
app.route('/v1/debug', debugModule);
app.route('/v1/webrtc', webrtcModule);
app.route('/v1/billing/ledger', ledgerModule); // Shifted to generic billing instead of isolated 'finance' per blueprint
app.route('/v1/sdui', sduiModule);
app.route('/v1/system/ecosystem', ecosystemModule);
app.route('/v1/system/diagnostics', diagnosticsModule);
app.route('/v1/system/behavioral', behavioralModule);
app.route('/v1/activities', activitiesModule);
app.route('/v1/inbox', inboxModule);
app.route('/v1/platform', missingApisModule);
app.route('/v1/narrow-path', narrowPathRoutes);
app.route('/v1/tracking', trackingRoutes);
app.route('/v1/gm', gmModule);
app.route('/v1/dashboard', dashboardModule);

// --- Phase 2: Growth & Compliance API Mounts ---
app.route('/v1/intake', intakeModule);
app.route('/v1/care-plans', carePlansModule);
app.route('/v1/compliance', complianceModule);
app.route('/v1/training', trainingModule);
app.route('/v1/support', supportModule);
app.route('/v1/franchise', franchiseModule);
app.route('/v1/reporting', reportingModule);
// ------------------------------------------------

// 6. Export with CORS wrapper + Sentry (extracted)
export default withSentryWorker(createFetchWrapper(app) as unknown as ExportedHandler);
