import {Client} from 'pg';
import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {randomUUID,randomBytes,createHash} from 'node:crypto';
import {mkdtemp,readFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');
if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test only');
const dir=await mkdtemp(join(tmpdir(),'platform-admin-'));
await build({entryPoints:['cloudflare/workers/src/auth.ts'],bundle:true,platform:'node',format:'cjs',outfile:join(dir,'auth.cjs')});
await build({entryPoints:['cloudflare/workers/src/gateway.ts'],bundle:true,platform:'node',format:'cjs',outfile:join(dir,'gateway.cjs')});
const require=createRequire(import.meta.url),{auth}=require(join(dir,'auth.cjs')),gateway=require(join(dir,'gateway.cjs')).default;
const db=new Client({connectionString:url.href});await db.connect();
await db.query("ALTER TABLE tenants ADD COLUMN IF NOT EXISTS slug TEXT,ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW(),ADD COLUMN IF NOT EXISTS allowed_vpn_ranges TEXT DEFAULT '',ADD COLUMN IF NOT EXISTS cors_allowed_origins JSONB DEFAULT '[]',ADD COLUMN IF NOT EXISTS cors_allowed_methods JSONB DEFAULT '[]',ADD COLUMN IF NOT EXISTS cors_allowed_headers JSONB DEFAULT '[]'");
await db.query('CREATE UNIQUE INDEX IF NOT EXISTS test_tenant_slug_unique ON tenants(slug)');
await db.query(await readFile('packages/database/migrations/20261011_admin_control.sql','utf8'));
const tenants=[randomUUID(),randomUUID()],users=[randomUUID(),randomUUID()],tokens=[randomBytes(32).toString('base64url'),randomBytes(32).toString('base64url')];
const hash=s=>createHash('sha256').update(s).digest('hex');
const call=(path,method='GET',body,token=tokens[0],headers={})=>gateway.fetch(new Request('https://fixture/v1/auth/admin/control/'+path,{method,headers:{authorization:'Bearer '+token,...headers},...(body===undefined?{}:{body:JSON.stringify(body)})}),{AUTH:{fetch:r=>auth(r,{SERVICE_NAME:'auth',DB_URL:url.href},new URL(r.url).pathname,{})}});
let checks=0;
const mutation=async(path,method,body)=>{
 // Isolated fixtures only: avoid the normal shared 10-attempt management limit.
 await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=$1',[hash('manageAccount:'+users[0])]);
 return call(path,method,body);
};
try{
 for(let i=0;i<2;i++){
  await db.query("INSERT INTO tenants(id,name,slug,status) VALUES($1,'Platform QA',$2,'active')",[tenants[i],'qa-'+tenants[i]]);
  await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,$3,$4,'unused','active')",[users[i],users[i]+'@example.invalid',i?'client':'admin',tenants[i]]);
  await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),users[i]]);
 }
 assert.equal((await call('monitor', 'GET',undefined,'invalid')).status,401);checks++;
 for(const path of ['monitor','tenants','accounts?tenantId='+tenants[0],'masters?category=services','audit']){assert.equal((await call(path,'GET',undefined,tokens[1])).status,403);checks++;}
 assert.equal((await call('monitor','GET',undefined,tokens[0],{'x-tenant-id':tenants[1]})).status,403);checks++;
 const monitor=await(await call('monitor')).json();assert.equal(monitor.categories.length,16);assert(!monitor.assignableRoles.includes('admin'));checks++;
 const listed=await(await call('tenants')).json();assert(listed.items.some(t=>t.id===tenants[1]));checks++;
 const slug='created-'+randomUUID();const created=await mutation('tenants','POST',{name:'Created tenant',slug});assert.equal(created.status,201);const tenant=(await created.json()).tenant;tenants.push(tenant.id);checks++;
 assert.equal((await mutation('tenants','POST',{name:'Duplicate',slug})).status,409);checks++;
 assert.equal((await mutation('accounts','POST',{tenantId:tenant.id,email:randomUUID()+'@example.invalid',role:'admin',password:'initial-password-1234'})).status,400);checks++;
 const email=randomUUID()+'@example.invalid';const account=await mutation('accounts','POST',{tenantId:tenant.id,email,role:'client',password:'initial-password-1234'});assert.equal(account.status,201);const accountId=(await account.json()).user.id;users.push(accountId);checks++;
 const stored=(await db.query('SELECT tenant_id,password_hash FROM users WHERE id=$1',[accountId])).rows[0];assert.equal(stored.tenant_id,tenant.id);assert(stored.password_hash.startsWith('$2'));checks++;
 const accounts=await(await call('accounts?tenantId='+tenant.id)).json();assert.equal(accounts.tenantId,tenant.id);assert(accounts.items.some(u=>u.id===accountId));assert(!JSON.stringify(accounts).includes('password'));checks++;
 const labels={en:'Care',es:'Cuidado',fr:'Soins'};const code='qa-'+users[0];let record;
 for(const category of monitor.categories){const response=await mutation('masters','POST',{tenantId:null,category,code,labels,status:'active'});assert.equal(response.status,201);if(category==='services')record=(await response.json()).record;checks++;}
 const scoped=await mutation('masters','POST',{tenantId:tenant.id,category:'services',code,labels,status:'active'});assert.equal(scoped.status,201);checks++;
 assert.equal((await mutation('masters','POST',{tenantId:null,category:'services',code,labels,status:'active'})).status,409);checks++;
 assert.equal((await mutation('masters','POST',{tenantId:null,category:'services',code:'invalid',labels:{en:'Only English'},status:'active'})).status,400);checks++;
 assert.equal((await mutation('masters/'+record.id,'PUT',{labels,status:'inactive',tenantId:tenant.id})).status,400);checks++;
 const edited=await mutation('masters/'+record.id,'PUT',{labels:{...labels,fr:'Soins modifiés'},status:'inactive'});assert.equal(edited.status,200);assert.equal((await edited.json()).record.status,'inactive');checks++;
 const global=await(await call('masters?category=services')).json(),local=await(await call('masters?category=services&tenantId='+tenant.id)).json();assert(global.items.every(r=>r.tenantId===null));assert(local.items.every(r=>r.tenantId===tenant.id));checks++;
 for(const path of ['tenants?offset=-1','tenants?offset=0&offset=1','masters?category=unknown','accounts?tenantId=bad','monitor?tenantId='+tenant.id])assert.equal((await call(path)).status,400);checks++;
 const history=await(await call('audit')).json();assert(history.items.some(e=>e.action==='master_updated'));assert(!JSON.stringify(history).includes('password'));checks++;
 const snapshot=await(await call('monitor')).json();assert(snapshot.mastersTotal>=17);assert(snapshot.mastersActive<snapshot.mastersTotal);checks++;
 console.log(`PASS: ${checks} platform Admin Gateway/PostgreSQL checks`);
}finally{
 await db.query('DELETE FROM admin_master_records WHERE code=$1',['qa-'+users[0]]);
 await db.query('DELETE FROM admin_control_audit WHERE actor_user_id=$1',[users[0]]);
 await db.query('DELETE FROM auth_account_audit WHERE target_user_id=ANY($1::uuid[])',[users]);
 await db.query('DELETE FROM auth_sessions WHERE user_id=ANY($1::uuid[])',[users]);
 await db.query('DELETE FROM users WHERE id=ANY($1::uuid[])',[users]);
 await db.query('DELETE FROM tenants WHERE id=ANY($1::uuid[])',[tenants]);
 await db.end();await rm(dir,{recursive:true,force:true});
}
