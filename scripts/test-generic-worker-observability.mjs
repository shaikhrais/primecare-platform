import {test} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp,readFile,writeFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {GENERIC_WORKER_SERVICES,assertGenericWorkerPreserves} from './check-generic-worker-deploy.mjs';
import {preserveGenericObservability,prepareGenericObservability} from './preserve-generic-worker-observability.mjs';
const observed={enabled:true,head_sampling_rate:1,redact_query_string:false,
 logs:{enabled:true,head_sampling_rate:1,persist:true,invocation_logs:true},
 traces:{enabled:false,persist:true,head_sampling_rate:1}};
const config=service=>({name:service==='gateway'?'primecare-api-gateway':`primecare-${service}-api`,
 main:service==='gateway'?'../cloudflare/workers/src/gateway.ts':'../cloudflare/workers/src/service.ts',
 compatibility_date:'2026-09-27',compatibility_flags:['nodejs_compat'],
 observability:{enabled:true},vars:{SERVICE_NAME:service},triggers:{crons:[]}});

test('observed settings repair each generated candidate without weakening live comparison',()=>{
 assert.equal(GENERIC_WORKER_SERVICES.length,12);
 for(const service of GENERIC_WORKER_SERVICES){
  const original=config(service),before=structuredClone(original);
  const live={compatibility_date:original.compatibility_date,compatibility_flags:original.compatibility_flags,
   bindings:[{type:'secret_text',name:'DB_URL'},{type:'plain_text',name:'SERVICE_NAME',text:service}],observability:observed};
  assert.throws(()=>assertGenericWorkerPreserves(live,{schedules:[]},original),/observability differs/);
  const prepared=preserveGenericObservability(service,original);
  assert.deepEqual(original,before);assert.deepEqual(prepared,{...original,observability:observed});
  assert.equal(assertGenericWorkerPreserves(live,{schedules:[]},prepared),true);
  const drift=structuredClone(live);drift.observability.logs.persist=false;
  assert.throws(()=>assertGenericWorkerPreserves(drift,{schedules:[]},prepared),/observability differs/);
  const secret=structuredClone(live);secret.bindings.push({type:'secret_text',name:'UNPROVEN_SECRET'});
  assert.throws(()=>assertGenericWorkerPreserves(secret,{schedules:[]},prepared),/secret preservation/);
 }
});
test('candidate is idempotent and returned nested settings do not share mutable state',()=>{
 const first=preserveGenericObservability('client',config('client'));
 assert.deepEqual(preserveGenericObservability('client',first),first);
 first.observability.logs.persist=false;
 assert.equal(preserveGenericObservability('client',config('client')).observability.logs.persist,true);
});
test('unknown identities, auth and unreviewed observability remain rejected',()=>{
 for(const service of ['auth','look-ai','other'])assert.throws(()=>preserveGenericObservability(service,config(service)),/identity/);
 for(const patch of [{name:'primecare-auth-api'},{main:'other.ts'},{observability:{enabled:false}},
  {observability:{enabled:true,extra:true}},{observability:null}, {observability:{...observed,redact_query_string:true}}]){
  const candidate={...config('client'),...patch},before=structuredClone(candidate);
  assert.throws(()=>preserveGenericObservability('client',candidate));assert.deepEqual(candidate,before);
 }
});
test('complete local batch preserves auth, provider binding fields and every unrelated config value',async()=>{
 const dir=await mkdtemp(join(tmpdir(),'primecare-observability-'));
 try{
  for(const s of GENERIC_WORKER_SERVICES)await writeFile(join(dir,s+'.jsonc'),JSON.stringify({...config(s),services:[{binding:'SVC',service:'existing'}]}));
  for(const s of ['auth','look-ai'])await writeFile(join(dir,s+'.jsonc'),'untouched '+s);
  assert.equal(await prepareGenericObservability(dir),12);
  const once=await readFile(join(dir,'client.jsonc'),'utf8');await prepareGenericObservability(dir);
  assert.equal(await readFile(join(dir,'client.jsonc'),'utf8'),once);
  for(const s of GENERIC_WORKER_SERVICES)assert.deepEqual(JSON.parse(await readFile(join(dir,s+'.jsonc'),'utf8')),
   {...config(s),services:[{binding:'SVC',service:'existing'}],observability:observed});
  for(const s of ['auth','look-ai'])assert.equal(await readFile(join(dir,s+'.jsonc'),'utf8'),'untouched '+s);
 }finally{await rm(dir,{recursive:true,force:true});}
});
test('invalid final config prevents changes to every earlier generated file',async()=>{
 const dir=await mkdtemp(join(tmpdir(),'primecare-observability-'));
 try{
  const before=new Map();for(const s of GENERIC_WORKER_SERVICES){const value=JSON.stringify({...config(s),...(s==='gateway'?{name:'other'}:{})});before.set(s,value);await writeFile(join(dir,s+'.jsonc'),value);}
  await assert.rejects(prepareGenericObservability(dir),/identity/);
  for(const [s,value]of before)assert.equal(await readFile(join(dir,s+'.jsonc'),'utf8'),value);
 }finally{await rm(dir,{recursive:true,force:true});}
});
