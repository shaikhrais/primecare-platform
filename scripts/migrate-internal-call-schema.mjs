import pg from 'pg';import {readFile,mkdir,writeFile} from 'node:fs/promises';import {createHash} from 'node:crypto';
import {snapshot,privateAcl} from './migrate-voice-identity-schema.mjs';
const mode=process.argv[2],fixture=mode==='--reference',table='communication_voice_extensions',sequence='communication_voice_extension_seq';
if(!['--reference','--dry-run','--apply','--verify'].includes(mode))throw Error('Explicit mode required');
const sql=await readFile('packages/database/migrations/20261025_internal_call_extensions.sql','utf8'),sha=createHash('sha256').update(sql).digest('hex'),pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
const report={mode,source:process.env.GITHUB_SHA,sourceSha256:sha,schemaChanges:false,businessDataWrites:false,publishedAssignments:0};let pool;
try{
 const scope=pin.internalCallSchemaMigration;
 if(scope?.sourceSha256!==sha||scope?.table!==table||scope?.sequence!==sequence||scope?.directHost!=='db.prisma.io'||scope?.runtimeHost!=='pooled.db.prisma.io'||scope?.existingData!=='preserve')throw Error('pinned_schema_required');
 const url=new URL(fixture?process.env.WORKFLOW_TEST_DATABASE_URL:process.env.PRODUCTION_DATABASE_URL);
 if(fixture){if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!=='/communication_registration_test'||process.env.PRODUCTION_DATABASE_URL)throw Error('fixture_required');}
 else if(url.hostname!==scope.runtimeHost||url.pathname!=='/postgres'||pin.sqliteFallback!==false||mode!=='--verify'&&process.env.INTERNAL_CALL_SCHEMA_APPLY!=='1')throw Error('pinned_target_required');
 const options=fixture?{connectionString:url.href}:{host:mode==='--verify'?url.hostname:scope.directHost,port:Number(url.port||5432),database:'postgres',user:decodeURIComponent(url.username),password:decodeURIComponent(url.password),ssl:{rejectUnauthorized:true}};
 pool=new pg.Pool({...options,max:1,connectionTimeoutMillis:10000});const db=await pool.connect();
 try{
  await db.query(mode==='--verify'?'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY':'BEGIN');await db.query("SET LOCAL statement_timeout='30s';SET LOCAL lock_timeout='10s';SET LOCAL search_path=pg_catalog,public");
  if(!fixture){const manifest=(await db.query('SELECT manifest_sha256 FROM "'+pin.schema+'"."'+pin.manifestTable+'"')).rows;if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('manifest_mismatch');}
  if(mode!=='--verify')await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',['primecare-internal-call-schema-v1']);
  const before=await snapshot(db,[table]),seqPresent=(await db.query('SELECT to_regclass($1) IS NOT NULL AS present',['public.'+sequence])).rows[0].present;
  if((before[table]!==null)!==seqPresent)throw Error('partial_schema_preserved');
  if(fixture&&before[table]!==null)throw Error('fresh_fixture_required');
  if(before[table]===null){if(mode==='--verify')throw Error('schema_missing');await db.query(sql);report.schemaChanges=true;}
  const shapes=await snapshot(db,[table]),seq=(await db.query("SELECT seqtypid::regtype::text AS type,seqstart::text,seqincrement::text,seqmax::text,seqmin::text,seqcache::text,seqcycle FROM pg_sequence WHERE seqrelid=to_regclass($1)",['public.'+sequence])).rows;
  await privateAcl(db,[table]);
  const acl=(await db.query("SELECT 1 FROM pg_class c CROSS JOIN LATERAL aclexplode(COALESCE(c.relacl,acldefault('S',c.relowner))) a WHERE c.oid=to_regclass($1) AND a.grantee<>c.relowner LIMIT 1",['public.'+sequence])).rows;if(acl.length)throw Error('sequence_acl_preserved');
  const reference={version:1,sourceSha256:sha,shapes,sequence:seq};
  if(fixture){await mkdir('test-results/internal-calls',{recursive:true});await writeFile('test-results/internal-calls/schema-reference.json',JSON.stringify(reference,null,2)+'\n');}
  else {const expected=JSON.parse(await readFile('test-results/internal-calls/schema-reference.json','utf8'));if(JSON.stringify(reference)!==JSON.stringify(expected)){
   const differences=[];function compare(a,b,path=''){if(JSON.stringify(a)===JSON.stringify(b))return;if(a&&b&&typeof a==='object'&&typeof b==='object'){for(const key of new Set([...Object.keys(a),...Object.keys(b)]))compare(a[key],b[key],path+'.'+key);}else differences.push({path,expected:a,actual:b});}compare(expected,reference);report.schemaDifferences=differences.slice(0,12);report.serverVersion=(await db.query('SHOW server_version')).rows[0].server_version;throw Error('existing_schema_preserved');
  }}
  await db.query(mode==='--dry-run'?'ROLLBACK':'COMMIT');report.independentReadback=mode==='--verify';report.verified=true;
 }finally{await db.query('ROLLBACK').catch(()=>{});db.release();}
}catch(e){report.verified=false;report.reason=['pinned_schema_required','pinned_target_required','partial_schema_preserved','schema_missing','existing_schema_preserved','manifest_mismatch','sequence_acl_preserved'].includes(e?.message)?e.message:'schema_setup_failed';if(/^[A-Z0-9]{5}$/.test(e?.code??''))report.databaseErrorCode=e.code;process.exitCode=1;}finally{await pool?.end();}
await mkdir('test-results/internal-calls',{recursive:true});await writeFile('test-results/internal-calls/schema-'+mode.slice(2)+'.json',JSON.stringify(report,null,2)+'\n');console.log('INTERNAL_CALL_SCHEMA '+JSON.stringify(report));
