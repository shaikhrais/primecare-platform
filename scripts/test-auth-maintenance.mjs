import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
const result=await build({entryPoints:['cloudflare/workers/src/maintenance.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {validateSettings,encryptCredential,decryptCredential,configuredMail,maintenance}=await import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));
const env={CONFIG_ENCRYPTION_KEY:'a'.repeat(64),EMAIL:{send:async()=>({messageId:'test'})}};
const legacyKey='re_test_fixture_key';
const actor={id:'user',roles:'maintenance',tenant_id:'tenant-a',email:'it@example.com'};
const input={sender:'mail@example.com',revision:0,templates:{password_reset:{subject:'Reset',title:'Your code',body:'Use {{code}} within 15 minutes.'}}};
test('settings reject overrides, invalid sender, removed placeholders, unsupported fields and templates',()=>{
 assert.ok(validateSettings(input));
 for(const value of [{...input,tenant_id:'tenant-b'},{...input,sender:'x\nBcc: a@example.com'},{...input,apiKey:'bad'},{...input,revision:-1},{...input,templates:{password_reset:{subject:'Reset',title:'Reset',body:'no code'}}},{...input,templates:{password_reset:{subject:'Reset',title:'Reset',body:'{{code}} {{password}}'}}},{...input,templates:{arbitrary:{subject:'x',title:'x',body:'x'}}}])assert.equal(validateSettings(value),null);
});
test('encrypted credentials are randomized and tenant bound, wrong keys fail closed',async()=>{
 const a=await encryptCredential(env,legacyKey,'tenant-a'),b=await encryptCredential(env,legacyKey,'tenant-a');
 assert.notEqual(a,b);assert.ok(!a.includes(legacyKey));assert.equal(await decryptCredential(env,a,'tenant-a'),legacyKey);
 await assert.rejects(decryptCredential(env,a,'tenant-b'));
 await assert.rejects(decryptCredential({CONFIG_ENCRYPTION_KEY:'b'.repeat(64)},a,'tenant-a'));
 await assert.rejects(encryptCredential({},legacyKey,'tenant-a'));
});
test('unauthorized role is denied without configuration database access',async()=>{
 const db={query:()=>assert.fail('configuration accessed')};
 for(const roles of ['rmt','hr_director','cto','admin','guest'])assert.equal((await maintenance(db,env,{...actor,roles},'GET','/maintenance/configuration',{})).status,403);
});
test('read returns setup status and templates, never ciphertext or provider credentials',async()=>{
 const secret=await encryptCredential(env,legacyKey,actor.tenant_id);
 const db={query:async(sql,values)=>{assert.equal(values[0],actor.tenant_id);return {rows:sql.includes('FROM tenant_mail_configuration')?[{sender:input.sender,api_key_ciphertext:secret,revision:2,templates:{}}]:[]};}};
 const r=await maintenance(db,env,actor,'GET','/maintenance/configuration',{});
 assert.equal(r.status,200);assert.equal(r.body.keyConfigured,false);assert.equal(r.body.provider,'cloudflare');assert.equal(r.body.bindingConfigured,true);assert.equal(r.body.emailReady,true);
 assert.ok(!JSON.stringify(r).includes(secret));assert.ok(!JSON.stringify(r).includes(legacyKey));assert.equal(r.body.deliveryVerified,false);
});
test('saving preserves existing key, refuses stale edits and records no secrets in audit',async()=>{
 const secret=await encryptCredential(env,legacyKey,actor.tenant_id),calls=[];
 const db={query:async(sql,values)=>{calls.push({sql,values});return {rows:sql.startsWith('SELECT revision')?[{revision:3,api_key_ciphertext:secret}]:[]};}};
 assert.equal((await maintenance(db,env,actor,'POST','/maintenance/configuration',{...input,revision:2})).status,409);
 assert.ok(!calls.some(c=>c.sql.startsWith('INSERT')));
 const withoutKey=input;
 assert.equal((await maintenance(db,env,actor,'POST','/maintenance/configuration',{...withoutKey,revision:3})).status,200);
 assert.equal(calls.find(c=>c.sql.startsWith('INSERT INTO tenant_mail')).values[2],secret);
 assert.ok(!JSON.stringify(calls.at(-1)).includes(secret));
});
test('test email cannot override recipient, always goes to current account',async()=>{
 const db={query:async()=>({rows:[]})};
 assert.equal((await maintenance(db,env,actor,'POST','/maintenance/configuration/test-email',{to:'victim@example.com'})).status,400);
 const original=env.EMAIL.send;let recipient;
 try {
  env.EMAIL.send=async(message)=>{recipient=message.to;return {messageId:'accepted'};};
  assert.equal((await maintenance(db,{...env,EMAIL_FROM:input.sender},actor,'POST','/maintenance/configuration/test-email',{})).status,200);
  assert.equal(recipient,actor.email);
 }finally{env.EMAIL.send=original;}
});
test('runtime preserves native binding and does not decrypt legacy provider credentials',async()=>{
 const secret=await encryptCredential(env,legacyKey,actor.tenant_id);
 const db={query:async(sql,values)=>{assert.deepEqual(values,[actor.tenant_id]);return {rows:[{sender:input.sender,api_key_ciphertext:secret,templates:input.templates}]};}};
 const mail=await configuredMail(db,env,actor.tenant_id);
 assert.equal(mail.EMAIL,env.EMAIL);assert.equal(mail.RESEND_API_KEY,undefined);assert.equal(mail.EMAIL_FROM,input.sender);
});

test('Cloudflare sender restriction rejects spoofed organization sender',async()=>{
 const db={query:async()=>({rows:[]})};
 const limited={...env,EMAIL_ALLOWED_SENDER:'noreply@15minutes-email.com'};
 assert.equal((await maintenance(db,limited,actor,'POST','/maintenance/configuration',input)).status,400);
});
test('native settings can be saved without any provider encryption key',async()=>{
 const db={query:async()=>({rows:[]})};
 assert.equal((await maintenance(db,{},actor,'POST','/maintenance/configuration',input)).status,200);
});
