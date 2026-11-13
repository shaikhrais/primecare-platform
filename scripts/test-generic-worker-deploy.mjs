import {test} from 'node:test';import assert from 'node:assert/strict';
import {assertGenericWorkerPreserves as check} from './check-generic-worker-deploy.mjs';
const config={compatibility_date:'2026-09-27',compatibility_flags:['nodejs_compat'],observability:{enabled:true},vars:{SERVICE_NAME:'auth',PREFERENCE_SYNC_ENABLED:'0'},ratelimits:[{name:'LIMIT',namespace_id:'123',simple:{limit:10,period:60}}],services:[{binding:'SVC',service:'target'}],send_email:[{name:'EMAIL',allowed_sender_addresses:['sender@example.test']}],triggers:{crons:['*/5 * * * *']}};
const settings={compatibility_date:config.compatibility_date,compatibility_flags:config.compatibility_flags,observability:config.observability,bindings:[{type:'secret_text',name:'DB_URL'},{type:'plain_text',name:'SERVICE_NAME',text:'auth'},{type:'plain_text',name:'PREFERENCE_SYNC_ENABLED',text:'0'},{type:'ratelimit',name:'LIMIT',namespace_id:'123',simple:{limit:10,period:60}},{type:'service',name:'SVC',service:'target'},{type:'send_email',name:'EMAIL',allowed_sender_addresses:['sender@example.test']}]};
const schedules={schedules:[{cron:'*/5 * * * *'}]};
test('matching configuration passes without changing live settings',()=>{const before=structuredClone(settings);assert.equal(check(settings,schedules,config),true);assert.deepEqual(settings,before);});
test('missing preference flag, extra secret and unknown binding all fail closed',()=>{
 for(const mutate of [c=>delete c.vars.PREFERENCE_SYNC_ENABLED,c=>c.vars.PREFERENCE_SYNC_ENABLED='1']){const c=structuredClone(config);mutate(c);assert.throws(()=>check(settings,schedules,c),/bindings differ/);}
 for(const b of [{type:'secret_text',name:'OTHER_SECRET'},{type:'queue',name:'OTHER'}]){const s=structuredClone(settings);s.bindings.push(b);assert.throws(()=>check(s,schedules,config));}
});
test('schedule, compatibility and observability drift fail closed',()=>{
 for(const mutate of [c=>c.triggers.crons=[],c=>c.compatibility_date='2020-01-01',c=>c.observability.enabled=false]){const c=structuredClone(config);mutate(c);assert.throws(()=>check(settings,schedules,c));}
});
test('gateway must also preserve service bindings',()=>{const c={...structuredClone(config),vars:{},ratelimits:[],send_email:[],triggers:{crons:[]}},s={...structuredClone(settings),bindings:[{type:'service',name:'SVC',service:'target'}]};assert.equal(check(s,{schedules:[]},c,{requireDatabase:false}),true);delete c.vars;assert.equal(check(s,{schedules:[]},c,{requireDatabase:false}),true);c.services=[];assert.throws(()=>check(s,{schedules:[]},c,{requireDatabase:false}));});
test('observability refusal identifies exact non-secret metadata without changing either side',()=>{
 const s=structuredClone(settings),c=structuredClone(config);
 s.observability={enabled:true,head_sampling_rate:1,logs:{enabled:true,invocation_logs:true}};
 const before=structuredClone({s,c});
 assert.throws(()=>check(s,schedules,c),error=>{
  assert.match(error.message,/Generated observability differs from live Worker/);
  const detail=JSON.parse(error.message.split(': ')[1]);
  assert.deepEqual(detail,{live:s.observability,generated:c.observability});
  return true;
 });
 assert.deepEqual({s,c},before);
 c.observability=structuredClone(s.observability);assert.equal(check(s,schedules,c),true);
 for(const mutate of [v=>v.head_sampling_rate=0.5,v=>v.logs.invocation_logs=false,v=>v.logs.new_setting=true]){
  const altered=structuredClone(c);mutate(altered.observability);
  assert.throws(()=>check(s,schedules,altered),/Generated observability differs/);
 }
});
test('observability diagnostics are bounded and omit unrelated bindings',()=>{
 const s=structuredClone(settings);s.observability={enabled:true,extra:'x'.repeat(10000)};
 s.bindings.push({type:'plain_text',name:'PRIVATE_VALUE',text:'do-not-log-this-binding'});
 const c=structuredClone(config);c.vars.PRIVATE_VALUE='do-not-log-this-binding';
 assert.throws(()=>check(s,schedules,c),error=>{
  assert.match(error.message,/Generated observability differs/);
  assert.ok(error.message.length<4300);assert.doesNotMatch(error.message,/do-not-log-this-binding/);
  return true;
 });
});
