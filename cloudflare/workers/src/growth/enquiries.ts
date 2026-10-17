import {captureTerritoryEnquiry} from '../platform-bundle/routing';
import {json,withDb,sha256,parseBody,bodyFailure,type Env} from '../auth';
import {requiredRow,optionalRow} from '../database-results';
import {GrowthFailure,fail,canonical,registry} from '../../../../packages/shared/src/growth/contract';
import {canReceiveEnquiry,enquiryBody} from '../../../../packages/shared/src/growth/intake';
export async function publicEnquiry(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null>{
 if(env.SERVICE_NAME!=='governance'||!path.startsWith('/growth/enquiries/'))return null;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('x-content-type-options','nosniff');
 try{
  const match=/^\/growth\/enquiries\/([0-9a-f]{64})$/.exec(path);if(!match)fail(404,'not_found');
  if(!['GET','POST'].includes(request.method))fail(405,'method_not_allowed');
  if(new URL(request.url).searchParams.size||request.headers.has('x-tenant-id'))fail(400);
  let body:Record<string,unknown>|undefined,key:string|null=null;
  if(request.method==='POST'){
   key=request.headers.get('idempotency-key');if(!key||! /^[A-Za-z0-9_-]{16,100}$/.test(key))fail(400);
   try{body=await parseBody(request);}catch(error){if(error instanceof GrowthFailure)throw error;return bodyFailure(error,'invalid_request',safe);}
  }else if(request.body)fail(400);
  return await withDb(env,async db=>{
   // Rate attempts persist outside the business transaction, including replay and denied links.
   const rateLimit=async(bucket:string,limit:number)=>{const rate=requiredRow((await db.query("INSERT INTO growth_intake_rate(bucket,attempts,window_start) VALUES($1,1,NOW()) ON CONFLICT(bucket) DO UPDATE SET attempts=CASE WHEN growth_intake_rate.window_start<NOW()-INTERVAL '1 minute' THEN 1 ELSE growth_intake_rate.attempts+1 END,window_start=CASE WHEN growth_intake_rate.window_start<NOW()-INTERVAL '1 minute' THEN NOW() ELSE growth_intake_rate.window_start END RETURNING attempts",[bucket])).rows);if(typeof rate.attempts!=='number')throw Error('Invalid intake rate');if(rate.attempts>limit){safe.set('retry-after','60');fail(429,'rate_limited');}};
   await rateLimit(await sha256('enquiry-source:'+(request.headers.get('cf-connecting-ip')??'unknown')),registry.intakePolicy.sourceRate);
   const known=optionalRow((await db.query('SELECT id FROM growth_intake_links WHERE public_key=$1',[match![1]])).rows);if(!known)fail(404,'not_found');
   await rateLimit(await sha256('enquiry-link:'+match![1]),registry.intakePolicy.linkRate);
   await db.query('BEGIN');let committed=false;
   try{
    const link=optionalRow((await db.query("SELECT l.* FROM growth_intake_links l JOIN tenants t ON t.id=l.tenant_id JOIN users u ON u.id=l.owner_id AND u.tenant_id=l.tenant_id WHERE l.public_key=$1 AND l.active=TRUE AND LOWER(t.status)='active' AND LOWER(u.status)='active' AND u.roles=ANY($2::text[]) FOR SHARE OF l,u",[match![1],registry.roles.filter(canReceiveEnquiry)])).rows);
    if(!link)fail(404,'not_found');
    const mode=String(link.routing_mode??'direct');if(!registry.intakePolicy.routingModes.includes(mode)||mode==='territory'&&link.pipeline!=='client')throw Error('Invalid delivery mode');
    if(request.method==='GET')return json({name:link!.name,pipeline:link!.pipeline,consentVersion:registry.intakePolicy.consentVersion,...(mode==='territory'?{routingMode:mode,sharingConsentVersion:registry.intakePolicy.sharingConsentVersion}:{})},200,safe);
    const v=enquiryBody(body!,mode),tenant=String(link!.tenant_id),fingerprint=await sha256(canonical(v));
    if(mode==='territory'){
     // Lock order matches staff capture and tenant acceptance. Responses never reveal matching or duplicate state.
     await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',['platform-enquiry-routing']);
     const replay=optionalRow((await db.query('SELECT request_hash FROM growth_territory_receipts WHERE link_id=$1 AND request_key=$2',[link.id,key])).rows);if(replay){if(replay.request_hash!==fingerprint)fail(409,'conflict');return json({accepted:true},202,safe);}
     const routed=await captureTerritoryEnquiry(db,{name:v.name,email:v.email,phone:v.phone,postalCode:v.postalCode,service:v.service,consent:'Public sharing consent '+v.sharingConsentVersion,confirmed:true},null,{linkId:String(link.id),source:String(link.source),attribution:String(link.attribution)});
     await db.query('INSERT INTO growth_territory_receipts(id,link_id,tenant_id,enquiry_id,request_key,request_hash,response_consent_version,sharing_consent_version,new_enquiry) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9)',[crypto.randomUUID(),link.id,tenant,routed.id,key,fingerprint,v.consentVersion,v.sharingConsentVersion,routed.created]);
     await db.query('COMMIT');committed=true;return json({accepted:true},202,safe);
    }
    if(!optionalRow((await db.query("SELECT id FROM tenants WHERE id::text=$1 AND LOWER(status)='active' FOR SHARE",[tenant])).rows))fail(404,'not_found');
    await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['enquiry:'+tenant+':'+link!.pipeline]);
    const replay=optionalRow((await db.query('SELECT request_hash FROM growth_intake_receipts WHERE link_id=$1 AND request_key=$2',[link!.id,key])).rows);
    if(replay){if(replay.request_hash!==fingerprint)fail(409,'conflict');return json({accepted:true},202,safe);}
    const digits=String(v.phone).replace(/\D/g,''),hash=await sha256(String(v.email)||digits);
    const old=optionalRow((await db.query("SELECT id FROM growth_leads WHERE tenant_id::text=$1 AND pipeline=$2 AND (contact_hash=$3 OR ($4<>'' AND LOWER(email)=$4) OR ($5<>'' AND regexp_replace(phone,'[^0-9]','','g')=$5)) ORDER BY created_at,id LIMIT 1",[tenant,link!.pipeline,hash,v.email,digits])).rows);
    let leadId=old?.id;
    if(!leadId){leadId=crypto.randomUUID();await db.query("INSERT INTO growth_leads(id,tenant_id,pipeline,name,email,phone,source,reference,contact_basis,contact_hash,campaign_id,owner_id,due_at) VALUES($1,$2,$3,$4,$5,$6,$7,$8,'requested',$9,$10,$11,NOW()+INTERVAL '1 day')",[leadId,tenant,link!.pipeline,v.name,v.email,v.phone,link!.source,'Intake '+link!.id+': '+link!.attribution,hash,link!.campaign_id,link!.owner_id]);await db.query("INSERT INTO growth_milestones(tenant_id,lead_id,stage,evidence) VALUES($1,$2,'new',$3)",[tenant,leadId,'Enquiry response consent '+v.consentVersion]);}
    // Receipt is the immutable anonymous audit event. Existing contacts/opt-outs are never changed.
    await db.query('INSERT INTO growth_intake_receipts(id,link_id,tenant_id,lead_id,request_key,request_hash,consent_version,new_lead) VALUES($1,$2,$3,$4,$5,$6,$7,$8)',[crypto.randomUUID(),link!.id,tenant,leadId,key,fingerprint,v.consentVersion,!old]);
    await db.query('COMMIT');committed=true;return json({accepted:true},202,safe);
   }finally{if(!committed)await db.query('ROLLBACK');}
  });
 }catch(error){if(error instanceof GrowthFailure)return json({error:error.code},error.status,safe);return json({error:'unavailable'},503,safe);}
}
