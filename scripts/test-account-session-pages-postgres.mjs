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
const require=createRequire(import.meta.url),pgPath=require.resolve('pg'),directory=await mkdtemp(join(tmpdir(),'account-page-pg-'));
// Execute real ownership SQL. Faults alter returned values only, never storage.
const plugin={name:'account-page-fault',setup(b){
 b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'page-fault'}));
 b.onLoad({filter:/.*/,namespace:'page-fault'},()=>({loader:'js',contents:
 'import pg from '+JSON.stringify(pgPath)+';export class Client extends pg.Client {async query(sql,values){const f=globalThis.__accountPageFault;f.queries.push(sql);const r=await super.query(sql,values);if(f.mode==="zero"&&sql.startsWith("SELECT COUNT"))return {...r,rows:[{count:0}]};if(!sql.startsWith("SELECT")||!sql.includes("ORDER BY")||!r.rows.length)return r;const row=r.rows[0];if(f.mode==="duplicate")return {...r,rows:[row,{...row}]};if(f.mode==="identity")return {...r,rows:[{...row,[f.session?"token_hash":"id"]:" bad"}]};if(f.mode==="binding")return {...r,rows:[{...row,...(f.session?{current:!row.current}:{targetUserId:f.other})}]};if(f.mode==="valid")return {...r,rows:r.rows.map(x=>Object.freeze(Object.assign(Object.create(null),x)))};return r;}}'}));
}};
await build({entryPoints:['cloudflare/workers/src/service.ts'],outfile:join(directory,'service.cjs'),bundle:true,platform:'node',format:'cjs',plugins:[plugin],external:[pgPath]});
await build({entryPoints:['cloudflare/workers/src/gateway.ts'],outfile:join(directory,'gateway.cjs'),bundle:true,platform:'node',format:'cjs'});
const service=require(join(directory,'service.cjs')).default,gateway=require(join(directory,'gateway.cjs')).default;
const db=new Client({connectionString:url.href});await db.connect();
const ids=[randomUUID(),randomUUID()],tenant=randomUUID(),token='Q'.repeat(43),hash=s=>createHash('sha256').update(s).digest('hex');let checks=0;
globalThis.__accountPageFault={mode:null,queries:[]};
const call=path=>gateway.fetch(new Request('https://fixture/v1'+path,{headers:{authorization:'Bearer '+token}}),{AUTH:{fetch:r=>service.fetch(r,{DB_URL:url.href,SERVICE_NAME:'auth'})}});
const snapshot=async()=>Object.fromEntries(await Promise.all(['users','auth_sessions','auth_account_audit','auth_management_audit'].map(async table=>[table,(await db.query('SELECT * FROM '+table+' ORDER BY '+(table==='auth_sessions'?'token_hash':'id'))).rows])));
try {
 for(let i=0;i<2;i++)await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,$3,$4,'unused','active')",[ids[i],ids[i]+'@'+tenant+'.invalid',i?'rmt':'ceo',tenant]);
 for(let i=0;i<2;i++)for(let j=0;j<2;j++)await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(i===0&&j===0?token:ids[i]+j),ids[i]]);
 for(let i=0;i<2;i++) {
  await db.query("INSERT INTO auth_account_audit(actor_user_id,target_user_id,tenant_id,action) VALUES($1,$2,$3,'account_created')",[ids[0],ids[1],tenant]);
  await db.query('INSERT INTO auth_management_audit(actor_user_id,target_user_id,tenant_id,previous_state,new_state) VALUES($1,$2,$3,$4,$5)',[ids[0],ids[1],tenant,JSON.stringify({role:'rmt'}),JSON.stringify({role:'rmt',status:'active'})]);
 }
 const before=await snapshot();
 for(const [path,collection,session,binding] of [['/admin/users?search='+tenant,'users',false,false],['/admin/users/creation-audit?userId='+ids[1],'events',false,true],['/admin/users/audit?userId='+ids[1],'events',false,true],['/admin/users/'+ids[1]+'/sessions?','sessions',true,false],['/user/sessions?','sessions',true,true]]) {
  const separator=path.endsWith('?')?'':'&';
  for(const mode of [null,'valid','zero','duplicate','identity',...(binding?['binding']:[])]) {
   globalThis.__accountPageFault={mode,session,other:ids[0],queries:[]};
   const response=await call(path+separator+'limit=25');assert.equal(response.status,mode===null||mode==='valid'?200:503,path+' '+mode);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);
   const body=await response.json();assert.ok(!JSON.stringify(body).includes('token_hash'));assert.ok(!JSON.stringify(body).includes(hash(token)));assert.ok(!JSON.stringify(body).includes('unused'));
   if(response.status===200){assert.equal(body.pagination.total,2);assert.equal(body[collection].length,2);}
   assert.ok(globalThis.__accountPageFault.queries.some(sql=>sql.startsWith('SELECT')&&sql.includes('ORDER BY')));assert.equal(globalThis.__accountPageFault.queries.at(-1),'ROLLBACK');assert.ok(!globalThis.__accountPageFault.queries.some(sql=>/^(COMMIT|INSERT|UPDATE|DELETE)/.test(sql)));assert.deepEqual(await snapshot(),before);checks++;
  }
  for(const offset of [1,2]) {
   globalThis.__accountPageFault={mode:null,queries:[]};const response=await call(path+separator+'limit=1&offset='+offset);assert.equal(response.status,200);const body=await response.json();assert.equal(body[collection].length,offset===1?1:0);assert.equal(body.pagination.total,2);assert.equal(body.pagination.hasMore,false);checks++;
  }
 }
 assert.deepEqual(await snapshot(),before);console.log(`Account/session pages passed ${checks} real PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} identities).`);
} finally {
 for(const table of ['auth_management_audit','auth_account_audit'])await db.query('DELETE FROM '+table+' WHERE actor_user_id::text=$1',[ids[0]]);
 for(const id of ids){await db.query('DELETE FROM auth_sessions WHERE user_id::text=$1',[id]);await db.query('DELETE FROM users WHERE id::text=$1',[id]);}
 await db.end();await rm(directory,{recursive:true,force:true});delete globalThis.__accountPageFault;
}
