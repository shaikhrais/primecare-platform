import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {test} from 'node:test';
async function load(path){const r=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm'});return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));}
const {singleConfiguration,configuredMailFields,configurationRevision,configurationUpdatedAt,configurationAudit}=await load('cloudflare/workers/src/maintenance-projection.ts');
const {maintenance,configuredMail,validateSettings}=await load('cloudflare/workers/src/maintenance.ts');
const actor={id:'fixture-user',tenant_id:'fixture-tenant',roles:'maintenance',email:'fixture@example.invalid'};
const template={subject:'Reset',title:'Reset code',body:'Use {{code}} to reset.'};
const row={sender:'mail@example.invalid',revision:2,updated_at:new Date('2026-01-01T00:00:00Z'),templates:{password_reset:template}};
const db=(rows,audit=[])=>({query:async sql=>({rows:sql.includes('FROM tenant_mail_configuration')?rows:audit})});

test('batch 280 maintenance revisions reject coercion and PostgreSQL int4 overflow',()=>{
 for(const value of [undefined,null,'2',true,0,-1,1.5,NaN,Infinity,2147483648])assert.throws(()=>configurationRevision(value));
 for(const value of [1,2147483647])assert.equal(configurationRevision(value),value);
});
test('batch 280 maintenance update dates reject corrupt, missing and infinite values',()=>{
 for(const value of [undefined,null,'infinity','2026-02-30T00:00:00Z','2026-13-01T00:00:00Z',new Date(NaN),new Date('+010000-01-01T00:00:00Z')])assert.throws(()=>configurationUpdatedAt(value));
 assert.equal(configurationUpdatedAt(row.updated_at),'2026-01-01T00:00:00.000Z');
});
test('batch 280 absent configuration retains setup defaults and finite persisted dates serialize',async()=>{
 const absent=await maintenance(db([]),{},actor,'GET','/maintenance/configuration',{});
 assert.equal(absent.body.revision,0);assert.equal(absent.body.updatedAt,null);assert.equal(absent.body.sender,'');
 const persisted=await maintenance(db([row]),{},actor,'GET','/maintenance/configuration',{});
 assert.equal(persisted.body.revision,2);assert.equal(persisted.body.updatedAt,'2026-01-01T00:00:00.000Z');
});
test('batch 281 stored overrides enforce content and canonical placeholder bounds',()=>{
 for(const templates of [null,[],{unknown:template},{password_reset:null},{password_reset:{...template,subject:'private\nsubject'}},{password_reset:{...template,title:''}},{password_reset:{...template,body:'no reset code'}},{password_reset:{...template,body:'{{code}} {{password}}'}},{password_reset:{...template,body:'{{code}} {{bad_placeholder}}'}},{password_reset:{...template,body:'x'.repeat(4001)+'{{code}}'}}])assert.throws(()=>configuredMailFields({...row,templates}));
});
test('batch 281 template projection excludes private fields and derives required variables',async()=>{
 const persisted={...row,api_key_ciphertext:'private-ciphertext',private:'private-row',templates:{password_reset:{...template,required:['private-variable'],private:'private-template'}}};
 const response=await maintenance(db([persisted]),{},actor,'GET','/maintenance/configuration',{});
 assert.deepEqual(response.body.templates.password_reset,{...template,required:['code']});
 assert.ok(!JSON.stringify(response).includes('private-'));
});
test('batch 281 projected overrides accept the actual settings writer format',()=>{
 const settings=validateSettings({sender:row.sender,revision:0,templates:{password_reset:template}});
 assert.deepEqual(configuredMailFields(settings).templates,settings.templates);
});
test('batch 282 audit accepts only persisted maintenance event actions',()=>{
 for(const action of [null,undefined,{},'private-action','',false])assert.throws(()=>configurationAudit([{action,created_at:row.updated_at}]));
 for(const action of ['email_configuration_changed','test_email_accepted'])assert.equal(configurationAudit([{action,created_at:row.updated_at}])[0].action,action);
});
test('batch 282 audit validates timestamps and the existing twenty-row bound',()=>{
 const valid={action:'email_configuration_changed',created_at:row.updated_at};
 for(const rows of [null,{},[null],Array(21).fill(valid),[{...valid,created_at:null}],[{...valid,created_at:'infinity'}]])assert.throws(()=>configurationAudit(rows));
 assert.equal(configurationAudit(Array(20).fill(valid)).length,20);
});
test('batch 282 audit projects two fields and excludes adapter secrets',async()=>{
 const audit=[{action:'test_email_accepted',created_at:row.updated_at,actor_user_id:'private-actor',api_key:'private-key'}];
 const response=await maintenance(db([row],audit),{},actor,'GET','/maintenance/configuration',{});
 assert.deepEqual(response.body.audit,[{action:'test_email_accepted',created_at:'2026-01-01T00:00:00.000Z'}]);
 assert.ok(!JSON.stringify(response).includes('private-'));
});
test('batch 283 configuration cardinality rejects ambiguity and malformed rows',async()=>{
 for(const rows of [null,{},[undefined],[null],[row,row]]){
  assert.throws(()=>singleConfiguration(rows));
  await assert.rejects(configuredMail(db(rows),{},actor.tenant_id));
  await assert.rejects(maintenance(db(rows),{},actor,'GET','/maintenance/configuration',{}));
 }
});
test('batch 283 runtime mail rejects invalid stored senders and templates',async()=>{
 for(const invalid of [{...row,sender:1},{...row,sender:'private\naddress'},{...row,sender:'Display <mail@example.invalid>'},{...row,sender:''},{...row,templates:null},{...row,templates:{password_reset:{...template,body:'missing code'}}}])await assert.rejects(configuredMail(db([invalid]),{},actor.tenant_id));
});
test('batch 283 runtime retains native binding, derives placeholders and ignores credentials',async()=>{
 const env={EMAIL:{send:async()=>({messageId:'fixture'})},EMAIL_ALLOWED_SENDER:row.sender};
 const absent=await configuredMail(db([]),env,actor.tenant_id);assert.equal(absent,env);
 const mail=await configuredMail(db([{...row,api_key_ciphertext:'private-key',templates:{password_reset:{...template,required:['private'],secret:'private'}}}]),env,actor.tenant_id);
 assert.equal(mail.EMAIL,env.EMAIL);assert.equal(mail.EMAIL_ALLOWED_SENDER,env.EMAIL_ALLOWED_SENDER);
 assert.deepEqual(mail.EMAIL_TEMPLATES.password_reset,{...template,required:['code']});assert.ok(!JSON.stringify(mail).includes('private'));
});
test('batch 283 corrupt test-email configuration sends nothing and writes no acceptance audit',async()=>{
 const calls=[];const database={query:async sql=>{calls.push(sql);return {rows:[{...row,sender:'not-an-email'}]}}};
 const response=await maintenance(database,{EMAIL:{send:async()=>assert.fail('must not send')}},actor,'POST','/maintenance/configuration/test-email',{});
 assert.equal(response.status,503);assert.ok(!calls.some(sql=>sql.startsWith('INSERT')));
});
