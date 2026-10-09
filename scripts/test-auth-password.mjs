import {auditFixture} from './auth-audit-fixtures.mjs';
import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import bcrypt from 'bcryptjs';
const bundled=await build({entryPoints:['cloudflare/workers/src/password-change.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {changePassword,validatePasswordChange}=await import('data:text/javascript;base64,'+Buffer.from(bundled.outputFiles[0].text).toString('base64'));
const input={currentPassword:'fixture-old-password',newPassword:'fixture-new-password'};
const user={id:'fixture',password_hash:await bcrypt.hash(input.currentPassword,4)};
test('validates password change and rejects user ID overrides',()=>{
 assert.deepEqual(validatePasswordChange(input),input);
 for(const value of [{...input,newPassword:'short'},{...input,newPassword:'a'.repeat(73)},{...input,userId:'victim'},{...input,newPassword:input.currentPassword}])assert.equal(validatePasswordChange(value),null);
});
test('wrong current password never mutates',async()=>{
 const db={query:()=>{throw new Error('Unexpected mutation')}};
 assert.equal((await changePassword(db,user,{...input,currentPassword:'wrong'})).status,401);
});
test('current password rejects bcrypt suffix aliases in ASCII and Unicode',()=>{
 for(const currentPassword of ['a'.repeat(72)+'x','é'.repeat(36)+'x']) {
  assert.equal(validatePasswordChange({...input,currentPassword}),null);
 }
});
test('changes hash, revokes all sessions and appends audit without logging secrets',async()=>{
 const calls=[];const db={query:async(sql,values)=>{calls.push({sql,values});
  const audit=auditFixture(sql,values);if(audit)return audit;return {rows:sql.startsWith('UPDATE users')?[{id:values[1],password_hash:values[0]}]:[]};}};
 const result=await changePassword(db,user,input);
 assert.equal(result.status,200);assert.equal(result.body.reauthenticationRequired,true);
 assert.ok(await bcrypt.compare(input.newPassword,calls[0].values[0]));
 assert.ok(calls[1].sql.startsWith('DELETE FROM auth_sessions'));
 assert.ok(calls[2].sql.startsWith('INSERT INTO auth_password_audit'));
});
