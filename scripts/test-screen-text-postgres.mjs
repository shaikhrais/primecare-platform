import {test} from 'node:test';import assert from 'node:assert/strict';import pg from 'pg';
import {build} from 'esbuild';import {mkdtemp,readFile,writeFile} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {createRequire} from 'node:module';
const connection=process.env.SCREEN_TEXT_TEST_DATABASE_URL;if(!connection)throw Error('SCREEN_TEXT_TEST_DATABASE_URL required');
const require=createRequire(import.meta.url),dir=await mkdtemp(join(tmpdir(),'screen-text-pg-')),file=join(dir,'screen.cjs');
await build({entryPoints:['cloudflare/workers/src/screen-text.ts'],bundle:true,platform:'node',format:'cjs',outfile:file,external:['pg']});
await writeFile(file,(await readFile(file,'utf8')).replaceAll('require("pg")',`require(${JSON.stringify(require.resolve('pg'))})`));
const {screenText,screenTextDefaults}=require(file);
test('public fallback, protected writes/history, stale edits, concurrent edits and audited restore',async()=>{
 const db=new pg.Client({connectionString:connection});await db.connect();const schema='screen_text_'+Date.now();await db.query(`CREATE SCHEMA ${schema};SET search_path TO ${schema}`);
 try{
  await db.query('CREATE TABLE users(id text PRIMARY KEY,roles text,tenant_id text,status text);CREATE TABLE auth_sessions(user_id text REFERENCES users(id),token_hash text,expires_at timestamptz)');
  const migration=await readFile('packages/database/migrations/20261013_screen_text.sql','utf8');await db.query(migration);await db.query(migration);
  const otherActor=crypto.randomUUID(),actor=crypto.randomUUID(),admin='a'.repeat(43),other='b'.repeat(43),hash=async value=>Buffer.from(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(value))).toString('hex');
  await db.query("INSERT INTO users VALUES($1,'platform_admin','platform-root','active'),($2,'admin','tenant','active')",[actor,otherActor]);
  await db.query("INSERT INTO auth_sessions VALUES($1,$2,NOW()+INTERVAL '1 hour'),($4,$3,NOW()+INTERVAL '1 hour')",[actor,await hash(admin),await hash(other),otherActor]);
  const url=new URL(connection);url.searchParams.set('options',`-c search_path=${schema}`);const env={SERVICE_NAME:'governance',DB_URL:url.toString()};
  const request=async(path,method='GET',body,token)=>screenText(new Request('https://test'+path,{method,headers:{...(token?{authorization:'Bearer '+token}:{}),...(body?{'content-type':'application/json'}:{})},...(body?{body:JSON.stringify(body)}:{})}),env,path,{});
  const path='/screen-text/admin_reality_check';const fallback=await (await request(path)).json();assert.equal(fallback.version,0);assert.deepEqual(fallback.locales,screenTextDefaults.admin_reality_check);
  assert.equal((await request(path+'/history')).status,401);assert.equal((await request(path,'PUT',{version:0,locales:fallback.locales},other)).status,403);
  const locales=structuredClone(fallback.locales);locales.en.title='Live edited title';
  const results=await Promise.all([request(path,'PUT',{version:0,locales},admin),request(path,'PUT',{version:0,locales},admin)]);assert.deepEqual(results.map(r=>r.status).sort(),[200,409]);
  const saved=await (await request(path)).json();assert.equal(saved.version,1);assert.equal(saved.locales.en.title,'Live edited title');
  const history=await (await request(path+'/history','GET',undefined,admin)).json();assert.equal(history.history.length,1);assert.equal(history.history[0].actor_id,actor);assert.deepEqual(history.history[0].previous_locales,fallback.locales);
  const restored=await request(path,'PUT',{version:1,locales:history.history[0].previous_locales},admin);assert.equal(restored.status,200);assert.equal((await restored.json()).version,2);
  assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM screen_text_history')).rows[0].n,2);
  const bad=structuredClone(locales);bad.es.items='No parameter';assert.equal((await request(path,'PUT',{version:2,locales:bad},admin)).status,400);
  await db.query("UPDATE users SET status='inactive' WHERE id=$1",[actor]);assert.equal((await request(path,'PUT',{version:2,locales},admin)).status,401);
  assert.equal((await request('/screen-text/unregistered')).status,404);
 }finally{await db.query('SET search_path TO public');await db.query(`DROP SCHEMA ${schema} CASCADE`);await db.end();}
});
