import {Client} from 'pg';
import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';
import {mkdtemp,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');
if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const require=createRequire(import.meta.url),pgPath=require.resolve('pg'),directory=await mkdtemp(join(tmpdir(),'nested-adapter-pg-'));
// SQL and transactions remain real; faults alter only returned adapter values.
const plugin={name:'nested-adapter-fault',setup(b){
 b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'nested-fault'}));
 b.onLoad({filter:/.*/,namespace:'nested-fault'},()=>({loader:'js',contents:
  'import pg from '+JSON.stringify(pgPath)+';export class Client extends pg.Client {async query(sql,values){const f=globalThis.__nestedAdapterFault;f.queries.push(sql);const result=await super.query(sql,values);const get=(row,key,value)=>Object.defineProperty({...row},key,{enumerable:true,get(){f.hits++;return value;}});if(!result.rows.length)return result;const row=result.rows[0];let rows;if(sql.includes("FROM tenant_mail_configuration")){if(f.mode==="sparse-config")rows=new Array(1);if(f.mode==="prototype-config")rows=[Object.create(row)];if(f.mode==="getter-config")rows=[get(row,"sender",row.sender)];if(f.mode==="getter-map")rows=[{...row,templates:get(row.templates,"password_reset",row.templates.password_reset)}];if(f.mode==="getter-template")rows=[{...row,templates:{password_reset:get(row.templates.password_reset,"body",row.templates.password_reset.body)}}];if(f.mode==="compatible")rows=[Object.freeze(Object.assign(Object.create(null),{...row,templates:Object.freeze(Object.assign(Object.create(null),{password_reset:Object.freeze(Object.assign(Object.create(null),row.templates.password_reset))}))}))];}if(sql.includes("FROM tenant_configuration_audit")){if(f.mode==="sparse-audit")rows=new Array(1);if(f.mode==="getter-audit")rows=[get(row,"action",row.action)];if(f.mode==="map-audit"){rows=[row];rows.map=()=>{f.hits++;throw Error("adapter map");};Object.freeze(rows);}}if(sql.startsWith("SELECT id,actor_user_id")&&sql.includes("FROM auth_management_audit")){if(f.mode==="getter-state")rows=[{...row,current:get(row.current,"role",row.current.role)}];if(f.mode==="compatible")rows=[{...row,current:Object.freeze(Object.assign(Object.create(null),row.current))}];}if(sql.startsWith("INSERT INTO auth_management_audit")){if(f.mode==="getter-confirm")rows=[{...row,new_state:get(row.new_state,"role",row.new_state.role)}];if(f.mode==="prototype-confirm")rows=[{...row,new_state:Object.create(row.new_state)}];}return rows?{...result,rows}:result;}}'}));
}};
await build({entryPoints:['cloudflare/workers/src/service.ts'],outfile:join(directory,'service.cjs'),bundle:true,platform:'node',format:'cjs',plugins:[plugin],external:[pgPath]});
await build({entryPoints:['cloudflare/workers/src/gateway.ts'],outfile:join(directory,'gateway.cjs'),bundle:true,platform:'node',format:'cjs'});
const service=require(join(directory,'service.cjs')).default,gateway=require(join(directory,'gateway.cjs')).default;
const db=new Client({connectionString:url.href});await db.connect();
const ids=[randomUUID(),randomUUID()],tenant=randomUUID(),token='S'.repeat(43),hash=s=>createHash('sha256').update(s).digest('hex');let checks=0;
globalThis.__nestedAdapterFault={mode:null,queries:[],hits:0,sends:0};
const env={SERVICE_NAME:'auth',DB_URL:url.href,EMAIL_FROM:'mail@example.invalid',EMAIL:{send:async()=>{globalThis.__nestedAdapterFault.sends++;return {messageId:'fixture'};}}};
const call=(path,method='GET',body)=>gateway.fetch(new Request('https://fixture/v1/auth'+path,{method,headers:{authorization:'Bearer '+token,'content-type':'application/json'},...(body===undefined?{}:{body:JSON.stringify(body)})}),{AUTH:{fetch:r=>service.fetch(r,env)}});
const tables=['users','auth_sessions','auth_management_audit','tenant_mail_configuration','tenant_configuration_audit'];
const snapshot=async()=>Object.fromEntries(await Promise.all(tables.map(async table=>[table,(await db.query('SELECT * FROM '+table+' ORDER BY '+(table==='auth_sessions'?'token_hash':table==='tenant_mail_configuration'?'tenant_id':'id'))).rows])));
try {
 for(let i=0;i<2;i++)await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,$3,$4,'unused','active')",[ids[i],ids[i]+'@example.invalid',i?'rmt':'ceo',tenant]);
 for(let i=0;i<2;i++)await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(i?ids[i]:token),ids[i]]);
 await db.query('INSERT INTO tenant_mail_configuration(tenant_id,sender,templates) VALUES($1,$2,$3)',[tenant,'mail@example.invalid',JSON.stringify({password_reset:{subject:'Reset',title:'Reset',body:'Use {{code}}.'}})]);
 await db.query("INSERT INTO tenant_configuration_audit(tenant_id,actor_user_id,action) VALUES($1,$2,'email_configuration_changed')",[tenant,ids[0]]);
 await db.query('INSERT INTO auth_management_audit(actor_user_id,target_user_id,tenant_id,previous_state,new_state) VALUES($1,$2,$3,$4,$5)',[ids[0],ids[1],tenant,JSON.stringify({role:'rmt'}),JSON.stringify({role:'rmt',status:'active'})]);
 const before=await snapshot();
 for(const [path,mode,status,method,body] of [
  ...['sparse-config','prototype-config','getter-config','getter-map','getter-template','sparse-audit','getter-audit'].map(mode=>['/maintenance/configuration',mode,503]),
  ['/maintenance/configuration',null,200],['/maintenance/configuration','compatible',200],['/maintenance/configuration','map-audit',200],
  ['/maintenance/configuration/test-email','getter-template',503,'POST',{}],
  ['/admin/users/audit?userId='+ids[1],'getter-state',503],['/admin/users/audit?userId='+ids[1],'compatible',200],
  ...['getter-confirm','prototype-confirm'].map(mode=>['/admin/users',mode,503,'POST',{id:ids[1],role:'rmt',status:'inactive'}]),
 ]) {
  globalThis.__nestedAdapterFault={mode,queries:[],hits:0,sends:0};
  const response=await call(path,method,body);assert.equal(response.status,status,path+' '+mode);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);
  const text=await response.text();assert.ok(!text.includes('token_hash'));assert.ok(!text.includes('unused'));assert.equal(globalThis.__nestedAdapterFault.hits,0);assert.equal(globalThis.__nestedAdapterFault.sends,0);
  const queries=globalThis.__nestedAdapterFault.queries;const commits=path==='/maintenance/configuration/test-email'||path==='/maintenance/configuration'&&status===200;assert.equal(queries.at(-1),commits?'COMMIT':'ROLLBACK');if(!commits)assert.ok(!queries.includes('COMMIT'));
  if(mode?.endsWith('confirm')){assert.ok(queries.some(sql=>sql.startsWith('UPDATE users')));assert.ok(queries.some(sql=>sql.startsWith('INSERT INTO auth_management_audit')));}
  else assert.ok(!queries.some(sql=>/^(UPDATE|DELETE)/.test(sql)||sql.startsWith('INSERT INTO tenant_configuration_audit')));
  assert.deepEqual(await snapshot(),before);checks++;
 }
 console.log(`Nested adapter validation passed ${checks} real PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} identities).`);
} finally {
 await db.query('DELETE FROM tenant_configuration_audit WHERE tenant_id=$1',[tenant]);await db.query('DELETE FROM tenant_mail_configuration WHERE tenant_id=$1',[tenant]);
 await db.query('DELETE FROM auth_management_audit WHERE actor_user_id::text=$1',[ids[0]]);
 for(const id of ids){await db.query('DELETE FROM auth_sessions WHERE user_id::text=$1',[id]);await db.query('DELETE FROM users WHERE id::text=$1',[id]);}
 for(const operation of ['manageAccount','maintenance'])await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=$1',[hash(operation+':'+ids[0])]);
 await db.end();await rm(directory,{recursive:true,force:true});delete globalThis.__nestedAdapterFault;
}
