import { Hono } from 'hono';
import { cors } from 'hono/cors';
import { secureHeaders } from 'hono/secure-headers';
import { prismaMiddleware } from './middleware/prisma';
import { errorHandler } from './_shared/middleware/errors';
import { Bindings, Variables } from './bindings';

// Modular Module Imports
import authModule from './auth/auth.routes';
import adminModule from './admin/admin.module';
import managerModule from './manager/manager.module';
import staffModule from './staff/staff.module';
import rnModule from './rn/rn.module';
import pswModule from './psw/psw.module';
import clientModule from './client/client.module';
import systemModule from './system/system.module';

import { ChatServer } from './durable_objects/ChatServer';
export { ChatServer };

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// 1. Foundational Middleware
app.use('*', secureHeaders());
app.use('*', errorHandler);
app.use('*', prismaMiddleware());

// 2. CORS
app.use('*', cors({
    origin: (origin) => {
        if (!origin) return null;
        if (origin.includes('localhost') || origin.includes('pages.dev') || origin.includes('workers.dev')) {
            return origin;
        }
        return null;
    },
    allowMethods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    allowHeaders: ['Content-Type', 'Authorization', 'X-Requested-With'],
    exposeHeaders: ['Content-Length', 'X-Kinde-Status'],
    maxAge: 600,
    credentials: true,
}));

// 3. Health Routes
app.get('/v1/health', (c) => {
    return c.json({ status: 'ok', time: new Date().toISOString(), architecture: 'role-first-modular' });
});

// 4. Mount Modules (Role-First Architecture)
app.route('/v1/auth', authModule);
app.route('/v1/admin', adminModule);
app.route('/v1/manager', managerModule);
app.route('/v1/staff', staffModule);
app.route('/v1/rn', rnModule);
app.route('/v1/psw', pswModule);
app.route('/v1/client', clientModule);
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
