// PrimeCare Service Worker — Maximum Offline Coverage
// Version-based cache busting
const CACHE_VERSION = 'pc-v3';
const STATIC_CACHE = `${CACHE_VERSION}-static`;
const API_CACHE = `${CACHE_VERSION}-api`;
const PHOTO_CACHE = `${CACHE_VERSION}-photos`;
const FONT_CACHE = `${CACHE_VERSION}-fonts`;

// ── Pre-cache: App shell + critical routes ───────────────────────────────
const PRE_CACHE_URLS = [
    '/',
    '/manifest.json',
    '/primecare-icon.png',
];

// API routes to cache aggressively (user's own data)
const CACHE_FIRST_API = [
    '/v1/auth/me',
    '/v1/system/feature-flags',
];

// API routes to use stale-while-revalidate
const STALE_REVALIDATE_API = [
    '/v1/manager/schedule',
    '/v1/staff/schedule',
    '/v1/client/family',
    '/v1/staff/visits',
    '/v1/manager/analytics',
    '/v1/admin/home',
    '/v1/staff/profile',
    '/v1/manager/staff',
    '/v1/billing/invoices',
    '/v1/client/care-plan',
    '/v1/manager/schedule/logistics-board',
    '/v1/admin/tenants',
];

// Max age for cached API responses (ms)
const API_CACHE_MAX_AGE = 5 * 60 * 1000; // 5 minutes
const STALE_MAX_AGE = 30 * 60 * 1000;     // 30 minutes stale OK

// ─── Install: Pre-cache the app shell ─────────────────────────────────
self.addEventListener('install', (event) => {
    console.log('[SW v3] Installing PrimeCare Service Worker');
    event.waitUntil(
        caches.open(STATIC_CACHE)
            .then((cache) => cache.addAll(PRE_CACHE_URLS))
            .catch((err) => console.warn('[SW] Pre-cache partial failure:', err))
    );
    self.skipWaiting();
});

// ─── Activate: Clean up old caches ────────────────────────────────────
self.addEventListener('activate', (event) => {
    console.log('[SW v3] Activating PrimeCare Service Worker');
    event.waitUntil(
        caches.keys().then((keys) =>
            Promise.all(
                keys
                    .filter((key) => key.startsWith('pc-') && ![STATIC_CACHE, API_CACHE, PHOTO_CACHE, FONT_CACHE].includes(key))
                    .map((key) => { console.log('[SW] Purging old cache:', key); return caches.delete(key); })
            )
        )
    );
    self.clients.claim();
});

// ─── Fetch: Multi-strategy routing ────────────────────────────────────
self.addEventListener('fetch', (event) => {
    const url = new URL(event.request.url);

    // Skip non-GET, chrome-extension, and WebSocket requests
    if (event.request.method !== 'GET') return;
    if (url.protocol === 'chrome-extension:') return;
    if (url.pathname.startsWith('/ws') || url.pathname.includes('websocket')) return;

    // 1. Fonts: Cache-first (immutable)
    if (url.hostname === 'fonts.googleapis.com' || url.hostname === 'fonts.gstatic.com') {
        event.respondWith(immutableCacheFirst(event.request, FONT_CACHE));
        return;
    }

    // 2. Images/photos: Cache-first
    if (/\.(png|jpg|jpeg|gif|svg|webp|ico)$/.test(url.pathname) || url.pathname.startsWith('/photos/')) {
        event.respondWith(immutableCacheFirst(event.request, PHOTO_CACHE));
        return;
    }

    // 3. Static assets (JS, CSS, WOFF): Cache-first (hashed filenames)
    if (isStaticAsset(url.pathname)) {
        event.respondWith(immutableCacheFirst(event.request, STATIC_CACHE));
        return;
    }

    // 4. API: Check if it's a stale-while-revalidate route
    if (url.pathname.startsWith('/api/') || url.pathname.startsWith('/v1/')) {
        const matchedSWR = STALE_REVALIDATE_API.some(p => url.pathname.includes(p));
        if (matchedSWR) {
            event.respondWith(staleWhileRevalidate(event.request));
            return;
        }
        // Default API: Network-first
        event.respondWith(networkFirst(event.request));
        return;
    }

    // 5. Navigation: Network-first with SPA fallback
    if (event.request.mode === 'navigate') {
        event.respondWith(networkFirstNavigation(event.request));
        return;
    }

    // Default: Network-first
    event.respondWith(networkFirst(event.request));
});

// ─── Strategy: Immutable Cache-First ──────────────────────────────────
async function immutableCacheFirst(request, cacheName) {
    const cached = await caches.match(request);
    if (cached) return cached;

    try {
        const response = await fetch(request);
        if (response.ok) {
            const cache = await caches.open(cacheName);
            cache.put(request, response.clone());
        }
        return response;
    } catch {
        return new Response('', { status: 503 });
    }
}

