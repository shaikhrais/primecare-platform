import {auditFixture} from './auth-audit-fixtures.mjs';
import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import bcrypt from 'bcryptjs';
async function load(path){const result=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm'});return import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));}
const {recoverPassword,resetPassword,validateRecovery,recoveryHash}=await load('cloudflare/workers/src/password-recovery.ts');
const {renderEmail,sendEmail,mailReady}=await load('cloudflare/workers/src/email.ts');
const env={EMAIL:{send:async()=>({messageId:'test-only'})},EMAIL_FROM:'PrimeCare <test@example.com>'};
test('validates email, code, password bytes and rejects identity overrides',()=>{
 assert.equal(validateRecovery({email:'bad'}),null);
 assert.equal(validateRecovery({email:'a@example.com',userId:'victim'}),null);
 assert.equal(validateRecovery({email:'a@example.com',code:'ABC123ABC123',newPassword:'é'.repeat(37)},true),null);
 assert.equal(validateRecovery({email:'a@example.com',code:'bad',newPassword:'long-enough-password'},true),null);
 assert.equal(validateRecovery({email:' A@EXAMPLE.COM ',code:'abc123abc123',newPassword:'long-enough-password'},true).code,'ABC123ABC123');
});
test('shared templates escape HTML and require all variables',()=>{
 assert.ok(renderEmail('security_notice',{message:'<script>alert(1)</script>',support:'IT'}).html.includes('&lt;script&gt;'));
 assert.throws(()=>renderEmail('password_reset',{}));
});
test('missing mail configuration does not claim email success or access database',async()=>{
 assert.equal((await recoverPassword({query:()=>assert.fail('database accessed')},{},'a@example.com')).status,503);
});
test('recovery sends code, stores only its bound hash, and cleans up provider failures',async()=>{
 const calls=[];let sent;
 const db={query:async(sql,values)=>{calls.push({sql,values});const audit=auditFixture(sql,values);if(audit)return audit;if(sql.includes('auth_rate_limits'))return {rows:[{attempts:1,retry_after:900}]};if(sql.startsWith('SELECT id,email'))return {rows:[{id:'user',email:'a@example.com'}]};if(sql.startsWith('INSERT INTO auth_password_resets'))return {rows:[{token_hash:values[0],user_id:values[1]}]};return {rows:[]};}};
 const original=env.EMAIL.send;
 try {
  env.EMAIL.send=async(message)=>{sent=message;return {messageId:'provider-id'};};
  assert.equal((await recoverPassword(db,env,'a@example.com')).status,200);
  const code=/[A-F0-9]{12}/.exec(sent.text)[0];
  assert.equal(calls.find(c=>c.sql.startsWith('INSERT INTO auth_password_resets')).values[0],await recoveryHash('a@example.com:'+code));
  assert.ok(!JSON.stringify(calls).includes(code));
  env.EMAIL.send=async()=>{throw new Error('E_SENDER_NOT_VERIFIED');};
  assert.equal((await recoverPassword(db,env,'a@example.com')).status,503);
  assert.ok(calls.at(-1).sql.startsWith('DELETE FROM auth_password_resets'));
 }finally{env.EMAIL.send=original;}
});
test('unknown accounts have generic success and never send mail',async()=>{
 const db={query:async(sql)=>({rows:sql.includes('auth_rate_limits')?[{attempts:1,retry_after:900}]:[]})};
 assert.equal((await recoverPassword(db,env,'absent@example.com')).status,200);
});
test('expired or replayed code rolls back without updating credentials',async()=>{
 const calls=[];const db={query:async(sql)=>{calls.push(sql);return {rows:sql.startsWith('SELECT id FROM')?[{id:'user'}]:sql.includes('auth_rate_limits')?[{attempts:1,retry_after:900}]:[]};}};
 assert.equal((await resetPassword(db,{email:'a@example.com',code:'ABC123ABC123',newPassword:'long-enough-password'})).status,400);
 assert.ok(calls.includes('ROLLBACK'));assert.ok(!calls.some(sql=>sql.startsWith('UPDATE users')));
});
test('valid code updates bcrypt hash, revokes sessions and all reset codes atomically',async()=>{
 const calls=[];const db={query:async(sql,values)=>{calls.push({sql,values});const audit=auditFixture(sql,values);if(audit)return audit;return {rows:sql.includes('auth_rate_limits')?[{attempts:1,retry_after:900}]:sql.startsWith('SELECT id FROM')?[{id:'user'}]:sql.includes('RETURNING user_id')?[{user_id:'user'}]:sql.startsWith('UPDATE users')?[{id:values[1],password_hash:values[0]}]:[]};}};
 const password='long-enough-password';
 assert.equal((await resetPassword(db,{email:'a@example.com',code:'ABC123ABC123',newPassword:password})).status,200);
 assert.ok(await bcrypt.compare(password,calls.find(c=>c.sql.startsWith('UPDATE users')).values[0]));
 assert.ok(calls.some(c=>c.sql.startsWith('DELETE FROM auth_sessions')));
 assert.equal(calls.at(-1).sql,'COMMIT');
});

test('native transport uses only the binding, validates senders and masks provider errors',async()=>{
 const original=globalThis.fetch;let message;
 try {
  globalThis.fetch=()=>assert.fail('external email service contacted');
  const mail={EMAIL_FROM:'PrimeCare <noreply@15minutes-email.com>',EMAIL_ALLOWED_SENDER:'noreply@15minutes-email.com',EMAIL:{send:async(value)=>{message=value;return {messageId:'native-id'};}}};
  assert.equal(await sendEmail(mail,'user@example.com','security_notice',{message:'test',support:'IT'},'test-key'),'native-id');
  assert.equal(message.from,'noreply@15minutes-email.com');
  assert.equal(mailReady({...mail,EMAIL_FROM:'spoof@other-domain.com'}),false);
  assert.equal(mailReady({...mail,EMAIL_FROM:'x\r\nBcc: victim@example.com'}),false);
  assert.equal(mailReady({RESEND_API_KEY:'legacy-key',EMAIL_FROM:mail.EMAIL_FROM}),false);
  await assert.rejects(sendEmail({...mail,EMAIL:{send:async()=>({})}},'user@example.com','security_notice',{message:'test',support:'IT'},'test-key'),/Email delivery unavailable/);
  await assert.rejects(sendEmail({...mail,EMAIL:{send:async()=>{throw new Error('private provider error');}}},'user@example.com','security_notice',{message:'test',support:'IT'},'test-key'),/Email delivery unavailable/);
 }finally{globalThis.fetch=original;}
});
