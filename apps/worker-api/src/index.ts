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
import rnModule from './tenancy/rn/rn.module';
import pswModule from './tenancy/psw/psw.module';
import clientModule from './tenancy/client/client.module';
import coordinatorModule from './tenancy/coordinator/coordinator.module';
import userModule from './user/user.routes';
import systemModule from './platform/system/system.module';
import scrumMasterModule from './platform/scrum_master/scrum_master.module';
import superuserModule from './platform/superuser/superuser.module';
import debugModule from './platform/system/debug.routes';
import cronRoutes from './platform/system/cron.routes';

import { ChatServer } from './durable_objects/ChatServer';
import { RealtimeSync } from './durable_objects/RealtimeSync';
export { ChatServer, RealtimeSync };

// Extracted sub-modules
import { registerCorsMiddleware, registerErrorHandler, createFetchWrapper } from './cors-wrapper';
import { registerPublicRoutes } from './public-routes';

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
app.use('*', correlationId());
app.use('*', requestLogger());
app.use('*', rateLimiter());
app.use('*', secureHeaders());
app.use('*', prismaMiddleware());
app.use('*', governanceMiddleware());
app.use('*', tenantIsolation());
app.use('*', csrfProtection());
app.use('*', sanitizeInput());

app.use('*', async (c, next) => { await next(); c.header('X-API-Version', '1.0.0'); });


// 5. Mount Modules
app.route('/v1/auth', authModule);
app.route('/v1/admin', adminModule);
app.route('/v1/manager', managerModule);
app.route('/v1/staff', staffModule);
app.route('/v1/rn', rnModule);
app.route('/v1/psw', pswModule);
app.route('/v1/client', clientModule);
app.route('/v1/coordinator', coordinatorModule);
app.route('/v1/user', userModule);
app.route('/v1/system', systemModule);
app.route('/v1/scrum-master', scrumMasterModule);
app.route('/v1/superuser', superuserModule);
app.route('/v1/cron', cronRoutes);
app.use('/v1/debug/*', async (c, next) => { const env = c.env?.ENVIRONMENT || 'development'; if (env === 'production') return c.json({ error: 'Debug routes disabled in production' }, 403); return await next(); });
app.route('/v1/debug', debugModule);

// 6. Export with CORS wrapper (extracted)
export default createFetchWrapper(app);
