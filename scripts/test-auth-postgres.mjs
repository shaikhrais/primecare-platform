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
await build({entryPoints:['cloudflare/workers/src/auth.ts'],bundle:true,platform:'node',format:'cjs',outfile});
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
  await db.query(await readFile('packages/database/migrations/20260925_auth_identity_compatibility.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260926_auth_sessions.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260928_auth_account_audit.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260928_auth_rate_limits.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260928_auth_management_audit.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260928_auth_password_audit.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260928_auth_bootstrap_audit.sql','utf8'));
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
  assert.equal((await call('/login','POST',{email,password:changedPassword})).status,200);passed++;
  console.log(JSON.stringify({passed, database:'isolated PostgreSQL', productionVerified:false}));
} finally {
  // Remove only the uniquely identified synthetic fixture; sessions cascade.
  if(userId) await db.query('DELETE FROM auth_account_audit WHERE actor_user_id=$1',[userId]);
  if(userId) await db.query('DELETE FROM auth_management_audit WHERE actor_user_id=$1',[userId]);
  if(userId) await db.query('DELETE FROM auth_password_audit WHERE user_id=$1',[userId]);
  if(createdId) await db.query('DELETE FROM users WHERE id=$1',[createdId]);
  if(userId) await db.query('DELETE FROM users WHERE id=$1 AND email=$2',[userId,email]);
  await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=$1',[createHash('sha256').update('login:'+rateEmail).digest('hex')]);
  await db.end();
}
