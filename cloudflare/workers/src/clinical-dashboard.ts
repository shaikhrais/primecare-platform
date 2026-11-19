import {json, withDb, tokenFrom, sha256, type Env} from './auth';
import {privilegedActor} from './auth-projection';
import {sourceLimitAllowed} from './source-limit-result';

type ClinicalEnv = Env & {CLINICAL_READ_DATABASE_URL?: string};

/** assigned verified active branch count only.
 * No booking or appointment metrics. Authority is the reviewed effective view.
 */
export async function clinicalDashboard(request:Request, env:ClinicalEnv, path:string, headers:HeadersInit):Promise<Response|null> {
  if (env.SERVICE_NAME !== 'governance' || path !== '/v1/clinical/dashboard') return null;
  const safe = new Headers(headers);
  safe.set('cache-control','no-store'); safe.append('vary','Authorization, Cookie');
  safe.set('x-content-type-options','nosniff');
  const reply = (status:number,error:string) => json({error},status,safe);
  if (request.method !== 'GET') {safe.set('allow','GET');return reply(405,'method_not_allowed');}
  const token = tokenFrom(request);
  if (!token) return reply(401,'unauthenticated');
  if (new URL(request.url).search || request.body !== null || request.headers.has('x-tenant-id')) return reply(400,'unexpected_scope_or_query');
  const connectionString = env.CLINICAL_READ_DATABASE_URL?.trim();
  if (!connectionString) return reply(503,'unavailable');
  try {
    if (env.WORKSPACE_SOURCE_LIMIT && !sourceLimitAllowed(await env.WORKSPACE_SOURCE_LIMIT.limit({key:await sha256('clinical-dashboard:'+(request.headers.get('cf-connecting-ip')??'unknown'))}))) {
      safe.set('retry-after','60');return reply(429,'rate_limited');
    }
    return await withDb({...env, DB_URL:connectionString},async db => {
      await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
      try {
        const actor = privilegedActor((await db.query(`SELECT u.id,u.tenant_id,u.roles
          FROM public.auth_sessions s JOIN public.users u ON u.id=s.user_id
          JOIN public.tenants t ON t.id=u.tenant_id
          WHERE s.token_hash=$1 AND s.expires_at>CURRENT_TIMESTAMP
            AND u.status='active' AND t.status='active'`,[await sha256(token)])).rows);
        if (!actor) return reply(401,'unauthenticated');
        if (actor.roles !== 'clinical_director' || !actor.tenant_id) return reply(403,'forbidden');
        const measured = (await db.query(`SELECT COUNT(DISTINCT branch_id)::text AS branch_count
          FROM public.clinical_branch_director_effective_scope
          WHERE tenant_id=$1 AND director_user_id=$2`,[actor.tenant_id,actor.id])).rows;
        const value = measured.length===1 ? measured[0].branch_count : undefined;
        if (typeof value!=='string' || !/^(0|[1-9][0-9]*)$/.test(value)
            || !Number.isSafeInteger(Number(value))) return reply(503,'unavailable');
        if (Number(value)===0) return reply(403,'no_scope');
        return json({assignedVerifiedBranchCount:Number(value)},200,safe);
      } finally {await db.query('ROLLBACK');}
    });
  } catch {return reply(503,'unavailable');}
}
