import registry from './legacy-domain-registry.json';
import {json,type Env} from './auth';

/** Deny legacy operations before authentication, body parsing or SQL. The
 * governance catalog keeps these business operations explicitly blocked. */
export function legacyDomain(request:Request,env:Env,path:string,headers:HeadersInit):Response|null {
  const segments=path.split('/');
  const route=registry.find(r=>r.service===env.SERVICE_NAME&&r.path.split('/').length===segments.length&&r.path.split('/').every((s,i)=>s.startsWith('{')?segments[i].length>0:s===segments[i]));
  if(!route)return null;
  const safe=new Headers(headers);safe.set('cache-control','no-store');
  if(!route.methods.includes(request.method)){
    safe.set('allow',route.methods.join(', '));
    return json({error:'Method not allowed'},405,safe);
  }
  return json({error:'Legacy domain operation is not implemented securely',status:'not_implemented',code:'legacy_domain_disabled'},501,safe);
}
