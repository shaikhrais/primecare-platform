import { OpenAPIHono } from '@hono/zod-openapi';
import { swaggerUI } from '@hono/swagger-ui';
import { cors } from 'hono/cors';
import { secureHeaders } from 'hono/secure-headers';
import { prismaMiddleware } from './_shared/middleware/prisma';
import { errorHandler } from './_shared/middleware/errors';
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
import debugModule from './platform/system/debug.routes';

import { ChatServer } from './durable_objects/ChatServer';
export { ChatServer };

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// 1. Foundational CORS (Must be at the very top)
app.use('*', cors({
    origin: (origin) => {
        const allowed = [
            'https://primecare-admin.pages.dev',
            'http://localhost:5173',
            'http://localhost:8787'
        ];
        if (allowed.includes(origin)) return origin;
        // If it's a direct browser request or similar, allowed[0] is the safest production bet
        return allowed[0];
    },
    allowMethods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    allowHeaders: ['Content-Type', 'Authorization', 'X-Requested-With', 'Accept', 'X-Kinde-Status', 'x-tenant-id', 'x-tenant-slug'],
    exposeHeaders: ['Content-Length', 'X-Kinde-Status'],
    maxAge: 600,
    credentials: true,
}));

// 3. Health Routes
app.get('/v1/health', (c) => {
    return c.json({ status: 'ok', time: new Date().toISOString(), architecture: 'role-first-modular' });
});

app.onError((err, c) => {
    console.error('Hono Global Error:', err);
    return c.json({
        error: err.message || 'Internal Server Error',
        stack: err.stack,
        path: c.req.path
    }, 500);
});

// 3. Middlewares
app.use('*', secureHeaders());
app.use('*', prismaMiddleware());

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
