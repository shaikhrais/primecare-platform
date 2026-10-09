import {createHash} from 'node:crypto';
import {auditFixture} from './auth-audit-fixtures.mjs';
import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
const plugin={name:'result-fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({loader:'js',contents:'export class Client {async connect(){} async end(){} query(sql,values){return globalThis.__resultQuery(sql,values)}}'}));}};
async function load(path,plugins=[]){const r=await build({entryPoints:[path],plugins,bundle:true,write:false,platform:'node',format:'esm'});return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));}
const {auth}=await load('cloudflare/workers/src/auth.ts',[plugin]),{workspace}=await load('cloudflare/workers/src/workspace.ts',[plugin]);
const {default:gateway}=await load('cloudflare/workers/src/gateway.ts');
const {validateSettings}=await load('cloudflare/workers/src/maintenance.ts');
const actor={id:'actor',roles:'ceo',tenant_id:'tenant-a',email:'it@example.com'},date='2026-01-01T00:00:00Z';
const user={id:'target',email:'target@example.com',roles:'rmt',status:'active',updated_at:date};
const event={id:'event',actorUserId:'actor',targetUserId:'target',created_at:date,action:'account_updated',previous:{},current:{}};
const session={created_at:date,expires_at:'2026-01-02T00:00:00Z',current:true,token_hash:createHash('sha256').update('a'.repeat(43)).digest('hex')};
const settings={sender:'it@example.com',revision:1,templates:{}};
function fixture(change=()=>undefined){
 const calls=[];let sends=0;
 const env={DB_URL:'fixture',SERVICE_NAME:'auth',EMAIL_FROM:'it@example.com',EMAIL:{send:async()=>{sends++;return {messageId:'fixture'};}}};
 globalThis.__resultQuery=async(sql,values)=>{
  calls.push({sql,values});let rows=[];
  if(sql.includes('WHERE s.token_hash=$1'))rows=[actor];
  else if(sql.startsWith('INSERT INTO auth_rate_limits'))rows=[{attempts:1,retry_after:60}];
  else if(sql.startsWith('SELECT id,roles,status'))rows=[user];
  else if(sql.startsWith('UPDATE users SET roles'))rows=[{...user,roles:values[0],status:values[1],tenant_id:values[3]}];
  else if(sql.startsWith('SELECT id,email,roles,status,updated_at'))rows=[user];
  else if(sql.startsWith('SELECT id FROM users'))rows=[{id:'target'}];
  else if(sql.startsWith('SELECT COUNT')||sql.startsWith('WITH revoked'))rows=[{count:1}];
  else if(sql.startsWith('SELECT id,actor_user_id'))rows=[event];
  else if(sql.startsWith('SELECT created_at'))rows=[session];
  else if(sql.startsWith('SELECT 1 FROM auth_sessions'))rows=[{}];
  else if(sql.includes('SELECT roles AS role'))rows=[{role:'ceo',count:1}];
  else if(sql.includes('FROM pg_attribute'))rows=[{attname:'tenant_id'}];
  else if(sql.startsWith('SELECT revision'))rows=[{revision:1,api_key_ciphertext:null}];
  else if(sql.includes('FROM tenant_mail_configuration'))rows=[];
  else if(sql.startsWith('INSERT INTO tenant_mail_configuration'))rows=[{tenant_id:values[0],sender:values[1],api_key_ciphertext:values[2],templates:JSON.parse(values[3]),revision:2,updated_at:date}];
  else if(sql.startsWith('INSERT INTO tenant_configuration_audit'))rows=[{tenant_id:values[0],actor_user_id:values[1],action:sql.includes('test_email_accepted')?'test_email_accepted':'email_configuration_changed'}];
  const replacement=change(sql,rows,values);
  return replacement===undefined?(auditFixture(sql,values)??{rows}):{rows:replacement};
 };
 return {calls,get sends(){return sends;},async call(path,method='GET',body,query='') {
  const publicPath=path==='/workspace'?'/v1/governance/workspace':path.startsWith('/admin/')?'/v1'+path:path==='/user/sessions'?'/v1'+path:'/v1/auth'+path;
  return gateway.fetch(new Request('https://gateway.test'+publicPath+query,{method,headers:{authorization:'Bearer '+'a'.repeat(43),'content-type':'application/json'},...(body===undefined?{}:{body:JSON.stringify(body)})}),{
   AUTH:{fetch:r=>auth(r,env,new URL(r.url).pathname,{})},GOVERNANCE:{fetch:r=>workspace(r,{...env,SERVICE_NAME:'governance'},'/workspace',{})}
  });
 }};
}
async function unavailable(f,path,method='GET',body,query='') {
 const r=await f.call(path,method,body,query);assert.equal(r.status,503);assert.equal(r.headers.get('cache-control'),'no-store');assert.equal(r.headers.get('set-cookie'),null);
 const error=(await r.json()).error;assert.ok(['Authentication service unavailable','Account list unavailable','Session service unavailable','Workspace unavailable'].includes(error)||error.startsWith('Email provider did not accept the test.'));
 assert.ok(!f.calls.some(c=>c.sql==='COMMIT'));return r;
}

