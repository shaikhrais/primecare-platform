import {sourceLimitAllowed} from './source-limit-result';
import {json,withDb,tokenFrom,sha256,type Env} from './auth';

const idPattern=/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/;
const fields='id,service_type,preferred_date,preferred_time,status,created_at,updated_at';
const timestamp=(value:unknown):string=>{
  if(value instanceof Date){if(!Number.isFinite(value.getTime()))throw Error('Invalid booking timestamp');return value.toISOString();}
  if(typeof value!=='string'||!/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{1,3})?Z$/.test(value)||!Number.isFinite(Date.parse(value)))throw Error('Invalid booking timestamp');
  const iso=new Date(value).toISOString();if(iso.slice(0,19)!==value.slice(0,19))throw Error('Invalid booking timestamp');return iso;
};
const project=(r:Record<string,unknown>,expectedId:string,expectedStatus:'pending'|'cancelled')=>{
  if(!r||typeof r!=='object'||Array.isArray(r)||typeof r.id!=='string'||!idPattern.test(r.id)||r.id!==expectedId||
    typeof r.service_type!=='string'||!r.service_type.trim()||r.service_type.length>100||/[\u0000-\u001f]/.test(r.service_type)||
    r.preferred_time!==null&&(typeof r.preferred_time!=='string'||!/^([01]\d|2[0-3]):[0-5]\d$/.test(r.preferred_time))||r.status!==expectedStatus)throw Error('Invalid booking projection');
  return {id:r.id,service_type:r.service_type,preferred_date:timestamp(r.preferred_date),preferred_time:r.preferred_time,status:r.status,created_at:timestamp(r.created_at),updated_at:timestamp(r.updated_at)};
};
const projectEvent=(r:Record<string,unknown>)=>{
  if(typeof r.id!=='string'||! /^[1-9]\d*$/.test(r.id)||
    !(r.action==='created'&&r.previous_status===null&&r.new_status==='pending'||r.action==='cancelled'&&r.previous_status==='pending'&&r.new_status==='cancelled'))throw Error('Invalid booking audit event');
  return {id:r.id,action:r.action,previous_status:r.previous_status,new_status:r.new_status,created_at:timestamp(r.created_at)};
};
const oneRow=(rows:Record<string,unknown>[])=>{if(rows.length!==1)throw Error('Invalid booking result cardinality');return rows[0];};
const exactCount=(value:unknown)=>{if(typeof value!=='number'||!Number.isSafeInteger(value)||value<0)throw Error('Invalid booking audit count');return value;};

async function createInput(request:Request):Promise<Record<string,unknown>>{
  if(!/^application\/json(?:\s*;|$)/i.test(request.headers.get('content-type')??''))throw Error('JSON required');
  const reader=request.body?.getReader();if(!reader)throw Error('Body required');
  const chunks:Uint8Array[]=[];let size=0;
  try{for(;;){const {done,value}=await reader.read();if(done)break;size+=value.byteLength;if(size>8192){await reader.cancel();throw Error('Body too large');}chunks.push(value);}}finally{reader.releaseLock();}
  const bytes=new Uint8Array(size);let offset=0;for(const chunk of chunks){bytes.set(chunk,offset);offset+=chunk.byteLength;}
  const b=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));
  if(!b||typeof b!=='object'||Array.isArray(b)||Object.keys(b).some(k=>!['service_type','preferred_date','preferred_time','notes'].includes(k)))throw Error('Invalid fields');
  if(typeof b.service_type!=='string'||!b.service_type.trim()||b.service_type.length>100||/[\u0000-\u001f]/.test(b.service_type))throw Error('Invalid service');
  if(typeof b.preferred_date!=='string'||!/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{1,3})?Z$/.test(b.preferred_date)||!Number.isFinite(Date.parse(b.preferred_date)))throw Error('Invalid date');
  const date=new Date(b.preferred_date).toISOString();
  // Reject normalized impossible calendar dates such as February 30.
  if(date.slice(0,19)!==b.preferred_date.slice(0,19))throw Error('Invalid date');
  if(b.preferred_time!=null&&(typeof b.preferred_time!=='string'||!/^([01]\d|2[0-3]):[0-5]\d$/.test(b.preferred_time)))throw Error('Invalid time');
  if(b.notes!=null&&(typeof b.notes!=='string'||b.notes.length>2000||b.notes.includes('\u0000')))throw Error('Invalid notes');
  return {service_type:b.service_type.trim(),preferred_date:date,preferred_time:b.preferred_time??null,notes:b.notes??null};
}

