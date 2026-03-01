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
import userModule from './user/user.routes';
import systemModule from './platform/system/system.module';

import { ChatServer } from './durable_objects/ChatServer';
export { ChatServer };

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// 1. Foundational CORS (Must be at the very top)
app.use('*', cors({
    origin: (origin) => {
        if (!origin) return 'https://primecare-admin.pages.dev';
        if (origin.includes('pages.dev') || origin.includes('workers.dev') || origin.includes('localhost')) {
            return origin;
        }
        return 'https://primecare-admin.pages.dev';
    },
    allowMethods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    allowHeaders: ['Content-Type', 'Authorization', 'X-Requested-With', 'Accept', 'X-Kinde-Status', 'x-tenant-id'],
    exposeHeaders: ['Content-Length', 'X-Kinde-Status'],
    maxAge: 600,
    credentials: true,
}));

app.onError((err, c) => {
    console.error('Hono Global Error:', err);

    // Safety check: ensure we don't double-set headers if they were already sent
    const origin = c.req.header('Origin') || 'https://primecare-admin.pages.dev';

    return c.json({
        error: err.message || 'Internal Server Error',
        stack: err.stack,
        path: c.req.path,
        method: c.req.method
    }, 500, {
        'Access-Control-Allow-Origin': origin,
        'Access-Control-Allow-Credentials': 'true',
    });
});

// 3. Middlewares
app.use('*', secureHeaders());
app.use('*', prismaMiddleware());

// 3. Health Routes
app.get('/v1/health', (c) => {
    return c.json({ status: 'ok', time: new Date().toISOString(), architecture: 'role-first-modular' });
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

// 5. Mount Modules (Role-First Architecture)
app.route('/v1/auth', authModule);
app.route('/v1/admin', adminModule);
app.route('/v1/manager', managerModule);
app.route('/v1/staff', staffModule);
app.route('/v1/rn', rnModule);
app.route('/v1/psw', pswModule);
app.route('/v1/client', clientModule);
app.route('/v1/user', userModule);
app.route('/v1/system', systemModule);

// 5. Public Marketing Lead Support (Moved to a public endpoint if needed, or tucked into a module)
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
