import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
const bundled=await build({entryPoints:['cloudflare/workers/src/account-management.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {manageAccount,validateAccountUpdate}=await import('data:text/javascript;base64,'+Buffer.from(bundled.outputFiles[0].text).toString('base64'));
const actor={id:'actor',roles:'ceo',tenant_id:'tenant-a'};
const input={id:'11111111-1111-1111-1111-111111111111',role:'rmt',status:'inactive'};
function fixture(found=true){const calls=[];return {calls,async query(sql,values){calls.push({sql,values});
  return {rows:sql.startsWith('SELECT')?(found?[{id:input.id,roles:'rmt',status:'active'}]:[]):sql.startsWith('UPDATE')?[{id:input.id,roles:input.role,status:input.status,tenant_id:actor.tenant_id}]:[]};}};}
test('rejects unknown role, mass assignment and invalid statuses',()=>{
 assert.deepEqual(validateAccountUpdate(input),input);
 for(const data of [{...input,role:'superadmin'},{...input,tenant_id:'other'},{...input,status:'deleted'},null]) assert.equal(validateAccountUpdate(data),null);
});
test('only CEO may manage accounts and cannot modify self',async()=>{
 const db=fixture();
 for(const role of ['hr_director','rmt','admin']) assert.equal((await manageAccount(db,{...actor,roles:role},input)).status,403);
 assert.equal((await manageAccount(db,actor,{...input,id:actor.id})).status,403);assert.equal(db.calls.length,0);
});
test('cross-tenant or missing target causes no mutation',async()=>{
 const db=fixture(false);assert.equal((await manageAccount(db,actor,input)).status,404);
 assert.equal(db.calls.length,1);assert.deepEqual(db.calls[0].values,[input.id,actor.tenant_id]);
});
test('updates tenant-scoped target, revokes sessions and appends audit',async()=>{
 const db=fixture();assert.equal((await manageAccount(db,actor,input)).status,200);
 assert.equal(db.calls.find(c=>c.sql.startsWith('UPDATE')).values[3],actor.tenant_id);
 assert.ok(db.calls.some(c=>c.sql.startsWith('DELETE FROM auth_sessions')));
 assert.ok(db.calls.some(c=>c.sql.startsWith('INSERT INTO auth_management_audit')));
});
