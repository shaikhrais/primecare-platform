import pg from 'pg';import assert from 'node:assert/strict';import {readFile,mkdir,writeFile} from 'node:fs/promises';import {createHash} from 'node:crypto';
import {snapshot,privateAcl,validateMetadataShape,assertExisting} from './migrate-messaging-storage.mjs';
const mode=process.argv[2],fixture=mode==='--reference',names=['communication_call_audit'];
if(!['--reference','--apply','--verify'].includes(mode))throw Error('Explicit audit schema mode required');
const definition=JSON.parse(await readFile('tools/governance-production/call-audit-storage-registration.json','utf8')),pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8')),sql=await readFile(definition.migrationPath,'utf8');
if(createHash('sha256').update(sql).digest('hex')!==definition.migrationSha256||pin.callAuditSchemaMigration?.migrationSha256!==definition.migrationSha256||pin.sqliteFallback!==false)throw Error('Pinned audit migration required');
let options;
if(fixture){const u=new URL(process.env.AUDIT_TEST_DATABASE_URL??'');if(!['localhost','127.0.0.1'].includes(u.hostname)||u.username!=='audit_fixture'||u.pathname!=='/call_audit_test'||process.env.PRODUCTION_DATABASE_URL)throw Error('Named disposable PostgreSQL required');options={connectionString:u.href};}
else{const u=new URL(process.env.PRODUCTION_DATABASE_URL??'');if(u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres'||!/^governance_[a-f0-9]+$/.test(pin.schema))throw Error('Pinned audit target required');if(mode==='--apply'&&process.env.CALL_AUDIT_SCHEMA_APPLY!=='1')throw Error('Audit schema opt-in required');options={host:mode==='--apply'?'db.prisma.io':u.hostname,port:5432,database:'postgres',user:decodeURIComponent(u.username),password:decodeURIComponent(u.password),ssl:{rejectUnauthorized:true}};}
const pool=new pg.Pool({...options,max:1,connectionTimeoutMillis:10000}),db=await pool.connect();
const value=x=>x&&typeof x==='object'&&x.t&&typeof x.v==='string'?x.v:x;
try{
 await db.query(mode==='--verify'?'BEGIN READ ONLY':'BEGIN');await db.query("SET LOCAL statement_timeout='60s'");
 if(!fixture){
  const manifest=(await db.query(`SELECT manifest_sha256 FROM "${pin.schema}".govt_source_manifest`)).rows;assert.equal(manifest.length,1);assert.equal(manifest[0].manifest_sha256,pin.manifestSha256);
  const rows=(await db.query(`SELECT baseline_sql,sha256,schema_metadata FROM "${pin.schema}".govt_database_rebuild_baselines WHERE name=$1`,[definition.baseline])).rows;assert.equal(rows.length,1);assert.equal(value(rows[0].baseline_sql),sql);assert.equal(value(rows[0].sha256),definition.migrationSha256);const metadata=value(rows[0].schema_metadata);assert.deepEqual(typeof metadata==='string'?JSON.parse(metadata):metadata,definition);
 }
 const reference=fixture?null:JSON.parse(await readFile('test-results/call-audit/reference.json','utf8'));
 if(reference)assert.equal(reference.migrationSha256,definition.migrationSha256);
 const before=await snapshot(db,names);if(reference)await assertExisting(before,reference);
 if(mode!=='--verify'){await db.query("SELECT pg_advisory_xact_lock(hashtext('primecare-call-audit-schema-v1'))");await db.query(sql);}
 const shapes=await snapshot(db,names);if(reference)assert.deepEqual(shapes,reference.shapes);await privateAcl(db,names);await validateMetadataShape(db,definition);
 if(fixture){await mkdir('test-results/call-audit',{recursive:true});await writeFile('test-results/call-audit/reference.json',JSON.stringify({migrationSha256:definition.migrationSha256,shapes},null,2));}
 await db.query('COMMIT');console.log('CALL_AUDIT_SCHEMA '+JSON.stringify({mode,verified:true,tables:1,customerWrites:0,roleGrants:0}));
}catch(e){await db.query('ROLLBACK');console.log('CALL_AUDIT_SCHEMA_FAILED '+(e.code==='ERR_ASSERTION'?'schema_or_registration_mismatch':/^[A-Z0-9]{5}$/.test(e.code??'')?e.code:'validation_failed'));process.exitCode=1;}finally{db.release();await pool.end();}
