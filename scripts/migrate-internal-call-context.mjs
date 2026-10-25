import pg from 'pg';import {readFile,mkdir,writeFile} from 'node:fs/promises';import {createHash} from 'node:crypto';
const mode=process.argv[2];if(!['--dry-run','--apply','--verify'].includes(mode))throw Error('Explicit context migration mode required');
const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8')),scope=pin.internalCallContextProcedure,sql=await readFile('packages/database/migrations/20261025_internal_call_context.sql','utf8'),body=sql.split('$context$')[1],hash=createHash('sha256').update(sql).digest('hex'),signature='public.primecare_call_context_v1(text,text,text,text,text,text[],text)';
const report={source:process.env.GITHUB_SHA,mode,created:false,reused:false,verified:false,governanceRowWrites:false,businessDataWrites:false,permissionChanges:false};let db,transaction=false;
const fail=reason=>{throw Error(reason);};
async function manifest(){const rows=(await db.query(`SELECT manifest_sha256 FROM "${pin.schema}"."${pin.manifestTable}"`)).rows;if(rows.length!==1||rows[0].manifest_sha256!==pin.manifestSha256)fail('manifest_mismatch');}
async function existing(){return (await db.query(`SELECT p.prosrc,p.provolatile,p.prosecdef,p.proconfig,p.prorettype='jsonb'::regtype AS jsonb_result,p.proretset,p.pronargdefaults,p.proowner=(SELECT oid FROM pg_roles WHERE rolname=current_user) AS owned,l.lanname,
 NOT EXISTS(SELECT 1 FROM aclexplode(COALESCE(p.proacl,acldefault('f',p.proowner))) a WHERE a.grantee<>p.proowner) AS owner_only
 FROM pg_proc p JOIN pg_language l ON l.oid=p.prolang WHERE p.oid=to_regprocedure($1)`,[signature])).rows;}
function verify(rows){if(rows.length!==1||rows[0].prosrc!==body||rows[0].provolatile!=='s'||rows[0].prosecdef!==false||rows[0].lanname!=='sql'||rows[0].jsonb_result!==true||rows[0].proretset!==false||rows[0].pronargdefaults!==3||rows[0].owned!==true||rows[0].owner_only!==true||JSON.stringify(rows[0].proconfig)!==JSON.stringify(['search_path=pg_catalog, public']))fail('existing_context_preserved');}
try{
 if(!scope||scope.sourceSha256!==hash||scope.signature!==signature||scope.runtimeHost!=='pooled.db.prisma.io'||scope.directHost!=='db.prisma.io'||scope.securityInvoker!==true||scope.ownerOnly!==true||scope.readOnly!==true||scope.governanceRowWrites!==false||scope.businessDataWrites!==false||pin.sqliteFallback!==false||!/^governance_[a-f0-9]+$/.test(pin.schema)||pin.manifestTable!=='govt_source_manifest'||!body)fail('pinned_context_scope_required');
 const fixture=!!process.env.CALL_CONTEXT_TEST_DATABASE_URL,url=new URL(fixture?process.env.CALL_CONTEXT_TEST_DATABASE_URL:process.env.PRODUCTION_DATABASE_URL);
 if(fixture){if(process.env.PRODUCTION_DATABASE_URL||!['localhost','127.0.0.1'].includes(url.hostname)||url.username!=='twilio_fixture'||url.pathname!=='/twilio_sms_test')fail('fixture_target_required');}
 else if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!==scope.runtimeHost||url.pathname!=='/postgres'||url.port&&url.port!=='5432'||!url.username||!url.password)fail('pinned_context_target_required');
 if(mode==='--apply'&&process.env.CALL_CONTEXT_APPLY!=='1')fail('context_apply_opt_in_required');
 db=new pg.Client(fixture?{connectionString:url.href}:{host:mode==='--verify'?scope.runtimeHost:scope.directHost,port:5432,database:'postgres',user:decodeURIComponent(url.username),password:decodeURIComponent(url.password),ssl:{rejectUnauthorized:true}});await db.connect();
 await db.query(mode==='--verify'?'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY':'BEGIN');transaction=true;await db.query("SET LOCAL statement_timeout='30s';SET LOCAL lock_timeout='5s'");await manifest();
 const rows=await existing();if(rows.length){verify(rows);report.reused=true;}else{
  if(mode==='--verify')fail('context_missing');
  // Never replace an existing function or change grants on an unknown object.
  await db.query(sql);verify(await existing());report.created=mode==='--apply';report.wouldCreate=true;
 }
 await manifest();await db.query(mode==='--apply'?'COMMIT':'ROLLBACK');transaction=false;report.verified=true;report.independentReadback=mode==='--verify';report.sourceSha256=hash;
}catch(error){report.reason=['pinned_context_scope_required','fixture_target_required','pinned_context_target_required','context_apply_opt_in_required','manifest_mismatch','existing_context_preserved','context_missing'].includes(error?.message)?error.message:'context_migration_failed';if(/^[A-Z0-9]{5}$/.test(error?.code??''))report.sqlState=error.code;process.exitCode=1;
}finally{if(transaction)await db?.query('ROLLBACK').catch(()=>{});await db?.end().catch(()=>{});await mkdir('test-results/internal-calls',{recursive:true});await writeFile('test-results/internal-calls/context-'+mode.slice(2)+'.json',JSON.stringify(report,null,2)+'\n');console.log('INTERNAL_CALL_CONTEXT '+JSON.stringify(report));}
