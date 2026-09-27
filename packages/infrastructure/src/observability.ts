// Governance - Category: service | Purpose: #R3: Observability Middleware Adds correlation IDs and request logging for tracing + debugging. Phase 3C upgrades: - ...
import { MiddlewareHandler } from 'hono';
import { Bindings, Variables } from '@primecare/contracts';

/**
 * #R3: Observability Middleware
 * Adds correlation IDs and request logging for tracing + debugging.
 *
 * Phase 3C upgrades:
 *  - Slow-request warning (>3s)
 *  - Response size tracking
 *  - Removed dead sessionTimeout() no-op
 */

/** Threshold in ms above which a request is logged at 'warn' level */
const SLOW_REQUEST_THRESHOLD_MS = 3000;

/**
 * Correlation ID Middleware
 * Generates a unique request ID for every request and passes it through to responses.
 * Enables tracing a single request across logs, errors, and downstream services.
 */
export const correlationId = (): MiddlewareHandler<{ Bindings: Bindings; Variables: Variables }> => {
    return async (c, next) => {
        // Accept client-provided correlation ID or generate one
        const reqId = c.req.header('X-Correlation-ID') || c.req.header('X-Request-ID') || crypto.randomUUID();
        c.set('requestId', reqId);
        c.header('X-Request-ID', reqId);
        c.header('X-Correlation-ID', reqId);
        await next();
    };
};

/**
 * Request Logger Middleware
 * Logs method, path, status, duration, and response size for every request.
 * Structured format for easy parsing by log aggregators (Cloudflare Logpush).
 * Emits a warning for slow requests exceeding SLOW_REQUEST_THRESHOLD_MS.
 */
export const requestLogger = (): MiddlewareHandler<{ Bindings: Bindings; Variables: Variables }> => {
    return async (c, next) => {
        const start = Date.now();
        const method = c.req.method;
        const path = c.req.path;

        await next();

        const duration = Date.now() - start;
        const status = c.res.status;
        const reqId = c.get('requestId') || '-';
        const contentLength = c.res.headers.get('Content-Length');
        const isSlow = duration > SLOW_REQUEST_THRESHOLD_MS;

        // Determine log level: error responses, slow requests, or normal
        let level: string;
        if (status >= 500) level = 'error';
        else if (status >= 400 || isSlow) level = 'warn';
        else level = 'info';

        const logFn = level === 'error' ? console.error : level === 'warn' ? console.warn : console.log;
        logFn(
            JSON.stringify({
                ts: new Date().toISOString(),
                level,
                reqId,
                method,
                path,
                status,
                ms: duration,
                ...(contentLength ? { bytes: parseInt(contentLength, 10) } : {}),
                ...(isSlow ? { slow: true } : {}),
            })
        );
    };
};
