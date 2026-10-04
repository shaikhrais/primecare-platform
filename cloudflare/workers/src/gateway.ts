interface Service { fetch(request: Request): Promise<Response> }
interface Env {
  AUTH: Service; CLIENT: Service; PROVIDER: Service; VISIT: Service;
  NOTES: Service; BILLING: Service; SCHEDULING: Service; NOTIFICATION: Service;
  VERIFICATION: Service; COMPLIANCE: Service; GOVERNANCE: Service; FRANCHISE_REPORTING: Service;
}

const routes: Record<string, keyof Env> = {
  auth: 'AUTH', client: 'CLIENT', provider: 'PROVIDER', providers: 'PROVIDER',
  visit: 'VISIT', visits: 'VISIT', notes: 'NOTES', billing: 'BILLING', scheduling: 'SCHEDULING',
  notification: 'NOTIFICATION', notifications: 'NOTIFICATION', verification: 'VERIFICATION',
  compliance: 'COMPLIANCE', governance: 'GOVERNANCE', 'franchise-reporting': 'FRANCHISE_REPORTING',
};

function corsHeaders(request: Request): Headers {
  const origin = request.headers.get('Origin');
  const allowed = origin && /^https:\/\/(?:[a-z0-9-]+\.)?primecare-[a-z0-9-]+\.pages\.dev$/.test(origin);
  const headers = new Headers({
    'Access-Control-Allow-Methods': 'GET,POST,PUT,PATCH,DELETE,OPTIONS',
    'Access-Control-Allow-Headers': 'Authorization,Content-Type,X-Device-Id,X-Tenant-Id,X-Requested-With,X-Device-Fingerprint,X-Request-Id,X-Correlation-Id,X-Request-Signature,X-App-Version',
    'Access-Control-Max-Age': '86400',
    Vary: 'Origin',
  });
  if (allowed) headers.set('Access-Control-Allow-Origin', origin);
  return headers;
}

function withGatewayHeaders(request: Request, response: Response): Response {
  const headers = new Headers(response.headers);
  corsHeaders(request).forEach((value, key) => headers.set(key, value));
  headers.set('x-primecare-gateway', 'cloudflare-worker-typescript');
  headers.set('cache-control', 'no-store');
  return new Response(response.body, { status: response.status, statusText: response.statusText, headers });
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    if (request.method === 'OPTIONS') {
      const origin = request.headers.get('Origin');
      const headers = corsHeaders(request);
      return new Response(null, { status: origin && headers.has('Access-Control-Allow-Origin') ? 204 : 403, headers });
    }
    const url = new URL(request.url);
    if(url.pathname==='/v1/user/change-password' && request.method==='POST') {
      url.hostname='service';url.pathname='/change-password';
      return withGatewayHeaders(request,await env.AUTH.fetch(new Request(url,request)));
    }
    if(/^\/v1\/admin\/users(?:\/audit|\/[^/]+\/sessions)?$/.test(url.pathname)) {
      url.hostname='service';url.pathname=url.pathname.slice(3);
      return withGatewayHeaders(request,await env.AUTH.fetch(new Request(url,request)));
    }
    if (url.pathname === '/health') {
      const unique = Object.entries(routes).filter(([name]) => !['providers', 'visits', 'notifications'].includes(name));
      const checks = await Promise.all(unique.map(async ([name, binding]) => {
        try { const response = await env[binding].fetch(new Request('https://service/health')); return [name, response.ok]; }
        catch { return [name, false]; }
      }));
      const services = Object.fromEntries(checks);
      const healthy = Object.values(services).every(Boolean);
      return withGatewayHeaders(request, Response.json(
        { status: healthy ? 'healthy' : 'degraded', runtime: 'cloudflare-worker-typescript', services },
        { status: healthy ? 200 : 503 },
      ));
    }
    const match = url.pathname.match(/^\/(?:v1|api)\/([^/]+)(\/.*)?$/);
    if (!match || !routes[match[1]]) return withGatewayHeaders(request, Response.json({ error: 'Route not found' }, { status: 404 }));
    url.hostname = 'service';
    url.pathname = match[2] || '/';
    const response = await env[routes[match[1]]].fetch(new Request(url, request));
    return withGatewayHeaders(request, response);
  },
} satisfies ExportedHandler<Env>;
