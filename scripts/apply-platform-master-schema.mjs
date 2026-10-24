import pg from 'pg';
import assert from 'node:assert/strict';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {platformMasterTables,platformMasterSchemaProfile,platformMasterMigrationBody} from './platform-master-schema-profile.mjs';
const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
const sql=await readFile('packages/database/migrations/20261011_platform_administration.sql','utf8');
const migrationSha256=createHash('sha256').update(sql).digest('hex');
const expected={optInVariable:'APPLY_PLATFORM_MASTER_SCHEMA',tables:platformMasterTables,migrationSha256,governanceSchemaChanges:false,accountChanges:false,roleGrants:false};
assert.deepEqual(pin.platformMasterSchemaWriter,expected);
const mode=process.argv[2];if(process.env.APPLY_PLATFORM_MASTER_SCHEMA!=='1'||!['--dry-run','--apply'].includes(mode)||!/^[a-z][a-z0-9_]*$/.test(pin.schema)||! /^[a-f0-9]{40}$/.test(process.env.GITHUB_SHA||'')||! /^\d+$/.test(process.env.GITHUB_RUN_ID||'')||!process.env.GITHUB_ACTOR)throw Error('Exact platform schema scope required');
const baseline=JSON.parse(await readFile('test-results/platform-master-schema/manifest.json','utf8'));
if(baseline.version!==1||baseline.source!==process.env.GITHUB_SHA||baseline.migrationSha256!==migrationSha256||baseline.nativePostgres!==true||Object.keys(baseline.profiles).sort().join(',')!=='text:text,text:uuid,uuid:text,uuid:uuid')throw Error('Exact native PostgreSQL schema evidence required');
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();
try{
 await db.query('BEGIN');await db.query("SET LOCAL search_path TO public; SET LOCAL lock_timeout='10s'; SET LOCAL statement_timeout='120s'");
 await db.query("SELECT pg_advisory_xact_lock(hashtext('primecare-platform-administration'))");
 const manifest=(await db.query(`SELECT manifest_sha256 FROM "${pin.schema}".govt_source_manifest`)).rows;
 if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Production authority mismatch');
 const screen=(await db.query(`SELECT id::text AS id,screen_code,route_path,active::text AS active FROM "${pin.schema}".govt_screens WHERE id=1269`)).rows;
 assert.deepEqual(screen,[{id:'1269',screen_code:'PLATFORM_ADMINISTRATION',route_path:'/platform/administration',active:'1'}]);
 for(const [id,method,path]of [[16434,'GET','/v1/governance/platform'],[16441,'GET','/v1/governance/platform/tenants/{tenantId}/masters'],[16442,'POST','/v1/governance/platform/tenants/{tenantId}/masters']]){
  const api=(await db.query(`SELECT http_method,route_path,permission_key FROM "${pin.schema}".govt_api_endpoints WHERE id=$1`,[id])).rows;
  assert.deepEqual(api,[{http_method:method,route_path:path,permission_key:'platform_administration_policy'}]);
 }
 const parents=(await db.query("SELECT table_name,udt_name FROM information_schema.columns WHERE table_schema='public' AND column_name='id' AND table_name IN ('tenants','users') ORDER BY table_name")).rows;
 if(parents.length!==2||parents[0].table_name!=='tenants'||parents[1].table_name!=='users'||parents.some(p=>!['uuid','text'].includes(p.udt_name)))throw Error('Native identity schema differs');
 const profile=baseline.profiles[parents[0].udt_name+':'+parents[1].udt_name];
 const present=(await db.query("SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name=ANY($1::text[])",[platformMasterTables])).rows.length;
 if(present!==0&&present!==4)throw Error('Partial platform schema requires separate review');
 if(present===4)for(const table of platformMasterTables)assert.deepEqual(await platformMasterSchemaProfile(db,'public',table),profile[table]);
 await db.query(platformMasterMigrationBody(sql));
 for(const table of platformMasterTables)assert.deepEqual(await platformMasterSchemaProfile(db,'public',table),profile[table]);
 await db.query(mode==='--apply'?'COMMIT':'ROLLBACK');
 // A new read-only transaction independently checks committed or rolled-back state.
 await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 if(mode==='--apply'||present===4){for(const table of platformMasterTables)assert.deepEqual(await platformMasterSchemaProfile(db,'public',table),profile[table]);}
 else {const count=(await db.query("SELECT COUNT(*)::int AS n FROM information_schema.tables WHERE table_schema='public' AND table_name=ANY($1::text[])",[platformMasterTables])).rows[0].n;assert.equal(count,0);}
 await db.query('ROLLBACK');
 const report={source:process.env.GITHUB_SHA,runId:process.env.GITHUB_RUN_ID,actor:process.env.GITHUB_ACTOR,mode,migrationSha256,tables:platformMasterTables,previousTables:present,identityProfile:parents.map(p=>p.udt_name).join(':'),independentReadback:true,businessRecordsWritten:0,accountChanges:0,roleGrantsChanged:false,governanceChanges:false};
 await mkdir('test-results/platform-master-schema',{recursive:true});await writeFile('test-results/platform-master-schema/'+(mode==='--apply'?'applied':'dry-run')+'.json',JSON.stringify(report,null,2)+'\n');
 console.log('PLATFORM_MASTER_SCHEMA_APPLICATION '+JSON.stringify(report));
}catch(error){await db.query('ROLLBACK');console.error('PLATFORM_MASTER_SCHEMA_APPLICATION_FAILED '+JSON.stringify({mode,code:/^[A-Z0-9]{5}$/.test(error?.code||'')?error.code:null,reason:'Authority, native schema evidence or migration validation failed; no account or permission changes requested.'}));process.exitCode=1;}
finally{await db.end();}
