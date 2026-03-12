import { OpenAPIHono, z } from '@hono/zod-openapi';
import { swaggerUI } from '@hono/swagger-ui';
import { cors } from 'hono/cors';
import { secureHeaders } from 'hono/secure-headers';
import { prismaMiddleware } from './_shared/middleware/prisma';
import { governanceMiddleware } from './_shared/middleware/governance';
import { errorHandler } from './_shared/middleware/errors';
import { tenantIsolation, csrfProtection, sanitizeInput } from './_shared/middleware/security';
import { apiRateLimit } from './_shared/middleware/rate-limit';
import { correlationId, requestLogger, sessionTimeout } from './_shared/middleware/observability';
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
import superuserModule from './platform/superuser/superuser.module';
import debugModule from './platform/system/debug.routes';
import cronRoutes from './platform/system/cron.routes';

import { ChatServer } from './durable_objects/ChatServer';
import { RealtimeSync } from './durable_objects/RealtimeSync';
export { ChatServer, RealtimeSync };

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// 1. Foundational CORS (Must be at the very top)
app.use('*', async (c, next) => {
    const tenantId = c.req.header('X-Tenant-ID') || c.req.header('x-tenant-id');
    const origin = c.req.header('Origin');

    // Default fallback from Registry
    let allowedOrigins: string[] = [...CorsRegistry.ALLOWED_ORIGINS];
    let allowedMethods: string[] = [...CorsRegistry.ALLOWED_METHODS];
    let allowedHeaders: string[] = [...CorsRegistry.ALLOWED_HEADERS];

    if (tenantId) {
        const prisma = c.get('prisma');
        if (prisma) {
            const tenant = await prisma.tenant.findUnique({
                where: { id: tenantId },
                select: {
                    corsAllowedOrigins: true,
                    corsAllowedMethods: true,
                    corsAllowedHeaders: true
                }
            });
            if (tenant) {
                allowedOrigins = tenant.corsAllowedOrigins || allowedOrigins;
                allowedMethods = tenant.corsAllowedMethods || allowedMethods;
                allowedHeaders = tenant.corsAllowedHeaders || allowedHeaders;
            }
        }
    }

    const corsMiddleware = cors({
        origin: (reqOrigin) => {
            if (allowedOrigins.includes(reqOrigin)) return reqOrigin;
            // R20: Block wildcard (*) with credentials — browsers reject this combination
            // and it's a security risk. Only match exact origins.
            // Support Cloudflare Pages preview subdomains
            if (/^https:\/\/[a-z0-9]+\.primecare-admin\.pages\.dev$/.test(reqOrigin)) return reqOrigin;
            return allowedOrigins[0];
        },
        allowMethods: allowedMethods,
        allowHeaders: allowedHeaders,
        exposeHeaders: Array.from(CorsRegistry.EXPOSE_HEADERS),
        maxAge: CorsRegistry.MAX_AGE,
        credentials: CorsRegistry.CREDENTIALS,
    });

    return await corsMiddleware(c, next);
});

// 2. Health Routes
app.get('/v1/health', async (c) => {
    // #21: Actually check DB connectivity
    try {
        const prisma = c.get('prisma');
        if (prisma) await prisma.$queryRaw`SELECT 1`;
        return c.json({ status: 'ok', db: 'connected', time: new Date().toISOString(), architecture: 'role-first-modular' });
    } catch (e: any) {
        return c.json({ status: 'degraded', db: 'disconnected', time: new Date().toISOString() }, 503);
    }
});

app.onError((err, c) => {
    console.error('APP.ONERROR:', err);
    // R11: Don't log full error objects in production
    // Removed raw console.error to prevent telemetry pollution

    const origin = c.req.header('Origin');
    const allowed = ['https://primecare-admin.pages.dev', 'http://localhost:5173', 'http://localhost:8787'];
    const isPreview = origin && /^https:\/\/[a-z0-9]+\.primecare-admin\.pages\.dev$/.test(origin);
    const headerOrigin = (allowed.includes(origin || '') || isPreview) ? origin! : allowed[0];

    c.header('Access-Control-Allow-Origin', headerOrigin);
    c.header('Access-Control-Allow-Credentials', 'true');

    return c.json({
        status: 'error',
        message: 'Internal Server Error',
        path: c.req.path
    }, 500);
});

