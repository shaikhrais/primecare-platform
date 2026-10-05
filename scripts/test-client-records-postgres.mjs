import {Client} from 'pg';import {build} from 'esbuild';import assert from 'node:assert/strict';import {randomUUID,createHash} from 'node:crypto';import {mkdtemp,readFile} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const registry=JSON.parse(await readFile('cloudflare/workers/src/client-records-registry.json','utf8')),dir=await mkdtemp(join(tmpdir(),'client-records-pg-'));await build({entryPoints:['cloudflare/workers/src/client-self.ts'],outfile:join(dir,'records.cjs'),bundle:true,platform:'node',format:'cjs'});const {clientSelf}=createRequire(import.meta.url)(join(dir,'records.cjs'));
const db=new Client({connectionString:url.href});await db.connect();const ids=[randomUUID(),randomUUID()],tenants=[randomUUID(),randomUUID()],profiles=[randomUUID(),randomUUID()],tokens=['j'.repeat(43),'k'.repeat(43)],hash=s=>createHash('sha256').update(s).digest('hex');let createdProfiles=false,checks=0;const created=[];
const call=(path,query='',token=tokens[0])=>clientSelf(new Request('https://fixture'+path+query,{headers:{authorization:'Bearer '+token}}),{DB_URL:url.href,SERVICE_NAME:'client'},path,{});
try{
 await db.query('CREATE TABLE client_profiles(id TEXT PRIMARY KEY,user_id TEXT NOT NULL,tenant_id TEXT NOT NULL,full_name TEXT NOT NULL,city TEXT,province TEXT,postal_code TEXT,updated_at TIMESTAMP NOT NULL DEFAULT NOW())');createdProfiles=true;
 for(let i=0;i<2;i++){await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'patient',$3,'unused','active')",[ids[i],ids[i]+'@example.invalid',tenants[0]]);await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),ids[i]]);await db.query("INSERT INTO client_profiles(id,user_id,tenant_id,full_name) VALUES($1,$2,$3,'Client')",[profiles[i],ids[i],tenants[0]]);}
 for(const record of registry){
  const isDate=f=>f.endsWith('_at')||f.endsWith('_date');
  const column=f=>{const t=record.types[f],base=Array.isArray(t)?t[0]:t;return f+' '+(base==='integer'?'INTEGER':base==='number'?'DOUBLE PRECISION':isDate(f)?'TIMESTAMP':'TEXT')+(Array.isArray(t)?'':' NOT NULL');};
  await db.query('CREATE TABLE '+record.table+'('+record.fields.map(column).join(',')+',client_id TEXT NOT NULL,tenant_id TEXT NOT NULL,notes TEXT,signature_data_url TEXT,document_key TEXT,auth_code TEXT)');created.push(record.table);
  const records=[randomUUID(),randomUUID(),randomUUID()];
  for(let i=0;i<3;i++){
   const values=record.fields.map(f=>{const t=record.types[f],base=Array.isArray(t)?t[0]:t;return f==='id'?records[i]:Array.isArray(t)?null:base==='integer'?1:base==='number'?1.5:isDate(f)?'2026-01-01T12:00:00Z':'value';});values.push(profiles[i===1?1:0],tenants[i===2?1:0],'private note','private signature','private key','private code');
   await db.query('INSERT INTO '+record.table+'('+[...record.fields,'client_id','tenant_id','notes','signature_data_url','document_key','auth_code'].join(',')+') VALUES('+values.map((_,j)=>'$'+(j+1)).join(',')+')',values);
  }
  const response=await call(record.path,'?limit=1');assert.equal(response.status,200);const list=await response.json();assert.equal(list.pagination.total,1);assert.equal(list[record.collection][0].id,records[0]);assert.ok(!JSON.stringify(list).includes('private'));checks++;
  const detail=await (await call(record.path+'/'+records[0])).json();assert.equal(detail[record.item].id,records[0]);checks++;
  for(const id of records.slice(1))assert.equal((await call(record.path+'/'+id)).status,404);checks++;
  const page=await (await call(record.path,'?offset=1')).json();assert.deepEqual(page[record.collection],[]);assert.equal(page.pagination.total,1);checks++;
  const other=await (await call(record.path,'',tokens[1])).json();assert.equal(other[record.collection][0].id,records[1]);checks++;
  await db.query('DELETE FROM '+record.table+' WHERE id=$1',[records[0]]);const empty=await (await call(record.path)).json();assert.deepEqual(empty[record.collection],[]);assert.equal(empty.pagination.total,0);checks++;
 }
 console.log(`Owned client records passed ${checks} PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} auth identities).`);
}finally{for(const table of created.reverse())await db.query('DROP TABLE '+table);if(createdProfiles)await db.query('DROP TABLE client_profiles');await db.query('DELETE FROM auth_sessions WHERE user_id::text=ANY($1)',[ids]);await db.query('DELETE FROM users WHERE id::text=ANY($1)',[ids]);await db.end();}
