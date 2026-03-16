/**
 * Service Worker Registration & Bridge
 *
 * Registers the service worker, handles updates, and provides
 * a typed interface for the app to communicate with the SW.
 */

type SWStatus = 'installing' | 'waiting' | 'active' | 'redundant' | 'unsupported' | 'error';

interface SWBridge {
    status: SWStatus;
    registration: ServiceWorkerRegistration | null;
    /** Queue a mutation for offline replay */
    queueOfflineRequest: (url: string, method: string, headers: Record<string, string>, body: string) => void;
    /** Get the pending offline queue */
    getOfflineQueue: () => Promise<any[]>;
    /** Clear the offline queue */
    clearOfflineQueue: () => void;
    /** Get cache status (sizes, version) */
    getCacheStatus: () => Promise<any>;
    /** Proactively cache an API response */
    cacheApiResponse: (url: string, body: any) => void;
    /** Force activate a waiting SW */
    skipWaiting: () => void;
}

let swRegistration: ServiceWorkerRegistration | null = null;
let swStatus: SWStatus = 'unsupported';

/**
 * Register the PrimeCare service worker
 * Call this once from main.tsx or AppProviders
 */
export async function registerServiceWorker(
    onUpdate?: () => void,
    onSuccess?: () => void,
    onSyncComplete?: (result: { synced: number; remaining: number; failed: number }) => void,
): Promise<SWBridge> {
    if (!('serviceWorker' in navigator)) {
        console.warn('[PWA] Service Workers not supported');
        return createBridge('unsupported', null);
    }

    try {
        const registration = await navigator.serviceWorker.register('/sw.js', { scope: '/' });
        swRegistration = registration;
        console.log('[PWA] Service Worker registered, scope:', registration.scope);

        // Track lifecycle
        registration.addEventListener('updatefound', () => {
            const newWorker = registration.installing;
            if (!newWorker) return;

            newWorker.addEventListener('statechange', () => {
                if (newWorker.state === 'installed') {
                    if (navigator.serviceWorker.controller) {
                        // New version available
                        swStatus = 'waiting';
                        console.log('[PWA] New version available — waiting to activate');
                        onUpdate?.();
                    } else {
                        // First install
                        swStatus = 'active';
                        console.log('[PWA] Content cached for offline use');
                        onSuccess?.();
                    }
                }
            });
        });

        // Listen for SW messages
        navigator.serviceWorker.addEventListener('message', (event) => {
            if (event.data?.type === 'SYNC_COMPLETE') {
                console.log('[PWA] Offline sync complete:', event.data);
                onSyncComplete?.(event.data);
            }
        });

        // Register periodic background sync if supported
        if ('periodicSync' in registration) {
            try {
                await (registration as any).periodicSync.register('pc-data-refresh', {
                    minInterval: 60 * 60 * 1000, // 1 hour
                });
                console.log('[PWA] Periodic background sync registered');
            } catch {
                console.log('[PWA] Periodic sync not granted');
            }
        }

        swStatus = registration.active ? 'active' : 'installing';
        return createBridge(swStatus, registration);
    } catch (err) {
        console.error('[PWA] Registration failed:', err);
        swStatus = 'error';
        return createBridge('error', null);
    }
}

function createBridge(status: SWStatus, registration: ServiceWorkerRegistration | null): SWBridge {
    return {
        status,
        registration,

        queueOfflineRequest(url, method, headers, body) {
            navigator.serviceWorker.controller?.postMessage({
                type: 'QUEUE_OFFLINE_REQUEST',
                payload: { url, method, headers, body },
            });
        },

        getOfflineQueue() {
            return new Promise((resolve) => {
                if (!navigator.serviceWorker.controller) { resolve([]); return; }
                const channel = new MessageChannel();
                channel.port1.onmessage = (e) => resolve(e.data || []);
                navigator.serviceWorker.controller.postMessage(
                    { type: 'GET_OFFLINE_QUEUE' },
                    [channel.port2],
                );
                setTimeout(() => resolve([]), 2000); // Timeout fallback
            });
        },

        clearOfflineQueue() {
            navigator.serviceWorker.controller?.postMessage({ type: 'CLEAR_OFFLINE_QUEUE' });
        },

        getCacheStatus() {
            return new Promise((resolve) => {
                if (!navigator.serviceWorker.controller) { resolve({}); return; }
                const channel = new MessageChannel();
                channel.port1.onmessage = (e) => resolve(e.data || {});
                navigator.serviceWorker.controller.postMessage(
                    { type: 'GET_CACHE_STATUS' },
                    [channel.port2],
                );
                setTimeout(() => resolve({}), 2000);
            });
        },

        cacheApiResponse(url, body) {
            navigator.serviceWorker.controller?.postMessage({
                type: 'CACHE_API_RESPONSE',
                url,
                body,
            });
        },

        skipWaiting() {
            navigator.serviceWorker.controller?.postMessage({ type: 'SKIP_WAITING' });
            registration?.waiting?.postMessage({ type: 'SKIP_WAITING' });
        },
    };
}
