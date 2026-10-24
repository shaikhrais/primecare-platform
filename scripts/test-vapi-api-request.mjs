import {test} from 'node:test';
import assert from 'node:assert/strict';
import {VapiApiRequestAdapter} from '../packages/shared/src/communications/vapi-api-request.mjs';
import {VoiceTaskService,BoundVoiceApiTask} from '../cloudflare/workers/src/business-tasks/voice-tasks.ts';
const uid=n=>`${String(n).padStart(8,'0')}-1111-4111-8111-111111111111`;
const url='https://fixture.invalid/registered-tool',callId=uid(1),callSid='CA'+'a'.repeat(32),intent=uid(7);
function fixture(){
 let executions=0,proposals=0,authenticated=true,authorized=true,admitted=true,confirmed=false,denied=false;
 const claims=new Set(),rows=new Map();
 const identity={actor:{id:'alice',tenantId:'tenant-a'},sessionId:'app-session',authentication:'otp',active:true,expiresAt:Date.now()+300000};
 const call={vapiCallId:callId,callSid,orgId:uid(2),assistantId:uid(3),phoneNumberId:uid(4),active:true,expiresAt:Date.now()+300000};
 const task=new BoundVoiceApiTask('fixture.request',1,{validate(args){if(Object.keys(args).join(',')!=='serviceId'||args.serviceId!=='psw')throw Error('Invalid');return {...args};},describe(){return 'Request PSW help; appointment is not confirmed.';},async execute(actor,args,key){assert.deepEqual(actor,identity.actor);assert.equal(args.serviceId,'psw');assert.match(key,/^voice-task:/);executions++;}});
 const tasks=new VoiceTaskService({run(){throw Error('unused');},read(){throw Error('unused');},inbox(){throw Error('unused');}},{async assert(){if(denied)throw Error('private policy details');},async assignee(){throw Error('unused');}},{async create(row){proposals++;rows.set(row.id,structuredClone(row));},async read(id){return structuredClone(rows.get(id)??null);},async claim(id){const row=rows.get(id);if(row.status!=='proposed')return false;row.status='executing';return true;},async finish(id,status){rows.get(id).status=status;}},{async current(id){assert.equal(id,callSid);return structuredClone(identity);},async consumeConfirmation(){if(!confirmed)return null;confirmed=false;return {approved:true,method:'app',approvedAt:Date.now()};}},[task]);
 const options={url,orgId:call.orgId,assistantId:call.assistantId,phoneNumberId:call.phoneNumberId,async authenticate(){return authenticated;},async authorize(){return authorized;},async admit(){return admitted;},calls:{async current(id){assert.equal(id,callId);return structuredClone(call);}},claims:{async claim({vapiCallId,requestId,digest}){assert.equal(vapiCallId,callId);assert.match(digest,/^[a-f0-9]{64}$/);if(claims.has(requestId))return false;claims.add(requestId);return true;}},tasks,taskIds:['fixture.request']};
 return {adapter:new VapiApiRequestAdapter(options),options,identity,call,rows,claims,get executions(){return executions;},get proposals(){return proposals;},confirm(){confirmed=true;},deny(){denied=true;},authenticate(v){authenticated=v;},authorize(v){authorized=v;},admit(v){admitted=v;}};
}
const proposal=(n=10)=>({action:'propose',taskId:'fixture.request',args:{serviceId:'psw'},requestId:uid(n)});
const execute=(id,n)=>({action:'execute',intentId:id,requestId:uid(n)});
const req=(body,headers={})=>new Request(url,{method:'POST',headers:{'content-type':'application/json','x-primecare-vapi-call-id':callId,...headers},body:JSON.stringify(body)});
test('API Request reaches inherited task service, requires app approval and executes only once',async()=>{
 const f=fixture(),p=await (await f.adapter.respond(req(proposal()))).json();assert.equal(p.status,'awaiting_confirmation');assert.equal(p.requiresConfirmation,true);assert.equal(f.executions,0);assert.ok(!('digest'in p));assert.ok(!('actor'in p));
 const waiting=await (await f.adapter.respond(req(execute(p.intentId,11)))).json();assert.equal(waiting.status,'awaiting_confirmation');assert.equal(f.executions,0);
 f.confirm();const done=await (await f.adapter.respond(req(execute(p.intentId,12)))).json();assert.equal(done.status,'completed');assert.equal(f.executions,1);
 assert.equal((await f.adapter.respond(req(execute(p.intentId,12)))).status,409);assert.equal(f.executions,1);
 assert.equal((await f.adapter.respond(req(execute(p.intentId,13)))).status,503);assert.equal(f.executions,1);
});
test('service auth, registered policy and rate limits fail closed before parsing or claiming',async()=>{
 for(const [method,value,status] of [['authenticate',false,401],['authenticate',undefined,401],['authorize',false,403],['admit',false,429]]){const f=fixture();f[method](value);assert.equal((await f.adapter.respond(req(proposal()))).status,status);assert.equal(f.claims.size,0);assert.equal(f.proposals,0);}
});
test('provider scope and OTP identity must independently match, including revocation between proposal and execution',async()=>{
 for(const change of [c=>c.active=false,c=>c.expiresAt=Date.now()-1,c=>c.orgId=uid(9),c=>c.assistantId=uid(9),c=>c.phoneNumberId=uid(9),c=>c.callSid='forged',c=>c.vapiCallId=uid(9)]){const f=fixture();change(f.call);assert.equal((await f.adapter.respond(req(proposal()))).status,503);assert.equal(f.proposals,0);}
 for(const auth of ['caller-id','voice-match']){const f=fixture();f.identity.authentication=auth;assert.equal((await f.adapter.respond(req(proposal()))).status,503);assert.equal(f.proposals,0);}
 const f=fixture(),p=await (await f.adapter.respond(req(proposal()))).json();f.confirm();f.identity.actor.tenantId='tenant-b';assert.equal((await f.adapter.respond(req(execute(p.intentId,11)))).status,503);assert.equal(f.executions,0);
});
test('model identity, approval, unknown tasks, oversized input, wrong URL and malformed call IDs never dispatch',async()=>{
 for(const body of [{...proposal(),actor:{id:'admin'}},{...proposal(),approved:true},{...proposal(),taskId:'otp.check'},{...proposal(),args:{serviceId:'psw',tenantId:'tenant-b'}},{...proposal(),args:{serviceId:'x'.repeat(17000)}}]){const f=fixture();assert.ok((await f.adapter.respond(req(body))).status>=400);assert.equal(f.proposals,0);}
 const f=fixture();assert.equal((await f.adapter.respond(req(proposal(),{'x-primecare-vapi-call-id':'forged'}))).status,400);assert.equal((await f.adapter.respond(new Request(url+'?x=1',{method:'POST'}))).status,404);assert.equal((await f.adapter.respond(new Request(url))).status,405);
});
test('durable duplicate claims prevent concurrent proposals, and provider errors never leak',async()=>{
 const f=fixture(),out=await Promise.all([f.adapter.respond(req(proposal())),f.adapter.respond(req(proposal()))]);assert.deepEqual(out.map(r=>r.status).sort(),[200,409]);assert.equal(f.proposals,1);
 const g=fixture();g.deny();const failed=await g.adapter.respond(req(proposal()));assert.equal(failed.status,503);assert.ok(!(await failed.text()).includes('private policy'));assert.equal(g.proposals,0);
});
test('call binding is rechecked after durable claim before task access',async()=>{
 const f=fixture();f.options.claims.claim=async()=>{f.call.callSid='CA'+'b'.repeat(32);return true;};const adapter=new VapiApiRequestAdapter(f.options);assert.equal((await adapter.respond(req(proposal()))).status,503);assert.equal(f.proposals,0);
});
