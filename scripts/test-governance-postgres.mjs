// CI-only integration checks against disposable loopback PostgreSQL after auth schema setup.
import {Client} from 'pg';
import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';
import {mkdtemp} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');
if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Only disposable loopback auth_test is permitted');
const dir=await mkdtemp(join(tmpdir(),'governance-real-pg-'));
await build({entryPoints:['cloudflare/workers/src/governance-api.ts','cloudflare/workers/src/auth.ts'],outdir:dir,bundle:true,platform:'node',format:'cjs'});
const require=createRequire(import.meta.url),{governanceApi}=require(join(dir,'governance-api.js')),{auth}=require(join(dir,'auth.js'));
const db=new Client({connectionString:url.href});await db.connect();
const tenant=randomUUID(),otherTenant=randomUUID(),ids=[randomUUID(),randomUUID(),randomUUID()],tokens=['c'.repeat(43),'d'.repeat(43)];
const hash=t=>createHash('sha256').update(t).digest('hex');let checks=0;
const call=(path,query='',token=tokens[0],tenantHeader)=>governanceApi(new Request('https://fixture'+path+query,{headers:{authorization:'Bearer '+token,...(tenantHeader?{'x-tenant-id':tenantHeader}:{})}}),{SERVICE_NAME:'governance',DB_URL:url.href},path,{});
const accounts=(query='',token=tokens[0])=>auth(new Request('https://fixture/admin/users'+query,{headers:{authorization:'Bearer '+token}}),{SERVICE_NAME:'auth',DB_URL:url.href},'/admin/users',{});
try {
 for(let i=0;i<3;i++)await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,$3,$4,'fixture-unused-hash','active')",[ids[i],i===1?`literal_%${ids[i]}@example.invalid`:`batch-${ids[i]}@example.invalid`,i===1?'rmt':'ceo',i===2?otherTenant:tenant]);
 for(let i=0;i<2;i++)await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),ids[i]]);
 for(const path of ['/page-progress','/screen-health','/role-coverage','/pending-tasks','/api-contracts','/api-execution-status','/organization-map','/overview']) {
  const r=await call(path,'?limit=2');assert.equal(r.status,200,path);const data=await r.json();assert.ok(data.data.length<=2);checks++;
 }
 const org=await (await call('/organization-map','?limit=100')).json();assert.equal(org.data.find(r=>r.role==='ceo').activeAccounts,1);assert.equal(org.data.find(r=>r.role==='rmt').activeAccounts,1);checks++;
 const overview=await (await call('/overview')).json();assert.equal(overview.data[0].activeAccounts,2);checks++;
 const list=await (await accounts('?limit=100')).json();assert.equal(list.pagination.total,2);assert.ok(!list.users.some(u=>u.id===ids[2]));assert.ok(!JSON.stringify(list).includes('password_hash'));checks++;
 const literal=await (await accounts('?search=%25')).json();assert.equal(literal.pagination.total,1);assert.equal(literal.users[0].id,ids[1]);checks++;
 const filtered=await (await accounts('?role=rmt&status=active')).json();assert.equal(filtered.pagination.total,1);checks++;
 assert.equal((await call('/overview','',tokens[0],otherTenant)).status,403);checks++;
 assert.equal((await call('/page-progress','',tokens[1])).status,403);assert.equal((await accounts('',tokens[1])).status,403);checks++;
 await db.query("UPDATE users SET status='inactive' WHERE id=$1",[ids[0]]);assert.equal((await accounts()).status,401);assert.equal((await call('/overview')).status,401);checks++;
 await db.query("UPDATE users SET status='active' WHERE id=$1",[ids[0]]);await db.query("UPDATE auth_sessions SET expires_at=NOW()-INTERVAL '1 second' WHERE user_id=$1",[ids[0]]);assert.equal((await accounts()).status,401);checks++;
 console.log(`Governance/account batches passed ${checks} real PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE||'uuid'} identities).`);
}finally {
 await db.query('DELETE FROM auth_sessions WHERE token_hash=ANY($1)',[tokens.map(hash)]);
 await db.query('DELETE FROM users WHERE id::text=ANY($1)',[ids]);await db.end();
}
