import {businessModules} from './business-modules';
import {legacyDomain} from './legacy-domain';
import {sourceLoginLimit} from './auth-source-limit';
import { auth, withDb, type Env } from './auth';
import {sendEmail} from './email';
import {activeMfaKeyId} from './security/mfa-keyring.mjs';
import {verifyMfaKeyRotation,runMfaKeyRotation} from './security/mfa-key-rotation.mjs';
import {deliverMfaNotifications} from './security/mfa-notifications.mjs';
import lifecycle from '../../../packages/shared/src/auth-lifecycle.json';

import {HandlerPipeline, type WorkerContext} from './runtime/handler-pipeline';
import {WorkerApplication} from './runtime/worker-application';

interface MfaRotationReport {
  fromKeyId:string;toKeyId:string;rewrapped:number;expiredReplacementChallengesRemoved:number;
  remainingOldCredentials:number;remainingOldReplacementEnvelopes:number;
}
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
  ...businessModules.map(module => stage(module.name, module.handle)),
]);

/** Shared service implementation inherited by the existing Worker entry point. */
export class ServiceApplication extends WorkerApplication<Env> {
  async scheduled(_controller: unknown, env: Env): Promise<void> {
    if (env.SERVICE_NAME !== 'auth') return;
    if (env.MFA_ENCRYPTION_KEY_V2 !== undefined) {
      const source=env.MFA_KEYRING_SOURCE_SHA256;let verified=false;
      try {
        if(!/^[a-f0-9]{64}$/.test(source??''))throw Error('Missing keyring source');
        const drill=await verifyMfaKeyRotation(env,'mfa-v1','mfa-v2');
        console.log('MFA_KEYRING_DRILL '+JSON.stringify({source,activeKeyId:activeMfaKeyId(env),...drill}));verified=true;
      }catch {console.log('MFA_KEYRING_DRILL '+JSON.stringify({source,verified:false}));}
      if(verified&&env.MFA_ROTATION_FROM_KEY_ID){
        try {
          const report=await withDb<MfaRotationReport>(env,db=>runMfaKeyRotation(db,env,env.MFA_ROTATION_FROM_KEY_ID));
          console.log('MFA_KEY_ROTATION_REPORT '+JSON.stringify({source,verified:true,...report}));
        }catch{console.log('MFA_KEY_ROTATION_REPORT '+JSON.stringify({source,verified:false}));}
      }
    }

    const report = await withDb(env, db => deliverMfaNotifications(db, async (notice: {id:string;recipient:string;locale:string}) => {
      const language = ['en','fr','es'].includes(notice.locale) ? notice.locale as 'en'|'fr'|'es' : 'en';
      const copy = lifecycle.locales[language];
      const templates = {...env.EMAIL_TEMPLATES, security_notice: {subject:copy.notifySubject,
        title:copy.notifyTitle,body:copy.notifyBody,required:['message','support']}};
      return sendEmail({...env,EMAIL_TEMPLATES:templates}, notice.recipient, 'security_notice',
        {message:copy.notifyMessage,support:copy.supportContact}, 'mfa-lifecycle-'+notice.id);
    }));
    console.log('MFA_NOTIFICATION_QUEUE '+JSON.stringify(report));
  }
  protected healthy(env: Env): Promise<void> {
    return withDb(env, db => db.query('SELECT 1').then(() => undefined));
  }

  protected dispatch(context: WorkerContext<Env>): Promise<Response | null> {
    return pipeline.run(context);
  }
}
