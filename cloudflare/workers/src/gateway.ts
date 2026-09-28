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

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    if (url.pathname === '/health') {
      const unique = Object.entries(routes).filter(([name]) => !['providers', 'visits', 'notifications'].includes(name));
      const checks = await Promise.all(unique.map(async ([name, binding]) => {
        try { const response = await env[binding].fetch(new Request('https://service/health')); return [name, response.ok]; }
        catch { return [name, false]; }
      }));
      const services = Object.fromEntries(checks);
      const healthy = Object.values(services).every(Boolean);
      return Response.json({ status: healthy ? 'healthy' : 'degraded', services }, { status: healthy ? 200 : 503 });
    }
    const match = url.pathname.match(/^\/(?:v1|api)\/([^/]+)(\/.*)?$/);
    if (!match || !routes[match[1]]) return Response.json({ error: 'Route not found' }, { status: 404 });
    url.hostname = 'service';
    url.pathname = match[2] || '/';
    const response = await env[routes[match[1]]].fetch(new Request(url, request));
    const headers = new Headers(response.headers);
    headers.set('x-primecare-gateway', 'cloudflare-worker-typescript');
    return new Response(response.body, { status: response.status, statusText: response.statusText, headers });
  },
} satisfies ExportedHandler<Env>;
