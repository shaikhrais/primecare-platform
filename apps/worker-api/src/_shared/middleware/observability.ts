import { MiddlewareHandler } from 'hono';
import { Bindings, Variables } from '../../bindings';

/**
 * #R3: Observability Middleware
 * Adds correlation IDs and request logging for tracing + debugging.
 */

/**
 * Correlation ID Middleware
 * Generates a unique request ID for every request and passes it through to responses.
 * Enables tracing a single request across logs, errors, and downstream services.
 */
export const correlationId = (): MiddlewareHandler<{ Bindings: Bindings; Variables: Variables }> => {
    return async (c, next) => {
        // Accept client-provided correlation ID or generate one
        const reqId = c.req.header('X-Request-ID') || crypto.randomUUID();
        c.set('requestId' as any, reqId);
        c.header('X-Request-ID', reqId);
        await next();
    };
};

/**
 * Request Logger Middleware
 * Logs method, path, status, and duration for every request.
 * Structured format for easy parsing by log aggregators.
 */
export const requestLogger = (): MiddlewareHandler<{ Bindings: Bindings; Variables: Variables }> => {
    return async (c, next) => {
        const start = Date.now();
        const method = c.req.method;
        const path = c.req.path;

        await next();

        const duration = Date.now() - start;
        const status = c.res.status;
        const reqId = c.get('requestId' as any) || '-';

        // Structured log format: [timestamp] [reqId] METHOD /path status durationMs
        console.log(
            JSON.stringify({
                ts: new Date().toISOString(),
                reqId,
                method,
                path,
                status,
                ms: duration,
                ...(status >= 400 ? { level: 'warn' } : { level: 'info' }),
            })
        );
    };
};

/**
 * Session timeout warning — add session expiry to response headers.
 * Frontend can read this to show "session expiring" warnings.
 */
export const sessionTimeout = (): MiddlewareHandler<{ Bindings: Bindings; Variables: Variables }> => {
    return async (c, next) => {
        await next();

        const jwtPayload = c.get('jwtPayload' as any) as { exp?: number } | undefined;
        if (jwtPayload?.exp) {
            const remainingSecs = jwtPayload.exp - Math.floor(Date.now() / 1000);
            c.header('X-Session-Expires-In', String(remainingSecs));
        }
    };
};