// ─── Strategy: Network-First ──────────────────────────────────────────
async function networkFirst(request) {
    try {
        const response = await fetch(request);
        // Only cache 200 OK — prevents cache poisoning from 401/500
        if (response.ok && response.status === 200) {
            const cache = await caches.open(API_CACHE);
            const clone = response.clone();
            // Add timestamp header for staleness checks
            const headers = new Headers(clone.headers);
            headers.set('sw-cached-at', Date.now().toString());
            cache.put(request, new Response(clone.body, { status: 200, headers }));
        }
        return response;
    } catch {
        const cached = await caches.match(request);
        if (cached) {
            // Add offline indicator header
            const headers = new Headers(cached.headers);
            headers.set('x-served-from', 'cache');
            return new Response(cached.body, { status: cached.status, headers });
        }

        if (request.mode === 'navigate') {
            const fallback = await caches.match('/');
            if (fallback) return fallback;
        }

        return new Response(JSON.stringify({ error: 'You are offline', offline: true }), {
            status: 503,
            headers: { 'Content-Type': 'application/json' },
        });
    }
}

// ─── Strategy: Network-First Navigation (SPA) ────────────────────────
async function networkFirstNavigation(request) {
    try {
        const response = await fetch(request);
        if (response.ok) {
            const cache = await caches.open(STATIC_CACHE);
            cache.put('/', response.clone());
        }
        return response;
    } catch {
        const cached = await caches.match('/');
        if (cached) return cached;
        return offlineFallback();
    }
}

// ─── Strategy: Stale-While-Revalidate ─────────────────────────────────
async function staleWhileRevalidate(request) {
    const cache = await caches.open(API_CACHE);
    const cached = await cache.match(request);

    // Serve cached version immediately (if fresh enough)
    const revalidatePromise = fetch(request)
        .then((response) => {
            if (response.ok && response.status === 200) {
                const headers = new Headers(response.headers);
                headers.set('sw-cached-at', Date.now().toString());
                cache.put(request, new Response(response.clone().body, { status: 200, headers }));
            }
            return response;
        })
        .catch(() => null);

    if (cached) {
        const cachedAt = parseInt(cached.headers.get('sw-cached-at') || '0');
        const age = Date.now() - cachedAt;

        // If not too stale, serve immediately
        if (age < STALE_MAX_AGE) {
            // Revalidate in background silently
            revalidatePromise; // fire and forget
            const headers = new Headers(cached.headers);
            headers.set('x-served-from', age < API_CACHE_MAX_AGE ? 'cache' : 'stale-cache');
            return new Response(cached.body, { status: cached.status, headers });
        }
    }

    // No cache or too stale — wait for network
    const networkResponse = await revalidatePromise;
    if (networkResponse) return networkResponse;
    if (cached) return cached;
    return new Response(JSON.stringify({ error: 'Offline', offline: true }), {
        status: 503, headers: { 'Content-Type': 'application/json' },
    });
}

// ─── Offline Fallback Page ────────────────────────────────────────────
function offlineFallback() {
    const html = `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PrimeCare — Offline</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', -apple-system, sans-serif; background: #0F1733; color: white; display: flex; align-items: center; justify-content: center; min-height: 100vh; }
        .container { text-align: center; padding: 40px; max-width: 400px; }
        .icon { font-size: 4rem; margin-bottom: 24px; animation: float 3s ease-in-out infinite; }
        @keyframes float { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-10px); } }
        h1 { font-size: 1.5rem; font-weight: 800; margin-bottom: 8px; }
        p { color: #94A3B8; font-size: 0.9rem; line-height: 1.6; margin-bottom: 24px; }
        button { padding: 12px 32px; border: none; border-radius: 10px; background: #2563EB; color: white; font-weight: 700; font-size: 0.9rem; cursor: pointer; }
        button:hover { background: #1D4ED8; }
        .queue-count { margin-top: 16px; font-size: 0.75rem; color: #64748B; }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">📡</div>
        <h1>You're Offline</h1>
        <p>Don't worry — any actions you've taken are saved and will sync automatically when your connection returns.</p>
        <button onclick="location.reload()">Try Again</button>
        <div class="queue-count" id="queue-info"></div>
    </div>
    <script>
        caches.open('pc-offline-queue').then(c => c.match('queue')).then(r => r?.json()).then(q => {
            if (q?.length) document.getElementById('queue-info').textContent = q.length + ' pending changes will sync when online';
        });
    </script>
</body>
</html>`;
    return new Response(html, { status: 200, headers: { 'Content-Type': 'text/html' } });
}

// ─── Background Sync: Replay offline mutations ───────────────────────
self.addEventListener('sync', (event) => {
    if (event.tag === 'pc-offline-sync') {
        event.waitUntil(processOfflineQueue());
    }
});

// Periodic background sync (requires permission)
self.addEventListener('periodicsync', (event) => {
    if (event.tag === 'pc-data-refresh') {
        event.waitUntil(refreshCriticalData());
    }
});

