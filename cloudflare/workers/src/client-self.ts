import {json,withDb,tokenFrom,sha256,type Env} from './auth';

/** Ownership comes from the registered client_profiles.user_id relationship,
 * never from caller-supplied profile identifiers or presentation grants. */
export async function clientSelf(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null> {
  const bookingMatch=/^\/bookings\/([^/]+)$/.exec(path);
  if(env.SERVICE_NAME!=='client'||!bookingMatch&&!['/home/profile','/invoices','/bookings'].includes(path))return null;
  const safe=new Headers(headers);safe.set('cache-control','no-store');
  if(request.method!=='GET'){safe.set('allow','GET');return json({error:'Method not allowed'},405,safe);}
  const params=new URL(request.url).searchParams,keys=['/invoices','/bookings'].includes(path)?['limit','offset']:[];
  const limit=params.get('limit')??'25',offset=params.get('offset')??'0';
  if(request.body!==null||[...params.keys()].some(k=>!keys.includes(k)||params.getAll(k).length!==1)||!/^[1-9]\d{0,2}$/.test(limit)||Number(limit)>100||!/^\d{1,6}$/.test(offset)||Number(offset)>100000)return json({error:'Invalid query or body'},400,safe);
  if(bookingMatch&&!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(bookingMatch[1]))return json({error:'Invalid booking identifier'},400,safe);
  const token=request.headers.has('authorization')?tokenFrom(request):null;if(!token)return json({error:'No session'},401,safe);
  try{
    if(env.WORKSPACE_SOURCE_LIMIT&&!(await env.WORKSPACE_SOURCE_LIMIT.limit({key:await sha256('client-self:'+(request.headers.get('cf-connecting-ip')??'unknown'))})).success){safe.set('retry-after','60');return json({error:'Too many requests'},429,safe);}
    return await withDb(env,async db=>{
      await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
      try{
        const actor=(await db.query("SELECT u.id,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 1",[await sha256(token)])).rows[0];
        if(!actor)return json({error:'Invalid session'},401,safe);
        if(!actor.tenant_id||(request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==String(actor.tenant_id)))return json({error:'Forbidden'},403,safe);
        const profiles=(await db.query('SELECT id,full_name,city,province,postal_code,updated_at FROM client_profiles WHERE user_id::text=$1 AND tenant_id::text=$2 LIMIT 2',[String(actor.id),String(actor.tenant_id)])).rows;
        if(!profiles.length)return json({error:'Client profile not found'},404,safe);
        if(profiles.length!==1)return json({error:'Client data unavailable'},503,safe);
        const p=profiles[0];
        if(path==='/home/profile')return json({profile:{id:String(p.id),full_name:p.full_name,city:p.city,province:p.province,postal_code:p.postal_code,updated_at:p.updated_at}},200,safe);
        const values=[String(p.id),String(actor.tenant_id)];
        if(path==='/bookings'||bookingMatch){
          const fields='id,start_at,end_at,service_type,priority,status,recurrence_rule';
          const project=(b:Record<string,unknown>)=>({id:String(b.id),start_at:b.start_at,end_at:b.end_at,service_type:b.service_type,priority:b.priority,status:b.status,recurrence_rule:b.recurrence_rule});
          const filter='client_id::text=$1 AND tenant_id::text=$2';
          if(bookingMatch){
            const booking=(await db.query('SELECT '+fields+' FROM bookings WHERE '+filter+' AND id::text=$3',[...values,bookingMatch[1]])).rows[0];
            return booking?json({booking:project(booking)},200,safe):json({error:'Booking not found'},404,safe);
          }
          const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM bookings WHERE '+filter,values)).rows[0].count);
          const rows=(await db.query('SELECT '+fields+' FROM bookings WHERE '+filter+' ORDER BY start_at DESC,id DESC LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          return json({bookings:rows.map(project),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        const filter='client_id::text=$1 AND tenant_id::text=$2';
        const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM invoices WHERE '+filter,values)).rows[0].count);
        const rows=(await db.query('SELECT id,status,currency,subtotal::text AS subtotal,tax::text AS tax,total::text AS total,created_at,updated_at FROM invoices WHERE '+filter+' ORDER BY created_at DESC,id DESC LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
        return json({invoices:rows.map(i=>({id:String(i.id),status:i.status,currency:i.currency,subtotal:i.subtotal,tax:i.tax,total:i.total,created_at:i.created_at,updated_at:i.updated_at})),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
      }finally{await db.query('ROLLBACK');}
    });
  }catch{return json({error:'Client data unavailable'},503,safe);}
}
