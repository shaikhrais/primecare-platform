import pg from 'pg';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
import {mfaLifecycleTables,mfaSchemaProfile} from './mfa-schema-profile.mjs';
const pin=JSON.parse(readFileSync('tools/governance-production/production-pin.json'));
const sql=readFileSync('packages/database/migrations/20261026_auth_mfa_lifecycle.sql','utf8');
const expected={optInVariable:'APPLY_MFA_LIFECYCLE_SCHEMA',tables:mfaLifecycleTables,
  migrationSha256:createHash('sha256').update(sql).digest('hex'),governanceSchemaChanges:false,accountChanges:false,existingCredentialChanges:false};
if(JSON.stringify(pin.authLifecycleSchemaWriter)!==JSON.stringify(expected)||process.env.APPLY_MFA_LIFECYCLE_SCHEMA!=='1'||
  !['--dry-run','--apply'].includes(process.argv[2])||! /^[a-z][a-z0-9_]+$/.test(pin.schema))throw Error('Exact lifecycle schema scope required');
const baseline=JSON.parse(readFileSync('test-results/mfa-lifecycle-schema/manifest.json'));
if(baseline.version!==1||baseline.source!==process.env.GITHUB_SHA||baseline.migrationSha256!==expected.migrationSha256||
  baseline.nativePostgres!==true||Object.keys(baseline.profiles).sort().join(',')!==[...mfaLifecycleTables].sort().join(','))throw Error('Exact native schema evidence required');
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();
try{
  await db.query('BEGIN');await db.query("SET LOCAL lock_timeout='10s'; SET LOCAL statement_timeout='120s'; SET LOCAL search_path TO public");
  await db.query("SELECT pg_advisory_xact_lock(hashtext('auth-mfa-lifecycle-schema-v1'))");
  const authority=(await db.query(`SELECT manifest_sha256 FROM "${pin.schema}".govt_source_manifest`)).rows;
  if(authority.length!==1||authority[0].manifest_sha256!==pin.manifestSha256)throw Error('Production authority mismatch');
  const rows=(await db.query(`SELECT definition FROM "${pin.schema}".govt_platform_hierarchy_policy WHERE id='auth-lifecycle-completion-v1'`)).rows;
  if(rows.length!==1)throw Error('Registered lifecycle policy required');
  assert.deepEqual(JSON.parse(rows[0].definition),JSON.parse(readFileSync('tools/governance-production/auth-lifecycle-policy.json')));
  const surface=JSON.parse(readFileSync('tools/governance-production/auth-lifecycle-surface.json'));
  for(const endpoint of surface.endpoints){
    const registered=(await db.query(`SELECT route_path,http_method,permission_key FROM "${pin.schema}".govt_api_endpoints WHERE endpoint_code=$1`,[endpoint.code])).rows;
    assert.deepEqual(registered,[{route_path:endpoint.route,http_method:'POST',permission_key:endpoint.permission}]);
  }
  const operational=(await db.query("SELECT n.nspname FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace WHERE c.oid=to_regclass('auth_mfa_credentials') AND c.relkind='r'")).rows;
  if(operational.length!==1||operational[0].nspname!=='public')throw Error('Existing operational auth authority required');
  await db.query(sql);
  for(const table of mfaLifecycleTables)assert.deepEqual(await mfaSchemaProfile(db,'public',table),baseline.profiles[table]);
  await db.query(process.argv[2]==='--apply'?'COMMIT':'ROLLBACK');
  console.log('MFA_LIFECYCLE_SCHEMA '+JSON.stringify({mode:process.argv[2],tables:mfaLifecycleTables.length,accountChanges:0,credentialChanges:0,governanceChanges:0}));
}catch{await db.query('ROLLBACK');throw Error('MFA lifecycle schema failed; transaction rolled back and existing data preserved');}
finally{await db.end();}
