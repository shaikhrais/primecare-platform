interface ServiceBinding { fetch(request: Request): Promise<Response> }

interface Env {
  AUTH: ServiceBinding;
  CLIENT: ServiceBinding;
  PROVIDER: ServiceBinding;
  VISIT: ServiceBinding;
  NOTES: ServiceBinding;
  BILLING: ServiceBinding;
  SCHEDULING: ServiceBinding;
  NOTIFICATION: ServiceBinding;
  VERIFICATION: ServiceBinding;
  COMPLIANCE: ServiceBinding;
  GOVERNANCE: ServiceBinding;
  FRANCHISE_REPORTING: ServiceBinding;
}

const routes: Record<string, keyof Env> = {
  auth: 'AUTH', client: 'CLIENT', provider: 'PROVIDER', providers: 'PROVIDER',
  visit: 'VISIT', visits: 'VISIT', notes: 'NOTES', billing: 'BILLING',
  scheduling: 'SCHEDULING', notification: 'NOTIFICATION', notifications: 'NOTIFICATION',
  verification: 'VERIFICATION', compliance: 'COMPLIANCE', governance: 'GOVERNANCE',
  'franchise-reporting': 'FRANCHISE_REPORTING',
};

function corsHeaders(origin: string | null): Record<string, string> {
  const allowed = !origin ||
    /^https:\/\/primecare-[a-z0-9-]+\.pages\.dev$/.test(origin) ||
    /^https:\/\/[a-z0-9.-]+\.primecare\.ca$/.test(origin);
  if (!allowed) return {};
  return {
    'access-control-allow-origin': origin ?? '*',
    'access-control-allow-methods': 'GET,POST,PUT,PATCH,DELETE,OPTIONS',
    'access-control-allow-headers': 'Authorization,Content-Type,X-Device-Id,X-Tenant-Id',
    vary: 'Origin',
  };
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const origin = request.headers.get('origin');
    const cors = corsHeaders(origin);
    if (origin && !cors['access-control-allow-origin']) {
      return new Response('Origin not allowed', { status: 403 });
    }
    if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers: cors });

    const incoming = new URL(request.url);
    if (incoming.pathname === '/health') {
      const checks = await Promise.all(Object.entries(routes)
        .filter(([route]) => !['providers', 'visits', 'notifications'].includes(route))
        .map(async ([route, binding]) => {
          try {
            const result = await env[binding].fetch(new Request(`https://service/health`));
            return [route, result.ok ? 'healthy' : `http-${result.status}`];
          } catch { return [route, 'unavailable']; }
        }));
      const services = Object.fromEntries(checks);
      const healthy = Object.values(services).every(value => value === 'healthy');
      return Response.json({ status: healthy ? 'healthy' : 'degraded', services }, {
        status: healthy ? 200 : 503, headers: cors,
      });
    }

    const match = incoming.pathname.match(/^\/(?:v1|api)\/([^/]+)(\/.*)?$/);
    if (!match || !routes[match[1]]) {
      return Response.json({ error: 'Route not found' }, { status: 404, headers: cors });
    }
    const binding = routes[match[1]];
    const target = new URL(request.url);
    target.hostname = 'service';
    target.pathname = match[2] || '/';
    const response = await env[binding].fetch(new Request(target, request));
    const headers = new Headers(response.headers);
    Object.entries(cors).forEach(([key, value]) => headers.set(key, value));
    headers.set('x-primecare-gateway', 'cloudflare-worker');
    return new Response(response.body, {
      status: response.status, statusText: response.statusText, headers,
    });
  },
};
