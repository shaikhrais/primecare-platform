// Governance - Category: adapter | Purpose: Sentry Middleware for Cloudflare Workers Wraps the Hono app's fetch handler with Sentry error tracking. Uses @sentry/...
/**
 * Sentry Middleware for Cloudflare Workers
 *
 * Wraps the Hono app's fetch handler with Sentry error tracking.
 * Uses @sentry/cloudflare which is purpose-built for the Workers runtime.
 */
import * as Sentry from '@sentry/cloudflare';

/**
 * Initialize and wrap the worker export with Sentry.
 * Call this in the main export instead of exporting the app directly.
 */
export function withSentryWorker(handler: ExportedHandler<any>) {
    return Sentry.withSentry(
        (env: any) => ({
            dsn: env.SENTRY_DSN,
            tracesSampleRate: env.ENVIRONMENT === 'production' ? 0.1 : 1.0,
            environment: env.ENVIRONMENT || 'development',
            release: `worker-api@${env.API_VERSION || '1.0.0'}`,
        }),
        handler,
    );
}

/**
 * Capture an exception with contextual request data.
 * Call this from error handlers (cors-wrapper, middleware, etc.)
 */
export function captureWorkerException(
    err: Error,
    context?: {
        path?: string;
        method?: string;
        correlationId?: string;
        tenantId?: string;
    },
): void {
    Sentry.withScope((scope) => {
        if (context?.correlationId) scope.setTag('correlationId', context.correlationId);
        if (context?.tenantId) scope.setTag('tenantId', context.tenantId);
        if (context?.path) scope.setTag('request.path', context.path);
        if (context?.method) scope.setTag('request.method', context.method);
        Sentry.captureException(err);
    });
}
