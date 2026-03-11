// PrimeCare Service Worker — Offline-First Strategy
// Version-based cache busting
const CACHE_VERSION = 'pc-v1';
const STATIC_CACHE = `${CACHE_VERSION}-static`;
const API_CACHE = `${CACHE_VERSION}-api`;
const OFFLINE_QUEUE_KEY = 'pc-offline-queue';

// Static assets to pre-cache on install
const PRE_CACHE_URLS = [
    '/',
    '/manifest.json',
];

// ─── Install: Pre-cache the app shell ───
self.addEventListener('install', (event) => {
    console.log('[SW] Installing PrimeCare Service Worker');
    event.waitUntil(
        caches.open(STATIC_CACHE).then((cache) => {
            return cache.addAll(PRE_CACHE_URLS);
        })
    );
    self.skipWaiting();
});

// ─── Activate: Clean up old caches ───
self.addEventListener('activate', (event) => {
    console.log('[SW] Activating PrimeCare Service Worker');
    event.waitUntil(
        caches.keys().then((keys) => {
            return Promise.all(
                keys
                    .filter((key) => key.startsWith('pc-') && key !== STATIC_CACHE && key !== API_CACHE)
                    .map((key) => caches.delete(key))
            );
        })
    );
    self.clients.claim();
});

// ─── Fetch strategy ───
self.addEventListener('fetch', (event) => {
    const url = new URL(event.request.url);

    // Skip non-GET requests (they go through the offline queue system)
    if (event.request.method !== 'GET') return;

    // Skip chrome-extension requests to avoid Cache API errors
    if (url.protocol === 'chrome-extension:') return;

    // API calls: Network-first, fall back to cache
    if (url.pathname.startsWith('/api/') || url.pathname.startsWith('/v1/')) {
        event.respondWith(networkFirstStrategy(event.request));
        return;
    }

    // Static assets (JS, CSS, images, fonts): Cache-first
    if (isStaticAsset(url.pathname)) {
        event.respondWith(cacheFirstStrategy(event.request));
        return;
    }

    // HTML pages: Network-first (SPA — always serve index.html from cache if offline)
    event.respondWith(networkFirstStrategy(event.request));
});

// ─── Cache-First: Good for versioned static assets ───
async function cacheFirstStrategy(request) {
    const cached = await caches.match(request);
    if (cached) return cached;

    try {
        const response = await fetch(request);
        if (response.ok) {
            const cache = await caches.open(STATIC_CACHE);
            cache.put(request, response.clone());
        }
        return response;
    } catch (err) {
        // Return a minimal offline page if nothing is cached
        return new Response('Offline', { status: 503, statusText: 'Service Unavailable' });
    }
}

// ─── Network-First: Good for dynamic content ───
async function networkFirstStrategy(request) {
    try {
        const response = await fetch(request);
        if (response.ok) {
            const cache = await caches.open(API_CACHE);
            cache.put(request, response.clone());
        }
        return response;
    } catch (err) {
        const cached = await caches.match(request);
        if (cached) return cached;

        // For navigation requests, serve the cached root (SPA)
        if (request.mode === 'navigate') {
            const fallback = await caches.match('/');
            if (fallback) return fallback;
        }

        return new Response(JSON.stringify({ error: 'Offline', queued: true }), {
            status: 503,
            headers: { 'Content-Type': 'application/json' },
        });
    }
}

// ─── Offline POST Queue (Background Sync) ───
self.addEventListener('sync', (event) => {
    if (event.tag === 'pc-offline-sync') {
        event.waitUntil(processOfflineQueue());
    }
});

async function processOfflineQueue() {
    const queue = await getOfflineQueue();
    const remaining = [];

    for (const item of queue) {
        try {
            const response = await fetch(item.url, {
                method: item.method,
                headers: item.headers,
                body: item.body,
            });
            if (!response.ok) remaining.push(item);
        } catch (err) {
            remaining.push(item);
        }
    }

    await saveOfflineQueue(remaining);
}

// ─── Push Notification Handler ───
self.addEventListener('push', (event) => {
    if (!event.data) return;

    const data = event.data.json();
    const options = {
        body: data.body || 'New notification from PrimeCare',
        icon: '/primecare-icon.png',
        badge: '/primecare-icon.png',
        vibrate: [100, 50, 100],
        data: { url: data.url || '/' },
        actions: data.actions || [],
    };

    event.waitUntil(self.registration.showNotification(data.title || 'PrimeCare', options));
});

// Handle notification clicks
self.addEventListener('notificationclick', (event) => {
    event.notification.close();
    const url = event.notification.data?.url || '/';
    event.waitUntil(
        self.clients.matchAll({ type: 'window' }).then((clients) => {
            const existing = clients.find((c) => c.url.includes(url));
            if (existing) return existing.focus();
            return self.clients.openWindow(url);
        })
    );
});

// ─── Message handler: Queue offline POST requests from the app ───
self.addEventListener('message', (event) => {
    if (event.data?.type === 'QUEUE_OFFLINE_REQUEST') {
        getOfflineQueue().then((queue) => {
            queue.push(event.data.payload);
            saveOfflineQueue(queue);
        });
    }

    if (event.data?.type === 'GET_OFFLINE_QUEUE') {
        getOfflineQueue().then((queue) => {
            event.ports[0].postMessage(queue);
        });
    }

    if (event.data?.type === 'SKIP_WAITING') {
        self.skipWaiting();
    }
});

// ─── Helper: Detect static assets ───
function isStaticAsset(pathname) {
    return /\.(js|css|png|jpg|jpeg|gif|svg|woff2?|ttf|eot|ico|webp)$/.test(pathname)
        || pathname.startsWith('/assets/');
}

// ─── Helper: IndexedDB-backed offline queue ───
async function getOfflineQueue() {
    try {
        const cache = await caches.open('pc-offline-queue');
        const response = await cache.match('queue');
        if (!response) return [];
        return await response.json();
    } catch {
        return [];
    }
}

async function saveOfflineQueue(queue) {
    const cache = await caches.open('pc-offline-queue');
    await cache.put('queue', new Response(JSON.stringify(queue)));
}
