import {test} from 'node:test';import assert from 'node:assert/strict';
import {PostgresReceptionCallbackAccessPolicy} from '../cloudflare/workers/src/business-tasks/reception-callback-policy.ts';
import pin from '../tools/governance-production/production-pin.json' with {type:'json'};
const actor={id:'alice',tenantId:'tenant-a'},state={id:'11111111-1111-4111-8111-111111111111',kind:'voice_task',version:1,ownerId:actor.id,tenantId:actor.tenantId,taskId:'reception.callback.request'};
function fixture(){let deny=false,manifest=pin.manifestSha256;const calls=[];const policy=new PostgresReceptionCallbackAccessPolicy({async connect(){return {async query(sql,values){calls.push({sql,values});if(sql.startsWith('SELECT manifest'))return {rows:[{manifest_sha256:manifest}]};if(sql.startsWith('SELECT DISTINCT'))return {rows:deny?[]:[{role_id:'1',screen_id:'331',api_id:values[4].endsWith('approve')?'102':'101'}]};return {rows:[]};},release(){}};}});return {policy,calls,deny(){deny=true;},manifest(value){manifest=value;}};}
test('callback policy requires both exact current native API and linked-screen grants for every action',async()=>{
 for(const action of ['voice.task.propose','voice.task.confirm','voice.task.execute']){const f=fixture();await f.policy.assert(actor,action,state);const queries=f.calls.filter(c=>c.sql.startsWith('SELECT DISTINCT'));assert.equal(queries.length,2);assert.deepEqual(queries.map(q=>q.values),[['alice','tenant-a',null,'POST','/v1/voice/tasks/preview','TWILIO_TASK_PREVIEW'],['alice','tenant-a',null,'POST','/v1/voice/tasks/approve','TWILIO_TASK_APPROVE']]);for(const q of queries)for(const required of ['api_permissions','role_screen_permissions','endpoint_code','COUNT(*)',"LOWER(t.status)='active'"])assert.ok(q.sql.includes(required));}
});
test('callback policy rejects delegation, other tasks, invalid state and unrelated actions before database access',async()=>{
 for(const changed of [null,{...state,ownerId:'bob'},{...state,tenantId:'other'},{...state,taskId:'appointment.booking.request'},{...state,kind:'conversation'},{...state,version:2},{...state,id:'forged'}]){const f=fixture();await assert.rejects(()=>f.policy.assert(actor,'voice.task.execute',changed));assert.equal(f.calls.length,0);}
 const f=fixture();await assert.rejects(()=>f.policy.assert(actor,'voice.sms.spoken.verify',state));await assert.rejects(()=>f.policy.assignee());assert.equal(f.calls.length,0);
});
test('current denial or wrong manifest cannot be replaced by a role label or provider authentication',async()=>{
 for(const mode of ['deny','manifest']){const f=fixture();if(mode==='deny')f.deny();else f.manifest('wrong');await assert.rejects(()=>f.policy.assert(actor,'voice.task.execute',state));assert.equal(f.calls.at(-1).sql,'ROLLBACK');}
});
