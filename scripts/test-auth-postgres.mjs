// Runs only against a disposable local PostgreSQL auth_test database.
import { build } from 'esbuild';
import { Client } from 'pg';
import bcrypt from 'bcryptjs';
import assert from 'node:assert/strict';
import { mkdtemp, readFile } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { createRequire } from 'node:module';
import { randomUUID, createHash } from 'node:crypto';
import {checkAuthSchema} from './check-auth-schema.mjs';

const connectionString = process.env.AUTH_TEST_DATABASE_URL;
if (!connectionString) throw new Error('AUTH_TEST_DATABASE_URL is required; never use production credentials.');
const url = new URL(connectionString);
if (!['localhost', '127.0.0.1'].includes(url.hostname) || url.pathname !== '/auth_test') {
  throw new Error('Integration tests require loopback PostgreSQL database auth_test.');
}
const directory = await mkdtemp(join(tmpdir(), 'primecare-auth-test-'));
const outfile = join(directory, 'auth.cjs');
// A one-shot test hook schedules a real password/status update between credential
// verification and session insertion. Every SQL query still runs in PostgreSQL.
await build({entryPoints:['cloudflare/workers/src/auth.ts'],bundle:true,platform:'node',format:'cjs',outfile,
  plugins:[{name:'session-race-fixture',setup(builder){
    builder.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'session-race-fixture'}));
    builder.onLoad({filter:/.*/,namespace:'session-race-fixture'},()=>({loader:'js',resolveDir:process.cwd(),contents:`
      import pg from ${JSON.stringify(createRequire(import.meta.url).resolve('pg'))};
      export class Client extends pg.Client {
        async query(sql,values) {
          if(sql.startsWith('INSERT INTO auth_sessions') && globalThis.__authBeforeInsert) {
            const hook=globalThis.__authBeforeInsert;
            globalThis.__authBeforeInsert=null;
            await hook();
          }
          return super.query(sql,values);
        }
      }`}));
  }}]});
