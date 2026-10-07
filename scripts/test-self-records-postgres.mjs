import {assertReadIdentityRejections} from './record-identity-postgres-fixtures.mjs';
import {assertOwnedPageBoundaries} from './owned-result-postgres-fixtures.mjs';
import {assertReadDateRejections} from './read-date-postgres-fixtures.mjs';
import {Client} from 'pg';import {build} from 'esbuild';import assert from 'node:assert/strict';import {randomUUID,createHash} from 'node:crypto';import {mkdtemp,readFile} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const registry=JSON.parse(await readFile('cloudflare/workers/src/self-records-registry.json','utf8')).filter(r=>r.listBatch<=30),dir=await mkdtemp(join(tmpdir(),'self-records-pg-'));await build({entryPoints:['cloudflare/workers/src/self-records.ts'],outfile:join(dir,'self.cjs'),bundle:true,platform:'node',format:'cjs'});const {selfRecords}=createRequire(import.meta.url)(join(dir,'self.cjs'));
const db=new Client({connectionString:url.href});await db.connect();const users=[randomUUID(),randomUUID()],tenants=[randomUUID(),randomUUID()],tokens=['s'.repeat(43),'t'.repeat(43)],hash=s=>createHash('sha256').update(s).digest('hex'),created=[];let checks=0;
const call=(path,query='',token=tokens[0],headers={})=>selfRecords(new Request('https://fixture'+path+query,{headers:{authorization:'Bearer '+token,...headers}}),{DB_URL:url.href,SERVICE_NAME:'auth'},path,{});
try{
 for(let i=0;i<2;i++){await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,$3,$4,'unused','active')",[users[i],users[i]+'@example.invalid',i?'psw':'ceo',tenants[0]]);await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),users[i]]);}
 for(const record of registry){
  const column=f=>{const t=record.types[f],base=Array.isArray(t)?t[0]:t;return f+' '+(record.dateFields.includes(f)?'TIMESTAMP':base==='integer'?'INTEGER':base==='boolean'?'BOOLEAN':'TEXT')+(Array.isArray(t)?'':' NOT NULL');};
  // Deliberately omit the singleton uniqueness constraint so ambiguity can be
  // tested as a fail-closed guard for legacy/malformed data, not a migration.
  await db.query('CREATE TABLE '+record.table+'('+record.fields.map(column).join(',')+',user_id TEXT NOT NULL,tenant_id TEXT'+(record.table==='daily_activities'?' NOT NULL':'')+(record.table==='app_notifications'?',link TEXT':'')+')');created.push(record.table);
  const ids=[];
  const insert=async(i,user,tenant)=>{const id=randomUUID();ids.push(id);const values=record.fields.map(f=>f==='id'?id:record.dateFields.includes(f)?'2026-01-0'+(i+1)+'T12:00:00Z':record.types[f]==='integer'?10:record.types[f]==='boolean'?i===2:f==='status'?(i===2?'COMPLETED':'PENDING'):'stored');values.push(user,tenant);const fields=[...record.fields,'user_id','tenant_id'];if(record.table==='app_notifications'){fields.push('link');values.push('private-navigation-link');}await db.query('INSERT INTO '+record.table+'('+fields.join(',')+') VALUES('+values.map((_,j)=>'$'+(j+1)).join(',')+')',values);return id;};
  if(record.singleton){
   await insert(0,users[0],tenants[0]);await insert(1,users[1],tenants[0]);await insert(2,users[0],tenants[1]);await insert(3,users[0],null);
   checks+=await assertReadIdentityRejections(db,()=>call(record.path),{table:record.table,id:ids[0],duplicate:!record.singleton});
   if(record.dateFields.length)checks+=await assertReadDateRejections(db,()=>call(record.path),{table:record.table,field:record.dateFields[0],id:ids[0]});
   const response=await call(record.path);assert.equal(response.status,200);const body=await response.json();assert.equal(body.profile.id,ids[0]);assert.equal(body.profile.care_coins,10);assert.deepEqual(Object.keys(body.profile),record.fields);checks++;
   assert.equal((await (await call(record.path,'',tokens[1])).json()).profile.id,ids[1]);checks++;
   const duplicate=await insert(4,users[0],tenants[0]);assert.equal((await call(record.path)).status,503);await db.query('DELETE FROM '+record.table+' WHERE id=$1',[duplicate]);checks++;
   await db.query('DELETE FROM '+record.table+' WHERE id=$1',[ids[0]]);assert.equal((await call(record.path)).status,404);checks++;
  }else{
   for(let i=0;i<3;i++)await insert(i,users[0],tenants[0]);await insert(3,users[1],tenants[0]);await insert(4,users[0],tenants[1]);if(record.table!=='daily_activities')await insert(5,users[0],null);
   checks+=await assertReadIdentityRejections(db,()=>call(record.path),{table:record.table,id:ids[0],duplicate:!record.singleton});
   if(record.dateFields.length)checks+=await assertReadDateRejections(db,()=>call(record.path),{table:record.table,field:record.dateFields[0],id:ids[0]});
   const response=await call(record.path,'?limit=1');assert.equal(response.status,200);const list=await response.json();assert.equal(list.pagination.total,3);assert.equal(typeof list.pagination.total,'number');assert.equal(list[record.collection][0].id,ids[2]);assert.deepEqual(Object.keys(list[record.collection][0]),record.fields);assert.ok(!JSON.stringify(list).includes('navigation-link'));checks++;
   const page=await (await call(record.path,'?limit=1&offset=1')).json();assert.equal(page[record.collection][0].id,ids[1]);assert.equal(page.pagination.hasMore,true);checks++;
   const detail=await (await call(record.path+'/'+ids[0])).json();assert.equal(detail[record.item].id,ids[0]);checks++;
   for(const id of ids.slice(3))assert.equal((await call(record.path+'/'+id)).status,404);checks++;
   const other=await (await call(record.path,'',tokens[1])).json();assert.equal(other.pagination.total,1);assert.equal(other[record.collection][0].id,ids[3]);checks++;
   const summary=await (await call(record.path+'/summary')).json(),key=record.summaryField,expected=key==='is_read'?[{is_read:false,count:2},{is_read:true,count:1}]:[{status:'COMPLETED',count:1},{status:'PENDING',count:2}];assert.deepEqual(summary.groups,expected);assert.equal(summary.pagination.total,2);assert.equal(typeof summary.pagination.total,'number');checks++;
   const summaryPage=await (await call(record.path+'/summary','?limit=1&offset=1')).json();assert.deepEqual(summaryPage.groups,[expected[1]]);assert.equal(summaryPage.pagination.hasMore,false);checks++;
   checks+=await assertOwnedPageBoundaries(call,record.path,record.collection);if(record.summaryField)checks+=await assertOwnedPageBoundaries(call,record.path+'/summary','groups');
  await db.query('DELETE FROM '+record.table+' WHERE id=ANY($1)',[ids.slice(0,3)]);const empty=await (await call(record.path)).json();assert.deepEqual(empty[record.collection],[]);assert.equal(empty.pagination.total,0);const emptySummary=await (await call(record.path+'/summary')).json();assert.deepEqual(emptySummary.groups,[]);assert.equal(emptySummary.pagination.total,0);checks++;
  }
 }
 assert.equal((await call(registry[0].path,'',tokens[0],{'x-tenant-id':tenants[1]})).status,403);checks++;
 await db.query("UPDATE auth_sessions SET expires_at=NOW()-INTERVAL '1 second' WHERE user_id=$1",[users[0]]);for(const r of registry)assert.equal((await call(r.path)).status,401);checks++;
 await db.query("UPDATE users SET status='inactive' WHERE id=$1",[users[1]]);for(const r of registry)assert.equal((await call(r.path,'',tokens[1])).status,401);checks++;
 console.log(`Personal record batches 26–30 and 200 passed ${checks} PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} auth identities).`);
}finally{for(const table of created.reverse())await db.query('DROP TABLE '+table);await db.query('DELETE FROM auth_sessions WHERE user_id::text=ANY($1)',[users]);await db.query('DELETE FROM users WHERE id::text=ANY($1)',[users]);await db.end();}
