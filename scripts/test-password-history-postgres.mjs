import {Client} from 'pg';import {build} from 'esbuild';import assert from 'node:assert/strict';import {randomUUID,createHash} from 'node:crypto';import {mkdtemp,readFile,rm} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const record=JSON.parse(await readFile('cloudflare/workers/src/self-records-registry.json','utf8')).find(r=>r.listBatch===50),dir=await mkdtemp(join(tmpdir(),'password-history-pg-'));
await build({entryPoints:['cloudflare/workers/src/self-records.ts'],outfile:join(dir,'self.cjs'),bundle:true,platform:'node',format:'cjs'});const {selfRecords}=createRequire(import.meta.url)(join(dir,'self.cjs'));
const db=new Client({connectionString:url.href});await db.connect();const users=[randomUUID(),randomUUID(),randomUUID()],tenants=[randomUUID(),randomUUID()],tokens=['p'.repeat(43),'q'.repeat(43),'r'.repeat(43)],events=Array.from({length:5},()=>randomUUID()),hash=s=>createHash('sha256').update(s).digest('hex');let checks=0;
const call=(path=record.path,query='',token=tokens[0],headers={})=>selfRecords(new Request('https://fixture'+path+query,{headers:{authorization:'Bearer '+token,...headers}}),{DB_URL:url.href,SERVICE_NAME:'auth'},path,{});
try{
 // The lifecycle suite installs the actual audit migration for each identity type.
 assert.equal((await db.query("SELECT to_regclass('auth_password_audit') IS NOT NULL AS present")).rows[0].present,true);
 for(let i=0;i<3;i++){await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'patient',$3,'unused','active')",[users[i],users[i]+'@example.invalid',tenants[i===2?1:0]]);await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),users[i]]);}
 for(let i=0;i<5;i++)await db.query("INSERT INTO auth_password_audit(id,user_id,action,created_at) VALUES($1,$2,'password_changed',$3)",[events[i],users[i<3?0:i===3?1:2],'2026-01-0'+(i+1)+'T12:00:00Z']);
 const response=await call(record.path,'?limit=1');assert.equal(response.status,200);assert.equal(response.headers.get('cache-control'),'no-store');const list=await response.json();assert.equal(list.pagination.total,3);assert.equal(list.events[0].id,events[2]);assert.equal(list.events[0].action,'password_changed');assert.deepEqual(Object.keys(list.events[0]),record.fields);checks++;
 const page=await (await call(record.path,'?limit=1&offset=1')).json();assert.equal(page.events[0].id,events[1]);assert.equal(page.pagination.hasMore,true);checks++;
 const detail=await (await call(record.path+'/'+events[0])).json();assert.equal(detail.event.id,events[0]);assert.equal(detail.event.created_at,'2026-01-01T12:00:00.000Z');checks++;
 for(const id of events.slice(3))assert.equal((await call(record.path+'/'+id)).status,404);checks++;
 for(let i=1;i<3;i++){const own=await (await call(record.path,'',tokens[i])).json();assert.equal(own.pagination.total,1);assert.equal(own.events[0].id,events[i+2]);}checks++;
 assert.equal((await call(record.path,'',tokens[0],{'x-tenant-id':tenants[1]})).status,403);checks++;
 await db.query('DELETE FROM auth_password_audit WHERE id=ANY($1::uuid[])',[events.slice(0,3)]);const empty=await (await call()).json();assert.deepEqual(empty.events,[]);assert.equal(empty.pagination.total,0);assert.equal((await call(record.path+'/'+events[0])).status,404);checks++;
 await db.query("UPDATE auth_sessions SET expires_at=NOW()-INTERVAL '1 second' WHERE user_id=$1",[users[0]]);assert.equal((await call()).status,401);checks++;
 await db.query("UPDATE users SET status='inactive' WHERE id=$1",[users[1]]);assert.equal((await call(record.path,'',tokens[1])).status,401);checks++;
 console.log(`Password history batch 50 passed ${checks} PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} auth identities).`);
}finally{await db.query('DELETE FROM auth_password_audit WHERE id=ANY($1::uuid[])',[events]);await db.query('DELETE FROM auth_sessions WHERE user_id::text=ANY($1)',[users]);await db.query('DELETE FROM users WHERE id::text=ANY($1)',[users]);await db.end();await rm(dir,{recursive:true,force:true});}
