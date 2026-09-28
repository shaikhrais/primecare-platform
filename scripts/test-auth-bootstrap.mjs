import {test} from 'node:test';
import assert from 'node:assert/strict';
import {bootstrap,validateBootstrap} from './bootstrap-first-ceo.mjs';
const input={email:'fixture@example.invalid',password:'fixture-password-long',tenant:'11111111-1111-1111-1111-111111111111'};
function fixture(mode){
 const calls=[];
 return {calls,async query(sql,values){
   calls.push({sql,values});
   if(sql.startsWith('SELECT id FROM tenants')) return {rows:mode==='missing_tenant'?[]:[{id:input.tenant}]};
   if(sql.includes("roles='ceo'")) return {rows:mode==='existing_ceo'?[{id:'existing'}]:[]};
   if(sql.startsWith('SELECT id FROM users')) return {rows:mode==='duplicate'?[{id:'existing'}]:[]};
   if(sql.startsWith('INSERT INTO users')) return {rows:[{id:'new'}]};
   if(sql.startsWith('INSERT INTO auth_bootstrap_audit')&&mode==='audit_failure') throw new Error('audit failure');
   return {rows:[]};
 }};
}
test('validates inputs without accepting short or overlong bcrypt passwords',()=>{
 assert.equal(validateBootstrap(input).email,input.email);
 for(const change of [{tenant:''},{tenant:'invalid tenant'},{email:'bad'},{password:'short'},{password:'a'.repeat(73)}])
   assert.throws(()=>validateBootstrap({...input,...change}));
});
test('creates first CEO and audit in same transaction without returning credentials',async()=>{
 const db=fixture();assert.deepEqual(await bootstrap(db,input),{created:true});
 assert.equal(db.calls.at(-1).sql,'COMMIT');
 assert.ok(db.calls.some(c=>c.sql.startsWith('INSERT INTO auth_bootstrap_audit')));
 const insert=db.calls.find(c=>c.sql.startsWith('INSERT INTO users'));
 assert.notEqual(insert.values[2],input.password);
});
for(const mode of ['missing_tenant','existing_ceo','duplicate','audit_failure'])
 test(`bootstrap rolls back on ${mode}`,async()=>{
   const db=fixture(mode);await assert.rejects(bootstrap(db,input));
   assert.equal(db.calls.at(-1).sql,'ROLLBACK');assert.ok(!db.calls.some(c=>c.sql==='COMMIT'));
 });
