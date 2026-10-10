import {Client} from 'pg';
import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';
import {mkdtemp} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');
if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test only');
const dir=await mkdtemp(join(tmpdir(),'admin-workspace-'));
await build({entryPoints:['cloudflare/workers/src/auth.ts'],bundle:true,platform:'node',format:'cjs',outfile:join(dir,'auth.cjs')});
await build({entryPoints:['cloudflare/workers/src/gateway.ts'],bundle:true,platform:'node',format:'cjs',outfile:join(dir,'gateway.cjs')});
const require=createRequire(import.meta.url),{auth}=require(join(dir,'auth.cjs')),gateway=require(join(dir,'gateway.cjs')).default;
const db=new Client({connectionString:url.href});await db.connect();
await db.query('CREATE TABLE IF NOT EXISTS tenants(id UUID PRIMARY KEY,name TEXT NOT NULL,status TEXT NOT NULL)');
const ids=[randomUUID(),randomUUID(),randomUUID()],tenants=[randomUUID(),randomUUID()],tokens=['j'.repeat(43),'k'.repeat(43),'l'.repeat(43)];
const hash=s=>createHash('sha256').update(s).digest('hex');
const call=(path,method='GET',body,token=tokens[0],headers={})=>gateway.fetch(new Request('https://fixture/v1/auth/admin/workspace'+path,{method,headers:{authorization:'Bearer '+token,...headers},...(body===undefined?{}:{body:JSON.stringify(body)})}),{AUTH:{fetch:r=>auth(r,{SERVICE_NAME:'auth',DB_URL:url.href},new URL(r.url).pathname,{})}});
let createdId;let checks=0;
try {
 for(const tenant of tenants)await db.query("INSERT INTO tenants(id,name,status) VALUES($1,'Admin QA organization','active')",[tenant]);
 for(let i=0;i<3;i++){
  await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,$3,$4,'unused','active')",[ids[i],`admin-${ids[i]}@example.invalid`,i===1?'client':'admin',i===2?tenants[1]:tenants[0]]);
  await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),ids[i]]);
 }
 const workspace=await call('');assert.equal(workspace.status,200);const data=await workspace.json();assert.equal(data.total,2);assert.equal(data.users.length,2);assert.equal(data.organization.id,tenants[0]);assert(!data.assignableRoles.includes('admin'));assert(data.users.every(u=>!('password_hash' in u)));checks++;
 assert.equal((await call('','GET',undefined,tokens[1])).status,403);checks++;
 assert.equal((await call('','GET',undefined,'invalid')).status,401);checks++;
 assert.equal((await call('','GET',undefined,tokens[0],{'x-tenant-id':tenants[1]})).status,403);checks++;
 assert.equal((await call('?offset=-1')).status,400);assert.equal((await call('?offset=0&offset=1')).status,400);assert.equal((await call('?tenant_id='+tenants[1])).status,400);checks++;
 const input={email:`created-${randomUUID()}@example.invalid`,role:'rmt',password:'initial-password-1234'};
 assert.equal((await call('/users','POST',{...input,role:'admin'})).status,400);checks++;
 assert.equal((await call('/users','POST',{...input,tenantId:tenants[1]})).status,400);checks++;
 const created=await call('/users','POST',input);assert.equal(created.status,201);createdId=(await created.json()).user.id;checks++;
 assert.equal((await call('/users','POST',input)).status,409);checks++;
 assert.equal((await db.query('SELECT count(*)::int AS n FROM auth_account_audit WHERE target_user_id=$1',[createdId])).rows[0].n,1);checks++;
 const token='m'.repeat(43);await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(token),createdId]);
 const update={email:input.email,role:'rn',status:'inactive'};
 assert.equal((await call('/users/'+createdId,'PUT',update)).status,200);checks++;
 assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM auth_sessions WHERE user_id=$1',[createdId])).rows[0].n,0);checks++;
 const row=(await db.query('SELECT roles,status FROM users WHERE id=$1',[createdId])).rows[0];assert.equal(row.roles,'rn');assert.equal(row.status,'inactive');checks++;
 assert.equal((await call('/users/'+createdId,'PUT',update,tokens[2])).status,404);checks++;
 assert.equal((await call('/users/'+ids[0],'PUT',update)).status,403);assert.equal((await call('/users/'+ids[2],'PUT',update)).status,404);checks++;
 const event=(await db.query('SELECT previous_state,new_state FROM auth_management_audit WHERE target_user_id=$1',[createdId])).rows[0];assert.equal(event.previous_state.role,'rmt');assert.equal(event.new_state.role,'rn');checks++;
 const empty=await (await call('?offset=25')).json();assert.equal(empty.users.length,0);assert.equal(empty.total,3);checks++;
 assert.equal((await call('/users','DELETE')).status,405);checks++;
 // Audit failure must roll back both account changes and session revocation.
 await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(token),createdId]);
 await db.query("CREATE FUNCTION admin_qa_reject_audit() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'fixture audit failure'; END $$");
 await db.query('CREATE TRIGGER admin_qa_reject_audit BEFORE INSERT ON auth_management_audit FOR EACH ROW EXECUTE FUNCTION admin_qa_reject_audit()');
 assert.equal((await call('/users/'+createdId,'PUT',{...update,status:'active'})).status,503);
 assert.equal((await db.query('SELECT status FROM users WHERE id=$1',[createdId])).rows[0].status,'inactive');
 assert.equal((await db.query('SELECT count(*)::int AS n FROM auth_sessions WHERE user_id=$1',[createdId])).rows[0].n,1);checks++;
 console.log(`PASS: ${checks} Admin workspace PostgreSQL/gateway checks`);
} finally {
 await db.query('DROP TRIGGER IF EXISTS admin_qa_reject_audit ON auth_management_audit');await db.query('DROP FUNCTION IF EXISTS admin_qa_reject_audit()');
 const owned=createdId?[...ids,createdId]:ids;
 await db.query('DELETE FROM auth_management_audit WHERE actor_user_id=ANY($1::uuid[]) OR target_user_id=ANY($1::uuid[])',[owned]);
 await db.query('DELETE FROM auth_account_audit WHERE actor_user_id=ANY($1::uuid[]) OR target_user_id=ANY($1::uuid[])',[owned]);
 await db.query('DELETE FROM auth_sessions WHERE user_id=ANY($1::uuid[])',[owned]);await db.query('DELETE FROM users WHERE id=ANY($1::uuid[])',[owned]);await db.query('DELETE FROM tenants WHERE id=ANY($1::uuid[])',[tenants]);await db.end();
}
