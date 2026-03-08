// Cloudflare Pages Function: Proxy /api/* -> Worker API
// Includes retry for cold-start resilience (first Prisma call may fail)
export async function onRequest(context) {
    const url = new URL(context.request.url);
    const apiPath = url.pathname.replace(/^\/api/, '');
    const targetUrl = `https://primecare-api.itpro-mohammed.workers.dev${apiPath}${url.search}`;

    // Handle OPTIONS preflight
    if (context.request.method === 'OPTIONS') {
        return new Response(null, {
            status: 204,
            headers: {
                'Access-Control-Allow-Origin': url.origin,
                'Access-Control-Allow-Methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Tenant-ID, X-Device-ID',
                'Access-Control-Allow-Credentials': 'true',
                'Access-Control-Max-Age': '86400',
            },
        });
    }

    // Clone headers (remove host to avoid conflicts)
    const headers = new Headers(context.request.headers);
    headers.delete('host');

    // Read body once for potential retry (streams can only be read once)
    let bodyContent = null;
    if (context.request.method !== 'GET' && context.request.method !== 'HEAD') {
        try { bodyContent = await context.request.arrayBuffer(); } catch { }
    }

    const maxAttempts = 2;
    let lastResponse;

    for (let attempt = 0; attempt < maxAttempts; attempt++) {
        try {
            const proxyRequest = new Request(targetUrl, {
                method: context.request.method,
                headers,
                body: bodyContent,
            });

            lastResponse = await fetch(proxyRequest);

            // If success or client error (4xx), return immediately
            if (lastResponse.status < 500) {
                return lastResponse;
            }

            // On 500, retry after delay (cold start warm-up)
            if (attempt < maxAttempts - 1) {
                await new Promise(r => setTimeout(r, 1500));
            }
        } catch (err) {
            if (attempt >= maxAttempts - 1) {
                return new Response(JSON.stringify({ error: 'API unavailable', _proxy: true }), {
                    status: 503,
                    headers: { 'Content-Type': 'application/json' },
                });
            }
            await new Promise(r => setTimeout(r, 1500));
        }
    }

    // Return last response (may be 500 if all retries failed)
    return lastResponse || new Response(JSON.stringify({ error: 'API unavailable' }), {
        status: 503,
        headers: { 'Content-Type': 'application/json' },
    });
}