async function refreshCriticalData() {
    const cache = await caches.open(API_CACHE);
    for (const url of STALE_REVALIDATE_API) {
        try {
            const response = await fetch(url);
            if (response.ok) {
                const headers = new Headers(response.headers);
                headers.set('sw-cached-at', Date.now().toString());
                await cache.put(new Request(url), new Response(response.body, { status: 200, headers }));
            }
        } catch { /* silently skip */ }
    }
}

async function processOfflineQueue() {
    const queue = await getOfflineQueue();
    if (!queue.length) return;

    const remaining = [];
    let synced = 0;

    for (const item of queue) {
        try {
            const response = await fetch(item.url, {
                method: item.method,
                headers: item.headers,
                body: item.body,
            });
            if (response.ok) {
                synced++;
            } else if (response.status >= 500) {
                // Server error — retry later
                remaining.push({ ...item, retryCount: (item.retryCount || 0) + 1 });
            }
            // 4xx errors are permanent failures — don't re-queue
        } catch {
            remaining.push({ ...item, retryCount: (item.retryCount || 0) + 1 });
        }
    }

    // Remove items that exceeded max retries
    const retryable = remaining.filter(i => (i.retryCount || 0) < 5);
    await saveOfflineQueue(retryable);

    // Notify all clients about sync results
    const clients = await self.clients.matchAll();
    clients.forEach((client) => {
        client.postMessage({
            type: 'SYNC_COMPLETE',
            synced,
            remaining: retryable.length,
            failed: remaining.length - retryable.length,
        });
    });
}

// ─── Push Notifications ───────────────────────────────────────────────
self.addEventListener('push', (event) => {
    if (!event.data) return;
    let data;
    try { data = event.data.json(); } catch { data = { title: 'PrimeCare', body: event.data.text() }; }

    event.waitUntil(
        self.registration.showNotification(data.title || 'PrimeCare', {
            body: data.body || 'New notification',
            icon: '/primecare-icon.png',
            badge: '/primecare-icon.png',
            vibrate: [100, 50, 100],
            tag: data.tag || 'default',
            renotify: !!data.tag,
            data: { url: data.url || '/' },
            actions: data.actions || [
                { action: 'open', title: 'Open' },
                { action: 'dismiss', title: 'Dismiss' },
            ],
        })
    );
});

self.addEventListener('notificationclick', (event) => {
    event.notification.close();
    if (event.action === 'dismiss') return;

    const url = event.notification.data?.url || '/';
    event.waitUntil(
        self.clients.matchAll({ type: 'window', includeUncontrolled: true }).then((clients) => {
            const existing = clients.find((c) => new URL(c.url).pathname === url);
            if (existing) return existing.focus();
            return self.clients.openWindow(url);
        })
    );
});

// ─── Message Channel: App ↔ SW Communication ─────────────────────────
self.addEventListener('message', (event) => {
    switch (event.data?.type) {
        case 'QUEUE_OFFLINE_REQUEST':
            getOfflineQueue().then((queue) => {
                queue.push({ ...event.data.payload, timestamp: Date.now(), retryCount: 0 });
                saveOfflineQueue(queue);
                // Trigger background sync if available
                if (self.registration.sync) {
                    self.registration.sync.register('pc-offline-sync');
                }
            });
            break;

        case 'GET_OFFLINE_QUEUE':
            getOfflineQueue().then((queue) => {
                event.ports[0]?.postMessage(queue);
            });
            break;

        case 'CLEAR_OFFLINE_QUEUE':
            saveOfflineQueue([]);
            break;

        case 'GET_CACHE_STATUS':
            getCacheStatus().then((status) => {
                event.ports[0]?.postMessage(status);
            });
            break;

        case 'SKIP_WAITING':
            self.skipWaiting();
            break;

        case 'CACHE_API_RESPONSE':
            // App can proactively cache data
            if (event.data.url && event.data.body) {
                caches.open(API_CACHE).then((cache) => {
                    const headers = new Headers({ 'Content-Type': 'application/json', 'sw-cached-at': Date.now().toString() });
                    cache.put(new Request(event.data.url), new Response(JSON.stringify(event.data.body), { status: 200, headers }));
                });
            }
            break;
    }
});

// ─── Helpers ──────────────────────────────────────────────────────────
function isStaticAsset(pathname) {
    return /\.(js|css|woff2?|ttf|eot)$/.test(pathname) || pathname.startsWith('/assets/');
}

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

async function getCacheStatus() {
    const keys = await caches.keys();
    const sizes = {};
    for (const key of keys) {
        if (!key.startsWith('pc-')) continue;
        const cache = await caches.open(key);
        const entries = await cache.keys();
        sizes[key] = entries.length;
    }
    const queue = await getOfflineQueue();
    return { caches: sizes, queueLength: queue.length, version: CACHE_VERSION };
}
