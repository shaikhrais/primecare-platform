import { OpenAPIHono } from '@hono/zod-openapi';
import { swaggerUI } from '@hono/swagger-ui';
import { cors } from 'hono/cors';
import { secureHeaders } from 'hono/secure-headers';
import { prismaMiddleware } from './_shared/middleware/prisma';
import { governanceMiddleware } from './_shared/middleware/governance';
import { errorHandler } from './_shared/middleware/errors';
import { Bindings, Variables } from './bindings';
import { AdminRegistry } from 'prime-care-shared';

const { CorsRegistry } = AdminRegistry;

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
import debugModule from './platform/system/debug.routes';

import { ChatServer } from './durable_objects/ChatServer';
export { ChatServer };

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// 1. Foundational CORS (Must be at the very top)
app.use('*', cors({
    origin: (origin) => {
        if (CorsRegistry.ALLOWED_ORIGINS.includes(origin as any)) return origin;
        return CorsRegistry.ALLOWED_ORIGINS[0];
    },
    allowMethods: Array.from(CorsRegistry.ALLOWED_METHODS),
    allowHeaders: Array.from(CorsRegistry.ALLOWED_HEADERS),
    exposeHeaders: Array.from(CorsRegistry.EXPOSE_HEADERS),
    maxAge: CorsRegistry.MAX_AGE,
    credentials: CorsRegistry.CREDENTIALS,
}));

// 2. Health Routes
app.get('/v1/health', (c) => {
    return c.json({ status: 'ok', time: new Date().toISOString(), architecture: 'role-first-modular' });
});

app.onError((err, c) => {
    console.error('Hono Global Error:', err);

    const origin = c.req.header('Origin');
    const allowed = ['https://primecare-admin.pages.dev', 'http://localhost:5173', 'http://localhost:8787'];
    const headerOrigin = allowed.includes(origin || '') ? origin! : allowed[0];

    c.header('Access-Control-Allow-Origin', headerOrigin);
    c.header('Access-Control-Allow-Credentials', 'true');

    return c.json({
        status: 'error',
        message: err.message || 'Internal Server Error',
        path: c.req.path
    }, 500);
});

// 3. Middlewares
app.use('*', prismaMiddleware());
app.use('*', governanceMiddleware());

// 3.5 Public Branding
app.get('/v1/public/branding', async (c) => {
    const prisma = c.get('prisma');
    const slug = c.req.query('slug');
    if (!slug) return c.json({ error: 'Slug required' }, 400);
    const tenant = await prisma.tenant.findUnique({
        where: { slug },
        select: { brandingConfig: true, logoUrl: true, name: true }
    });
    if (!tenant) return c.json({ error: 'Tenant not found' }, 404);
    return c.json(tenant);
});

// 4. OpenAPI Documentation
app.doc('/openapi.json', {
    openapi: '3.0.0',
    info: {
        title: 'PrimeCare Worker API',
        version: '1.0.0',
        description: 'API for PrimeCare workers, admins, and managers.',
    },
});

app.get('/doc', swaggerUI({ url: '/openapi.json' }));

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
app.route('/v1/debug', debugModule);

// 6. Marketing Lead
app.post('/v1/marketing/leads', async (c) => {
    const prisma = c.get('prisma');
    const data = await c.req.json();
    const lead = await prisma.lead.create({
        data: {
            ...data,
            status: 'new'
        }
    });
    return c.json({ success: true, lead }, 201);
});

export default app;
