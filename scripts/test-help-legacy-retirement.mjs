import test from 'node:test';import assert from 'node:assert/strict';import {readFile} from 'node:fs/promises';import {randomUUID,createHash} from 'node:crypto';import {PGlite} from '@electric-sql/pglite';import pg from 'pg';
import {helpLegacyRetirement,helpLegacyDigest,inspectHelpLegacyRetirement,registerHelpLegacyArchive,retireHelpLegacyGrants,readHelpLegacyRetirement,retirementFailureDiagnostic} from '../tools/governance-production/pc10-help-legacy-retirement.mjs';
const pin=JSON.parse(await readFile(new URL('../tools/governance-production/production-pin.json',import.meta.url))),contract=JSON.parse(await readFile(new URL('../tools/governance-production/pc10-help-reader-contract.json',import.meta.url)));
const table=n=>'"'+pin.schema+'"."'+pin.tablePrefix+n+'"',source=table('api_permissions'),archive=table('help_legacy_grant_archive'),commit='a'.repeat(40),key=helpLegacyRetirement.permissionKey;
function fixtureContext(){if(process.env.HELP_LEGACY_RETIREMENT_FIXTURE!=='1'||['PRODUCTION_DATABASE_URL','GOVERNANCE_DATABASE_URL','DB_URL'].some(k=>Object.hasOwn(process.env,k)))throw Error('Explicit isolated retirement test required');const value=process.env.HELP_LEGACY_RETIREMENT_TEST_DATABASE_URL;if(value){const u=new URL(value);if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='127.0.0.1'||u.pathname!=='/help_legacy_retirement'||u.search||u.hash)throw Error('Explicit localhost retirement test required');}return value;}
const native=fixtureContext();
async function fixture(run,{registered=true}={}){
 let db,client;if(native){client=new pg.Client({connectionString:native});await client.connect();db={query:(...args)=>client.query(...args),exec:sql=>client.query(sql),close:()=>client.end()};await db.exec('DROP SCHEMA IF EXISTS "'+pin.schema+'" CASCADE;DROP SCHEMA public CASCADE;CREATE SCHEMA public');}else db=new PGlite();
 try{
  await db.exec('CREATE SCHEMA "'+pin.schema+'";CREATE TABLE '+table('source_manifest')+'(manifest_sha256 text);CREATE TABLE '+source+'(_primecare_import_row bigint CONSTRAINT api_permissions_pkey PRIMARY KEY,id bigint,api_id bigint,role_id bigint,runtime_artifact_id bigint,permission_key text,can_access bigint,created_at text);CREATE INDEX primecare_call_api_permission_lookup ON '+source+'(role_id,api_id);CREATE TABLE '+table('api_endpoints')+'(id bigint PRIMARY KEY,http_method text,route_path text,permission_key text,rate_limit_key text,service_name text,auth_required bigint,implementation_status text,request_schema text,response_schema text);CREATE TABLE '+table('api_endpoint_registry')+'(id bigint,api_id bigint,endpoint_code text,method text,endpoint_path text);CREATE TABLE '+table('runtime_artifacts')+'(id bigint);CREATE TABLE '+table('screen_functions')+'(permission_key jsonb);CREATE TABLE public.communication_voice_otp(grant_id text)');
  await db.exec('ALTER TABLE '+table('source_manifest')+' ADD COLUMN manifest jsonb');
  await db.query('INSERT INTO '+table('source_manifest')+' VALUES($1,$2::jsonb)',[pin.manifestSha256,JSON.stringify({format:'primecare-governance-snapshot-v1',sqlite_objects:helpLegacyRetirement.manifestDeclaredReferences.map(o=>[o.object_type,o.object_name,o.table_name,o.sql])})]);
  await db.query('INSERT INTO '+table('api_endpoints')+' VALUES(794,$1,$2,$3,$4,$5,1,$6,$7,$8)',[contract.method,contract.path,contract.permissionKey,contract.rateLimitKey,contract.service,'registered-unimplemented',JSON.stringify(contract.requestSchema),JSON.stringify(contract.responseSchema)]);
  const o=helpLegacyRetirement.origin;await db.query('INSERT INTO '+table('api_endpoint_registry')+' VALUES($1,$2,$3,$4,$5)',[o.id,o.api_id,o.endpoint_code,o.method,o.endpoint_path]);
  await db.exec('INSERT INTO '+table('runtime_artifacts')+' VALUES(2)');
  for(let i=0;i<64;i++)await db.query('INSERT INTO '+source+' VALUES($1,$2,794,$3,1,$4,1,$5)',[String(50752+i),String(50753+i),String(i+1),key,'2026-07-02 16:19:24']);
  await db.query('INSERT INTO '+source+' VALUES($1,$2,2,1,2,$3,0,$4)',['9007199254740993','9007199254740994','unrelated_fixture_key','Original unicode é timestamp-text']);
  await db.query('INSERT INTO public.communication_voice_otp VALUES($1)',[randomUUID()]);
  const observed=await inspectHelpLegacyRetirement(db),definition={...structuredClone(helpLegacyRetirement),sourceRowsSha256:observed.sourceRowsSha256,sourceShapeSha256:observed.sourceShapeSha256,referenceInventorySha256:observed.referenceInventorySha256,groupFingerprint:observed.groupFingerprint,helpContractSha256:observed.helpContractSha256};
  assert.equal(observed.groupFingerprint,'393d8cfbcbc2d0d93170408674329463ec65e6f620996cec105b45319b33f238');assert.equal(observed.sourceRowsSha256,'76c84a508c9ea77fa080fbf0c251a856690bb519b8d00fe9e0d6d7d705eb0269');
  const options={fixtureDefinition:definition,sourceCommit:commit};if(registered)await registerHelpLegacyArchive(db,{...options,apply:true});
  const before=(await db.query('SELECT to_jsonb(p)::text AS row_text FROM '+source+' p ORDER BY _primecare_import_row')).rows.map(r=>r.row_text);
  await run({db,client,definition,options,observed,before,refresh:async()=>{const state=await inspectHelpLegacyRetirement(db);definition.sourceShapeSha256=state.sourceShapeSha256;definition.referenceInventorySha256=state.referenceInventorySha256;}});
 }finally{await db.close();}
}
const counts=async db=>({source:Number((await db.query('SELECT count(*)::text AS n FROM '+source+' WHERE permission_key=$1',[key])).rows[0].n),archive:Number((await db.query('SELECT count(*)::text AS n FROM '+archive)).rows[0].n)});
test('registration42501 identifies the exact failed phase while preserving rollback and grants',()=>fixture(async f=>{
 const query=f.db.query.bind(f.db),db={query:async(sql,...args)=>{if(sql.startsWith('LOCK TABLE '+source+' IN SHARE MODE'))throw Object.assign(Error('permission denied for table govt_api_permissions'),{code:'42501',detail:'private detail',hint:'private hint'});return query(sql,...args);}};
 await assert.rejects(registerHelpLegacyArchive(db,{...f.options,apply:true}),error=>{assert.deepEqual(retirementFailureDiagnostic(error),{sqlstate:'42501',phase:'archive-registration-source-lock',category:'insufficient_privilege',message:'permission denied for table govt_api_permissions'});return true;});
 assert.deepEqual(await counts(f.db),{source:64,archive:0});
}));
test('retirement diagnostics reject arbitrary text, URLs, SQL, details and non42501 messages',()=>{
 const phase='archive-registration-ddl';
 for(const message of ['permission denied for table secret password=hidden','permission denied for schema https://user:secret@example.test','permission denied for table api\nDETAIL:private','SELECT private FROM secret'])assert.deepEqual(retirementFailureDiagnostic({code:'42501',retirementPhase:phase,message,detail:'private',hint:'private',query:'private'}),{sqlstate:'42501',phase,category:'insufficient_privilege'});
 assert.deepEqual(retirementFailureDiagnostic({code:'42501',retirementPhase:phase,message:'permission denied to set parameter "primecare.help_legacy_archive_registration"'}),{sqlstate:'42501',phase,category:'insufficient_privilege',message:'permission denied to set parameter "primecare.help_legacy_archive_registration"'});
 assert.deepEqual(retirementFailureDiagnostic({code:'42501',retirementPhase:phase,message:'permission denied for function pg_advisory_xact_lock(integer, integer)'}),{sqlstate:'42501',phase,category:'insufficient_privilege',message:'permission denied for function pg_advisory_xact_lock(...)'});
 assert.deepEqual(retirementFailureDiagnostic({code:'XX000',retirementPhase:'private phase',message:'private'}),{sqlstate:'XX000',phase:null});
});
test('test harness refuses production markers and remote URL overrides before connections',async()=>{
 const old=process.env.PRODUCTION_DATABASE_URL;try{process.env.PRODUCTION_DATABASE_URL='fixture-marker';assert.throws(fixtureContext,/Explicit isolated/);await assert.rejects(registerHelpLegacyArchive({},{fixtureDefinition:helpLegacyRetirement}),/Explicit isolated/);}finally{if(old===undefined)delete process.env.PRODUCTION_DATABASE_URL;else process.env.PRODUCTION_DATABASE_URL=old;}
});
test('archive plan is read-only, registration creates exact five columns once and no grants move',()=>fixture(async f=>{
 assert.deepEqual(await registerHelpLegacyArchive(f.db,f.options),{archivePresent:false,applied:false,grantsRetired:0,newRoleGrants:0,runtimeActivated:false});
 assert.equal((await registerHelpLegacyArchive(f.db,{...f.options,apply:true})).applied,true);assert.equal((await registerHelpLegacyArchive(f.db,{...f.options,apply:true})).applied,false);assert.deepEqual(await counts(f.db),{source:64,archive:0});
},{registered:false}));
test('standalone archive SQL refuses execution without registered local scope',()=>fixture(async f=>{
 const sql=await readFile(new URL('../tools/governance-production/pc10-help-legacy-archive.sql',import.meta.url),'utf8');await assert.rejects(f.db.exec(sql),/Explicit registered/);
 assert.equal((await f.db.query('SELECT to_regclass($1) AS relation',[archive])).rows[0].relation,null);
},{registered:false}));
test('plan does not move grants; apply preserves complete raw JSON and unrelated unsafe-sized bigint exactly',()=>fixture(async f=>{
 const plan=await retireHelpLegacyGrants(f.db,f.options);assert.equal(plan.applied,false);assert.deepEqual(await counts(f.db),{source:64,archive:0});
 const result=await retireHelpLegacyGrants(f.db,{...f.options,apply:true});assert.equal(result.applied,true);assert.deepEqual(await counts(f.db),{source:0,archive:64});
 const originals=(await f.db.query('SELECT original_row::text AS row_text FROM '+archive+' ORDER BY source_ordinal')).rows.map(r=>r.row_text);assert.deepEqual(originals,f.observed.sourceRows.map(r=>r.original_row_text));
 const unrelated=(await f.db.query('SELECT to_jsonb(p)::text AS row_text FROM '+source+' p')).rows.map(r=>r.row_text);assert.deepEqual(unrelated,[f.before.at(-1)]);assert.ok(unrelated[0].includes('9007199254740994'));
 const receipt=await readHelpLegacyRetirement(f.db,f.options);assert.equal(receipt.archivedRows,64);assert.equal(receipt.activeLegacyRows,0);assert.equal(receipt.newRoleGrants,0);assert.equal(receipt.runtimeActivated,false);
}));
test('repeat is an exact no-op preserving archived source, context and timestamps',()=>fixture(async f=>{
 await retireHelpLegacyGrants(f.db,{...f.options,apply:true});const before=(await f.db.query('SELECT to_jsonb(a)::text AS row_text FROM '+archive+' a ORDER BY source_ordinal')).rows;
 const repeat=await retireHelpLegacyGrants(f.db,{...f.options,apply:true,sourceCommit:'b'.repeat(40)});assert.equal(repeat.applied,false);assert.equal(repeat.alreadyRetired,true);assert.deepEqual((await f.db.query('SELECT to_jsonb(a)::text AS row_text FROM '+archive+' a ORDER BY source_ordinal')).rows,before);
}));
for(const [label,sql]of [['timestamp',"UPDATE "+source+" SET created_at='changed' WHERE id=50753"],['ordinal','UPDATE '+source+' SET _primecare_import_row=9999 WHERE id=50753'],['flag','UPDATE '+source+' SET can_access=0 WHERE id=50753'],['role','UPDATE '+source+' SET role_id=99 WHERE id=50753'],['membership','DELETE FROM '+source+' WHERE id=50753']])test('changed '+label+' fails before any archival or deletion',()=>fixture(async f=>{
 await f.db.exec(sql);const before=await counts(f.db);await assert.rejects(retireHelpLegacyGrants(f.db,{...f.options,apply:true}),/Exact approved|incomplete/);assert.deepEqual(await counts(f.db),before);
}));
for(const [label,sql]of [['origin',"UPDATE "+table('api_endpoint_registry')+" SET method='PATCH'"],['Help operation',"UPDATE "+table('api_endpoints')+" SET route_path='/v1/other' WHERE id=794"],['artifact','INSERT INTO '+table('runtime_artifacts')+' VALUES(1)'],['authority',"UPDATE "+table('source_manifest')+" SET manifest_sha256='wrong'"]])test('changed '+label+' rejects retirement',()=>fixture(async f=>{
 await f.db.exec(sql);await assert.rejects(retireHelpLegacyGrants(f.db,{...f.options,apply:true}));assert.deepEqual(await counts(f.db),{source:64,archive:0});
}));
test('unregistered archive, extra archive column and unknown archive rows fail closed',()=>fixture(async f=>{
 await assert.rejects(retireHelpLegacyGrants(f.db,{...f.options,apply:true}));await registerHelpLegacyArchive(f.db,{...f.options,apply:true});await f.db.exec('ALTER TABLE '+archive+' ADD COLUMN unknown text');await assert.rejects(retireHelpLegacyGrants(f.db,{...f.options,apply:true}),/columns differ/);assert.deepEqual(await counts(f.db),{source:64,archive:0});
},{registered:false}));
test('an incomplete preexisting archive is never used to delete active rows',()=>fixture(async f=>{
 await f.db.query('INSERT INTO '+archive+'(source_ordinal,group_fingerprint,original_row,operation_context) SELECT _primecare_import_row,$1,to_jsonb(p),\'{}\'::jsonb FROM '+source+' p WHERE id=50753',[f.definition.groupFingerprint]);await assert.rejects(retireHelpLegacyGrants(f.db,{...f.options,apply:true}),/incomplete/);assert.deepEqual(await counts(f.db),{source:64,archive:1});
}));
test('post-archive SQL failure rolls back the entire move',()=>fixture(async f=>{
 const query=f.db.query.bind(f.db),db={query:async(sql,...args)=>{if(sql.startsWith('DELETE FROM '+source))return query('SELECT 1/0');return query(sql,...args);}};
 await assert.rejects(retireHelpLegacyGrants(db,{...f.options,apply:true}));assert.deepEqual(await counts(f.db),{source:64,archive:0});
}));
test('archive corruption and unrelated-grant changes fail independent readback',()=>fixture(async f=>{
 await retireHelpLegacyGrants(f.db,{...f.options,apply:true});await f.db.query('UPDATE '+archive+" SET original_row=jsonb_set(original_row,'{created_at}','\"changed\"'::jsonb) WHERE source_ordinal=50752");await assert.rejects(readHelpLegacyRetirement(f.db,f.options),/incomplete/);
}));
test('unrelated row mutations cannot pass the archived preservation receipt',()=>fixture(async f=>{
 await retireHelpLegacyGrants(f.db,{...f.options,apply:true});await f.db.query('UPDATE '+source+" SET created_at='changed' WHERE permission_key IS DISTINCT FROM $1",[key]);await assert.rejects(readHelpLegacyRetirement(f.db,f.options),/Unrelated/);
}));
test('retired reference matching extracts unsafe-sized original IDs as SQL text without rounding',()=>fixture(async f=>{
 await retireHelpLegacyGrants(f.db,{...f.options,apply:true});
 await f.db.query('UPDATE '+archive+" SET original_row=jsonb_set(original_row,'{id}','9007199254740993'::jsonb) WHERE source_ordinal=50752");
 const texts=(await f.db.query('SELECT original_row::text AS raw FROM '+archive+' ORDER BY source_ordinal')).rows.map(r=>r.raw);
 f.definition.sourceRowsSha256=createHash('sha256').update(JSON.stringify(texts)).digest('hex');
 await f.db.query('UPDATE '+archive+" SET operation_context=jsonb_set(jsonb_set(operation_context,'{sourceRowsSha256}',$1::jsonb),'{definitionSha256}',$2::jsonb)",[JSON.stringify(f.definition.sourceRowsSha256),JSON.stringify(helpLegacyDigest(f.definition))]);
 await f.db.query('INSERT INTO public.communication_voice_otp VALUES($1)',['9007199254740993']);
 await assert.rejects(readHelpLegacyRetirement(f.db,f.options),/outside-column reference/);
}));
test('new declared incoming SQL references fail even when the claimed manifest hash stays unchanged',()=>fixture(async f=>{
 const object=['view','unreviewed_fixture_view','fixture','SELECT id FROM api_permissions'];
 await f.db.query('UPDATE '+table('source_manifest')+" SET manifest=jsonb_set(manifest,'{sqlite_objects}',(manifest->'sqlite_objects')||$1::jsonb)",[JSON.stringify([object])]);
 await assert.rejects(retireHelpLegacyGrants(f.db,{...f.options,apply:true}),/Declared permission references/);assert.deepEqual(await counts(f.db),{source:64,archive:0});
}));
test('actual incoming foreign reference refuses a move even with reviewed inventory',()=>fixture(async f=>{
 await f.db.exec('CREATE TABLE '+table('fixture_fk')+'(permission_row_id bigint REFERENCES '+source+'(_primecare_import_row) ON DELETE CASCADE);INSERT INTO '+table('fixture_fk')+' VALUES(50752)');await f.refresh();await assert.rejects(retireHelpLegacyGrants(f.db,{...f.options,apply:true}),/Incoming foreign reference/);assert.deepEqual(await counts(f.db),{source:64,archive:0});
}));
test('nested logical JSON reference refuses a move without deleting referenced metadata',()=>fixture(async f=>{
 await f.db.exec('CREATE TABLE '+table('fixture_logical')+'(api_permission_id jsonb);INSERT INTO '+table('fixture_logical')+" VALUES('{\"v\":[50753]}'::jsonb)");await f.refresh();await assert.rejects(retireHelpLegacyGrants(f.db,{...f.options,apply:true}),/Incoming logical reference/);assert.deepEqual(await counts(f.db),{source:64,archive:0});
}));
test('reviewed public UUID column permits only zero matching reference count',()=>fixture(async f=>{
 await f.db.query('INSERT INTO public.communication_voice_otp VALUES($1)',['50753']);await assert.rejects(retireHelpLegacyGrants(f.db,{...f.options,apply:true}),/outside-column reference/);assert.deepEqual(await counts(f.db),{source:64,archive:0});
}));
test('a second public candidate is rejected without reading its private rows',()=>fixture(async f=>{
 await f.db.exec('CREATE TABLE public.fixture_unreviewed(grant_id text)');await f.refresh();const seen=[];const db={query:(sql,...args)=>{seen.push(sql);return f.db.query(sql,...args);}};await assert.rejects(retireHelpLegacyGrants(db,{...f.options,apply:true}),/outside governed/);assert.equal(seen.some(sql=>sql.includes('FROM "public"."fixture_unreviewed"')),false);assert.deepEqual(await counts(f.db),{source:64,archive:0});
}));
test('native context SHARE locks block a concurrent artifact1 insert before absence checks',{skip:!native},()=>fixture(async f=>{
 const other=new pg.Client({connectionString:native});await other.connect();let started,release;const ready=new Promise(resolve=>started=resolve),held=new Promise(resolve=>release=resolve),query=f.db.query.bind(f.db);
 try{const db={query:async(sql,...args)=>{const value=await query(sql,...args);if(sql.startsWith('LOCK TABLE '+table('api_endpoint_registry')+',')){started();await held;}return value;}};const move=retireHelpLegacyGrants(db,{...f.options,apply:true});await ready;await other.query("SET lock_timeout='200ms'");await assert.rejects(other.query('INSERT INTO '+table('runtime_artifacts')+' VALUES(1)'),e=>e.code==='55P03');release();assert.equal((await move).applied,true);assert.equal((await readHelpLegacyRetirement(other,f.options)).archivedRows,64);}finally{release?.();await other.end();}
}));
test('native source lock blocks a concurrent mutation of a retirement member',{skip:!native},()=>fixture(async f=>{
 const other=new pg.Client({connectionString:native});await other.connect();let started,release;const ready=new Promise(resolve=>started=resolve),held=new Promise(resolve=>release=resolve),query=f.db.query.bind(f.db);
 try{const db={query:async(sql,...args)=>{const value=await query(sql,...args);if(sql.startsWith('LOCK TABLE '+source+',')){started();await held;}return value;}};const move=retireHelpLegacyGrants(db,{...f.options,apply:true});await ready;await other.query("SET lock_timeout='200ms'");await assert.rejects(other.query('UPDATE '+source+" SET created_at='concurrent' WHERE id=50753"),e=>e.code==='55P03');release();assert.equal((await move).applied,true);assert.equal((await readHelpLegacyRetirement(other,f.options)).archivedRows,64);}finally{release?.();await other.end();}
}));