const {auth} = createRequire(import.meta.url)(outfile);
const db = new Client({connectionString});
await db.connect();
const email = `fixture-${randomUUID()}@example.invalid`;
const password = randomUUID();
const rateEmail=`rate-${randomUUID()}@example.invalid`;
const env = {DB_URL:connectionString,SERVICE_NAME:'auth'};
let userId;
let createdId;
let passed = 0;
const call = (path, method='GET', body, token) => auth(new Request('https://auth.test'+path, {
  method, headers:{'content-type':'application/json',...(token?{authorization:'Bearer '+token}:{})},
  ...(body===undefined?{}:{body:JSON.stringify(body)}),
}), env, path, {});
try {
  const textIds=process.env.AUTH_TEST_ID_TYPE==='text';
  if(textIds) await db.query("CREATE TABLE IF NOT EXISTS users(id TEXT PRIMARY KEY,email TEXT UNIQUE NOT NULL,roles TEXT NOT NULL,password_hash TEXT,status TEXT NOT NULL DEFAULT 'active')");
  else await db.query(await readFile('services/auth_api/dev_schema.sql','utf8'));
  await db.query('ALTER TABLE users ADD COLUMN IF NOT EXISTS tenant_id '+(textIds?'TEXT':'UUID'));
  await db.query('ALTER TABLE users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP NOT NULL DEFAULT NOW()');
  await db.query(await readFile('packages/database/migrations/20260925_auth_identity_compatibility.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260926_auth_sessions.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260928_auth_account_audit.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260928_auth_rate_limits.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260928_auth_management_audit.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260928_auth_password_audit.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260928_auth_bootstrap_audit.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20261003_auth_password_resets.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20261003_maintenance_configuration.sql','utf8'));
  assert.deepEqual(await checkAuthSchema(connectionString),[]); passed++;
  userId = (await db.query('INSERT INTO users(email,roles,password_hash,status,id) VALUES($1,$2,$3,$4,$5) RETURNING id',
    [email,'fixture-role',await bcrypt.hash(password,12),'active',textIds?'fixture_'+randomUUID():randomUUID()])).rows[0].id;
  const login = await call('/login','POST',{email,password});
  assert.equal(login.status,200); const {token}=await login.json(); passed++;
  const stored = await db.query('SELECT token_hash FROM auth_sessions WHERE user_id=$1',[userId]);
  assert.equal(stored.rowCount,1); assert.notEqual(stored.rows[0].token_hash,token); passed++;
  const identity = await call('/me','GET',undefined,token);
  assert.equal(identity.status,200); assert.equal((await identity.json()).userId,userId); passed++;
  assert.equal((await call('/login','POST',{email,password:'invalid'})).status,401); passed++;
  await db.query("UPDATE auth_sessions SET expires_at=NOW()-INTERVAL '1 minute' WHERE user_id=$1",[userId]);
  assert.equal((await call('/me','GET',undefined,token)).status,401); passed++;
  const second = await (await call('/login','POST',{email,password})).json();
  assert.equal((await call('/logout','POST',{},second.token)).status,200);
  assert.equal((await call('/me','GET',undefined,second.token)).status,401); passed++;
  const third = await (await call('/login','POST',{email,password})).json();
  await db.query("UPDATE users SET status='inactive' WHERE id=$1",[userId]);
  assert.equal((await call('/me','GET',undefined,third.token)).status,401);
  assert.equal((await call('/login','POST',{email,password})).status,401); passed++;
  const tenantId=randomUUID();
  await db.query("UPDATE users SET status='active',roles='ceo',tenant_id=$1 WHERE id=$2",[tenantId,userId]);
  const admin=await (await call('/login','POST',{email,password})).json();
  const account={email:`new-${randomUUID()}@example.invalid`,password:randomUUID(),role:'rmt'};
  const registered=await call('/register','POST',account,admin.token);
  assert.equal(registered.status,201);createdId=(await registered.json()).user.id;passed++;
  const persisted=(await db.query('SELECT tenant_id,roles,password_hash FROM users WHERE id=$1',[createdId])).rows[0];
  assert.equal(persisted.tenant_id,tenantId);assert.equal(persisted.roles,'rmt');
  assert.ok(await bcrypt.compare(account.password,persisted.password_hash));passed++;
  assert.equal((await db.query('SELECT id FROM auth_account_audit WHERE actor_user_id=$1 AND target_user_id=$2',[userId,createdId])).rowCount,1);passed++;
  assert.equal((await call('/register','POST',account,admin.token)).status,409);passed++;
  const staff=await (await call('/login','POST',{email:account.email,password:account.password})).json();
  assert.equal((await call('/register','POST',{...account,email:'forbidden@example.invalid'},staff.token)).status,403);passed++;
  const cross=new Request('https://auth.test/register',{method:'POST',headers:{authorization:'Bearer '+admin.token,'content-type':'application/json','x-tenant-id':randomUUID()},body:JSON.stringify({...account,email:'cross@example.invalid'})});
  assert.equal((await auth(cross,env,'/register',{})).status,403);passed++;
  assert.equal((await call('/admin/users','POST',{id:createdId,role:'rmt',status:'inactive'},admin.token)).status,200);
  assert.equal((await call('/me','GET',undefined,staff.token)).status,401);passed++;
  assert.equal((await db.query('SELECT id FROM auth_management_audit WHERE target_user_id=$1',[createdId])).rowCount,1);passed++;
  const concurrent=await Promise.all(Array.from({length:12},()=>call('/login','POST',{email:rateEmail,password:'not-a-real-password'})));
  assert.equal(concurrent.filter(r=>r.status===401).length,10);
  assert.equal(concurrent.filter(r=>r.status===429).length,2);passed++;
  const rateHash=createHash('sha256').update('login:'+rateEmail).digest('hex');
  await db.query("UPDATE auth_rate_limits SET reset_at=NOW()-INTERVAL '1 second' WHERE subject_hash=$1",[rateHash]);
  assert.equal((await call('/login','POST',{email:rateEmail,password:'not-a-real-password'})).status,401);passed++;
  const changedPassword=randomUUID();
  assert.equal((await call('/change-password','POST',{currentPassword:password,newPassword:changedPassword},admin.token)).status,200);passed++;
  assert.equal((await call('/me','GET',undefined,admin.token)).status,401);
  assert.equal((await call('/login','POST',{email,password})).status,401);
  const latestLogin=await call('/login','POST',{email,password:changedPassword});
  assert.equal(latestLogin.status,200);passed++;
  const latestToken=(await latestLogin.json()).token;
  const loginHash=createHash('sha256').update('login:'+email).digest('hex');
  await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=$1',[loginHash]);
  const racePassword=randomUUID();
  globalThis.__authBeforeInsert=async()=>{
    assert.equal((await call('/change-password','POST',{
      currentPassword:changedPassword,newPassword:racePassword,
    },latestToken)).status,200);
  };
  const staleLogin=await call('/login','POST',{email,password:changedPassword});
  assert.equal(staleLogin.status,401);
  assert.equal(staleLogin.headers.get('set-cookie'),null);
  assert.equal((await db.query('SELECT token_hash FROM auth_sessions WHERE user_id=$1',[userId])).rowCount,0);passed++;
  assert.equal((await call('/login','POST',{email,password:racePassword})).status,200);passed++;
  globalThis.__authBeforeInsert=async()=>{
    await db.query('BEGIN');
    await db.query("UPDATE users SET status='inactive' WHERE id=$1",[userId]);
    await db.query('DELETE FROM auth_sessions WHERE user_id=$1',[userId]);
    await db.query('COMMIT');
  };
  assert.equal((await call('/login','POST',{email,password:racePassword})).status,401);
  assert.equal((await db.query('SELECT token_hash FROM auth_sessions WHERE user_id=$1',[userId])).rowCount,0);passed++;
  // Restore the isolated fixture and prove rejected transactions cannot erase
  // throttling, including attempts made through different sessions.
  await db.query("UPDATE users SET status='active' WHERE id=$1",[userId]);
  const mutationHash=createHash('sha256').update('changePassword:'+userId).digest('hex');
  await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=$1',[mutationHash]);
  const a=(await (await call('/login','POST',{email,password:racePassword})).json()).token;
  const b=(await (await call('/login','POST',{email,password:racePassword})).json()).token;
  const attempts=await Promise.all(Array.from({length:7},(_,i)=>call('/change-password','POST',{
    currentPassword:'incorrect-fixture-password',newPassword:randomUUID(),
  },i%2?a:b)));
  assert.equal(attempts.filter(r=>r.status===401).length,5);
  assert.equal(attempts.filter(r=>r.status===429).length,2);passed++;
  await db.query("UPDATE auth_rate_limits SET reset_at=NOW()-INTERVAL '1 second' WHERE subject_hash=$1",[mutationHash]);
  assert.equal((await call('/change-password','POST',{currentPassword:'incorrect',newPassword:randomUUID()},a)).status,401);passed++;
  // Recovery verifies actual SQL expiry, concurrent consumption and session revocation.
  const code='A1B2C3D4E5F6';
  const resetHash=createHash('sha256').update(email+':'+code).digest('hex');
  const resetPasswordValue=randomUUID();
  await db.query("INSERT INTO auth_password_resets(token_hash,user_id,expires_at) VALUES($1,$2,NOW()-INTERVAL '1 second')",[resetHash,userId]);
  assert.equal((await call('/reset-password','POST',{email,code,newPassword:resetPasswordValue})).status,400);passed++;
  await db.query("UPDATE auth_password_resets SET expires_at=NOW()+INTERVAL '15 minutes' WHERE token_hash=$1",[resetHash]);
  const resets=await Promise.all([1,2].map(()=>call('/reset-password','POST',{email,code,newPassword:resetPasswordValue})));
  assert.equal(resets.filter(r=>r.status===200).length,1);
  assert.equal(resets.filter(r=>r.status===400).length,1);passed++;
  assert.equal((await call('/me','GET',undefined,a)).status,401);
  assert.equal((await call('/reset-password','POST',{email,code,newPassword:randomUUID()})).status,400);passed++;
  await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=$1',[loginHash]);
  assert.equal((await call('/login','POST',{email,password:racePassword})).status,401);
  assert.equal((await call('/login','POST',{email,password:resetPasswordValue})).status,200);passed++;
  assert.equal((await db.query('SELECT token_hash FROM auth_password_resets WHERE user_id=$1',[userId])).rowCount,0);passed++;
  // Live authorization, tenant binding, encrypted persistence and stale-save behavior.
  const maintenanceToken=(await (await call('/login','POST',{email,password:resetPasswordValue})).json()).token;
  assert.ok(maintenanceToken);
  env.CONFIG_ENCRYPTION_KEY='a'.repeat(64);
  await db.query("UPDATE users SET roles='rmt' WHERE id=$1",[userId]);
  assert.equal((await call('/maintenance/configuration','GET',undefined,maintenanceToken)).status,403);passed++;
  await db.query("UPDATE users SET roles='maintenance' WHERE id=$1",[userId]);
  assert.equal((await call('/maintenance/configuration','GET',undefined,maintenanceToken)).status,200);passed++;
  const settings={sender:'it@example.com',apiKey:'re_test_fixture_key',revision:0,templates:{}};
  assert.equal((await call('/maintenance/configuration','POST',settings,maintenanceToken)).status,200);passed++;
  assert.equal((await call('/maintenance/configuration','POST',settings,maintenanceToken)).status,409);passed++;
  const visible=await (await call('/maintenance/configuration','GET',undefined,maintenanceToken)).json();
  assert.equal(visible.keyConfigured,true);assert.equal(visible.revision,1);assert.ok(!JSON.stringify(visible).includes(settings.apiKey));passed++;
  const stored=(await db.query('SELECT api_key_ciphertext FROM tenant_mail_configuration WHERE tenant_id=$1',[String(tenantId)])).rows[0];
  assert.ok(stored.api_key_ciphertext);assert.ok(!stored.api_key_ciphertext.includes(settings.apiKey));passed++;
  await db.query('DELETE FROM tenant_mail_configuration WHERE tenant_id=$1',[String(tenantId)]);
  await db.query('DELETE FROM tenant_configuration_audit WHERE tenant_id=$1',[String(tenantId)]);
  console.log(JSON.stringify({passed, database:'isolated PostgreSQL', productionVerified:false}));
} finally {
  globalThis.__authBeforeInsert=null;
  await db.query('ROLLBACK');
  // Remove only the uniquely identified synthetic fixture; sessions cascade.
  if(userId) await db.query('DELETE FROM auth_account_audit WHERE actor_user_id=$1',[userId]);
  if(userId) await db.query('DELETE FROM auth_management_audit WHERE actor_user_id=$1',[userId]);
  if(userId) await db.query('DELETE FROM auth_password_audit WHERE user_id=$1',[userId]);
  if(createdId) await db.query('DELETE FROM users WHERE id=$1',[createdId]);
  if(userId) await db.query('DELETE FROM users WHERE id=$1 AND email=$2',[userId,email]);
  for(const id of [userId,createdId].filter(Boolean)) for(const operation of ['changePassword','createAccount','manageAccount'])
    await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=$1',[createHash('sha256').update(operation+':'+id).digest('hex')]);
  await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=$1',[createHash('sha256').update('login:'+rateEmail).digest('hex')]);
  await db.end();
}
