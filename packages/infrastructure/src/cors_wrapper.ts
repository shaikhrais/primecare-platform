// Governance - Category: service | Purpose: CORS + Fetch Wrapper — extracted from index.ts Ensures CORS headers on ALL responses including errors
/**
 * CORS + Fetch Wrapper — extracted from index.ts
 * Ensures CORS headers on ALL responses including errors
 */
import { OpenAPIHono } from '@hono/zod-openapi';
import { cors } from 'hono/cors';
import { AdminRegistry } from '@primecare/domain';
import { Bindings, Variables } from '@primecare/contracts';
import { captureWorkerException } from './sentry_client';

const { CorsRegistry } = AdminRegistry;
const CORS_ORIGINS = [
    'https://primecare-corporate.pages.dev',
    'https://primecare-clinical.pages.dev',
    'https://primecare-franchise.pages.dev',
    'https://primecare-marketing.pages.dev',
    'https://primecare-support.pages.dev',
    'https://primecare-business-development.pages.dev',
    'https://primecare-client.pages.dev',
    'https://primecare-admin.pages.dev',
    'https://primecare-v4.pages.dev',
    'https://primecare-app.pages.dev',
    'https://primecare-web.pages.dev',
    'https://primecare-mobile.pages.dev',
    'http://localhost:8787'
];
const CORS_PREVIEW_RE = /^https:\/\/[a-z0-9-]+\.primecare-[a-z0-9-]+\.pages\.dev$|^http:\/\/localhost:\d+$|^http:\/\/127\.0\.0\.1:\d+$/;

type AppType = OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>;

export function registerCorsMiddleware(app: AppType) {
    app.use('*', async (c, next) => {
        const tenantId = c.req.header('X-Tenant-ID') || c.req.header('x-tenant-id');
        let allowedOrigins: string[] = [...CorsRegistry.ALLOWED_ORIGINS];
        let allowedMethods: string[] = [...CorsRegistry.ALLOWED_METHODS];
        let allowedHeaders: string[] = [...CorsRegistry.ALLOWED_HEADERS];
        if (tenantId) { const prisma = c.get('prisma'); if (prisma) { let tenant: any = null;
        try {
          tenant = await prisma.tenant.findUnique({ where: { id: tenantId }, select: { corsAllowedOrigins: true, corsAllowedMethods: true, corsAllowedHeaders: true } });
        } catch(e) {
          console.error("Invalid UUID fallback", e);
        } if (tenant) { allowedOrigins = tenant?.corsAllowedOrigins || allowedOrigins; allowedMethods = tenant?.corsAllowedMethods || allowedMethods; allowedHeaders = tenant?.corsAllowedHeaders || allowedHeaders; } } }
        const corsMiddleware = cors({ 
            origin: (reqOrigin) => { 
                if (allowedOrigins.includes(reqOrigin)) return reqOrigin; 
                if (CORS_PREVIEW_RE.test(reqOrigin)) return reqOrigin; 
                return allowedOrigins[0]; 
            }, 
            allowMethods: allowedMethods, 
            allowHeaders: allowedHeaders, 
            exposeHeaders: Array.from(CorsRegistry.EXPOSE_HEADERS), 
            maxAge: CorsRegistry.MAX_AGE, 
            credentials: CorsRegistry.CREDENTIALS 
        });
        return await corsMiddleware(c, next);
    });
}

