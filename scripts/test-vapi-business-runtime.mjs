import {test} from 'node:test';
import assert from 'node:assert/strict';
import {createVapiBusinessRuntime} from '../packages/shared/src/communications/vapi-business-runtime.mjs';
import {savedAgents} from '../packages/shared/src/communications/vapi-agent-library.mjs';
const callId='11111111-1111-4111-8111-111111111111',leadId='22222222-2222-4222-8222-222222222222';
const request=(name='primecare_lead_suppress',args={notes:'Caller requested no contact.'})=>new Request('https://host.invalid',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({message:{type:'tool-calls',call:{id:callId},toolCallList:[{id:'tool_one',type:'function',function:{name,arguments:JSON.stringify(args)}}]}})});
function fixture(agentKey='qualification'){
 let scope='existing_session',writes=0,reads=0,deny=false,lose=false,change=false,contexts=0;
 const lead={id:leadId,pipeline:'client',stage:'new',version:1,contact_blocked:false},calls=[],receipts=new Map();
 const binding={scopeKey:scope,agentKey,assistantId:savedAgents[agentKey],expiresAt:Date.now()+60000,leadId,currentScope:()=>scope,fetch:async(url,init)=>{
  assert.equal(new URL(url).origin,'https://primecare-api-gateway.itpro-mohammed.workers.dev');assert.equal(init.redirect,'manual');
  if(deny)return new Response(null,{status:403});
  if(init.method==='GET'){reads++;return Response.json({leads:[lead],calls});}
  writes++;const b=JSON.parse(init.body);assert.equal(b.leadId,leadId);assert.equal(b.leadVersion,1);
  lead.version++;lead.contact_blocked=true;lead.due_at=null;calls.push({id:'33333333-3333-4333-8333-333333333333',lead_id:leadId,outcome:b.outcome,notes:b.notes});
  if(lose)throw Error('lost acknowledgement');
  return Response.json({id:calls[0].id,leadVersion:lead.version});
 }};
 const runtime=createVapiBusinessRuntime({authenticate:async()=>true,authorize:async(c)=>{assert.equal(c.nativeScopeKey,'existing_session');return true;},contexts:{current:async()=>{contexts++;if(change&&contexts===3)binding.leadId='44444444-4444-4444-8444-444444444444';return {...binding};}},journal:{async begin(k){const key=k.scopeKey+':'+k.toolCallId,old=receipts.get(key);if(old)return old;receipts.set(key,{status:'pending',digest:k.digest});return {status:'new'};},async complete(k){receipts.set(k.scopeKey+':'+k.toolCallId,{status:'complete',digest:k.digest,result:k.result});}}});
 return {runtime,get writes(){return writes;},get reads(){return reads;},deny(){deny=true;},lose(){lose=true;},change(){change=true;},logout(){scope='expired';}};
}
test('real protocol and native mutation adapter verify saved suppression then replay without a duplicate',async()=>{const f=fixture(),a=await (await f.runtime.respond(request())).json();assert.equal(JSON.parse(a.results[0].result).saved,true);assert.equal(JSON.parse(a.results[0].result).suppressionSaved,true);assert.equal(f.writes,1);assert.equal(f.reads,2);assert.deepEqual(await (await f.runtime.respond(request())).json(),a);assert.equal(f.writes,1);});
test('native API denial and lost acknowledgements return errors; replay never repeats an uncertain write',async()=>{for(const mode of ['deny','lose']){const f=fixture();f[mode]();assert.ok((await (await f.runtime.respond(request())).json()).results[0].error);assert.ok((await (await f.runtime.respond(request())).json()).results[0].error);assert.equal(f.writes,mode==='lose'?1:0);}});
test('host binding changes before execution and expired native scope prevent API access',async()=>{const f=fixture();f.change();assert.ok((await (await f.runtime.respond(request())).json()).results[0].error);assert.equal(f.writes,0);assert.equal(f.reads,0);const g=fixture();g.logout();assert.equal((await g.runtime.respond(request())).status,503);assert.equal(g.reads,0);});
test('onboarding cannot invoke a CRM write even through the server protocol',async()=>{const f=fixture('onboarding');assert.ok((await (await f.runtime.respond(request())).json()).results[0].error);assert.equal(f.writes,0);assert.equal(f.reads,0);});
test('owned onboarding and history reads return projected results through the complete server runtime',async()=>{
 for(const agentKey of ['onboarding','retention']){
  const paths=[],entries=new Map(),pagination={total:1,hasMore:false};
  const runtime=createVapiBusinessRuntime({authenticate:async()=>true,authorize:async()=>true,contexts:{current:async()=>({scopeKey:'owned_client',agentKey,assistantId:savedAgents[agentKey],expiresAt:Date.now()+60000,currentScope:()=> 'owned_client',fetch:async(url,init)=>{
   assert.equal(init.method,'GET');const path=new URL(url).pathname;paths.push(path);
   return Response.json(path.endsWith('/home/profile')?{profile:{id:'private-id',full_name:'PRIVATE'}}:path.endsWith('/consents')?{consents:[{form_type:'service',status:'signed',signature:'PRIVATE'}],pagination}:path.endsWith('/service-authorizations')?{authorizations:[{status:'active',funding_source:'PRIVATE'}],pagination}:{visits:[{status:'scheduled',requested_start_at:'2026-11-01T14:00:00Z',duration_minutes:60,clinical_notes:'PRIVATE'}],pagination});
  }})},journal:{async begin(k){assert.ok(!entries.has(k.toolCallId));entries.set(k.toolCallId,k);return {status:'new'};},async complete(k){entries.set(k.toolCallId,k);}}});
  const name=agentKey==='onboarding'?'primecare_client_onboarding_status':'primecare_client_service_history';
  const body=await (await runtime.respond(request(name,{}))).json();assert.equal(typeof body.results[0].result,'string');assert.doesNotMatch(body.results[0].result,/PRIVATE|private-id/);
  const result=JSON.parse(body.results[0].result);if(agentKey==='onboarding'){assert.equal(result.overallOnboardingComplete,null);assert.equal(paths.length,3);}else{assert.equal(result.clinicalCompletionVerified,false);assert.equal(paths.length,1);}
 }
});
