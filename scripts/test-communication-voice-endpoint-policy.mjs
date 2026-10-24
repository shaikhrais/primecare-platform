import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {PostgresVoiceEndpointPolicy} from '../cloudflare/workers/src/business-tasks/endpoint-policy.ts';
const pin=JSON.parse(readFileSync('tools/governance-production/production-pin.json'));
const definition=JSON.parse(readFileSync('tools/governance-production/twilio-contracts-registration.json'));
const session={actor:{id:'fixture-user',tenantId:'fixture-tenant'},sessionHash:'a'.repeat(64),expiresAt:Date.now()+300000};
const request=path=>new Request('https://fixture.invalid'+path,{method:'POST',headers:{authorization:'Bearer fixture-token'}});
function fixture({grants=[{role_id:'7',screen_id:'234',api_id:'16520'}],manifest=pin.manifestSha256,failure=false}={}){
 const calls=[];let released=false;
 const policy=new PostgresVoiceEndpointPolicy({async connect(){return {async query(sql,values){calls.push({sql,values});if(sql.startsWith('SELECT manifest'))return {rows:[{manifest_sha256:manifest}]};if(sql.startsWith('SELECT DISTINCT')){if(failure)throw Error('Database unavailable');return {rows:grants};}return {rows:[]};},release(){released=true;}};}});
 return {policy,calls,released:()=>released};
}
test('all nine native operations resolve exact registered identities and require current API plus screen grants',async()=>{
 const operations=definition.operations.filter(op=>op.authentication==='native-session-csrf');assert.equal(operations.length,9);
 for(const op of operations){const f=fixture();await f.policy.authorize(session,op.key,request(op.path));const q=f.calls.find(c=>c.sql.startsWith('SELECT DISTINCT'));assert.deepEqual(q.values,[session.actor.id,session.actor.tenantId,null,op.method,op.path,'TWILIO_'+op.key.replaceAll('.','_').toUpperCase()]);for(const part of ['COUNT(*)','endpoint_code','api_permissions','role_screen_permissions',"LOWER(t.status)='active'"])assert.ok(q.sql.includes(part));assert.ok(f.released());}
});
test('provider routes, expired sessions, missing bearer and mismatched paths are denied before database access',async()=>{
 const f=fixture();for(const [s,key,req] of [[session,'voice.agent',request('/v1/twilio/voice/agent')],[{...session,expiresAt:0},'token',request('/v1/voice/token')],[session,'token',new Request('https://fixture.invalid/v1/voice/token',{method:'POST'})],[session,'token',request('/v1/voice/token?actor=other')],[session,'token',request('/v1/voice/otp/start')]])await assert.rejects(f.policy.authorize(s,key,req),/Forbidden/);assert.equal(f.calls.length,0);
});
test('revoked, ambiguous and malformed grant results cannot authorize a voice operation',async()=>{
 for(const grants of [[],[{role_id:'7',screen_id:'234'}],[{role_id:null,screen_id:'234',api_id:'16520'}],[{role_id:'7',screen_id:'234',api_id:'16520'},{role_id:'7',screen_id:'234',api_id:'16521'}]]){const f=fixture({grants});await assert.rejects(f.policy.authorize(session,'token',request('/v1/voice/token')),/Forbidden/);assert.ok(f.released());}
});
test('manifest and database failures roll back without manufacturing grants',async()=>{
 for(const options of [{manifest:'wrong'},{failure:true}]){const f=fixture(options);await assert.rejects(f.policy.authorize(session,'token',request('/v1/voice/token')));assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(f.released());}
});
