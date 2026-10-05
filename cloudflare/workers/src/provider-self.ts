import {json,withDb,tokenFrom,sha256,type Env} from './auth';

/** Ownership comes from the registered provider_profiles.user_id relationship,
 * never from caller-supplied profile identifiers or presentation grants. */
export async function providerSelf(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null> {
  const visitMatch=/^\/visits\/([^/]+)$/.exec(path);
  if(env.SERVICE_NAME!=='provider'||!visitMatch&&!['/profile','/availability','/visits'].includes(path))return null;
  const safe=new Headers(headers);safe.set('cache-control','no-store');
  if(request.method!=='GET'){safe.set('allow','GET');return json({error:'Method not allowed'},405,safe);}
  const params=new URL(request.url).searchParams,keys=['/availability','/visits'].includes(path)?['limit','offset']:[];
  const limit=params.get('limit')??'25',offset=params.get('offset')??'0';
  if(request.body!==null||[...params.keys()].some(k=>!keys.includes(k)||params.getAll(k).length!==1)||!/^[1-9]\d{0,2}$/.test(limit)||Number(limit)>100||!/^\d{1,6}$/.test(offset)||Number(offset)>100000)return json({error:'Invalid query or body'},400,safe);
  if(visitMatch&&!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(visitMatch[1]))return json({error:'Invalid visit identifier'},400,safe);
  const token=request.headers.has('authorization')?tokenFrom(request):null;if(!token)return json({error:'No session'},401,safe);
  try{
    if(env.WORKSPACE_SOURCE_LIMIT&&!(await env.WORKSPACE_SOURCE_LIMIT.limit({key:await sha256('provider-self:'+(request.headers.get('cf-connecting-ip')??'unknown'))})).success){safe.set('retry-after','60');return json({error:'Too many requests'},429,safe);}
    return await withDb(env,async db=>{
      await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
      try{
        const actor=(await db.query("SELECT u.id,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 1",[await sha256(token)])).rows[0];
        if(!actor)return json({error:'Invalid session'},401,safe);
        if(!actor.tenant_id||(request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==String(actor.tenant_id)))return json({error:'Forbidden'},403,safe);
        const profiles=(await db.query('SELECT id,full_name,bio,languages,service_areas,provider_type,is_approved,skills FROM provider_profiles WHERE user_id::text=$1 AND tenant_id::text=$2 LIMIT 2',[String(actor.id),String(actor.tenant_id)])).rows;
        if(!profiles.length)return json({error:'Provider profile not found'},404,safe);
        if(profiles.length!==1)return json({error:'Provider data unavailable'},503,safe);
        const p=profiles[0];
        if(path==='/profile')return json({profile:{id:String(p.id),full_name:p.full_name,bio:p.bio,languages:p.languages,service_areas:p.service_areas,provider_type:p.provider_type,is_approved:p.is_approved,skills:p.skills}},200,safe);
        const values=[String(p.id),String(actor.tenant_id)];
        if(path==='/visits'||visitMatch){
          const fields='id,service_id,requested_start_at,duration_minutes,status,priority,updated_at';
          const project=(v:Record<string,unknown>)=>({id:String(v.id),service_id:String(v.service_id),requested_start_at:v.requested_start_at,duration_minutes:v.duration_minutes,status:v.status,priority:v.priority,updated_at:v.updated_at});
          const filter='assigned_provider_id::text=$1 AND tenant_id::text=$2';
          if(visitMatch){
            const visit=(await db.query('SELECT '+fields+' FROM visits WHERE '+filter+' AND id::text=$3',[...values,visitMatch[1]])).rows[0];
            return visit?json({visit:project(visit)},200,safe):json({error:'Visit not found'},404,safe);
          }
          const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM visits WHERE '+filter,values)).rows[0].count);
          const rows=(await db.query('SELECT '+fields+' FROM visits WHERE '+filter+' ORDER BY requested_start_at DESC,id DESC LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          return json({visits:rows.map(project),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        const filter='provider_id::text=$1 AND tenant_id::text=$2';
        const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM provider_availability WHERE '+filter,values)).rows[0].count);
        const rows=(await db.query('SELECT id,day_of_week,start_time,end_time FROM provider_availability WHERE '+filter+' ORDER BY day_of_week,start_time,id LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
        return json({availability:rows.map(i=>({id:String(i.id),day_of_week:i.day_of_week,start_time:i.start_time,end_time:i.end_time})),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
      }finally{await db.query('ROLLBACK');}
    });
  }catch{return json({error:'Provider data unavailable'},503,safe);}
}
