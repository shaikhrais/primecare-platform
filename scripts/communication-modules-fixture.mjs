/** Disposable API/SQL fixture only. Never a runtime policy or permission provider. */
import {pswFixture} from './psw-workspace-fixture.mjs';
import {CommunicationService} from '../cloudflare/workers/src/business-tasks/communication.ts';
import {BusinessMailService} from '../cloudflare/workers/src/business-tasks/mail.ts';
import {PostgresAtomicStore} from '../cloudflare/workers/src/business-tasks/store.ts';
import {CommunicationCore} from '../cloudflare/workers/src/business-tasks/channels.ts';
import {build} from 'esbuild';
import Ajv from 'ajv';import addFormats from 'ajv-formats';
export async function communicationModulesFixture(){
 const f=await pswFixture();const sql=await(await import('node:fs/promises')).readFile('packages/database/migrations/20261022_business_communications.sql','utf8');if(f.db.exec)await f.db.exec(sql.replaceAll('public.',''));else await f.db.query(sql.replaceAll('public.',''));
 const pool={query:(...args)=>f.db.query(...args),connect:async()=>({query:(...args)=>f.db.query(...args),release(){}})},store=new PostgresAtomicStore(pool),revoked=new Set(),actors=new Map(Object.values(f.actors).map(a=>[a.id,{id:a.id,tenantId:a.tenant}]));
 const policy={async assert(actor,action,state){if(actor.id==='inbound-mail'&&actor.tenantId===f.tenants[0]&&action==='mail.receive')return;if(revoked.has(actor.id)||actors.get(actor.id)?.tenantId!==actor.tenantId||state&&state.tenantId!==actor.tenantId)throw Error('Forbidden');},async assignee(actor,id){if(actors.get(id)?.tenantId!==actor.tenantId||revoked.has(id))throw Error('Forbidden');}};
 const pictures={async prepare(){throw Error('Fixture upload unavailable');},async get(){throw Error('Fixture binary unavailable');}};
 const messages=new CommunicationService(store,policy,pictures,{maxMembers:8,maxMessages:100,maxText:2000,maxPictureBytes:1024,maxPictures:3,ringMilliseconds:30000,maxSignalBytes:16384});let sends=0;
 const mail=new BusinessMailService(store,policy,{async access(actor,id){if(actor.id!==f.actors.admin.id||id!=='fixture-mailbox'||revoked.has(actor.id))throw Error('Forbidden');},async recipient(){},async resolve(){return{tenantId:f.tenants[0],mailboxId:'fixture-mailbox'};}},{async send(){sends++;throw Error('External mail is forbidden in this fixture');}},'sender@example.invalid',4096);
 const core=new CommunicationCore(messages,mail),result=await build({entryPoints:['cloudflare/workers/src/business-tasks/http.ts'],bundle:true,write:false,platform:'node',format:'esm'}),{CommunicationHttpWorker,CommunicationHttpError}=await import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));
 const ajv=new Ajv({strict:false});addFormats(ajv);ajv.addFormat('binary',()=>true);const validators=new Map();
 const worker=new CommunicationHttpWorker({core,maxRequestBytes:8192,validate(schema,value){if(!validators.has(schema))validators.set(schema,ajv.compile(schema));return validators.get(schema)(value);},async authenticate(request){const token=request.headers.get('authorization')?.replace(/^Bearer /,'');const actor=Object.values(f.actors).find(a=>a.token===token);if(!actor)throw new CommunicationHttpError(401);return actors.get(actor.id);},async authorizeEndpoint(actor){if(revoked.has(actor.id)||actor.id===f.actors.client.id)throw new CommunicationHttpError(403);}});
 const actor=actors.get(f.actors.admin.id),thread=crypto.randomUUID(),picture=crypto.randomUUID(),mailId=crypto.randomUUID();await messages.create(actor,thread,crypto.randomUUID(),[actor.id,f.actors.psw.id],'B14 fixture conversation');await messages.message(actor,thread,crypto.randomUUID(),1,'Initial private message');
 // Existing private attachment metadata is inserted only in the disposable SQL fixture.
 await f.db.query("UPDATE business_work_aggregates SET state=jsonb_set(state,'{messages,0,pictureIds}',$1::jsonb) WHERE id=$2",[JSON.stringify([picture]),thread]);
 await mail.queue(actor,mailId,crypto.randomUUID(),'recipient@example.invalid','B14 queued subject','Private outbound body');await mail.receive({from:'unverified@example.invalid',to:'inbox@example.invalid',raw:new TextEncoder().encode('From: unverified@example.invalid\r\nTo: inbox@example.invalid\r\nSubject: Quarantined fixture\r\nContent-Type: text/html; charset=utf-8\r\n\r\n<p>Safe preview</p><script>never execute</script>')});
 const scope={tenantId:actor.tenantId,userId:actor.id,role:f.actors.admin.role,dataset:'live'};
 return{...f,scope,thread,picture,mailId,worker,revoked,messages,mail,actorMap:actors,sends:()=>sends,call:(path,body,role='admin')=>worker.fetch(new Request('https://fixture'+path,{method:body?'POST':'GET',headers:{authorization:'Bearer '+f.actors[role].token,...(body?{'content-type':'application/json'}:{})},...(body?{body:JSON.stringify(body)}:{})}),{})};
}
