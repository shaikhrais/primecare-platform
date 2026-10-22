import {test} from 'node:test';
import assert from 'node:assert/strict';
import {PostgresCommunicationSession} from '../cloudflare/workers/src/business-tasks/session.ts';
import {tokenFrom,sha256} from '../cloudflare/workers/src/session-token.ts';
const token='a'.repeat(43);
const request=(headers={authorization:'Bearer '+token})=>new Request('https://example.invalid/v1/messages',{headers});
test('canonical token parser rejects malformed explicit bearer and duplicate cookies',()=>{
 assert.equal(tokenFrom(request({authorization:'bad',cookie:'session_token='+token})),null);
 assert.equal(tokenFrom(request({cookie:`session_token=${token}; session_token=${token}`})),null);
 assert.equal(tokenFrom(request({cookie:'session_token='+token})),token);
});
test('native session resolves only database identity and hashes credentials',async()=>{
 const adapter=new PostgresCommunicationSession({async query(sql,values){
  assert.match(sql,/s.expires_at>NOW\(\)/);assert.match(sql,/LOWER\(u.status\)='active'/);
  assert.deepEqual(values,[await sha256(token)]);assert.ok(!values.includes(token));
  return {rows:[{id:'user-a',tenant_id:'tenant-a',roles:'ignored'}]};
 }});
 const actor=await adapter.authenticate(request());assert.deepEqual(actor,{id:'user-a',tenantId:'tenant-a'});assert.ok(Object.isFrozen(actor));
});
test('cookie-only and malformed bearer fail before querying',async()=>{
 const adapter=new PostgresCommunicationSession({async query(){assert.fail('must not query');}});
 for(const headers of [{},{cookie:'session_token='+token},{authorization:'Bearer bad'}])await assert.rejects(adapter.authenticate(request(headers)),{status:401});
});
test('missing, duplicate and malformed database identity fail closed',async()=>{
 for(const rows of [[],[{id:'a',tenant_id:'t'},{id:'b',tenant_id:'t'}],[{id:'a',tenant_id:null}],[{id:' a',tenant_id:'t'}],[{id:5,tenant_id:'t'}]]){
  const adapter=new PostgresCommunicationSession({async query(){return {rows};}});
  await assert.rejects(adapter.authenticate(request()),{status:401});
 }
});
test('tenant override fails and session revocation is observed on every request',async()=>{
 let rows=[{id:'a',tenant_id:'t'}];
 const adapter=new PostgresCommunicationSession({async query(){return {rows};}});
 await assert.rejects(adapter.authenticate(request({authorization:'Bearer '+token,'x-tenant-id':'other'})),{status:403});
 await adapter.authenticate(request());rows=[];await assert.rejects(adapter.authenticate(request()),{status:401});
});
