/**
 * Sentry — Browser SDK Initialization
 *
 * Must be imported as the FIRST module in main.tsx so Sentry
 * instruments global error handlers before React mounts.
 *
 * DSN is read from VITE_SENTRY_DSN env var. When unset, Sentry
 * initializes in disabled mode (no-ops) — safe for local dev.
 */
import * as Sentry from '@sentry/react';

Sentry.init({
    dsn: import.meta.env.VITE_SENTRY_DSN || '',
    environment: import.meta.env.MODE,            // 'development' | 'production'
    release: `web-admin@${import.meta.env.VITE_APP_VERSION || '1.0.0'}`,
    enabled: !!import.meta.env.VITE_SENTRY_DSN,   // disabled when no DSN

    integrations: [
        Sentry.browserTracingIntegration(),
        Sentry.replayIntegration({
            maskAllText: false,
            blockAllMedia: false,
        }),
    ],

    // Performance monitoring — sample 10% in prod, 100% in dev
    tracesSampleRate: import.meta.env.PROD ? 0.1 : 1.0,

    // Session replay — capture 10% of sessions (100% on error)
    replaysSessionSampleRate: 0.1,
    replaysOnErrorSampleRate: 1.0,

    // Ignore noisy errors that aren't actionable
    ignoreErrors: [
        'ResizeObserver loop',
        'Network request failed',
        'Load failed',
        'ChunkLoadError',
    ],
});

export { Sentry };
