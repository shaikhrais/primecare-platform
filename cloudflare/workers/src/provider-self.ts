import {summaryRows} from './summary-results';
import {pageRows,recordRows,scopedActor,boundRow,resultRows,requiredRow} from './database-results';
import {accountId} from './account-read-projection';
import {projectRecordTimestamp,validRecordTimestamp} from './record-date-validation';
import {sourceLimitAllowed} from './source-limit-result';
import {json,withDb,tokenFrom,sha256,type Env} from './auth';

/** Ownership comes from the registered provider_profiles.user_id relationship,
 * never from caller-supplied profile identifiers or presentation grants. */
export async function providerSelf(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null> {
  const documentSummary=path==='/documents/summary';
  const documentMatch=!documentSummary?/^\/documents\/([^/]+)$/.exec(path):null;
  const statusSummary=path==='/visits/summary';
  const visitMatch=!statusSummary?/^\/visits\/([^/]+)$/.exec(path):null;
  const availabilitySummary=path==='/availability/summary';
  const availabilityMatch=!availabilitySummary?/^\/availability\/([^/]+)$/.exec(path):null;
  if(env.SERVICE_NAME!=='provider'||!visitMatch&&!documentMatch&&!availabilityMatch&&!availabilitySummary&&!statusSummary&&!documentSummary&&!['/profile','/availability','/visits','/documents'].includes(path))return null;
  const safe=new Headers(headers);safe.set('cache-control','no-store');
  if(request.method!=='GET'){safe.set('allow','GET');return json({error:'Method not allowed'},405,safe);}
  const params=new URL(request.url).searchParams,keys=(availabilitySummary||documentSummary||statusSummary||['/availability','/visits','/documents'].includes(path))?['limit','offset']:[];
  const limit=params.get('limit')??'25',offset=params.get('offset')??'0';
  if(request.body!==null||[...params.keys()].some(k=>!keys.includes(k)||params.getAll(k).length!==1)||!/^[1-9]\d{0,2}$/.test(limit)||Number(limit)>100||!/^\d{1,6}$/.test(offset)||Number(offset)>100000)return json({error:'Invalid query or body'},400,safe);
  if(visitMatch&&!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(visitMatch[1]))return json({error:'Invalid visit identifier'},400,safe);
  if(documentMatch&&!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(documentMatch[1]))return json({error:'Invalid document identifier'},400,safe);
  if(availabilityMatch&&!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(availabilityMatch[1]))return json({error:'Invalid availability identifier'},400,safe);
  const token=request.headers.has('authorization')?tokenFrom(request):null;if(!token)return json({error:'No session'},401,safe);
  try{
    if(env.WORKSPACE_SOURCE_LIMIT&&!sourceLimitAllowed(await env.WORKSPACE_SOURCE_LIMIT.limit({key:await sha256('provider-self:'+(request.headers.get('cf-connecting-ip')??'unknown'))}))){safe.set('retry-after','60');return json({error:'Too many requests'},429,safe);}
    return await withDb(env,async db=>{
      await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
      try{
        const actor=scopedActor((await db.query("SELECT u.id,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 1",[await sha256(token)])).rows);
        if(!actor)return json({error:'Invalid session'},401,safe);
        if(!actor.tenant_id||(request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==String(actor.tenant_id)))return json({error:'Forbidden'},403,safe);
        const profiles=resultRows((await db.query('SELECT id,full_name,bio,languages,service_areas,provider_type,is_approved,skills FROM provider_profiles WHERE user_id::text=$1 AND tenant_id::text=$2 LIMIT 2',[String(actor.id),String(actor.tenant_id)])).rows,1);
        if(!profiles.length)return json({error:'Provider profile not found'},404,safe);
        if(profiles.length!==1)return json({error:'Provider data unavailable'},503,safe);
        const p=profiles[0];accountId(p.id);
        const requiredString=(value:unknown)=>typeof value==='string';
        const nullableString=(value:unknown)=>value===null||typeof value==='string';
        const dateTime=(value:unknown)=>validRecordTimestamp(value);
        const nullableDateTime=(value:unknown)=>value===null||dateTime(value);
        const count=(rows:Record<string,unknown>[],label:string)=>{const value=requiredRow(rows).count;if(typeof value!=='number'||!Number.isSafeInteger(value)||value<0)throw Error('Invalid '+label+' count');return value;};
        const statusGroup=(row:Record<string,unknown>,label:string,withDuration=false)=>{if(!nullableString(row.status)||typeof row.count!=='number'||!Number.isSafeInteger(row.count)||row.count<0||withDuration&&(typeof row.durationMinutes!=='string'||! /^-?\d+$/.test(row.durationMinutes)))throw Error('Invalid '+label+' summary');return withDuration?{status:row.status,count:row.count,durationMinutes:row.durationMinutes}:{status:row.status,count:row.count};};
        if(path==='/profile'){
          if(![p.id,p.full_name,p.languages,p.service_areas,p.provider_type,p.skills].every(requiredString)||!nullableString(p.bio)||typeof p.is_approved!=='boolean')throw Error('Invalid provider profile data');
          return json({profile:{id:p.id,full_name:p.full_name,bio:p.bio,languages:p.languages,service_areas:p.service_areas,provider_type:p.provider_type,is_approved:p.is_approved,skills:p.skills}},200,safe);
        }
        const values=[String(p.id),String(actor.tenant_id)];
        if(path==='/documents'||documentMatch||documentSummary){
          // ProviderDocument has no tenant_id: tenant/owner scope comes from
          // its registered provider relation, checked again in the document SQL.
          const scope=' FROM provider_documents d JOIN provider_profiles p ON p.id=d.provider_id WHERE p.id::text=$1 AND p.tenant_id::text=$2 AND p.user_id::text=$3';
          const documentValues=[...values,String(actor.id)];
          if(documentSummary){
            const total=count((await db.query('SELECT COUNT(*)::int AS count FROM (SELECT d.status'+scope+' GROUP BY d.status) groups',documentValues)).rows,'document summary');
            const rows=(await db.query('SELECT d.status,COUNT(*)::int AS count'+scope+' GROUP BY d.status ORDER BY d.status NULLS LAST LIMIT $4 OFFSET $5',[...documentValues,Number(limit),Number(offset)])).rows;
            return json({groups:summaryRows(pageRows(rows,Number(limit),Number(offset),total),Number(limit),['status']).map(g=>statusGroup(g,'document')),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
          }
          const fields='d.id,d.doc_type,d.status,d.expiry_date,d.verified_at,d.created_at,d.updated_at';
          const project=(d:Record<string,unknown>)=>{
            if(![d.id,d.doc_type].every(requiredString)||!nullableString(d.status)||![d.expiry_date,d.verified_at].every(nullableDateTime)||![d.created_at,d.updated_at].every(dateTime))throw Error('Invalid provider document data');
            return {id:d.id,doc_type:d.doc_type,status:d.status,expiry_date:projectRecordTimestamp(d.expiry_date),verified_at:projectRecordTimestamp(d.verified_at),created_at:projectRecordTimestamp(d.created_at),updated_at:projectRecordTimestamp(d.updated_at)};
          };
          if(documentMatch){
            const document=boundRow((await db.query('SELECT '+fields+scope+' AND d.id::text=$4',[...documentValues,documentMatch[1]])).rows,documentMatch[1]);
            return document?json({document:project(document)},200,safe):json({error:'Document not found'},404,safe);
          }
          const total=count((await db.query('SELECT COUNT(*)::int AS count'+scope,documentValues)).rows,'document');
          const rows=(await db.query('SELECT '+fields+scope+' ORDER BY d.created_at DESC,d.id DESC LIMIT $4 OFFSET $5',[...documentValues,Number(limit),Number(offset)])).rows;
          return json({documents:recordRows(pageRows(rows,Number(limit),Number(offset),total),Number(limit)).map(project),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        if(statusSummary){
          const filter='assigned_provider_id::text=$1 AND tenant_id::text=$2';
          const total=count((await db.query('SELECT COUNT(*)::int AS count FROM (SELECT status FROM visits WHERE '+filter+' GROUP BY status) groups',values)).rows,'visit summary');
          const rows=(await db.query('SELECT status,COUNT(*)::int AS count,SUM(duration_minutes)::text AS "durationMinutes" FROM visits WHERE '+filter+' GROUP BY status ORDER BY status NULLS LAST LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          return json({groups:summaryRows(pageRows(rows,Number(limit),Number(offset),total),Number(limit),['status']).map(g=>statusGroup(g,'visit',true)),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        if(path==='/visits'||visitMatch){
          const fields='id,service_id,requested_start_at,duration_minutes,status,priority,updated_at';
          const project=(v:Record<string,unknown>)=>{
            if(![v.id,v.service_id].every(requiredString)||![v.requested_start_at,v.updated_at].every(dateTime)||typeof v.duration_minutes!=='number'||!Number.isSafeInteger(v.duration_minutes)||!nullableString(v.status)||!nullableString(v.priority))throw Error('Invalid provider visit data');
            return {id:v.id,service_id:v.service_id,requested_start_at:projectRecordTimestamp(v.requested_start_at),duration_minutes:v.duration_minutes,status:v.status,priority:v.priority,updated_at:projectRecordTimestamp(v.updated_at)};
          };
          const filter='assigned_provider_id::text=$1 AND tenant_id::text=$2';
          if(visitMatch){
            const visit=boundRow((await db.query('SELECT '+fields+' FROM visits WHERE '+filter+' AND id::text=$3',[...values,visitMatch[1]])).rows,visitMatch[1]);
            return visit?json({visit:project(visit)},200,safe):json({error:'Visit not found'},404,safe);
          }
          const total=count((await db.query('SELECT COUNT(*)::int AS count FROM visits WHERE '+filter,values)).rows,'visit');
          const rows=(await db.query('SELECT '+fields+' FROM visits WHERE '+filter+' ORDER BY requested_start_at DESC,id DESC LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          return json({visits:recordRows(pageRows(rows,Number(limit),Number(offset),total),Number(limit)).map(project),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        const filter='provider_id::text=$1 AND tenant_id::text=$2';
        const availabilityFields='id,day_of_week,start_time,end_time';
        const projectAvailability=(i:Record<string,unknown>)=>{if(!requiredString(i.id)||typeof i.day_of_week!=='number'||!Number.isSafeInteger(i.day_of_week)||![i.start_time,i.end_time].every(requiredString))throw Error('Invalid provider availability data');return {id:i.id,day_of_week:i.day_of_week,start_time:i.start_time,end_time:i.end_time};};
        if(availabilityMatch){
          const item=boundRow((await db.query('SELECT '+availabilityFields+' FROM provider_availability WHERE '+filter+' AND id::text=$3',[...values,availabilityMatch[1]])).rows,availabilityMatch[1]);
          return item?json({availability:projectAvailability(item)},200,safe):json({error:'Availability not found'},404,safe);
        }
        if(availabilitySummary){
          const total=count((await db.query('SELECT COUNT(*)::int AS count FROM (SELECT day_of_week FROM provider_availability WHERE '+filter+' GROUP BY day_of_week) groups',values)).rows,'availability summary');
          const rows=(await db.query('SELECT day_of_week,COUNT(*)::int AS count FROM provider_availability WHERE '+filter+' GROUP BY day_of_week ORDER BY day_of_week LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          const groups=summaryRows(pageRows(rows,Number(limit),Number(offset),total),Number(limit),['day_of_week']).map(g=>{if(typeof g.day_of_week!=='number'||!Number.isSafeInteger(g.day_of_week)||typeof g.count!=='number'||!Number.isSafeInteger(g.count)||g.count<0)throw Error('Invalid availability summary');return {day_of_week:g.day_of_week,count:g.count};});
          return json({groups,pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        const total=count((await db.query('SELECT COUNT(*)::int AS count FROM provider_availability WHERE '+filter,values)).rows,'availability');
        const rows=(await db.query('SELECT id,day_of_week,start_time,end_time FROM provider_availability WHERE '+filter+' ORDER BY day_of_week,start_time,id LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
        return json({availability:recordRows(pageRows(rows,Number(limit),Number(offset),total),Number(limit)).map(projectAvailability),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
      }finally{await db.query('ROLLBACK');}
    });
  }catch{return json({error:'Provider data unavailable'},503,safe);}
}
