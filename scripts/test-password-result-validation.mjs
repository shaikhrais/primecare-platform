import {auditFixture} from './auth-audit-fixtures.mjs';
import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import bcrypt from 'bcryptjs';
async function load(path){const result=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm'});return import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));}
const {recoverPassword,resetPassword,recoveryMessage}=await load('cloudflare/workers/src/password-recovery.ts');
const {changePassword}=await load('cloudflare/workers/src/password-change.ts');
const input={email:'a@example.com',code:'ABC123ABC123',newPassword:'fixture-new-password'};
function fixture(overrides={}) {
 const calls=[];let sends=0;
 const env={EMAIL_FROM:'test@example.com',EMAIL:{send:async()=>{sends++;return {messageId:'fixture'};}}};
 const db={query:async(sql,values)=>{
  calls.push({sql,values});
  const audit=auditFixture(sql,values);if(audit)return audit;
  if(sql.includes('auth_rate_limits'))return {rows:[{attempts:1,retry_after:900}]};
  if(sql.startsWith('SELECT id,email'))return {rows:overrides.lookup??[{id:'user',email:input.email}]};
  if(sql.startsWith('SELECT id FROM'))return {rows:overrides.resetLookup??[{id:'user'}]};
  if(sql.startsWith('INSERT INTO auth_password_resets'))return {rows:overrides.stored?overrides.stored(values):[{user_id:values[1],token_hash:values[0]}]};
  if(sql.includes('RETURNING user_id'))return {rows:overrides.consumed??[{user_id:'user'}]};
  if(sql.startsWith('UPDATE users'))return {rows:overrides.updated?overrides.updated(values):[{id:values[1],password_hash:values[0]}]};
  return {rows:[]};
 }};
 return {db,env,calls,get sends(){return sends;}};
}
for(const row of [{id:1,email:input.email},{id:' bad',email:input.email},{id:'user',email:1},{id:'user',email:'other@example.com'}])test('recovery rejects invalid lookup '+JSON.stringify(row),async()=>{
 const f=fixture({lookup:[row]});await assert.rejects(recoverPassword(f.db,f.env,input.email));
 assert.equal(f.sends,0);assert.ok(!f.calls.some(c=>c.sql.startsWith('INSERT INTO auth_password_resets')));
});
for(const lookup of [[],[{id:'user',email:input.email},{id:'other',email:input.email}]])test('unknown or ambiguous recovery retains generic success '+lookup.length,async()=>{
 const f=fixture({lookup});assert.deepEqual((await recoverPassword(f.db,f.env,input.email)).body,{message:recoveryMessage});assert.equal(f.sends,0);
});
test('valid mixed-case stored email binds to normalized requested address',async()=>{
 const f=fixture({lookup:[{id:'user',email:'A@EXAMPLE.COM',private:'secret'}]});
 assert.deepEqual((await recoverPassword(f.db,f.env,input.email)).body,{message:recoveryMessage});assert.equal(f.sends,1);
 assert.equal(f.calls.filter(c=>['BEGIN','COMMIT'].includes(c.sql)).length,2);
});
for(const [name,stored] of Object.entries({empty:()=>[],multiple:v=>[{user_id:'user',token_hash:v[0]},{user_id:'user',token_hash:v[0]}],foreign:v=>[{user_id:'other',token_hash:v[0]}],coerced:v=>[{user_id:1,token_hash:v[0]}],hash:()=>[{user_id:'user',token_hash:'private-wrong-hash'}]}))test('recovery storage '+name+' rolls back before sending',async()=>{
 const f=fixture({stored});await assert.rejects(recoverPassword(f.db,f.env,input.email));assert.equal(f.sends,0);assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(c=>c.sql==='COMMIT'));
});
for(const id of [1,null,' bad'])test('reset rejects malformed lookup '+id+' before consuming code',async()=>{
 const f=fixture({resetLookup:[{id}]});await assert.rejects(resetPassword(f.db,input));assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(c=>c.sql.includes('RETURNING user_id')));
});
for(const consumed of [[{user_id:'other'}],[{user_id:1}],[{user_id:'user'},{user_id:'user'}]])test('reset rejects invalid consumption '+JSON.stringify(consumed),async()=>{
 const f=fixture({consumed});await assert.rejects(resetPassword(f.db,input));assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(c=>c.sql.startsWith('UPDATE users')));
});
const oldPassword='fixture-old-password',user={id:'user',password_hash:await bcrypt.hash(oldPassword,4)};
for(const [name,updated] of Object.entries({empty:()=>[],multiple:v=>[{id:'user',password_hash:v[0]},{id:'user',password_hash:v[0]}],foreign:v=>[{id:'other',password_hash:v[0]}],coerced:v=>[{id:1,password_hash:v[0]}],hash:()=>[{id:'user',password_hash:'wrong-hash'}]})) {
 test('reset update '+name+' rolls back code consumption before session revocation/audit',async()=>{
  const f=fixture({updated});await assert.rejects(resetPassword(f.db,input));assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(c=>c.sql.startsWith('DELETE FROM auth_sessions')||c.sql.startsWith('INSERT INTO auth_password_audit')||c.sql==='COMMIT'));
 });
 test('own password update '+name+' never revokes sessions or appends audit',async()=>{
  const f=fixture({updated});await assert.rejects(changePassword(f.db,user,{currentPassword:oldPassword,newPassword:input.newPassword}));assert.ok(!f.calls.some(c=>c.sql.startsWith('DELETE FROM auth_sessions')||c.sql.startsWith('INSERT INTO auth_password_audit')));
 });
}

