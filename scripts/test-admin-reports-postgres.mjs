import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {Client} from 'pg';
import {readFile,mkdtemp} from 'node:fs/promises';
import {join} from 'node:path';
import {tmpdir} from 'node:os';
import {createRequire} from 'node:module';
const connection=process.env.REPORT_TEST_DATABASE_URL;
if(!connection)throw Error('REPORT_TEST_DATABASE_URL required; integration tests must not silently skip');
const setup=new Client({connectionString:connection});await setup.connect();
const schema='report_test_'+Date.now();await setup.query(`CREATE SCHEMA ${schema}`);
const u=new URL(connection);u.searchParams.set('options',`-c search_path=${schema}`);const scoped=u.toString();
await setup.query(`SET search_path TO ${schema}`);
await setup.query('CREATE TABLE users(id text PRIMARY KEY,roles text,tenant_id text,status text); CREATE TABLE auth_sessions(user_id text,token_hash text,expires_at timestamptz); CREATE TABLE tenant_mail_configuration(tenant_id text,sender text,api_key_ciphertext text,templates jsonb)');
await setup.query(await readFile('cloudflare/workers/contracts/admin-reports.sql','utf8'));
const token='a'.repeat(43);const digest=Buffer.from(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(token))).toString('hex');
await setup.query("INSERT INTO users VALUES('actor','admin','tenant-a','active'); INSERT INTO users VALUES('other','admin','tenant-b','active')");
await setup.query("INSERT INTO auth_sessions VALUES('actor',$1,NOW()+INTERVAL '1 hour')",[digest]);
const dir=await mkdtemp(join(tmpdir(),'report-pg-'));
await build({entryPoints:['cloudflare/workers/src/reporting.ts'],bundle:true,platform:'node',format:'cjs',outfile:join(dir,'reporting.cjs'),external:['pg','bcryptjs']});
// Resolve real database packages from this repository's dependency directory.
const module=await readFile(join(dir,'reporting.cjs'),'utf8');await import('node:fs/promises').then(fs=>fs.writeFile(join(dir,'reporting.cjs'),module.replace('require("pg")',`require(${JSON.stringify(join(process.cwd(),'node_modules/pg'))})`).replace('require("bcryptjs")',`require(${JSON.stringify(join(process.cwd(),'node_modules/bcryptjs'))})`)));
const {reporting}=createRequire(import.meta.url)(join(dir,'reporting.cjs'));
let sends=0;
const env={SERVICE_NAME:'governance',DB_URL:scoped,EMAIL_FROM:'reports@example.com',EMAIL:{send:async()=>{sends++;return {messageId:'accepted-'+sends};}}};
const call=(key,body={to:'recipient@example.net',confirmed:true},tenant='tenant-a')=>reporting(new Request('https://test/reports/page_readiness/email',{method:'POST',headers:{authorization:'Bearer '+token,'x-tenant-id':tenant,'idempotency-key':key,'content-type':'application/json'},body:JSON.stringify(body)}),env,'/reports/page_readiness/email',{});
test('real PostgreSQL serializes concurrent duplicate requests and persists tenant audit',async()=>{
 try {
  const responses=await Promise.all(Array.from({length:6},()=>call('concurrent-key-123456789')));
  assert.equal(sends,1);assert.ok(responses.every(r=>[200,202,409].includes(r.status)));
  assert.equal((await setup.query('SELECT COUNT(*)::int AS count FROM report_delivery')).rows[0].count,1);
  const row=(await setup.query('SELECT * FROM report_delivery')).rows[0];assert.equal(row.tenant_id,'tenant-a');assert.equal(row.state,'accepted');
  assert.equal((await call('concurrent-key-123456789',{to:'different@example.net',confirmed:true})).status,409);
  assert.equal((await call('cross-tenant-key-12345',undefined,'tenant-b')).status,403);assert.equal(sends,1);
  const report=await reporting(new Request('https://test/reports/page_readiness',{headers:{authorization:'Bearer '+token}}),env,'/reports/page_readiness',{});assert.equal(report.status,200);
  const audit=(await setup.query('SELECT * FROM report_audit')).rows;assert.equal(audit.length,1);assert.equal(audit[0].tenant_id,'tenant-a');
  env.EMAIL.send=async()=>{sends++;throw Error('timeout after acceptance');};
  assert.equal((await call('ambiguous-key-123456789')).status,503);assert.equal((await call('ambiguous-key-123456789')).status,409);assert.equal(sends,2);
  await setup.query("UPDATE report_delivery SET state='sending' WHERE idempotency_key='ambiguous-key-123456789'");
  assert.equal((await call('ambiguous-key-123456789')).status,409);assert.equal(sends,2);
  await setup.query("INSERT INTO report_delivery(actor_id,tenant_id,idempotency_key,request_hash,report_id,recipient,state) SELECT 'actor','tenant-a','quota-'||n,'h','page_readiness','r@example.net','unknown' FROM generate_series(1,8) n");
  assert.equal((await call('quota-over-limit-123456789')).status,429);assert.equal(sends,2);
 } finally {await setup.query('SET search_path TO public');await setup.query(`DROP SCHEMA ${schema} CASCADE`);await setup.end();}
});