const {singleConfiguration,configuredMailFields,configurationAudit}=await load('cloudflare/workers/src/maintenance-projection.ts');
const {validatedEmailTemplate}=await load('cloudflare/workers/src/email-template-validation.ts');
const {confirmedAudit}=await load('cloudflare/workers/src/audit-confirmation.ts');
const template={subject:'Reset',title:'Reset code',body:'Use {{code}}.'};
const cfg={sender:'it@example.com',revision:1,updated_at:date,templates:{password_reset:template}};
const audit={action:'email_configuration_changed',created_at:date,secret:'private-audit'};
let hits=0;
const getter=(value,key,result)=>Object.defineProperty({...value},key,{enumerable:true,get(){hits++;return result;}});
const inherited=value=>Object.create(value);
const classRow=value=>{class Row{}return Object.assign(new Row(),value);};
const nullRow=value=>Object.assign(Object.create(null),value);
const inheritedEntry=value=>{const rows=new Array(1);Object.setPrototypeOf(rows,Object.assign(Object.create(Array.prototype),{0:value}));return rows;};
const getterEntry=value=>Object.defineProperty(new Array(1),'0',{get(){hits++;return value;}});
const yes=fn=>()=>{fn();};
const no=fn=>()=>assert.throws(fn);
const expected={new_state:{role:'rmt',details:{source:'fixture'}}};
const stored={id:'audit',created_at:date,...expected,secret:'private-audit'};
const confirm=state=>confirmedAudit([{...stored,new_state:state}],expected);
const boundaries=[
 ['configuration rows',[
  ['sparse',no(()=>singleConfiguration(new Array(1)))],['inherited entry',no(()=>singleConfiguration(inheritedEntry(cfg)))],['getter entry',no(()=>singleConfiguration(getterEntry(cfg)))],['inherited row',no(()=>singleConfiguration([inherited(cfg)]))],['class row',no(()=>singleConfiguration([classRow(cfg)]))],['getter field',no(()=>singleConfiguration([getter(cfg,'sender',cfg.sender)]))],['absent defaults',yes(()=>assert.equal(singleConfiguration([]),null))],['null prototype',yes(()=>assert.equal(singleConfiguration([nullRow(cfg)]).sender,cfg.sender))],['frozen data',yes(()=>assert.equal(singleConfiguration(Object.freeze([Object.freeze(cfg)])).sender,cfg.sender))],['duplicate rows',no(()=>singleConfiguration([cfg,cfg]))]
 ]],
 ['stored template maps',[
  ['null',no(()=>configuredMailFields({...cfg,templates:null}))],['array',no(()=>configuredMailFields({...cfg,templates:[]}))],['inherited',no(()=>configuredMailFields({...cfg,templates:inherited(cfg.templates)}))],['class',no(()=>configuredMailFields({...cfg,templates:classRow(cfg.templates)}))],['template getter',no(()=>configuredMailFields({...cfg,templates:getter(cfg.templates,'password_reset',template)}))],['extra getter',no(()=>configuredMailFields({...cfg,templates:getter(cfg.templates,'secret','private')}))],['frozen',yes(()=>assert.deepEqual(configuredMailFields({...cfg,templates:Object.freeze({...cfg.templates})}).templates.password_reset.required,['code']))],['null prototype',yes(()=>assert.deepEqual(configuredMailFields({...cfg,templates:nullRow(cfg.templates)}).templates.password_reset.required,['code']))],['unknown template',no(()=>configuredMailFields({...cfg,templates:{unknown:template}}))],['private projection',yes(()=>assert.ok(!JSON.stringify(configuredMailFields({...cfg,secret:'private',templates:{password_reset:{...template,secret:'private',required:['private']}}})).includes('private')))]
 ]],
 ['template fields',[
  ['null',no(()=>validatedEmailTemplate('password_reset',null))],['array',no(()=>validatedEmailTemplate('password_reset',[]))],['inherited',no(()=>validatedEmailTemplate('password_reset',inherited(template)))],['class',no(()=>validatedEmailTemplate('password_reset',classRow(template)))],['subject getter',no(()=>validatedEmailTemplate('password_reset',getter(template,'subject',template.subject)))],['private getter',no(()=>validatedEmailTemplate('password_reset',getter(template,'secret','private')))],['placeholder rules',no(()=>validatedEmailTemplate('password_reset',{...template,body:'{{password}}'}))],['frozen',yes(()=>assert.deepEqual(validatedEmailTemplate('password_reset',Object.freeze({...template})).required,['code']))],['null prototype',yes(()=>assert.deepEqual(validatedEmailTemplate('password_reset',nullRow(template)).required,['code']))],['canonical variables',yes(()=>assert.deepEqual(validatedEmailTemplate('password_reset',{...template,required:['private']}).required,['code']))]
 ]],
 ['maintenance audit rows',[
  ['sparse',no(()=>configurationAudit(new Array(1)))],['inherited entry',no(()=>configurationAudit(inheritedEntry(audit)))],['getter entry',no(()=>configurationAudit(getterEntry(audit)))],['inherited row',no(()=>configurationAudit([inherited(audit)]))],['class row',no(()=>configurationAudit([classRow(audit)]))],['action getter',no(()=>configurationAudit([getter(audit,'action',audit.action)]))],['twenty row limit',no(()=>configurationAudit(Array(21).fill(audit)))],['empty',yes(()=>assert.deepEqual(configurationAudit([]),[]))],['map override',yes(()=>{const rows=[Object.freeze({...audit})];rows.map=()=>{hits++;throw Error('adapter map');};assert.deepEqual(configurationAudit(Object.freeze(rows)),[{action:audit.action,created_at:date}]);})],['null prototype privacy',yes(()=>assert.ok(!JSON.stringify(configurationAudit([nullRow(audit)])).includes('private')))]
 ]],
 ['persisted audit states',[
  ['inherited state',no(()=>confirm(inherited(expected.new_state)))],['class state',no(()=>confirm(classRow(expected.new_state)))],['role getter',no(()=>confirm(getter(expected.new_state,'role','rmt')))],['nested getter',no(()=>confirm({...expected.new_state,details:getter(expected.new_state.details,'source','fixture')}))],['array state',no(()=>confirm([]))],['wrong primitive',no(()=>confirm({...expected.new_state,role:'ceo'}))],['extra field',no(()=>confirm({...expected.new_state,secret:'private'}))],['missing field',no(()=>confirm({role:'rmt'}))],['frozen nested',yes(()=>confirm(Object.freeze({role:'rmt',details:Object.freeze({source:'fixture'})})))],['null prototype nested',yes(()=>confirm(nullRow({role:'rmt',details:nullRow({source:'fixture'})}))) ]
 ]]
];
let batch=689;for(const [family,cases] of boundaries){assert.equal(cases.length,10);for(const [name,fn] of cases)test('batch '+batch+++' '+family+' '+name,()=>{hits=0;fn();assert.equal(hits,0);});}assert.equal(batch,739);
for(const [name,change] of [
 ['configuration getter',sql=>sql.includes('FROM tenant_mail_configuration')?[getter(cfg,'sender',cfg.sender)]:undefined],
 ['nested template getter',sql=>sql.includes('FROM tenant_mail_configuration')?[{...cfg,templates:{password_reset:getter(template,'body',template.body)}}]:undefined],
 ['sparse maintenance audit',sql=>sql.includes('FROM tenant_configuration_audit')?new Array(1):undefined]
])test('gateway maintenance rejects '+name+' without executing adapter code',async()=>{hits=0;const f=fixture(change);await unavailable(f,'/maintenance/configuration');assert.equal(hits,0);assert.equal(f.sends,0);assert.equal(f.calls.at(-1).sql,'ROLLBACK');});
test('gateway corrupt stored template prevents email and acceptance audit',async()=>{hits=0;const f=fixture(sql=>sql.includes('FROM tenant_mail_configuration')?[{...cfg,templates:getter(cfg.templates,'password_reset',template)}]:undefined);const r=await f.call('/maintenance/configuration/test-email','POST',{});assert.equal(r.status,503);assert.equal(r.headers.get('cache-control'),'no-store');assert.equal(r.headers.get('set-cookie'),null);assert.ok(!(await r.text()).includes('private'));assert.equal(hits,0);assert.equal(f.sends,0);assert.ok(!f.calls.some(q=>q.sql.startsWith('INSERT INTO tenant_configuration_audit')));assert.equal(f.calls.at(-1).sql,'COMMIT');});
test('gateway account audit rejects nested getter states without execution',async()=>{hits=0;const f=fixture(sql=>sql.startsWith('SELECT id,actor_user_id')?[{...event,current:getter({role:'rmt'},'role','rmt')}]:undefined);await unavailable(f,'/admin/users/audit');assert.equal(hits,0);assert.equal(f.calls.at(-1).sql,'ROLLBACK');});
test('gateway account audit preserves frozen/null-prototype state privacy',async()=>{const f=fixture(sql=>sql.startsWith('SELECT id,actor_user_id')?[{...event,current:Object.freeze(nullRow({role:'rmt',secret:'private'}))}]:undefined);const r=await f.call('/admin/users/audit');assert.equal(r.status,200);const b=await r.json();assert.equal(b.events[0].current.role,'rmt');assert.ok(!JSON.stringify(b).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');});
test('gateway mutation rejects nested persisted audit getters and rolls back',async()=>{hits=0;const f=fixture((sql,rows,values)=>sql.startsWith('INSERT INTO auth_management_audit')?[{id:'audit',created_at:date,actor_user_id:values[0],target_user_id:values[1],tenant_id:values[2],previous_state:JSON.parse(values[3]),new_state:getter(JSON.parse(values[4]),'role','rmt')}]:undefined);await unavailable(f,'/admin/users','POST',{id:'target',role:'rmt',status:'inactive'});assert.equal(hits,0);assert.ok(f.calls.some(q=>q.sql.startsWith('UPDATE users')));assert.equal(f.calls.at(-1).sql,'ROLLBACK');});
test('gateway compatible persisted audit states retain mutation success',async()=>{const f=fixture((sql,rows,values)=>sql.startsWith('INSERT INTO auth_management_audit')?[{id:'audit',created_at:date,actor_user_id:values[0],target_user_id:values[1],tenant_id:values[2],previous_state:Object.freeze(nullRow(JSON.parse(values[3]))),new_state:Object.freeze(nullRow(JSON.parse(values[4])))}]:undefined);assert.equal((await f.call('/admin/users','POST',{id:'target',role:'rmt',status:'inactive'})).status,200);assert.equal(f.calls.at(-1).sql,'COMMIT');});