for(const [batch,sqlPrefix,rows] of [[365,'SELECT id,email',null],[365,'SELECT id,email',[null]],[365,'SELECT id,email',[[]]],[365,'SELECT id,email',[{},{},{}]],[366,'INSERT INTO auth_password_resets',null],[366,'INSERT INTO auth_password_resets',[null]],[366,'INSERT INTO auth_password_resets',[[]]],[367,'SELECT id FROM',null],[367,'SELECT id FROM',[null]],[367,'SELECT id FROM',[[]]],[367,'DELETE FROM auth_password_resets',null],[367,'DELETE FROM auth_password_resets',[null]],[367,'DELETE FROM auth_password_resets',[[]]]])test('batch '+batch+' recovery adapter shape '+sqlPrefix+' '+JSON.stringify(rows),async()=>{const f=fixture(),base=f.db.query;f.db.query=async(sql,v)=>{const r=await base(sql,v);if(sql.startsWith(sqlPrefix))r.rows=rows;return r;};await assert.rejects(sqlPrefix==='SELECT id FROM'||sqlPrefix==='DELETE FROM auth_password_resets'?resetPassword(f.db,input):recoverPassword(f.db,f.env,input.email));assert.equal(f.sends,0);assert.ok(!f.calls.some(q=>q.sql==='COMMIT'));if(batch!==365)assert.equal(f.calls.at(-1).sql,'ROLLBACK');});
for(const mode of ['missing','duplicate','id','user','action','date'])test('batch 364 reset audit '+mode+' rejects before commit',async()=>{const f=fixture(),base=f.db.query;f.db.query=async(sql,v)=>{const r=await base(sql,v);if(sql.startsWith('INSERT INTO auth_password_audit')){if(mode==='missing')r.rows=[];else if(mode==='duplicate')r.rows.push({...r.rows[0]});else if(mode==='id')r.rows[0].id=1;else if(mode==='user')r.rows[0].user_id='foreign';else if(mode==='action')r.rows[0].action='foreign';else r.rows[0].created_at='private-invalid-date';}return r;};await assert.rejects(resetPassword(f.db,input));assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>q.sql==='COMMIT'));});
test('batch 367 absent or ambiguous locked accounts preserve invalid-code response',async()=>{for(const resetLookup of [[],[{id:'user'},{id:'other'}]]){const f=fixture({resetLookup});assert.equal((await resetPassword(f.db,input)).status,400);assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>q.sql.includes('RETURNING user_id')||q.sql.startsWith('UPDATE')));}});
