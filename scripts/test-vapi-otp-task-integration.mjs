import {test} from 'node:test';
import assert from 'node:assert/strict';
import {VoiceOtpService} from '../cloudflare/workers/src/business-tasks/voice-otp.ts';
import {VoiceTaskService} from '../cloudflare/workers/src/business-tasks/voice-tasks.ts';
import {ReceptionCallbackTask} from '../cloudflare/workers/src/business-tasks/voice-reception-tasks.ts';
import {VapiApiRequestAdapter} from '../packages/shared/src/communications/vapi-api-request.mjs';
import {VapiCallReadClient,createVapiCanonicalCallDirectory} from '../packages/shared/src/communications/vapi-call-read.mjs';
const uuid=n=>`${String(n).padStart(8,'0')}-1111-4111-8111-111111111111`,vapiId=uuid(1),orgId=uuid(2),assistantId=uuid(3),phoneNumberId=uuid(4),accountSid='AC'+'a'.repeat(32),callSid='CA'+'b'.repeat(32),verificationSid='VE'+'c'.repeat(32),sharedNumber='+12897994277',sessionHash='d'.repeat(64),url='https://fixture.invalid/v1/vapi/voice/tasks';
function fixture(){
 let row=null,loggedIn=true,approved=false,writes=0;const contact={phone:'+15550001001',version:1},actor={id:'alice',tenantId:'tenant-a'};
 const call={sid:callSid,accountSid,to:sharedNumber,direction:'inbound',status:'in-progress'};
 const providerCall={id:vapiId,orgId,assistantId,phoneNumberId,type:'inboundPhoneCall',status:'in-progress',phoneCallProvider:'twilio',phoneCallProviderId:callSid,transport:{provider:'twilio',accountSid,callSid,conversationType:'voice'},startedAt:new Date().toISOString()};
 const unused=()=>{throw Error('unused');},store={run:unused,read:unused,inbox:unused},policy={async assert(a,action,state){assert.equal(a.tenantId,state.tenantId);},assignee:unused};
 const repository={async issue(id,hash,expiresAt){if(row)throw Error('Already issued');row={callSid:id,pairingHash:hash,state:'issued',expiresAt};},async begin(input){if(row.state!=='issued'||input.pairingHash!==row.pairingHash)return false;Object.assign(row,{state:'sending',nativeSessionHash:input.nativeSessionHash,userId:input.actor.id,tenantId:input.actor.tenantId,phone:input.contact.phone,contactVersion:input.contact.version});return true;},async sent(id,sid){row.state='pending';row.verificationSid=sid;},async unknown(){row.state='unknown';},async read(){return row?structuredClone(row):null;},async claimCheck(){if(row.state!=='pending')return false;row.state='checking';return true;},async checked(id,ok,grant,expiresAt){row.state=ok?'verified':'pending';row.grantId=ok?grant:null;row.expiresAt=expiresAt;}};
 const otp=new VoiceOtpService(store,policy,repository,{sessions:{async currentSession(hash){return loggedIn?{id:hash,userId:actor.id,tenantId:actor.tenantId,active:true,expiresAt:Date.now()+300000}:null;}},calls:{async fetch(){return {...call};}},contacts:{async current(){return {...contact};}},provider(){return {async start(){return {verificationSid,status:'pending'};},async check(sid,code){return {approved:sid===verificationSid&&code==='123456'};}};}},{accountSid,sharedNumber});
 const intents=new Map();
 const tasks=new VoiceTaskService(store,policy,{async create(intent){intents.set(intent.id,structuredClone(intent));},async read(id){return structuredClone(intents.get(id)??null);},async claim(id){const intent=intents.get(id);if(intent.status!=='proposed')return false;intent.status='executing';return true;},async finish(id,status){intents.get(id).status=status;}},{current:otp.current.bind(otp),async consumeConfirmation(){if(!approved)return null;approved=false;return {approved:true,method:'app',approvedAt:Date.now()};}},[new ReceptionCallbackTask(async(current,args,key)=>{assert.deepEqual(current,actor);assert.match(key,/^voice-task:/);writes++;})]);
 const vapi=new VapiCallReadClient({apiKey:'private-fixture-key',async fetch(){return Response.json(providerCall);}});
 const calls=createVapiCanonicalCallDirectory({vapi,twilio:{async fetch(){return {...call};}},orgId,assistantId,phoneNumberId,accountSid,sharedNumber});
 const adapter=new VapiApiRequestAdapter({url,orgId,assistantId,phoneNumberId,async authenticate(){return true;},async authorize(){return true;},async admit(){return true;},calls,claims:{seen:new Set(),async claim({requestId}){if(this.seen.has(requestId))return false;this.seen.add(requestId);return true;}},tasks,taskIds:['reception.callback.request']});
 let sequence=10;const request=body=>new Request(url,{method:'POST',headers:{'content-type':'application/json','x-primecare-vapi-call-id':vapiId},body:JSON.stringify({...body,requestId:uuid(sequence++)})});
 const propose=()=>adapter.respond(request({action:'propose',taskId:'reception.callback.request',args:{reason:'general',windowStartsAt:new Date(Date.now()+3600000).toISOString(),windowEndsAt:new Date(Date.now()+7200000).toISOString()}}));
 return {otp,adapter,request,propose,providerCall,call,contact,get writes(){return writes;},confirm(){approved=true;},logout(){loggedIn=false;},async verify(){const pair=await otp.issue(callSid);await otp.start(sessionHash,callSid,pair.pairingCode);assert.equal((await otp.check(sessionHash,callSid,'123456')).verified,true);return pair.pairingCode;}};
}
test('Vapi canonical call -> real OTP broker -> exact app approval -> inherited callback task',async()=>{
 const f=fixture();assert.equal((await f.propose()).status,503);assert.equal(f.writes,0);
 const pairing=await f.verify(),response=await f.propose(),proposal=await response.json();assert.equal(response.status,200);assert.equal(proposal.status,'awaiting_confirmation');assert.ok(!JSON.stringify(proposal).includes(pairing));assert.ok(!JSON.stringify(proposal).includes('123456'));
 let receipt=await (await f.adapter.respond(f.request({action:'execute',intentId:proposal.intentId}))).json();assert.equal(receipt.status,'awaiting_confirmation');assert.equal(f.writes,0);
 f.confirm();receipt=await (await f.adapter.respond(f.request({action:'execute',intentId:proposal.intentId}))).json();assert.equal(receipt.status,'completed');assert.equal(f.writes,1);
});
test('logout, contact change and either provider ending revoke Vapi task access after OTP',async()=>{
 for(const change of [f=>f.logout(),f=>f.contact.version++,f=>f.providerCall.status='ended',f=>f.call.status='completed']){const f=fixture();await f.verify();change(f);assert.equal((await f.propose()).status,503);assert.equal(f.writes,0);}
});
test('OTP verification and approval cannot be invoked as Vapi task commands',async()=>{
 const f=fixture();for(const action of ['otp.start','otp.check','approve']){const response=await f.adapter.respond(f.request({action,intentId:uuid(8)}));assert.equal(response.status,400);}assert.equal(f.writes,0);
});
