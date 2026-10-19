import {BaseWorker} from '../core/base-worker';
import type {WorkerContext} from './handler-pipeline';

export interface ServiceEnvironment { SERVICE_NAME: string }

const allowedOrigins = [
  /^https:\/\/primecare-[a-z0-9-]+\.pages\.dev$/,
  /^https:\/\/[a-z0-9.-]+\.primecare\.ca$/,
];

/** Shared service lifecycle. Gateway CORS remains a separate, existing boundary. */
export abstract class WorkerApplication<E extends ServiceEnvironment> extends BaseWorker<E> {
  protected abstract healthy(env: E): Promise<void>;
  protected abstract dispatch(context: WorkerContext<E>): Promise<Response | null>;

  private cors(origin: string | null): HeadersInit {
    if (origin && !allowedOrigins.some(pattern => pattern.test(origin))) return {};
    return {
      'access-control-allow-origin': origin ?? '*',
      'access-control-allow-methods': 'GET,POST,PUT,PATCH,DELETE,OPTIONS',
      'access-control-allow-headers': 'Authorization,Content-Type,Idempotency-Key,X-Device-Id,X-Tenant-Id,X-Requested-With,X-Device-Fingerprint,X-Request-Id,X-Correlation-Id,X-Request-Signature,X-App-Version',
      'access-control-expose-headers': 'Idempotency-Replayed',
      vary: 'Origin',
    };
  }

  protected override preflight(request: Request): Response | null {
    const origin = request.headers.get('origin');
    const headers = this.cors(origin);
    if (origin && !Object.keys(headers).length) return new Response('Origin not allowed', {status: 403});
    if (request.method === 'OPTIONS') return new Response(null, {status: 204, headers});
    return null;
  }

  protected override async handle(request: Request, env: E): Promise<Response> {
    const headers = this.cors(request.headers.get('origin'));
    const path = new URL(request.url).pathname;
    if (path === '/health') {
      await this.healthy(env);
      return Response.json({status: 'healthy', service: env.SERVICE_NAME, runtime: 'cloudflare-worker-typescript'}, {status: 200, headers});
    }
    if (path === '/') return Response.json({status: 'ok', service: env.SERVICE_NAME}, {status: 200, headers});
    const response = await this.dispatch({request, env, path, headers});
    if (response !== null) return response;
    if (/^\/api\/[a-z0-9-]+-screen$/.test(path) && request.method === 'GET')
      return Response.json({error: 'Business data binding is not implemented', status: 'not_implemented'}, {status: 501, headers});
    if (/^\/api\/([a-z0-9-]+-screen)\/action$/.test(path) && request.method === 'POST')
      return Response.json({error: 'Business action is not implemented', status: 'not_implemented'}, {status: 501, headers});
    return Response.json({error: 'Route not found', service: env.SERVICE_NAME}, {status: 404, headers});
  }

  protected override onError(error: unknown, request: Request, env: E): Response {
    console.error(error);
    return Response.json({error: 'Internal server error', service: env.SERVICE_NAME},
      {status: 500, headers: this.cors(request.headers.get('origin'))});
  }
}
