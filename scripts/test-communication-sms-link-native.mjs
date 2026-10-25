import {test} from 'node:test';
import assert from 'node:assert/strict';
import {NativeSmsLinkService,NativeSmsLinkChannel} from '../cloudflare/workers/src/business-tasks/sms-link-native.ts';
import {NativeSmsLinkHttpAdapter,NativeSmsLinkHttpError} from '../cloudflare/workers/src/business-tasks/sms-link-http.ts';
import {ScopedServiceBase,CommunicationChannelBase} from '../packages/shared/src/communications/service-base.ts';
const actor={id:'alice',tenantId:'tenant-a'},context={actor,sessionHash:'a'.repeat(64)},id=crypto.randomUUID();
const link={id,version:1,actorId:actor.id,tenantId:actor.tenantId,conversationId:'thread',provider:'twilio',channel:'sms',address:'+15550002000'};
const conversation={id:'thread',tenantId:actor.tenantId,kind:'conversation',version:1,members:[actor.id]};
function fixture(){
 const calls=[];let state=structuredClone(conversation),current=structuredClone(link),deny=false;
 const policy={async assert(a,action){calls.push(action);if(deny)throw Error('Policy denied');},async assignee(){throw Error('No grant');}};
 const store={async read(a,i,authorize){await authorize(state);return state;},async run(){throw Error('Unused');},async inbox(){return [];}};
 const repository={async status(c,i){calls.push(['status',c,i]);return current;},async bind(c,input){calls.push(['bind',c,input]);return current;},async revoke(c,i){calls.push(['revoke',c,i]);}};
 const service=new NativeSmsLinkService(store,policy,repository);
 return {service,calls,setState:v=>state=v,setLink:v=>current=v,deny:()=>deny=true};
}
function http(f,overrides={}){
 const authCalls=[],grants=[];const adapter=new NativeSmsLinkHttpAdapter({origin:'https://api.example.test',appOrigins:['https://app.example.test'],maxRequestBytes:1024,service:f.service,
 async authenticate(){authCalls.push(1);return {...context,expiresAt:Date.now()+60000};},async authorize(s,key){grants.push(key);},...overrides});
 return {adapter,authCalls,grants};
}
function request(action='status',body={conversationId:'thread'},headers={}){
 return new Request('https://api.example.test/v1/messaging/sms/link/'+action,{method:'POST',headers:{authorization:'Bearer fixture',origin:'https://app.example.test','content-type':'application/json',...headers},body:JSON.stringify(body)});
}
test('native link service and channel inherit shared bases and strip private link fields',async()=>{
 const f=fixture(),channel=new NativeSmsLinkChannel(f.service,context);assert.ok(f.service instanceof ScopedServiceBase);assert.ok(channel instanceof CommunicationChannelBase);
 assert.deepEqual(await channel.execute(actor,{action:'status',conversationId:'thread'}),{linked:true,link:{id,version:1,conversationId:'thread',channel:'sms'}});
 f.setLink(null);assert.deepEqual(await channel.execute(actor,{action:'status',conversationId:'thread'}),{linked:false});
});
test('request identity, session and consent overrides never reach a repository',async()=>{
 const f=fixture(),channel=new NativeSmsLinkChannel(f.service,context);
 for(const extra of [{actorId:'mallory'},{tenantId:'other'},{phone:'+15550009999'},{sessionHash:'b'.repeat(64)},{provider:'telegram'}])await assert.rejects(channel.execute(actor,{action:'status',conversationId:'thread',...extra}));
 await assert.rejects(channel.execute({...actor,id:'mallory'},{action:'revoke',id}));
 await assert.rejects(channel.execute(actor,{action:'bind',id,conversationId:'thread',consent:false}));
 assert.equal(f.calls.length,0);
});
test('conversation membership, tenant and current policy fail before link access',async()=>{
 for(const state of [{...conversation,members:['bob']},{...conversation,tenantId:'other'},{...conversation,kind:'workflow'}]){
  const f=fixture();f.setState(state);await assert.rejects(f.service.execute(context,{action:'status',conversationId:'thread'}));assert.ok(!f.calls.some(Array.isArray));
 }
 const f=fixture();f.deny();await assert.rejects(f.service.execute(context,{action:'bind',id,conversationId:'thread',consent:true}),/Policy denied/);assert.ok(!f.calls.some(Array.isArray));
});
test('cross-owner repository results and missing/invalid projections fail closed',async()=>{
 for(const invalid of [{...link,actorId:'bob'},{...link,tenantId:'other'},{...link,conversationId:'other'},{...link,version:0},{...link,id:'bad'},{...link,provider:'telegram'},undefined]){
  const f=fixture();f.setLink(invalid);await assert.rejects(f.service.execute(context,{action:'status',conversationId:'thread'}));
 }
});
test('bind and revoke delegate exact native context and bounded body fields',async()=>{
 const f=fixture(),mutable={actor:{...actor},sessionHash:context.sessionHash},channel=new NativeSmsLinkChannel(f.service,mutable);mutable.actor.id='mallory';mutable.sessionHash='b'.repeat(64);
 await channel.execute(actor,{action:'bind',id,conversationId:'thread',consent:true});await channel.execute(actor,{action:'revoke',id});
 assert.deepEqual(f.calls.filter(Array.isArray),[['bind',context,{id,conversationId:'thread',consent:true}],['revoke',context,id]]);
});
test('HTTP validates all registered operations and rechecks native identity and grant three times',async()=>{
 for(const [action,input] of [['status',{conversationId:'thread'}],['bind',{id,conversationId:'thread',consent:true}],['revoke',{id}]]){
  const f=fixture(),h=http(f),response=await h.adapter.respond(request(action,input));assert.equal(response.status,200);assert.equal(h.authCalls.length,3);assert.deepEqual(h.grants,Array(3).fill('link.'+action));
  const text=await response.text();for(const secret of [link.address,context.sessionHash,'actorId','tenantId','provider'])assert.ok(!text.includes(secret));assert.equal(response.headers.get('cache-control'),'private, no-store');
 }
});
test('HTTP rejects cookie-only credentials, unapproved origins, malformed input and extra fields',async()=>{
 for(const [headers,status] of [[{authorization:''},401],[{origin:'https://evil.example.test'},403],[{'content-type':'text/plain'},415],[{'content-length':'99999'},400]]){
  const f=fixture(),h=http(f);assert.equal((await h.adapter.respond(request('status',{conversationId:'thread'},headers))).status,status);assert.equal(f.calls.length,0);
 }
 for(const input of [{conversationId:'thread',actorId:'mallory'},{conversationId:'thread',action:'revoke'},{conversationId:'thread',sessionHash:context.sessionHash},null,[],{conversationId:''}]){
  const f=fixture(),h=http(f);assert.equal((await h.adapter.respond(request('status',input))).status,400);assert.equal(f.calls.length,0);
 }
});
test('HTTP session changes while reading prevent mutation and changes after commit hide result without retry',async()=>{
 for(const changeAt of [2,3]){
  const f=fixture();let n=0;const h=http(f,{async authenticate(){return {actor:++n===changeAt?{...actor,id:'bob'}:actor,sessionHash:context.sessionHash,expiresAt:Date.now()+60000};}});
  assert.equal((await h.adapter.respond(request('revoke',{id}))).status,401);assert.equal(f.calls.filter(Array.isArray).length,changeAt===2?0:1);
 }
});
test('HTTP grant failures and invalid repository output never disclose internal errors',async()=>{
 const f=fixture(),h=http(f,{async authorize(){throw new NativeSmsLinkHttpError(403);}});assert.equal((await h.adapter.respond(request())).status,403);assert.equal(f.calls.length,0);
 f.setLink({...link,actorId:'bob'});const response=await http(f).adapter.respond(request());assert.equal(response.status,503);assert.deepEqual(await response.json(),{error:'unavailable'});
});
test('HTTP keeps contracts restricted to exact origin, path and method',async()=>{
 const h=http(fixture());
 for(const [url,method,status] of [['https://other.example.test/v1/messaging/sms/link/status','POST',404],['https://api.example.test/v1/messaging/sms/link/status','GET',405],['https://api.example.test/v1/messaging/sms/link/status?actor=bob','POST',400],['https://api.example.test/v1/other','POST',404]])assert.equal((await h.adapter.respond(new Request(url,{method}))).status,status);
});
