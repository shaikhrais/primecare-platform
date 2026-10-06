import {providerTimesheetItems} from './provider-timesheet-items';
import {clientBookingLifecycle} from './client-booking-lifecycle';
import {legacyDomain} from './legacy-domain';
import {providerSelf} from './provider-self';
import {providerRecords} from './provider-records';
import {clientSelf} from './client-self';
import {sourceLoginLimit} from './auth-source-limit';
import {workspace} from './workspace';
import {governanceApi} from './governance-api';
import { auth, json, withDb, type Env } from './auth';

const allowedOrigins = [
  /^https:\/\/primecare-[a-z0-9-]+\.pages\.dev$/,
  /^https:\/\/[a-z0-9.-]+\.primecare\.ca$/,
];

function cors(origin: string | null): HeadersInit {
  if (origin && !allowedOrigins.some((pattern) => pattern.test(origin))) return {};
  return {
    'access-control-allow-origin': origin ?? '*',
    'access-control-allow-methods': 'GET,POST,PUT,PATCH,DELETE,OPTIONS',
    'access-control-allow-headers': 'Authorization,Content-Type,Idempotency-Key,X-Device-Id,X-Tenant-Id,X-Requested-With,X-Device-Fingerprint,X-Request-Id,X-Correlation-Id,X-Request-Signature,X-App-Version',
    'access-control-expose-headers': 'Idempotency-Replayed',
    vary: 'Origin',
  };
}


export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const origin = request.headers.get('origin');
    const headers = cors(origin);
    if (origin && !Object.keys(headers).length) return new Response('Origin not allowed', { status: 403 });
    if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers });
    const path = new URL(request.url).pathname;

    try {
      if (path === '/health') {
        await withDb(env, (db) => db.query('SELECT 1').then(() => undefined));
        return json({ status: 'healthy', service: env.SERVICE_NAME, runtime: 'cloudflare-worker-typescript' }, 200, headers);
      }
      if (path === '/') return json({ status: 'ok', service: env.SERVICE_NAME }, 200, headers);
      const legacyResponse=legacyDomain(request,env,path,headers);
      if(legacyResponse)return legacyResponse;
      if (env.SERVICE_NAME === 'auth') {
        const sourceLimit = await sourceLoginLimit(request,env);
        if (sourceLimit) {
          const responseHeaders = new Headers(sourceLimit.headers);
          new Headers(headers).forEach((value,key)=>responseHeaders.set(key,value));
          return new Response(sourceLimit.body,{status:sourceLimit.status,headers:responseHeaders});
        }
        const response = await auth(request, env, path, headers);
        if (response) return response;
      }
      const lifecycleResponse=await clientBookingLifecycle(request,env,path,headers);
      if(lifecycleResponse)return lifecycleResponse;
      const timesheetItemResponse=await providerTimesheetItems(request,env,path,headers);
      if(timesheetItemResponse)return timesheetItemResponse;
      const providerRecordResponse=await providerRecords(request,env,path,headers);
      if(providerRecordResponse)return providerRecordResponse;
      const providerResponse=await providerSelf(request,env,path,headers);
      if(providerResponse)return providerResponse;
      const clientResponse=await clientSelf(request,env,path,headers);
      if(clientResponse)return clientResponse;
      const batchResponse = await governanceApi(request,env,path,headers);
      if(batchResponse)return batchResponse;
      const pageResponse = await workspace(request,env,path,headers);
      if(pageResponse)return pageResponse;

      if (/^\/api\/[a-z0-9-]+-screen$/.test(path) && request.method === 'GET')
        return json({error:'Business data binding is not implemented',status:'not_implemented'},501,headers);
      const action = path.match(/^\/api\/([a-z0-9-]+-screen)\/action$/);
      if (action && request.method === 'POST')
        return json({error:'Business action is not implemented',status:'not_implemented'},501,headers);
      return json({ error: 'Route not found', service: env.SERVICE_NAME }, 404, headers);
    } catch (error) {
      console.error(error);
      return json({ error: 'Internal server error', service: env.SERVICE_NAME }, 500, headers);
    }
  },
} satisfies ExportedHandler<Env>;
