import { Container, getRandom } from '@cloudflare/containers';
import { env } from 'cloudflare:workers';

interface Env {
  API_CONTAINER: DurableObjectNamespace;
  DATABASE_URL: string;
  SERVICE_NAME: string;
}

const INSTANCE_COUNT = 2;

export class ApiContainer extends Container {
  defaultPort = 8080;
  sleepAfter = '10m';
  enableInternet = true;
  envVars = {
    DATABASE_URL: (env as unknown as { DATABASE_URL: string }).DATABASE_URL,
    DB_SSL_MODE: 'require',
    ENABLE_MOCK_UI: 'false',
  };
}

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
  async fetch(request: Request, bindings: Env): Promise<Response> {
    const origin = request.headers.get('origin');
    const cors = corsHeaders(origin);
    if (origin && !cors['access-control-allow-origin']) {
      return new Response('Origin not allowed', { status: 403 });
    }
    if (request.method === 'OPTIONS') {
      return new Response(null, { status: 204, headers: cors });
    }

    const container = await getRandom(bindings.API_CONTAINER, INSTANCE_COUNT);
    if (new URL(request.url).pathname === '/health') {
      try {
        const probe = await container.fetch(new Request(new URL('/', request.url), {
          method: 'GET', headers: request.headers,
        }));
        if (probe.status >= 500) throw new Error(`Container returned ${probe.status}`);
        return Response.json({
          status: 'healthy',
          service: bindings.SERVICE_NAME,
          runtime: 'cloudflare-container',
        }, { headers: cors });
      } catch (error) {
        return Response.json({
          status: 'unhealthy',
          service: bindings.SERVICE_NAME,
          error: error instanceof Error ? error.message : 'Container unavailable',
        }, { status: 503, headers: cors });
      }
    }

    const response = await container.fetch(request);
    const headers = new Headers(response.headers);
    Object.entries(cors).forEach(([key, value]) => headers.set(key, value));
    headers.set('x-primecare-service', bindings.SERVICE_NAME);
    return new Response(response.body, {
      status: response.status,
      statusText: response.statusText,
      headers,
    });
  },
};
