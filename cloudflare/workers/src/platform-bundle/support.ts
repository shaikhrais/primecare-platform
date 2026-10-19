import type {Client} from 'pg';
import {registry,type BundleActor} from '../../../../packages/shared/src/platform-bundle/contract';
import {keys,text,fail} from '../../../../packages/shared/src/growth/contract';
import {requiredRow,optionalRow} from '../database-results';
export async function supportCommand(db:Client,actor:BundleActor,global:boolean,tenant:string,id:string|undefined,body:Record<string,unknown>){
 if(!id){
  keys(body,['subject','message','priority']);if(!text(body.subject,150)||!text(body.message,2000)||!Object.hasOwn(registry.ticketHours,String(body.priority)))fail(400);
  const hours=registry.ticketHours[body.priority as keyof typeof registry.ticketHours];id=crypto.randomUUID();
  await db.query("INSERT INTO platform_support_tickets(id,tenant_id,subject,priority,created_by,response_due,resolution_due) VALUES($1,$2,$3,$4,$5,NOW()+$6*INTERVAL '1 hour',NOW()+$7*INTERVAL '1 hour')",[id,tenant,body.subject,body.priority,actor.id,hours.response,hours.resolution]);
 }else{
  keys(body,['version','action','message','ownerId','status','priority']);if(!Number.isSafeInteger(body.version)||Number(body.version)<1||!text(body.message,2000)||!['reply','triage','reopen'].includes(String(body.action)))fail(400);
  const old=optionalRow((await db.query('SELECT * FROM platform_support_tickets WHERE id=$1 AND tenant_id::text=$2 FOR UPDATE',[id,tenant])).rows);if(!old)fail(404,'not_found');if(old.version!==body.version)fail(409,'conflict');
  if(body.action==='triage'){
   if(!global)fail(403,'forbidden');if(!['open','in_progress','resolved'].includes(String(body.status))||!Object.hasOwn(registry.ticketHours,String(body.priority))||!(body.ownerId===null||text(body.ownerId,200)))fail(400);
   if(old.status==='resolved')fail(409,'conflict');
   if(body.ownerId!==null){const owner=optionalRow((await db.query("SELECT u.id FROM users u JOIN tenants t ON t.id=u.tenant_id WHERE u.id::text=$1 AND u.roles=ANY($2::text[]) AND LOWER(u.status)='active' AND LOWER(t.status)='active' FOR SHARE OF u,t",[body.ownerId,Object.entries(registry.roles).filter(([,s])=>s==='global').map(([r])=>r)])).rows);if(!owner)fail(400);}
   if(body.status!=='open'&&!body.ownerId)fail(400);
   const h=registry.ticketHours[body.priority as keyof typeof registry.ticketHours];
   // Priority changes keep the original cycle start; they never reset the SLA clock.
   await db.query("UPDATE platform_support_tickets SET owner_id=$1,status=$2,priority=$3,response_due=cycle_start+$4*INTERVAL '1 hour',resolution_due=cycle_start+$5*INTERVAL '1 hour',first_response_at=COALESCE(first_response_at,NOW()),resolved_at=CASE WHEN $2='resolved' THEN NOW() ELSE NULL END,version=version+1 WHERE id=$6",[body.ownerId,body.status,body.priority,h.response,h.resolution,id]);
  }else if(body.action==='reopen'){
   if(Object.keys(body).some(k=>!['version','action','message'].includes(k)))fail(400);if(old.status!=='resolved')fail(409,'conflict');const h=registry.ticketHours[old.priority as keyof typeof registry.ticketHours];
   await db.query("UPDATE platform_support_tickets SET status='open',cycle_start=NOW(),first_response_at=NULL,resolved_at=NULL,response_due=NOW()+$1*INTERVAL '1 hour',resolution_due=NOW()+$2*INTERVAL '1 hour',version=version+1 WHERE id=$3",[h.response,h.resolution,id]);
  }else{
   if(Object.keys(body).some(k=>!['version','action','message'].includes(k)))fail(400);if(old.status==='resolved')fail(409,'conflict');
   await db.query('UPDATE platform_support_tickets SET first_response_at=CASE WHEN $1 THEN COALESCE(first_response_at,NOW()) ELSE first_response_at END,version=version+1 WHERE id=$2',[global,id]);
  }
 }
 const messageId=crypto.randomUUID();await db.query('INSERT INTO platform_support_messages(id,tenant_id,ticket_id,actor_id,message) VALUES($1,$2,$3,$4,$5)',[messageId,tenant,id,actor.id,body.message]);
 return {id,version:id&&body.version?Number(body.version)+1:1};
}
