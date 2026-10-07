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
const session={created_at:date,expires_at:'2026-01-02T00:00:00Z',current:true};
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
  return {rows:replacement===undefined?rows:replacement};
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
 assert.ok(['Authentication service unavailable','Account list unavailable','Session service unavailable','Workspace unavailable'].includes((await r.json()).error));
 assert.ok(!f.calls.some(c=>c.sql==='COMMIT'));return r;
}
const isCount=sql=>sql.startsWith('SELECT COUNT'),isPage=sql=>sql.startsWith('SELECT created_at')||sql.startsWith('SELECT id,actor_user_id')||sql.startsWith('SELECT id,email,roles,status,updated_at');
test('304 management rejects ambiguous, foreign or malformed prior state before mutation',async()=>{
 for(const rows of [[user,user],[{...user,id:'other'}],[{...user,id:1}],[{...user,roles:0}],[{...user,status:'deleted'}]]) {
  const f=fixture(sql=>sql.startsWith('SELECT id,roles,status')?rows:undefined);
  await unavailable(f,'/admin/users','POST',{id:'target',role:'rmt',status:'inactive'});
  assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(c=>c.sql.startsWith('UPDATE users')||c.sql.startsWith('DELETE FROM auth_sessions')||c.sql.startsWith('INSERT INTO auth_management_audit')));
 }
});
test('305 maintenance request bounds match incrementable int4 revision',async()=>{
 for(const revision of [-1,2147483647,Number.MAX_SAFE_INTEGER,'1',null,1.5]) {
  assert.equal(validateSettings({...settings,revision}),null);
  const f=fixture();assert.equal((await f.call('/maintenance/configuration','POST',{...settings,revision})).status,400);assert.ok(!f.calls.some(c=>c.sql.startsWith('SELECT revision')||c.sql.startsWith('INSERT INTO tenant_mail')));
 }
 assert.ok(validateSettings({...settings,revision:0}));assert.ok(validateSettings({...settings,revision:2147483646}));
});
test('305 maintenance rejects corrupt or ambiguous locked revision before save',async()=>{
 for(const rows of [[{revision:0,api_key_ciphertext:null}],[{revision:'1',api_key_ciphertext:null}],[{revision:1,api_key_ciphertext:1}],[{revision:1,api_key_ciphertext:null},{revision:1,api_key_ciphertext:null}]]) {
  const f=fixture(sql=>sql.startsWith('SELECT revision')?rows:undefined);await unavailable(f,'/maintenance/configuration','POST',settings);
  assert.ok(!f.calls.some(c=>c.sql.startsWith('INSERT INTO tenant_mail')));assert.equal(f.calls.at(-1).sql,'ROLLBACK');
 }
});
test('306 configuration save confirms identity, revision, content, retained secret and date before audit',async()=>{
 for(const change of [()=>[],rows=>[...rows,...rows],rows=>[{...rows[0],tenant_id:'other'}],rows=>[{...rows[0],revision:1}],rows=>[{...rows[0],sender:'other@example.com'}],rows=>[{...rows[0],api_key_ciphertext:'private'}],rows=>[{...rows[0],templates:{security_notice:{subject:'notice',title:'notice',body:'{{message}} {{support}}'}}}],rows=>[{...rows[0],updated_at:'infinity'}]]) {
  const f=fixture((sql,rows)=>sql.startsWith('INSERT INTO tenant_mail')?change(rows):undefined);
  await unavailable(f,'/maintenance/configuration','POST',settings);assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(c=>c.sql.startsWith('INSERT INTO tenant_configuration_audit')));
 }
});
for(const [batch,path,body] of [[306,'/maintenance/configuration',settings],[307,'/maintenance/configuration/test-email',{}]])test(batch+' configuration audit confirms tenant, actor, action and cardinality',async()=>{
 for(const change of [()=>[],rows=>[...rows,...rows],rows=>[{...rows[0],tenant_id:'other'}],rows=>[{...rows[0],actor_user_id:'other'}],rows=>[{...rows[0],action:'other'}]]) {
  const f=fixture((sql,rows)=>sql.startsWith('INSERT INTO tenant_configuration_audit')?change(rows):undefined);await unavailable(f,path,'POST',body);assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.equal(f.sends,batch===307?1:0);
 }
});
for(const [batch,path] of [[308,'/admin/users'],[310,'/admin/users/target/sessions'],[312,'/admin/users/audit'],[313,'/admin/users/creation-audit'],[314,'/user/sessions']]) {
 test(batch+' read requires exactly one count result',async()=>{
  for(const rows of [[],[{count:1},{count:1}],null,[null]]) {const f=fixture(sql=>isCount(sql)?rows:undefined);await unavailable(f,path);assert.equal(f.calls.at(-1).sql,'ROLLBACK');}
 });
 test(batch+' read rejects oversized or malformed page results',async()=>{
  for(const change of [rows=>[...rows,...rows],()=>null,()=>[null],()=>[[]]]) {const f=fixture((sql,rows)=>isPage(sql)?change(rows):undefined);await unavailable(f,path,'GET',undefined,'?limit=1');assert.equal(f.calls.at(-1).sql,'ROLLBACK');}
 });
}
for(const [batch,path,method] of [[309,'/admin/users/target','GET'],[310,'/admin/users/target/sessions','GET'],[311,'/admin/users/target/sessions','DELETE']])test(batch+' target requires an unambiguous ID matching the requested account',async()=>{
 for(const change of [rows=>[...rows,...rows],rows=>[{...rows[0],id:'other'}],rows=>[{...rows[0],id:1}]]) {
  const f=fixture((sql,rows)=>sql.startsWith('SELECT id FROM users')||sql.startsWith('SELECT id,email,roles,status,updated_at')?change(rows):undefined);
  await unavailable(f,path,method);assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(c=>c.sql.startsWith('WITH revoked')||c.sql.startsWith('INSERT INTO auth_management_audit')));
 }
});
for(const [batch,path] of [[311,'/admin/users/target/sessions'],[315,'/user/sessions']])test(batch+' revocation requires exactly one deletion count before audit/commit',async()=>{
 for(const rows of [[],[{count:1},{count:1}],null,[null]]) {const f=fixture(sql=>sql.startsWith('WITH revoked')?rows:undefined);await unavailable(f,path,'DELETE');assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(c=>c.sql.startsWith('INSERT INTO auth_management_audit')));}
});
for(const [batch,path,method] of [[314,'/user/sessions','GET'],[315,'/user/sessions','DELETE'],[316,'/workspace','GET']])test(batch+' actor rejects ambiguous and malformed identities before protected queries',async()=>{
 for(const change of [rows=>[...rows,...rows],rows=>[{...rows[0],id:1}],rows=>[{...rows[0],id:' bad'}],...(batch===316?[rows=>[{...rows[0],roles:1}],rows=>[{...rows[0],roles:''}]]:[])]) {
  const f=fixture((sql,rows)=>sql.includes('WHERE s.token_hash=$1')?change(rows):undefined);await unavailable(f,path,method);assert.ok(!f.calls.some(c=>isCount(c.sql)||c.sql.startsWith('WITH revoked')||c.sql.includes('SELECT roles AS role')));
 }
});
test('315 bearer recheck rejects ambiguity before deleting own sessions',async()=>{
 const f=fixture(sql=>sql.startsWith('SELECT 1 FROM auth_sessions')?[{},{}]:undefined);await unavailable(f,'/user/sessions','DELETE');assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(c=>c.sql.startsWith('WITH revoked')));
});
for(const [batch,match] of [[317,sql=>sql.includes('COUNT(*)::int AS count FROM auth_sessions')],[318,sql=>sql.startsWith('SELECT COUNT(*)::int AS count FROM "')]])test(batch+' workspace aggregate requires exactly one valid count row',async()=>{
 for(const rows of [[],[{count:1},{count:1}],null,[null]]) {const f=fixture(sql=>match(sql)?rows:undefined);await unavailable(f,'/workspace');assert.equal(f.calls.at(-1).sql,'ROLLBACK');}
});
test('all fifteen families retain valid reads, authorized mutations and missing-target behavior',async()=>{
 for(const [path,method,body,query] of [['/admin/users','GET',undefined,'?limit=1'],['/admin/users/target','GET'],['/admin/users/target/sessions','GET',undefined,'?limit=1'],['/admin/users/target/sessions','DELETE'],['/admin/users/audit','GET'],['/admin/users/creation-audit','GET'],['/user/sessions','GET'],['/user/sessions','DELETE'],['/workspace','GET'],['/maintenance/configuration','POST',settings],['/maintenance/configuration/test-email','POST',{}],['/admin/users','POST',{id:'target',role:'rmt',status:'inactive'}]]) {
  const f=fixture();const r=await f.call(path,method,body,query);assert.equal(r.status,200,path);assert.equal(r.headers.get('cache-control'),'no-store');assert.ok(!JSON.stringify(await r.json()).includes('password_hash'));
 }
 const missing=fixture(sql=>sql.startsWith('SELECT id FROM users')||sql.startsWith('SELECT id,email,roles,status,updated_at')?[]:undefined);assert.equal((await missing.call('/admin/users/target')).status,404);
});