export function registerErrorHandler(app: AppType) {
    app.onError((err, c) => {
        // Structured JSON logging for observability
        const correlationId = c.req.header('X-Correlation-ID') || 'unknown';
        const tenantId = c.req.header('X-Tenant-ID') || c.req.header('x-tenant-id') || 'unknown';
        const structuredLog = {
            level: 'error',
            timestamp: new Date().toISOString(),
            correlationId,
            path: c.req.path,
            method: c.req.method,
            userAgent: c.req.header('User-Agent')?.substring(0, 100) || 'unknown',
            tenantId,
            error: {
                name: err?.name || 'UnknownError',
                message: err?.message || 'No error message',
                stack: typeof err?.stack === 'string' ? err.stack.split('\n').slice(0, 5).join('\n') : 'No stack trace',
            },
        };
        console.error(JSON.stringify(structuredLog));

        // Report to Sentry with request context
        captureWorkerException(err, { path: c.req.path, method: c.req.method, correlationId, tenantId });

        const origin = c.req.header('Origin'); const allowed = CORS_ORIGINS;
        const isPreview = origin && CORS_PREVIEW_RE.test(origin);
        const headerOrigin = (allowed.includes(origin || '') || isPreview) ? origin! : allowed[0]!;
        c.header('Access-Control-Allow-Origin', headerOrigin); c.header('Access-Control-Allow-Credentials', 'true');
        
        // Architecture Audit #1: OpenAPI 400/404 Consensus Synchronization
        // Catches strictly identical validation anomalies across 413 dynamic endpoints cleanly generating formal 400 structures
        if (err?.name === 'ZodError' || (err as any)?.issues || err?.message?.includes('Invalid')) {
            return c.json({ success: false, error: 'Validation Error', details: (err as any)?.issues || err.message }, 400);
        }
        if (err?.name === 'NotFoundError' || err?.message?.includes('not found')) {
            return c.json({ success: false, error: 'Resource Not Found' }, 404);
        }

        return c.json({ status: 'error', message: 'Internal Server Error', path: c.req.path }, 500);
    });
}

export function createFetchWrapper(app: AppType) {
    return {
        ...app,
        async fetch(request: Request, env: any, ctx: any) {
            const origin = request.headers.get('Origin') || '';
            const isAllowed = CORS_ORIGINS.includes(origin) || CORS_PREVIEW_RE.test(origin);
            const allowOrigin = isAllowed ? origin : CORS_ORIGINS[0]!;
            if (request.method === 'OPTIONS') {
                return new Response(null, { status: 204, headers: { 'Access-Control-Allow-Origin': allowOrigin, 'Access-Control-Allow-Methods': 'GET,POST,PUT,PATCH,DELETE,OPTIONS', 'Access-Control-Allow-Headers': 'Content-Type,Authorization,X-Requested-With,Accept,X-Tenant-ID,x-tenant-id,x-tenant-slug,X-Device-ID,X-Device-Name,X-Device-Type,X-Is-Temporary', 'Access-Control-Allow-Credentials': 'true', 'Access-Control-Max-Age': '600' } });
            }
            try {
                const response = await app.fetch(request, env, ctx);
                const newHeaders = new Headers(response.headers); newHeaders.set('Access-Control-Allow-Origin', allowOrigin); newHeaders.set('Access-Control-Allow-Credentials', 'true');
                return new Response(response.body, { status: response.status, statusText: response.statusText, headers: newHeaders });
            } catch (err: any) {
                const stackStr = typeof err?.stack === 'string' ? err.stack.split('\n').slice(0, 3).join('\n') : '';
                console.error(JSON.stringify({ level: 'fatal', timestamp: new Date().toISOString(), path: new URL(request.url).pathname, method: request.method, error: { name: err?.name || 'FetchWrapperError', message: err?.message || 'Unknown', stack: stackStr } }));
                return new Response(JSON.stringify({ error: 'Internal Server Error' }), { status: 500, headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': allowOrigin, 'Access-Control-Allow-Credentials': 'true' } });
            }
        },
        async scheduled(event: any, env: any, ctx: any) {
            try { const healthReq = new Request('http://localhost/v1/health'); await app.fetch(healthReq, env, ctx); const slaReq = new Request('http://localhost/v1/cron/incident-sla', { method: 'POST' }); await app.fetch(slaReq, env, ctx); } catch { /* ignore */ }
        },
    };
}