/** Client submission/cancellation with atomic audit and actor-scoped retries. */
export async function clientBookingLifecycle(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null>{
  if(env.SERVICE_NAME!=='client')return null;
  const match=/^\/booking-requests\/([^/]+)\/(cancel|audit)$/.exec(path);
  const create=path==='/booking-requests'&&request.method==='POST';
  if(!create&&!match)return null;
  const safe=new Headers(headers);safe.set('cache-control','no-store');
  const audit=match?.[2]==='audit';
  if(request.method!==(audit?'GET':'POST')){safe.set('allow',audit?'GET':'POST');return json({error:'Method not allowed'},405,safe);}
  const params=new URL(request.url).searchParams,limit=params.get('limit')??'25',offset=params.get('offset')??'0';
  if(match&&!idPattern.test(match[1])||[...params.keys()].some(k=>!audit||!['limit','offset'].includes(k)||params.getAll(k).length!==1)||!/^[1-9]\d{0,2}$/.test(limit)||Number(limit)>100||!/^\d{1,6}$/.test(offset)||Number(offset)>100000||!create&&request.body!==null)return json({error:'Invalid query or body'},400,safe);
  const token=request.headers.has('authorization')?tokenFrom(request):null;if(!token)return json({error:'No session'},401,safe);
  const key=request.headers.get('idempotency-key');if(!audit&&(!key||!/^[A-Za-z0-9_-]{8,100}$/.test(key)))return json({error:'Valid Idempotency-Key required'},400,safe);
  let input:Record<string,unknown>={};try{if(create)input=await createInput(request);}catch{return json({error:'Invalid booking request'},400,safe);}
  try{
    if(env.WORKSPACE_SOURCE_LIMIT&&!sourceLimitAllowed(await env.WORKSPACE_SOURCE_LIMIT.limit({key:await sha256('client-booking-lifecycle:'+(request.headers.get('cf-connecting-ip')??'unknown'))}))){safe.set('retry-after','60');return json({error:'Too many requests'},429,safe);}
    const hash=await sha256(token),fingerprint=await sha256(JSON.stringify({action:create?'created':'cancelled',id:match?.[1]??null,input}));
    return await withDb(env,async db=>{
      await db.query(audit?'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY':'BEGIN');let committed=false;
      try{
        const actor=(await db.query("SELECT u.id,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>clock_timestamp() AND LOWER(u.status)='active' LIMIT 1"+(audit?'':' FOR SHARE OF u'),[hash])).rows[0];
        if(!actor)return json({error:'Invalid session'},401,safe);
        if(!actor.tenant_id||request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==String(actor.tenant_id))return json({error:'Forbidden'},403,safe);
        const profiles=(await db.query('SELECT id FROM client_profiles WHERE user_id::text=$1 AND tenant_id::text=$2 LIMIT 2'+(audit?'':' FOR SHARE'),[String(actor.id),String(actor.tenant_id)])).rows;
        if(!profiles.length)return json({error:'Client profile not found'},404,safe);if(profiles.length!==1)return json({error:'Client data unavailable'},503,safe);
        // Recheck the session after acquiring user/profile locks.
        if(!audit&&!(await db.query('SELECT 1 FROM auth_sessions WHERE token_hash=$1 AND user_id=$2 AND expires_at>clock_timestamp()',[hash,actor.id])).rows.length)return json({error:'Invalid session'},401,safe);
        const scope=[String(profiles[0].id),String(actor.tenant_id)];
        const filter='client_id::text=$1 AND tenant_id::text=$2 AND id::text=$3';
        if(audit){
          if(!(await db.query('SELECT id FROM booking_requests WHERE '+filter,[...scope,match![1]])).rows.length)return json({error:'Booking request not found'},404,safe);
          const values=[match![1],String(actor.id),String(actor.tenant_id)],where='request_id=$1 AND actor_user_id=$2 AND tenant_id=$3';
          const total=exactCount((await db.query('SELECT COUNT(*)::int AS count FROM booking_request_audit WHERE '+where,values)).rows[0].count);
          const rows=(await db.query('SELECT id::text AS id,action,previous_status,new_status,created_at FROM booking_request_audit WHERE '+where+' ORDER BY created_at DESC,id DESC LIMIT $4 OFFSET $5',[...values,Number(limit),Number(offset)])).rows;
          return json({events:rows.map(projectEvent),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',[JSON.stringify([String(actor.id),String(actor.tenant_id),key])]);
        const previous=(await db.query('SELECT request_id,request_hash,response_json FROM booking_request_audit WHERE actor_user_id=$1 AND tenant_id=$2 AND idempotency_key=$3',[String(actor.id),String(actor.tenant_id),key])).rows[0];
        if(previous){
          if(!(await db.query('SELECT id FROM booking_requests WHERE '+filter,[...scope,previous.request_id])).rows.length)return json({error:'Booking request not found'},404,safe);
          if(previous.request_hash!==fingerprint)return json({error:'Idempotency key already used for another request'},409,safe);
          const stored=previous.response_json;
          if(!stored||typeof stored!=='object'||Array.isArray(stored))throw Error('Invalid booking replay');
          const response={request:project(stored.request,previous.request_id,create?'pending':'cancelled')};
          safe.set('idempotency-replayed','true');return json(response,create?201:200,safe);
        }
        let row:Record<string,unknown>,previousStatus:string|null=null;
        const requestId=create?crypto.randomUUID():match![1];
        if(create){
          row=oneRow((await db.query('INSERT INTO booking_requests(id,client_id,tenant_id,service_type,preferred_date,preferred_time,notes,status,created_at,updated_at) VALUES($1,$2,$3,$4,$5,$6,$7,\'pending\',NOW(),NOW()) RETURNING '+fields,[requestId,...scope,input.service_type,input.preferred_date,input.preferred_time,input.notes])).rows);
        }else{
          const owned=(await db.query('SELECT '+fields+' FROM booking_requests WHERE '+filter+' FOR UPDATE',[...scope,match![1]])).rows[0];
          if(!owned)return json({error:'Booking request not found'},404,safe);if(owned.status!=='pending')return json({error:'Only pending requests can be cancelled'},409,safe);
          previousStatus='pending';row=oneRow((await db.query("UPDATE booking_requests SET status='cancelled',updated_at=NOW() WHERE "+filter+" AND status='pending' RETURNING "+fields,[...scope,match![1]])).rows);
        }
        const response={request:project(row,requestId,create?'pending':'cancelled')};
        await db.query('INSERT INTO booking_request_audit(request_id,actor_user_id,tenant_id,action,previous_status,new_status,idempotency_key,request_hash,response_json) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9)',[String(row.id),String(actor.id),String(actor.tenant_id),create?'created':'cancelled',previousStatus,create?'pending':'cancelled',key,fingerprint,JSON.stringify(response)]);
        await db.query('COMMIT');committed=true;return json(response,create?201:200,safe);
      }finally{if(!committed)await db.query('ROLLBACK');}
    });
  }catch{safe.delete('idempotency-replayed');return json({error:'Booking request service unavailable'},503,safe);}
}
