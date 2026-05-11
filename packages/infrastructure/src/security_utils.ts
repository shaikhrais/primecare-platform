import { MiddlewareHandler } from 'hono';
import { Bindings, Variables } from '@primecare/contracts';
import { OpenAPIHono } from '@hono/zod-openapi';
import { registerCorsMiddleware, registerErrorHandler } from './cors_wrapper';
import { prismaMiddleware } from './prisma_client';

/**
 * #16: Tenant Isolation Middleware
 * Ensures all authenticated requests have tenantId extracted and validated.
 * Sets c.get('tenantId') for downstream use.
 * Verifies the JWT tenantId matches the X-Tenant-ID header when both are present.
 */
export const tenantIsolation = (): MiddlewareHandler<{ Bindings: Bindings; Variables: Variables }> => {
    return async (c, next) => {
        const headerTenantId = c.req.header('X-Tenant-ID') || c.req.header('x-tenant-id');
        const jwtPayload = c.get('jwtPayload' as any) as { tenantId?: string } | undefined;
        const jwtTenantId = jwtPayload?.tenantId;

        // If both exist, they must match (prevents cross-tenant token reuse)
        if (headerTenantId && jwtTenantId && headerTenantId !== jwtTenantId) {
            return c.json({
                error: 'Tenant Mismatch',
                message: 'Session tenant does not match request tenant.'
            }, 403);
        }

        // Set resolved tenantId for downstream
        const tenantId = jwtTenantId || headerTenantId;
        if (tenantId) {
            c.set('tenantId' as any, tenantId);
        }

        // R23 (L25): Enforce tenantId for authenticated non-public requests
        // Without tenantId, the Prisma tenant extension won't activate, leaking cross-tenant data
        if (!tenantId && jwtPayload) {
            const path = c.req.path;
            const isPublicOrAuth = 
                path.includes('/v1/public/') || 
                path.includes('/v1/auth/') || 
                path.includes('/v1/debug/') || 
                path.endsWith('/health');
                
            if (!isPublicOrAuth) {
                return c.json({
                    error: 'Tenant Context Required',
                    message: 'Request must include tenant identification.'
                }, 403);
            }
        }

        await next();
    };
};

/**
 * #13: CSRF Protection Middleware
 * For mutation requests (POST/PUT/PATCH/DELETE), requires a custom header
 * that can't be sent by plain HTML forms or cross-origin AJAX.
 */
export const csrfProtection = (): MiddlewareHandler<{ Bindings: Bindings; Variables: Variables }> => {
    return async (c, next) => {
        const method = c.req.method;
        const safeMethods = ['GET', 'HEAD', 'OPTIONS'];

        if (safeMethods.includes(method)) {
            return await next();
        }

        // Mutation request — verify custom header exists
        const hasCustomHeader = c.req.header('X-Requested-With');
        // R23 (L27): Removed Content-Type bypass — application/json CAN be sent cross-origin
        // with SameSite: None cookies. X-Requested-With is the only reliable CSRF defense.
        if (!hasCustomHeader) {
            return c.json({
                error: 'CSRF Protection',
                message: 'Missing required request headers.'
            }, 403);
        }

        await next();
    };
};

/**
 * #14: Input Sanitization Middleware
 * Strips common XSS vectors from string values in JSON request bodies.
 * Applied globally to POST/PUT/PATCH requests.
 */
export const sanitizeInput = (): MiddlewareHandler<{ Bindings: Bindings; Variables: Variables }> => {
    const SCRIPT_RE = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi;
    const EVENT_RE = /\bon\w+\s*=/gi;
    const HREF_JS_RE = /javascript\s*:/gi;

    const sanitize = (val: any): any => {
        if (typeof val === 'string') {
            return val
                .replace(SCRIPT_RE, '')
                .replace(EVENT_RE, '')
                .replace(HREF_JS_RE, '');
        }
        if (Array.isArray(val)) return val.map(sanitize);
        if (val && typeof val === 'object') {
            const clean: any = {};
            for (const [k, v] of Object.entries(val)) {
                // R23: Block prototype pollution via __proto__ or constructor
                if (k === '__proto__' || k === 'constructor' || k === 'prototype') continue;
                clean[k] = sanitize(v);
            }
            return clean;
        }
        return val;
    };

    return async (c, next) => {
        const method = c.req.method;
        if (['POST', 'PUT', 'PATCH'].includes(method)) {
            const contentType = c.req.header('Content-Type') || '';
            if (contentType.includes('application/json')) {
                try {
                    const body = await c.req.json() as any /* Audit 32 SECURED */;
                    const sanitized = sanitize(body);
                    // Replace the parsed body (Hono caches req.json())
                    (c.req as any)._json = sanitized;
                } catch { /* not JSON body */ }
            }
        }
        await next();
    };
};

/**
 * #23: Global Standard Middleware Registration
 * Orchestrates all mandatory security and infrastructure middlewares in the correct order.
 * Ensures that every service in the PrimeCare mesh adheres to the same isolation and resilience standards.
 */
export function registerStandardMiddleware(app: OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>) {
    // 1. Foundation
    registerCorsMiddleware(app as any);
    registerErrorHandler(app as any);
    
    // 2. Data Context
    app.use('*', prismaMiddleware());
    
    // 3. Security Hardening
    app.use('*', csrfProtection());
    app.use('*', tenantIsolation());
    app.use('*', sanitizeInput());
}
