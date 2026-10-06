// Run after auth schema setup; restricted to a disposable loopback database.
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
const dir=await mkdtemp(join(tmpdir(),'account-admin-pg-'));
await build({entryPoints:['cloudflare/workers/src/auth.ts'],outfile:join(dir,'auth.cjs'),bundle:true,platform:'node',format:'cjs'});
const {auth}=createRequire(import.meta.url)(join(dir,'auth.cjs'));
const db=new Client({connectionString:url.href});await db.connect();
const ids=[randomUUID(),randomUUID(),randomUUID()],tenants=[randomUUID(),randomUUID()],tokens=['e'.repeat(43),'f'.repeat(43),'g'.repeat(43)];
const hash=s=>createHash('sha256').update(s).digest('hex');let checks=0,triggerInstalled=false;
const call=(path,method='GET',query='',token=tokens[0],body)=>auth(new Request('https://fixture'+path+query,{method,headers:{authorization:'Bearer '+token},...(body===undefined?{}:{body:JSON.stringify(body)})}),{SERVICE_NAME:'auth',DB_URL:url.href},path,{});
const sessions='/admin/users/'+ids[1]+'/sessions';
try {
 for(let i=0;i<3;i++)await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,$3,$4,'fixture-unused-hash','active')",[ids[i],`admin-${ids[i]}@example.invalid`,i===1?'rmt':'ceo',i===2?tenants[1]:tenants[0]]);
 for(let i=0;i<3;i++)await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),ids[i]]);
 await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()-INTERVAL '1 hour')",[hash('h'.repeat(43)),ids[1]]);
 const detail=await (await call('/admin/users/'+ids[1])).json();assert.equal(detail.user.id,ids[1]);assert.equal(detail.user.canModify,true);assert.deepEqual(Object.keys(detail.user).sort(),['id','email','roles','status','updated_at','canModify'].sort());checks++;
 const self=await (await call('/admin/users/'+ids[0])).json();assert.equal(self.user.canModify,false);checks++;
 assert.equal((await call('/admin/users/'+ids[2])).status,404);assert.equal((await call('/admin/users/'+ids[0],'GET','',tokens[1])).status,403);checks++;
 await db.query("INSERT INTO auth_account_audit(actor_user_id,target_user_id,tenant_id,action) VALUES($1,$2,$3,'account_created'),($4,$4,$5,'account_created')",[ids[0],ids[1],tenants[0],ids[2],tenants[1]]);
 const creation=await (await call('/admin/users/creation-audit','GET','?userId='+ids[1]+'&limit=1')).json();assert.equal(creation.pagination.total,1);assert.equal(typeof creation.pagination.total,'number');assert.equal(creation.events[0].targetUserId,ids[1]);assert.equal(creation.events[0].action,'account_created');checks++;
 const crossCreation=await (await call('/admin/users/creation-audit','GET','?userId='+ids[2])).json();assert.equal(crossCreation.pagination.total,0);checks++;
 const emptyPage=await (await call('/admin/users/creation-audit','GET','?offset=1')).json();assert.equal(emptyPage.events.length,0);assert.equal(emptyPage.pagination.total,1);checks++;
 const active=await (await call(sessions)).json();assert.equal(active.pagination.total,1);assert.equal(typeof active.pagination.total,'number');assert.equal(active.sessions.length,1);assert.ok(!JSON.stringify(active).includes('token_hash'));checks++;
 const all=await (await call(sessions,'GET','?includeExpired=true')).json();assert.equal(all.pagination.total,2);checks++;
 assert.equal((await call('/admin/users/'+ids[2]+'/sessions')).status,404);assert.equal((await call('/admin/users/'+ids[2]+'/sessions','DELETE')).status,404);checks++;
 assert.equal((await call('/admin/users/'+ids[0]+'/sessions','DELETE')).status,403);checks++;
 assert.equal((await call('/admin/users/audit','GET','',tokens[1])).status,403);checks++;
 await db.query("INSERT INTO auth_management_audit(actor_user_id,target_user_id,tenant_id,previous_state,new_state) VALUES($1,$2,$3,$4,$5)",[ids[0],ids[1],tenants[0],JSON.stringify({role:'rmt',password:'never-return-this-secret'}),JSON.stringify({status:'active',token:'never-return-this-secret'})]);
 const history=await (await call('/admin/users/audit','GET','?userId='+ids[1])).json();assert.equal(history.pagination.total,1);assert.equal(typeof history.pagination.total,'number');assert.ok(!JSON.stringify(history).includes('never-return'));checks++;
 const foreign=await (await call('/admin/users/audit','GET','?userId='+ids[2])).json();assert.equal(foreign.pagination.total,0);checks++;
 // A corrupt RETURNING row must roll back before success, audit or revocation.
 const badEmail='projection-'+randomUUID()+'@example.invalid';
 await db.query(`CREATE FUNCTION test_corrupt_auth_return() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN IF (TG_OP='INSERT' AND NEW.email='${badEmail}') OR (TG_OP='UPDATE' AND NEW.id::text='${ids[1]}' AND NEW.status='inactive') THEN NEW.roles:='ceo'; END IF; RETURN NEW; END $$`);
 await db.query('CREATE TRIGGER test_corrupt_auth_return BEFORE INSERT OR UPDATE ON users FOR EACH ROW EXECUTE FUNCTION test_corrupt_auth_return()');
 try {
  const beforeCreation=(await db.query('SELECT COUNT(*)::int AS count FROM auth_account_audit WHERE actor_user_id=$1',[ids[0]])).rows[0].count;
  const badCreation=await call('/register','POST','',tokens[0],{email:badEmail,password:'fixture-created-password',role:'rmt'});
  assert.equal(badCreation.status,503);assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM users WHERE email=$1',[badEmail])).rows[0].count,0);
  assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_account_audit WHERE actor_user_id=$1',[ids[0]])).rows[0].count,beforeCreation);checks++;
  const beforeSessions=(await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[ids[1]])).rows[0].count;
  const beforeManagement=(await db.query('SELECT COUNT(*)::int AS count FROM auth_management_audit WHERE actor_user_id=$1',[ids[0]])).rows[0].count;
  const badUpdate=await call('/admin/users','POST','',tokens[0],{id:ids[1],role:'rmt',status:'inactive'});
  assert.equal(badUpdate.status,503);assert.deepEqual((await db.query('SELECT roles,status FROM users WHERE id=$1',[ids[1]])).rows[0],{roles:'rmt',status:'active'});
  assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[ids[1]])).rows[0].count,beforeSessions);
  assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_management_audit WHERE actor_user_id=$1',[ids[0]])).rows[0].count,beforeManagement);checks++;
 }finally {await db.query('DROP TRIGGER test_corrupt_auth_return ON users');await db.query('DROP FUNCTION test_corrupt_auth_return()');}
 // Deliberately fail the audit insert, using a fixture trigger in this disposable
 // database. Both deletion and audit must roll back before a success is returned.
 await db.query(`CREATE OR REPLACE FUNCTION test_admin_audit_failure() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN IF NEW.target_user_id::text='${ids[1]}' AND NEW.new_state->>'action'='sessions_revoked' THEN RAISE EXCEPTION 'fixture audit failure'; END IF; RETURN NEW; END $$`);
 await db.query('CREATE TRIGGER test_admin_audit_failure BEFORE INSERT ON auth_management_audit FOR EACH ROW EXECUTE FUNCTION test_admin_audit_failure()');triggerInstalled=true;
 assert.equal((await call(sessions,'DELETE')).status,503);assert.equal(Number((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[ids[1]])).rows[0].count),2);checks++;
 await db.query('DROP TRIGGER test_admin_audit_failure ON auth_management_audit');triggerInstalled=false;
 const revoked=await call(sessions,'DELETE');assert.equal(revoked.status,200);const revokedBody=await revoked.json();assert.equal(revokedBody.revokedSessions,2);assert.equal(typeof revokedBody.revokedSessions,'number');checks++;
 assert.equal((await call('/me','GET','',tokens[1])).status,401);assert.equal((await call('/me','GET','',tokens[2])).status,200);checks++;
 const audit=await (await call('/admin/users/audit','GET','?userId='+ids[1]+'&limit=100')).json();assert.ok(audit.events.some(e=>e.action==='sessions_revoked'&&e.previous.sessionCount===2&&e.current.sessionCount===0));checks++;
 const again=await (await call(sessions,'DELETE')).json();assert.equal(again.revokedSessions,0);checks++;
 // PostgreSQL supports infinity timestamps; they cannot satisfy JSON date-time contracts.
 for(const [table,column,key,path] of [
  ['users','updated_at','id','/admin/users'],
  ['users','updated_at','id','/admin/users/'+ids[1]],
  ['auth_sessions','created_at','user_id',sessions],
  ['auth_management_audit','created_at','target_user_id','/admin/users/audit'],
  ['auth_account_audit','created_at','target_user_id','/admin/users/creation-audit']
 ]) {
  if(table==='auth_sessions')await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash('h'.repeat(43)),ids[1]]);
  const original=(await db.query(`SELECT ${column} FROM ${table} WHERE ${key}::text=$1`,[ids[1]])).rows;
  assert.ok(original.length>0);
  await db.query(`UPDATE ${table} SET ${column}='infinity' WHERE ${key}::text=$1`,[ids[1]]);
  try {const invalid=await call(path);assert.equal(invalid.status,503);assert.equal(invalid.headers.get('cache-control'),'no-store');assert.ok(!(await invalid.text()).includes('Invalid account'));checks++;}
  finally {await db.query(`UPDATE ${table} SET ${column}=$2 WHERE ${key}::text=$1`,[ids[1],original[0][column]]);}
 }
 await db.query("UPDATE users SET status='inactive' WHERE id=$1",[ids[0]]);assert.equal((await call('/admin/users/audit')).status,401);checks++;
 console.log(`Account administration passed ${checks} real PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE||'uuid'} identities).`);
}finally {
 await db.query('DROP TRIGGER IF EXISTS test_corrupt_auth_return ON users');
 await db.query('DROP FUNCTION IF EXISTS test_corrupt_auth_return()');
 if(triggerInstalled)await db.query('DROP TRIGGER IF EXISTS test_admin_audit_failure ON auth_management_audit');
 await db.query('DROP FUNCTION IF EXISTS test_admin_audit_failure()');
 await db.query('DELETE FROM auth_account_audit WHERE target_user_id::text=ANY($1)',[ids]);
 await db.query('DELETE FROM auth_management_audit WHERE target_user_id::text=ANY($1)',[ids]);
 await db.query('DELETE FROM auth_sessions WHERE user_id::text=ANY($1)',[ids]);
 await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=ANY($1)',[ids.flatMap(id=>['manageAccount','createAccount'].map(op=>hash(op+':'+id)))]);
 await db.query('DELETE FROM users WHERE id::text=ANY($1)',[ids]);await db.end();
}
