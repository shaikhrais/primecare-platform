import {assertReadDateRejections} from './read-date-postgres-fixtures.mjs';
import {Client} from 'pg';import {build} from 'esbuild';import assert from 'node:assert/strict';import {randomUUID,createHash} from 'node:crypto';import {mkdtemp} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const dir=await mkdtemp(join(tmpdir(),'provider-self-pg-'));await build({entryPoints:['cloudflare/workers/src/provider-self.ts'],outfile:join(dir,'provider.cjs'),bundle:true,platform:'node',format:'cjs'});const {providerSelf}=createRequire(import.meta.url)(join(dir,'provider.cjs'));const db=new Client({connectionString:url.href});await db.connect();
const ids=[randomUUID(),randomUUID(),randomUUID()],tenants=[randomUUID(),randomUUID()],profiles=[randomUUID(),randomUUID(),randomUUID()],tokens=['p'.repeat(43),'q'.repeat(43),'r'.repeat(43)];const hash=s=>createHash('sha256').update(s).digest('hex');let checks=0,createdProfiles=false,createdAvailability=false,createdVisits=false,createdDocuments=false;
const call=(path='/profile',query='',token=tokens[0],headers={})=>providerSelf(new Request('https://fixture'+path+query,{headers:{authorization:'Bearer '+token,...headers}}),{DB_URL:url.href,SERVICE_NAME:'provider'},path,{});
try{
 await db.query('CREATE TABLE provider_profiles(id TEXT PRIMARY KEY,user_id TEXT UNIQUE NOT NULL,tenant_id TEXT NOT NULL,full_name TEXT NOT NULL,bio TEXT,languages TEXT NOT NULL,service_areas TEXT NOT NULL,provider_type TEXT NOT NULL,is_approved BOOLEAN NOT NULL,skills TEXT NOT NULL,trust_score INTEGER)');createdProfiles=true;
 await db.query('CREATE TABLE provider_availability(id TEXT PRIMARY KEY,provider_id TEXT NOT NULL,tenant_id TEXT NOT NULL,day_of_week INTEGER NOT NULL,start_time TEXT NOT NULL,end_time TEXT NOT NULL)');createdAvailability=true;
 for(let i=0;i<3;i++){await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'rmt',$3,'unused','active')",[ids[i],ids[i]+'@example.invalid',tenants[i===2?1:0]]);await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),ids[i]]);await db.query("INSERT INTO provider_profiles(id,user_id,tenant_id,full_name,bio,languages,service_areas,provider_type,is_approved,skills,trust_score) VALUES($1,$2,$3,$4,NULL,'English','Hamilton','RMT',true,'Massage',100)",[profiles[i],ids[i],tenants[i===2?1:0],'Provider '+i]);await db.query("INSERT INTO provider_availability(id,provider_id,tenant_id,day_of_week,start_time,end_time) VALUES($1,$2,$3,1,'09:00','17:00')",[randomUUID(),profiles[i],tenants[i===2?1:0]]);}
 await db.query("INSERT INTO provider_availability(id,provider_id,tenant_id,day_of_week,start_time,end_time) VALUES($1,$2,$3,2,'09:00','17:00')",[randomUUID(),profiles[0],tenants[1]]);
 await db.query('CREATE TABLE visits(id TEXT PRIMARY KEY,assigned_provider_id TEXT,tenant_id TEXT NOT NULL,service_id TEXT NOT NULL,requested_start_at TIMESTAMP NOT NULL,duration_minutes INTEGER NOT NULL,status TEXT,priority TEXT,updated_at TIMESTAMP NOT NULL DEFAULT NOW(),client_id TEXT,management_notes TEXT)');createdVisits=true;
 const visits=[randomUUID(),randomUUID(),randomUUID(),randomUUID()];
 for(let i=0;i<4;i++)await db.query("INSERT INTO visits(id,assigned_provider_id,tenant_id,service_id,requested_start_at,duration_minutes,status,priority,client_id,management_notes) VALUES($1,$2,$3,'service',NOW(),60,'requested','normal','private-client','private-notes')",[visits[i],i===3?null:profiles[i===2?0:i],tenants[i===2?1:0]]);
 checks+=await assertReadDateRejections(db,()=>call('/visits'),{table:'visits',field:'updated_at',id:visits[0]});
 const visitList=await (await call('/visits','?limit=1')).json();assert.equal(visitList.pagination.total,1);assert.equal(visitList.visits[0].id,visits[0]);assert.ok(!JSON.stringify(visitList).includes('private'));checks++;
 const visitDetail=await (await call('/visits/'+visits[0])).json();assert.equal(visitDetail.visit.duration_minutes,60);checks++;
 for(const id of visits.slice(1))assert.equal((await call('/visits/'+id)).status,404);checks++;
 const visitPage=await (await call('/visits','?offset=1')).json();assert.equal(visitPage.visits.length,0);assert.equal(visitPage.pagination.total,1);checks++;
 const visitSummary=await (await call('/visits/summary')).json();assert.equal(visitSummary.pagination.total,1);assert.equal(visitSummary.groups[0].count,1);assert.equal(visitSummary.groups[0].durationMinutes,'60');checks++;
 const visitSummaryPage=await (await call('/visits/summary','?offset=1')).json();assert.equal(visitSummaryPage.groups.length,0);assert.equal(visitSummaryPage.pagination.total,1);checks++;
 await db.query('ALTER TABLE visits ALTER COLUMN duration_minutes DROP NOT NULL');await db.query('UPDATE visits SET duration_minutes=NULL WHERE id=$1',[visits[0]]);assert.equal((await call('/visits/'+visits[0])).status,503);await db.query('UPDATE visits SET duration_minutes=60 WHERE id=$1',[visits[0]]);checks++;

 await db.query('CREATE TABLE provider_documents(id TEXT PRIMARY KEY,provider_id TEXT NOT NULL,doc_type TEXT NOT NULL,status TEXT,expiry_date TIMESTAMP,verified_at TIMESTAMP,created_at TIMESTAMP NOT NULL DEFAULT NOW(),updated_at TIMESTAMP NOT NULL DEFAULT NOW(),file_key TEXT,verified_by TEXT)');createdDocuments=true;
 const docs=[randomUUID(),randomUUID(),randomUUID()];
 for(let i=0;i<3;i++)await db.query("INSERT INTO provider_documents(id,provider_id,doc_type,status,file_key,verified_by) VALUES($1,$2,'license','pending','private-key','private-verifier')",[docs[i],profiles[i]]);
 checks+=await assertReadDateRejections(db,()=>call('/documents'),{table:'provider_documents',field:'verified_at',id:docs[0]});
 const docList=await (await call('/documents','?limit=1')).json();assert.equal(docList.pagination.total,1);assert.equal(docList.documents[0].id,docs[0]);assert.ok(!JSON.stringify(docList).includes('private'));checks++;
 const docDetail=await (await call('/documents/'+docs[0])).json();assert.equal(docDetail.document.doc_type,'license');checks++;
 for(const id of docs.slice(1))assert.equal((await call('/documents/'+id)).status,404);checks++;
 const docPage=await (await call('/documents','?offset=1')).json();assert.equal(docPage.documents.length,0);assert.equal(docPage.pagination.total,1);checks++;

 const batch15=await (await call('/documents/summary')).json();assert.equal(batch15.pagination.total,1);assert.equal(batch15.groups[0].count,1);checks++;
 const batch15Page=await (await call('/documents/summary','?offset=1')).json();assert.equal(batch15Page.groups.length,0);assert.equal(batch15Page.pagination.total,1);checks++;
 // Null is a distinct stored-status group; other owners/tenants remain excluded.
 await db.query('UPDATE provider_documents SET status=NULL WHERE provider_id=$1',[profiles[0]]);
 const batch15Null=await (await call('/documents/summary')).json();assert.deepEqual(batch15Null.groups,[{status:null,count:1}]);checks++;
 await db.query('ALTER TABLE provider_documents ALTER COLUMN doc_type DROP NOT NULL');await db.query('UPDATE provider_documents SET doc_type=NULL WHERE id=$1',[docs[0]]);assert.equal((await call('/documents/'+docs[0])).status,503);await db.query("UPDATE provider_documents SET doc_type='license' WHERE id=$1",[docs[0]]);checks++;
 await db.query('DELETE FROM provider_documents WHERE provider_id=$1',[profiles[0]]);
 const batch15Empty=await (await call('/documents/summary')).json();assert.deepEqual(batch15Empty.groups,[]);assert.equal(batch15Empty.pagination.total,0);assert.equal(batch15Empty.pagination.hasMore,false);checks++;
 const own=await (await call()).json();assert.equal(own.profile.id,profiles[0]);assert.ok(!('trust_score' in own.profile));checks++;
 const list=await (await call('/availability')).json();assert.equal(list.pagination.total,1);assert.equal(list.availability[0].start_time,'09:00');checks++;
 const other=await (await call('/availability','',tokens[1])).json();assert.equal(other.pagination.total,1);assert.notEqual(other.availability[0].id,list.availability[0].id);checks++;
 const empty=await (await call('/availability','?offset=1')).json();assert.equal(empty.availability.length,0);assert.equal(empty.pagination.total,1);checks++;

 const availabilityDetail=await (await call('/availability/'+list.availability[0].id)).json();assert.equal(availabilityDetail.availability.id,list.availability[0].id);checks++;
 await db.query('ALTER TABLE provider_availability ALTER COLUMN start_time DROP NOT NULL');await db.query('UPDATE provider_availability SET start_time=NULL WHERE id=$1',[list.availability[0].id]);assert.equal((await call('/availability/'+list.availability[0].id)).status,503);await db.query("UPDATE provider_availability SET start_time='09:00' WHERE id=$1",[list.availability[0].id]);checks++;
 const unavailable=(await db.query('SELECT id FROM provider_availability WHERE provider_id=$1 OR tenant_id=$2',[profiles[1],tenants[1]])).rows;
 for(const item of unavailable)assert.equal((await call('/availability/'+item.id)).status,404);checks++;
 for(const day of [1,3])await db.query("INSERT INTO provider_availability(id,provider_id,tenant_id,day_of_week,start_time,end_time) VALUES($1,$2,$3,$4,'18:00','20:00')",[randomUUID(),profiles[0],tenants[0],day]);
 const availabilitySummary=await (await call('/availability/summary')).json();assert.deepEqual(availabilitySummary.groups,[{day_of_week:1,count:2},{day_of_week:3,count:1}]);assert.equal(availabilitySummary.pagination.total,2);checks++;
 const availabilitySummaryPage=await (await call('/availability/summary','?limit=1&offset=1')).json();assert.deepEqual(availabilitySummaryPage.groups,[{day_of_week:3,count:1}]);assert.equal(availabilitySummaryPage.pagination.total,2);assert.equal(availabilitySummaryPage.pagination.hasMore,false);checks++;
 await db.query('DELETE FROM provider_availability WHERE provider_id=$1 AND tenant_id=$2',[profiles[0],tenants[0]]);
 const noAvailability=await (await call('/availability/summary')).json();assert.deepEqual(noAvailability.groups,[]);assert.equal(noAvailability.pagination.total,0);checks++;
 await db.query('ALTER TABLE provider_profiles ALTER COLUMN skills DROP NOT NULL');await db.query('UPDATE provider_profiles SET skills=NULL WHERE id=$1',[profiles[0]]);assert.equal((await call()).status,503);await db.query("UPDATE provider_profiles SET skills='Massage' WHERE id=$1",[profiles[0]]);checks++;
 assert.equal((await call('/profile','',tokens[0],{'x-tenant-id':tenants[1]})).status,403);checks++;
 await db.query('UPDATE provider_profiles SET tenant_id=$1 WHERE id=$2',[tenants[1],profiles[0]]);assert.equal((await call()).status,404);checks++;
 await db.query("UPDATE users SET status='inactive' WHERE id=$1",[ids[1]]);assert.equal((await call('/availability','',tokens[1])).status,401);checks++;
 console.log(`Provider self passed ${checks} PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} auth identities).`);
}finally{if(createdDocuments)await db.query('DROP TABLE provider_documents');if(createdVisits)await db.query('DROP TABLE visits');if(createdAvailability)await db.query('DROP TABLE provider_availability');if(createdProfiles)await db.query('DROP TABLE provider_profiles');await db.query('DELETE FROM auth_sessions WHERE user_id::text=ANY($1)',[ids]);await db.query('DELETE FROM users WHERE id::text=ANY($1)',[ids]);await db.end();}