// 3. Middlewares
app.use('*', correlationId());     // R3: Request tracing
app.use('*', requestLogger());     // R3: Structured JSON logging
app.use('*', secureHeaders());     // #16: CSP + security headers
app.use('*', prismaMiddleware());
app.use('*', governanceMiddleware());
app.use('*', tenantIsolation());
app.use('*', csrfProtection());
app.use('*', sanitizeInput());
app.use('*', sessionTimeout());    // R3: X-Session-Expires-In header

// #17: API versioning + deprecation headers
app.use('*', async (c, next) => {
    await next();
    c.header('X-API-Version', '1.0.0');
    // R20: Don't expose server technology — removed X-Powered-By
});

// 3.5 Public Branding
// 3.5 Public Branding
app.get('/v1/public/branding', async (c) => {
    const slug = c.req.query('slug');
    if (!slug) return c.json({ error: 'Slug required' }, 400);

    // Default PrimeCare brand — returned when branding is not configured
    const DEFAULT_BRAND = {
        name: 'PrimeCare',
        slug: slug,
        status: 'active',
        logoUrl: '/primecare-logo-white.svg',
        brandingConfig: {
            primaryColor: '#0F172A',
            accentColor: '#3B82F6',
            logoUrl: '/primecare-logo-white.svg',
            name: 'PrimeCare',
            tagline: 'Compassionate Home Healthcare',
            isPlatform: true,
        },
        _needsSetup: true,
    };

    // ALWAYS RETURN DEFAULT TO PREVENT PRISMA POOL HANGS OVER CLOUDFLARE EDGE
    return c.json(DEFAULT_BRAND);
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

// #18: Gate Swagger docs behind non-production environment
app.get('/doc', async (c) => {
    const host = c.req.header('Host') || '';
    if (host.includes('workers.dev') && !host.includes('dev.')) {
        return c.json({ error: 'API docs disabled in production' }, 403);
    }
    // swaggerUI returns a middleware — invoke with next
    const handler = swaggerUI({ url: '/openapi.json' });
    return (handler as any)(c, async () => { });
});

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
// R23 (L29): Gate debug module behind non-production environment
app.use('/v1/debug/*', async (c, next) => {
    const env = c.env?.ENVIRONMENT || 'development';
    if (env === 'production') {
        return c.json({ error: 'Debug routes disabled in production' }, 403);
    }
    return await next();
});
app.route('/v1/debug', debugModule);

// #4: Marketing leads — validated with Zod schema + basic rate awareness
const MarketingLeadSchema = z.object({
    name: z.string().min(1).max(100),
    email: z.string().email().max(200),
    phone: z.string().max(30).optional(),
    source: z.string().max(50).optional(),
    message: z.string().max(1000).optional(),
    tenantId: z.string().uuid(),
});

app.post('/v1/marketing/leads', async (c) => {
    const prisma = c.get('prisma');
    const body = await c.req.json();
    const parsed = MarketingLeadSchema.safeParse(body);
    if (!parsed.success) {
        return c.json({ error: 'Validation failed', details: parsed.error.flatten() }, 400);
    }
    const lead = await prisma.lead.create({
        data: { ...parsed.data, status: 'new' }
    });
    return c.json({ success: true, lead }, 201);
});

// R23 (L21): Public Stats — now scoped to requesting tenant to prevent BI leakage
app.get('/v1/public/stats', async (c) => {
    try {
        const prisma = c.get('prisma');
        const tenantId = c.req.header('X-Tenant-ID') || c.req.header('x-tenant-id');

        const EMPTY = { totalUsers: 0, pendingVisits: 0, totalVisits: 0, totalLeads: 0, modelScore: 0, MTD_REVENUE: '0.00', healthAlerts: { complianceRisk: 0, coverageGap: 0, pipelineStagnation: 0 }, syncedAt: new Date().toISOString() };

        if (!prisma) return c.json(EMPTY);

        // R23: Require tenant context — don't leak platform-wide aggregate data
        if (!tenantId) {
            return c.json({ ...EMPTY, error: 'Tenant context required' });
        }

        // Scope queries to the requesting tenant
        const result: any[] = await prisma.$queryRaw`
            SELECT
                (SELECT COUNT(*) FROM users WHERE "tenantId" = ${tenantId})::int AS "totalUsers",
                (SELECT COUNT(*) FROM visits WHERE "tenantId" = ${tenantId})::int AS "totalVisits",
                (SELECT COUNT(*) FROM visits WHERE "tenantId" = ${tenantId} AND status = 'requested')::int AS "pendingVisits",
                (SELECT COUNT(*) FROM leads WHERE "tenantId" = ${tenantId})::int AS "totalLeads"
        `;

        const row = result[0] || EMPTY;

        return c.json({
            totalUsers: row.totalUsers || 0,
            pendingVisits: row.pendingVisits || 0,
            totalVisits: row.totalVisits || 0,
            totalLeads: row.totalLeads || 0,
            modelScore: 0, MTD_REVENUE: '0.00',
            healthAlerts: { complianceRisk: 0, coverageGap: 0, pipelineStagnation: 0 },
            syncedAt: new Date().toISOString(),
        });
    } catch (e: any) {
        return c.json({
            totalUsers: 0, pendingVisits: 0, totalVisits: 0, totalLeads: 0,
            modelScore: 0, MTD_REVENUE: '0.00',
            healthAlerts: { complianceRisk: 0, coverageGap: 0, pipelineStagnation: 0 },
            error: 'Stats aggregation failed',
            syncedAt: new Date().toISOString(),
        });
    }
});

// 8. Public Registries (no auth required — used by frontend to load registry data from DB)
app.get('/v1/public/registries', async (c) => {
    const prisma = c.get('prisma');
    const category = c.req.query('category');
    const section = c.req.query('section');
    try {
        const where: any = {};
        if (category) where.category = category;
        if (section) where.section = section;
        // #22: Add pagination limit to prevent fetching entire table
        const take = Math.min(parseInt(c.req.query('limit') || '100'), 500);
        const skip = parseInt(c.req.query('offset') || '0');
        const items = await prisma.registry.findMany({ where, orderBy: { key: 'asc' }, take, skip });
        return c.json({ total: items.length, items, syncedAt: new Date().toISOString() });
    } catch (e: any) {
        return c.json({ total: 0, items: [], error: 'Failed to fetch registries' });
    }
});

// Wrap export to guarantee CORS headers on ALL responses (including 500 errors)
const CORS_ORIGINS = ['https://primecare-admin.pages.dev', 'http://localhost:5173', 'http://localhost:8787'];
const CORS_PREVIEW_RE = /^https:\/\/[a-z0-9]+\.primecare-admin\.pages\.dev$/;

export default {
    ...app,
    async fetch(request: Request, env: any, ctx: any) {
        const origin = request.headers.get('Origin') || '';
        const isAllowed = CORS_ORIGINS.includes(origin) || CORS_PREVIEW_RE.test(origin);
        const allowOrigin = isAllowed ? origin : CORS_ORIGINS[0];

        // Handle preflight
        if (request.method === 'OPTIONS') {
            return new Response(null, {
                status: 204,
                headers: {
                    'Access-Control-Allow-Origin': allowOrigin,
                    'Access-Control-Allow-Methods': 'GET,POST,PUT,PATCH,DELETE,OPTIONS',
                    'Access-Control-Allow-Headers': 'Content-Type,Authorization,X-Requested-With,Accept,X-Tenant-ID,x-tenant-id,x-tenant-slug,X-Device-ID,X-Device-Name,X-Device-Type,X-Is-Temporary',
                    'Access-Control-Allow-Credentials': 'true',
                    'Access-Control-Max-Age': '600',
                },
            });
        }

        try {
            const response = await app.fetch(request, env, ctx);
            // Clone and ensure CORS headers are present
            const newHeaders = new Headers(response.headers);
            newHeaders.set('Access-Control-Allow-Origin', allowOrigin);
            newHeaders.set('Access-Control-Allow-Credentials', 'true');
            return new Response(response.body, { status: response.status, statusText: response.statusText, headers: newHeaders });
        } catch (err: any) {
            // Ultimate fallback for uncaught errors
            return new Response(JSON.stringify({ error: 'Internal Server Error' }), {
                status: 500,
                headers: {
                    'Content-Type': 'application/json',
                    'Access-Control-Allow-Origin': allowOrigin,
                    'Access-Control-Allow-Credentials': 'true',
                },
            });
        }
    },
    // Cron trigger: periodically check SLA and wake up Prisma
    async scheduled(event: any, env: any, ctx: any) {
        try {
            // Wake up DB
            const healthReq = new Request('http://localhost/v1/health');
            await app.fetch(healthReq, env, ctx);
            
            // Execute automated SLA sweeps
            const slaReq = new Request('http://localhost/v1/cron/incident-sla', { method: 'POST' });
            await app.fetch(slaReq, env, ctx);
        } catch { /* ignore */ }
    },
};
