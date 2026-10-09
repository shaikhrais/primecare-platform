import {providerTimesheetItems} from './provider-timesheet-items';
import {clientBookingLifecycle} from './client-booking-lifecycle';
import {legacyDomain} from './legacy-domain';
import {providerSelf} from './provider-self';
import {providerRecords} from './provider-records';
import {clientSelf} from './client-self';
import {sourceLoginLimit} from './auth-source-limit';
import {workspace} from './workspace';
import {governanceApi} from './governance-api';
import { auth, withDb, type Env } from './auth';

import {HandlerPipeline, type WorkerContext} from './runtime/handler-pipeline';
import {WorkerApplication} from './runtime/worker-application';

type ExistingHandler = (request: Request, env: Env, path: string, headers: HeadersInit) => Response | null | Promise<Response | null>;
const stage = (name: string, handler: ExistingHandler) => ({
  name,
  handle: ({request, env, path, headers}: WorkerContext<Env>) => handler(request, env, path, headers),
});

// Preserve the established precedence. Registering a stage grants no authority:
// each existing handler still checks service, session, tenant and resource scope.
const pipeline = new HandlerPipeline<Env>([
  stage('legacy-domain', legacyDomain),
  {
    name: 'authentication',
    async handle({request, env, path, headers}) {
      if (env.SERVICE_NAME !== 'auth') return null;
      const sourceLimit = await sourceLoginLimit(request, env);
      if (sourceLimit) {
        const responseHeaders = new Headers(sourceLimit.headers);
        new Headers(headers).forEach((value, key) => responseHeaders.set(key, value));
        return new Response(sourceLimit.body, {status: sourceLimit.status, headers: responseHeaders});
      }
      return auth(request, env, path, headers);
    },
  },
  stage('client-booking-lifecycle', clientBookingLifecycle),
  stage('provider-timesheet-items', providerTimesheetItems),
  stage('provider-records', providerRecords),
  stage('provider-self', providerSelf),
  stage('client-self', clientSelf),
  stage('governance', governanceApi),
  stage('workspace', workspace),
]);

/** Shared service implementation inherited by the existing Worker entry point. */
export class ServiceApplication extends WorkerApplication<Env> {
  protected healthy(env: Env): Promise<void> {
    return withDb(env, db => db.query('SELECT 1').then(() => undefined));
  }

  protected dispatch(context: WorkerContext<Env>): Promise<Response | null> {
    return pipeline.run(context);
  }
}
