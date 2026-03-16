/**
 * Global Error Capture — catches unhandled JS errors and promise rejections
 *
 * Sends structured telemetry payloads to /v1/telemetry/errors via sendBeacon
 * (fire-and-forget). Complements the React ErrorBoundary which only catches
 * errors within the React tree.
 *
 * Initialize once in main.tsx before React mounts.
 */

const TELEMETRY_ENDPOINT = '/v1/telemetry/errors';

/** Rate-limit: max 10 error reports per minute to avoid flooding */
let errorCount = 0;
const MAX_ERRORS_PER_MINUTE = 10;
setInterval(() => { errorCount = 0; }, 60_000);

function sendTelemetry(payload: Record<string, unknown>): void {
    if (errorCount >= MAX_ERRORS_PER_MINUTE) return;
    errorCount++;
    try {
        const body = JSON.stringify(payload);
        if (navigator.sendBeacon) {
            navigator.sendBeacon(TELEMETRY_ENDPOINT, new Blob([body], { type: 'application/json' }));
        } else {
            fetch(TELEMETRY_ENDPOINT, { method: 'POST', body, headers: { 'Content-Type': 'application/json' }, keepalive: true }).catch(() => {});
        }
    } catch { /* never let telemetry compound the original error */ }
}

/**
 * Initialize global error capture handlers.
 * Call once at app startup, before React.createRoot().
 */
export function initGlobalErrorCapture(): void {
    // Uncaught JS errors (syntax errors, null reference, etc.)
    window.addEventListener('error', (event: ErrorEvent) => {
        sendTelemetry({
            type: 'UNCAUGHT_ERROR',
            timestamp: new Date().toISOString(),
            url: window.location.href,
            error: {
                name: event.error?.name || 'Error',
                message: event.message || 'Unknown error',
                stack: event.error?.stack?.split('\n').slice(0, 5).join('\n'),
            },
            source: `${event.filename}:${event.lineno}:${event.colno}`,
            userAgent: navigator.userAgent,
        });
    });

    // Unhandled promise rejections
    window.addEventListener('unhandledrejection', (event: PromiseRejectionEvent) => {
        const reason = event.reason;
        sendTelemetry({
            type: 'UNHANDLED_REJECTION',
            timestamp: new Date().toISOString(),
            url: window.location.href,
            error: {
                name: reason?.name || 'UnhandledRejection',
                message: reason?.message || String(reason),
                stack: reason?.stack?.split('\n').slice(0, 5).join('\n'),
            },
            userAgent: navigator.userAgent,
        });
    });
}
