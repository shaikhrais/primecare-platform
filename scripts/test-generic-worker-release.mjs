import test from 'node:test';
import assert from 'node:assert/strict';
import {assertGenericWorkerPreserves} from './check-generic-worker-deploy.mjs';
import {retainedGenericConfig,assertRetainedGenericPreserves,inspectGenericRelease,releaseGenericWorker} from './generic-worker-release.mjs';
const source='a'.repeat(40),old='11111111-1111-4111-8111-111111111111',next='22222222-2222-4222-8222-222222222222',
 oldVersion='33333333-3333-4333-8333-333333333333',newVersion='44444444-4444-4444-8444-444444444444';
const config=()=>({name:'primecare-governance-api',main:'../cloudflare/workers/src/service.ts',compatibility_date:'2026-09-27',compatibility_flags:['nodejs_compat'],observability:{enabled:true},vars:{SERVICE_NAME:'governance'}});
function fixture(change=()=>{}){
 const candidate=retainedGenericConfig('governance',config());
 const initial={compatibility_date:candidate.compatibility_date,compatibility_flags:candidate.compatibility_flags,observability:candidate.observability,
  bindings:[{name:'DB_URL',type:'secret_text'},{name:'PRIVATE',type:'secret_text',text:'must-never-be-reported'},
   {name:'SERVICE_NAME',type:'plain_text',text:'governance'}]};
 const state={published:false,writes:0,configs:[],paths:[],waits:0};
 const api=async path=>{
  state.paths.push(path);const version=state.published?newVersion:oldVersion;let value;
  if(path.endsWith('/deployments?per_page=1'))value={deployments:[{id:state.published?next:old,versions:[{version_id:version,percentage:100}]}]};
  else if(path.endsWith('/versions?per_page=1'))value={items:[{id:version}]};
  else if(path.includes('/versions/'))value={id:version,resources:{bindings:structuredClone(initial.bindings)}};
  else if(path.endsWith('/settings'))value=structuredClone(initial);
  else if(path.endsWith('/schedules'))value={schedules:[]};
  else throw Error('unexpected path');
  change(value,path,state);return value;
 };
 const input={api,service:'governance',config:config(),source,
  writeConfig:async candidate=>{state.configs.push(JSON.parse(JSON.stringify(candidate)));},
  deploy:async()=>{state.writes++;state.published=true;return{versionId:newVersion};},wait:async()=>{state.waits++;}};
 return {input,state,initial,candidate};
}
test('retained mode permits extra secrets only with explicit retention; legacy refusal stays intact',()=>{
 const f=fixture();assert.throws(()=>assertGenericWorkerPreserves(f.initial,{schedules:[]},f.candidate),/secret preservation/);
 assert.equal(assertRetainedGenericPreserves('governance',f.initial,{schedules:[]},f.candidate).secretBindingCount,2);
 for(const keep_vars of [undefined,false,'true'])assert.throws(()=>assertRetainedGenericPreserves('governance',f.initial,{schedules:[]},{...f.candidate,keep_vars}),/retention/);
});
test('secret values are neither accessed nor copied into the candidate',()=>{
 const f=fixture();f.initial.bindings[1]={name:'PRIVATE',type:'secret_key',get text(){throw Error('secret accessed');},get value(){throw Error('secret accessed');}};
 assert.equal(assertRetainedGenericPreserves('governance',f.initial,{schedules:[]},f.candidate).secretBindingCount,2);
 assert.equal(f.candidate.vars.PRIVATE,undefined);assert.equal(f.candidate.vars.DB_URL,undefined);
});
test('retention cannot hide public binding, compatibility, observability or schedule drift',()=>{
 const f=fixture();
 for(const mutate of [c=>c.vars.SERVICE_NAME='other',c=>c.vars.PRIVATE='collision',c=>c.compatibility_date='2020-01-01',c=>c.compatibility_flags=[],c=>c.observability.enabled=false,c=>c.triggers={crons:['* * * * *']}]){
  const c=structuredClone(f.candidate);mutate(c);assert.throws(()=>assertRetainedGenericPreserves('governance',f.initial,{schedules:[]},c));
 }
 const missing=structuredClone(f.initial);missing.bindings=missing.bindings.filter(b=>b.name!=='DB_URL');assert.throws(()=>assertRetainedGenericPreserves('governance',missing,{schedules:[]},f.candidate),/database/);
 const unknown=structuredClone(f.initial);unknown.bindings.push({name:'QUEUE',type:'queue'});assert.throws(()=>assertRetainedGenericPreserves('governance',unknown,{schedules:[]},f.candidate),/binding type/);
});
test('read-only inspection joins current settings, deployed version and latest upload without writes',async()=>{
 const f=fixture(),result=await inspectGenericRelease(f.input);assert.equal(result.current.versionId,oldVersion);assert.equal(f.state.writes,0);assert.equal(f.state.configs.length,0);assert.equal(result.evidence.secretBindingCount,2);
});
test('latest-upload mismatch, split traffic, absent version secrets and changed lineage refuse before deployment',async()=>{
 for(const change of [
  (v,p)=>{if(p.endsWith('/versions?per_page=1'))v.items[0].id=newVersion;},
  (v,p)=>{if(v.deployments)v.deployments[0].versions[0].percentage=50;},
  (v,p)=>{if(p.includes('/versions/')&&!p.includes('?'))v.resources.bindings=[];},
  (v,p,s)=>{if(v.deployments&&s.paths.filter(p=>p.includes('/deployments')).length>1)v.deployments[0].id=next;},
  (v,p)=>{if(p.includes('/versions/')&&!p.includes('?'))v.id=newVersion;}
 ]){const f=fixture(change);await assert.rejects(()=>releaseGenericWorker(f.input));assert.equal(f.state.writes,0);}
});
test('successful release uses one explicit retained config and independently verifies uploaded version and secrets',async()=>{
 const f=fixture(),result=await releaseGenericWorker(f.input);assert.equal(f.state.writes,1);assert.equal(f.state.configs.length,1);assert.equal(f.state.configs[0].keep_vars,true);
 assert.equal(result.source,source);assert.equal(result.versionId,newVersion);assert.equal(result.deploymentId,next);assert.equal(result.secretBindingsPreserved,true);assert.equal(result.independentlyReadDeployment,true);
 assert.ok(!JSON.stringify(result).includes('must-never-be-reported'));assert.ok(!JSON.stringify(f.state.configs).includes('must-never-be-reported'));
});
test('a change while preparing local configuration refuses the provider write',async()=>{
 const f=fixture();f.input.writeConfig=async()=>{f.state.published=true;};await assert.rejects(()=>releaseGenericWorker(f.input),/changed before deployment/);assert.equal(f.state.writes,0);
});
test('post-deploy removed, added, renamed and retyped secrets never produce a success receipt',async()=>{
 for(const change of [b=>b.splice(1,1),b=>b.push({name:'NEW',type:'secret_text'}),b=>b[1].name='RENAMED',b=>b[1].type='secret_key']){
  const f=fixture((v,p,s)=>{if(s.published){if(p.endsWith('/settings'))change(v.bindings);if(p.includes('/versions/')&&!p.includes('?'))change(v.resources.bindings);}});
  await assert.rejects(()=>releaseGenericWorker(f.input),/identity changed/);assert.equal(f.state.writes,1);
 }
});
test('post-deploy public settings drift also prevents a success receipt',async()=>{
 const f=fixture((v,p,s)=>{if(s.published&&p.endsWith('/settings'))v.observability.enabled=false;});await assert.rejects(()=>releaseGenericWorker(f.input),/observability/);assert.equal(f.state.writes,1);
});
test('provider propagation never repeats the deployment and only accepts its exact version',async()=>{
 const f=fixture((v,p,s)=>{if(s.published&&p.endsWith('/versions?per_page=1'))v.items[0].id=oldVersion;});await assert.rejects(()=>releaseGenericWorker(f.input),/Latest upload/);assert.equal(f.state.writes,1);assert.equal(f.state.waits,3);
});
test('invalid source or unrelated service is refused before provider activity',async()=>{
 for(const extra of [{source:'main'},{service:'auth'},{service:'payments'}]){
  const f=fixture();await assert.rejects(()=>releaseGenericWorker({...f.input,...extra}));assert.equal(f.state.paths.length,0);assert.equal(f.state.writes,0);
 }
});
