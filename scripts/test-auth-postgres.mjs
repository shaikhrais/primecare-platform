// Runs only against a disposable local PostgreSQL auth_test database.
import { build } from 'esbuild';
import { Client } from 'pg';
import bcrypt from 'bcryptjs';
import assert from 'node:assert/strict';
import { mkdtemp, readFile } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { createRequire } from 'node:module';
import { randomUUID } from 'node:crypto';

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
const env = {DB_URL:connectionString,SERVICE_NAME:'auth'};
let userId;
let passed = 0;
const call = (path, method='GET', body, token) => auth(new Request('https://auth.test'+path, {
  method, headers:{'content-type':'application/json',...(token?{authorization:'Bearer '+token}:{})},
  ...(body===undefined?{}:{body:JSON.stringify(body)}),
}), env, path, {});
try {
  await db.query(await readFile('services/auth_api/dev_schema.sql','utf8'));
  await db.query(await readFile('packages/database/migrations/20260926_auth_sessions.sql','utf8'));
  userId = (await db.query('INSERT INTO users(email,roles,password_hash,status) VALUES($1,$2,$3,$4) RETURNING id',
    [email,'fixture-role',await bcrypt.hash(password,12),'active'])).rows[0].id;
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
  console.log(JSON.stringify({passed, database:'isolated PostgreSQL', productionVerified:false}));
} finally {
  // Remove only the uniquely identified synthetic fixture; sessions cascade.
  if(userId) await db.query('DELETE FROM users WHERE id=$1 AND email=$2',[userId,email]);
  await db.end();
}
