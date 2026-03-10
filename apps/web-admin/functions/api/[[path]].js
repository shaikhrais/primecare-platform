// Cloudflare Pages Function: Proxy /api/* -> Worker API
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

    const headers = new Headers(context.request.headers);
    headers.delete('host');

    const proxyRequest = new Request(targetUrl, {
        method: context.request.method,
        headers,
        body: context.request.method !== 'GET' && context.request.method !== 'HEAD' ? context.request.body : null,
        redirect: 'manual',
        duplex: 'half'
    });

    try {
        const response = await fetch(proxyRequest);
        return response;
    } catch (err) {
        return new Response(JSON.stringify({ error: 'API unavailable' }), {
            status: 503,
            headers: { 'Content-Type': 'application/json' },
        });
    }
}
