/** Production governance audit: aggregate SELECTs only; never exports row values. */
import pg from 'pg';
import {readFile,writeFile,mkdir} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {resolve,dirname} from 'node:path';
const here=dirname(fileURLToPath(import.meta.url));
export const quote=s=>'"'+s.replaceAll('"','""')+'"';
const number=v=>{const n=Number(v);if(!Number.isSafeInteger(n)||n<0)throw Error('Unsafe aggregate count');return n;};
const mandatory={roles:'Role definitions required by architecture and permissions.',screens:'Governed screen registry required by architecture.',api_endpoints:'Registered API identities and contracts; retain quarantined identity evidence.',api_permissions:'Permission identity evidence; rows do not establish authority.',theme_design_tokens:'Theme authority required by AGENTS section 10.',language_resources:'Localization resource definitions required by AGENTS section 11.',language_resource_values:'Localized values required by AGENTS section 11.',virtual_workflow_definitions:'User-required business-process catalogue and supporting guides.',virtual_workflow_steps:'User-required workflow acceptance steps.',virtual_workflow_source_links:'User-required specification/source binding evidence.',virtual_role_flow_guides:'User-required supporting role guides, not additional business processes.',virtual_flow_catalog_snapshots:'User-required saved catalogue evidence.',virtual_workflow_attempts:'Verification attempts must retain reproducible outcomes.',virtual_workflow_issues:'Verification failures must retain their recorded requirements.',virtual_workflow_issue_resolutions:'Issue-resolution evidence must remain traceable.',virtual_workflow_evidence:'Verification evidence must not be discarded during metadata cleanup.',virtual_workflow_checkpoints:'Resumption and source/evidence validity checkpoints.'};
const historical={screen_change_history:['old_state_json','new_state_json','created_at'],screen_stage_history:['old_stage','new_stage','changed_at'],translation_history:['old_text','new_text','changed_at'],migration_history:['migration_name','schema_snapshot','applied_at'],governance_snapshots:['snapshot_json','created_at'],rollback_snapshots:['schema_snapshot','data_snapshot','created_at']};
export function disposition(t){
 const reasons=[],tags=[];let action='owner-and-consumer-review';
 if(t.kind==='import-provenance'){action='retain-required-provenance';reasons.push('Pinned connection and import fidelity depend on this metadata.');}
 else if(mandatory[t.sourceName]){action=t.sourceName.includes('evidence')||t.sourceName.includes('snapshot')||t.sourceName.includes('attempt')||t.sourceName.includes('issue')||t.sourceName.includes('checkpoint')?'retain-verification-evidence':'retain-required-metadata';reasons.push(mandatory[t.sourceName]);}
 else if(historical[t.sourceName]?.every(c=>t.columns.includes(c))){action='retain-historical-evidence';reasons.push('Source schema records prior state, snapshots or migration evidence. Retention policy is not established.');}
 else if(t.references.activeReaderReferences.length){action='retain-reader-dependency';reasons.push('A previously migrated production reader explicitly names this relation; see source references.');}
 else if(t.incomingReferencedRows>0){action='retain-referenced-metadata';reasons.push('Declared source relationships have populated incoming references.');}
 else if(t.rows===0){action='empty-schema-review';reasons.push('An empty relation may support required future functionality; emptiness is not obsolescence.');}
 if(t.exactDuplicates?.extraRows>0)tags.push('exact-duplicate-candidates');
 if(t.nonKeyPayloadDuplicates?.extraRows>0)tags.push('same-non-key-payload-candidates');
 if(t.explicitRetiredRows>0)tags.push('explicit-retirement-marker-candidates');
 if(t.inactiveRows>0)tags.push('inactive-records-not-necessarily-obsolete');
 if(t.references.files===0)tags.push('no-static-mentions-dynamic-consumers-unresolved');
 if(t.foreignKeys.some(f=>f.orphanRows>0))tags.push('declared-reference-gaps');
 if(t.checkErrors.length)tags.push('incomplete-checks');
 return {action,reasons,tags,cleanupAuthorized:false,cleanupBlockers:['Per-record identity and replacement mapping must be reviewed.','Declared foreign keys do not cover JSON, code or external evidence references.','Owner/retention requirements and evidence holds must be resolved before deletion.']};
}
export async function auditDatabase(db,pin,manifest,plan,sourceIndex,{progress=()=>{}}={}){
 const qtable=name=>quote(pin.schema)+'.'+quote(name);let seq=0;
 const query=async(label,fn,errors)=>{const save='audit_'+(++seq);await db.query('SAVEPOINT '+save);try{const result=await fn();await db.query('RELEASE SAVEPOINT '+save);return result;}catch(e){await db.query('ROLLBACK TO SAVEPOINT '+save);await db.query('RELEASE SAVEPOINT '+save);errors.push({check:label,code:e.code||e.name});return null;}};
 const count=async(sql,params=[])=>number((await db.query(sql,params)).rows[0].n);
 const inventory=(await db.query('SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname=$1 ORDER BY tablename',[pin.schema])).rows.map(r=>r.tablename);
 const byPhysical=new Map(manifest.tables.map(t=>[t.name.startsWith(pin.tablePrefix)?t.name:pin.tablePrefix+t.name,t]));
 const result=[];
 for(const [position,name] of inventory.entries()){
  progress({table:name,position:position+1,total:inventory.length});
  const source=byPhysical.get(name),p=source?plan[source.name]:null;
  const columns=(await db.query('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=$1 AND table_name=$2 ORDER BY ordinal_position',[pin.schema,name])).rows;
  const t={table:name,sourceName:source?.name??null,kind:name===pin.manifestTable?'import-provenance':source?.name==='sqlite_sequence'?'import-provenance':source?'source-table':'unregistered-table',columns:source?source.columns.map(c=>c.name):columns.map(c=>c.column_name),primaryKey:p?.primaryKey??[],references:sourceIndex.tables[source?.name]??{mentions:0,files:0,references:[],activeReaderReferences:[],sqlReadFiles:0,sqlWriteFiles:0},rows:null,sourceImportRows:source?.rows??null,checkErrors:[],foreignKeys:[],uniqueKeys:[],incomingReferencedRows:0,retiredIncomingReferences:[],explicitRetiredRows:0,inactiveRows:0,unexpectedNullCodecRows:0};
  const from=qtable(name);
  const cmap=new Map((source?.columns??[]).map(c=>[c.name,c]));
  const expr=(c,alias='')=>{const col=(alias?quote(alias)+'.':'')+quote(c);return cmap.get(c)?.storage_types.length===0?`CASE WHEN ${col} IS NULL OR ${col}->>'t'='null' THEN NULL::jsonb ELSE ${col} END`:col;};
  t.rows=await query('row-count',()=>count('SELECT count(*) n FROM '+from),t.checkErrors);
  t.contentSha256=await query('content-fingerprint',async()=>{const sql=`SELECT encode(sha256(convert_to(coalesce(string_agg(h,'' ORDER BY h),''),'UTF8')),'hex') h FROM (SELECT encode(sha256(convert_to((to_jsonb(t)-'_primecare_import_row')::text,'UTF8')),'hex') h FROM ${from} t) x`;return (await db.query(sql)).rows[0].h;},t.checkErrors);
  t.storageBytes=await query('storage-size',async()=>number((await db.query('SELECT pg_total_relation_size($1::regclass) n',[from])).rows[0].n),t.checkErrors);
  if(source){
   const missing=t.columns.filter(c=>!columns.some(actual=>actual.column_name===c));if(missing.length)t.checkErrors.push({check:'source-columns',code:'MISSING_COLUMNS',columns:missing});
   const nullCols=source.columns.filter(c=>c.storage_types.length===0);
   if(nullCols.length)t.unexpectedNullCodecRows=await query('null-codec',()=>count(`SELECT count(*) n FROM ${from} WHERE `+nullCols.map(c=>`${quote(c.name)} IS NOT NULL AND (${quote(c.name)}->>'t' IS DISTINCT FROM 'null' OR jsonb_typeof(${quote(c.name)}) IS DISTINCT FROM 'object')`).join(' OR ')),t.checkErrors);
   const duplicates=async names=>{if(!names.length)return {groups:0,extraRows:0,notChecked:'No non-key payload columns.'};const r=(await db.query(`SELECT count(*) n,coalesce(sum(n-1),0) extra FROM (SELECT count(*) n FROM ${from} GROUP BY ${names.map(c=>expr(c)).join(',')} HAVING count(*)>1) d`)).rows[0];return {groups:number(r.n),extraRows:number(r.extra)};};
   t.exactDuplicates=await query('exact-duplicates',()=>duplicates(t.columns),t.checkErrors);
   t.nonKeyPayloadDuplicates=await query('non-key-payload-duplicates',()=>duplicates(t.columns.filter(c=>!t.primaryKey.includes(c))),t.checkErrors);
   for(const key of p.uniqueKeys){
    if(key.partial||key.expression||key.collations.some(c=>c!=='BINARY')){t.uniqueKeys.push({...key,notChecked:'Partial/expression/non-binary source semantics require explicit dialect review.'});continue;}
    const metrics=await query('unique-key:'+key.name,async()=>{const r=(await db.query(`SELECT count(*) n,coalesce(sum(n-1),0) extra FROM (SELECT count(*) n FROM ${from} WHERE ${key.columns.map(c=>expr(c)+' IS NOT NULL').join(' AND ')} GROUP BY ${key.columns.map(c=>expr(c)).join(',')} HAVING count(*)>1) d`)).rows[0];return {duplicateGroups:number(r.n),extraRows:number(r.extra)};},t.checkErrors);
    t.uniqueKeys.push({...key,...metrics});
   }
   const retired=source.columns.filter(c=>['status','implementation_status','lifecycle_status'].includes(c.name)&&c.storage_types.length===1&&c.storage_types[0]==='text').map(c=>`lower(trim(${quote(c.name)})) IN ('retired','obsolete','deprecated','superseded','deleted','archived')`);
   t.retirementPredicate=retired.length?'('+retired.join(' OR ')+')':null;
   if(retired.length)t.explicitRetiredRows=await query('explicit-retirement-markers',()=>count(`SELECT count(*) n FROM ${from} WHERE ${t.retirementPredicate}`),t.checkErrors);
   const inactive=source.columns.filter(c=>['active','is_active'].includes(c.name)&&c.storage_types.length===1&&c.storage_types[0]==='integer').map(c=>quote(c.name)+'=0');
   if(inactive.length)t.inactiveRows=await query('inactive-markers',()=>count(`SELECT count(*) n FROM ${from} WHERE `+inactive.join(' OR ')),t.checkErrors);
   const dates=source.columns.filter(c=>['created_at','updated_at','changed_at','applied_at','tested_at'].includes(c.name)&&c.storage_types[0]==='text').slice(0,2);
   t.datePrefixes={};for(const c of dates)t.datePrefixes[c.name]=await query('date-prefix:'+c.name,async()=>(await db.query(`SELECT min(left(${quote(c.name)},10)) first,max(left(${quote(c.name)},10)) last FROM ${from} WHERE ${quote(c.name)} ~ '^\\d{4}-\\d{2}-\\d{2}'`)).rows[0],t.checkErrors);
  }
  result.push(t);
 }
 const bySource=new Map(result.filter(t=>t.sourceName).map(t=>[t.sourceName,t]));
 for(const child of result.filter(t=>t.sourceName)){
  const childSource=byPhysical.get(child.table);
  for(const fk of plan[child.sourceName].foreignKeys){
   const target=bySource.get(fk.target),targetSource=target?byPhysical.get(target.table):null;
   const parts=fk.parts.sort((a,b)=>a.seq-b.seq).map(part=>({...part,to:part.to??plan[fk.target]?.primaryKey[part.seq]}));
   const f={id:fk.id,target:fk.target,columns:parts.map(p=>p.from),targetColumns:parts.map(p=>p.to),orphanRows:null};child.foreignKeys.push(f);
   if(!target){f.notChecked='Referenced target relation is absent from the pinned schema.';continue;}
   const compatible=parts.every(part=>{const a=childSource.columns.find(c=>c.name===part.from),b=targetSource.columns.find(c=>c.name===part.to);return a?.storage_types.length===1&&b?.storage_types.length===1&&a.storage_types[0]===b.storage_types[0]&&!(plan[fk.target].uniqueKeys.some(k=>k.columns.includes(part.to)&&k.collations.some(c=>c!=='BINARY')));});
   if(!compatible){f.notChecked='Source storage affinity, empty JSONB type or collation requires explicit review.';continue;}
   const nonnull=parts.map(p=>'c.'+quote(p.from)+' IS NOT NULL').join(' AND '),join=parts.map(p=>'p.'+quote(p.to)+'=c.'+quote(p.from)).join(' AND ');
   const cf=qtable(child.table),tf=qtable(target.table);
   f.orphanRows=await query('foreign-key:'+fk.id,()=>count(`SELECT count(*) n FROM ${cf} c WHERE ${nonnull} AND NOT EXISTS(SELECT 1 FROM ${tf} p WHERE ${join})`),child.checkErrors);
   f.referencingRows=await query('foreign-key-incoming:'+fk.id,()=>count(`SELECT count(*) n FROM ${cf} c WHERE ${nonnull} AND EXISTS(SELECT 1 FROM ${tf} p WHERE ${join})`),child.checkErrors);
   target.incomingReferencedRows+=f.referencingRows??0;
   if(target.explicitRetiredRows>0&&target.retirementPredicate){const pred=target.retirementPredicate.replaceAll(/"([^"]+)"/g,'p."$1"');const n=await query('retired-reference:'+fk.id,()=>count(`SELECT count(*) n FROM ${cf} c WHERE ${nonnull} AND EXISTS(SELECT 1 FROM ${tf} p WHERE ${join} AND ${pred})`),child.checkErrors);target.retiredIncomingReferences.push({table:child.table,foreignKey:fk.id,rows:n});}
  }
 }
 let apiGrantIdentityReview=null;
 if(['api_permissions','api_endpoints','api_endpoint_registry'].every(n=>bySource.has(n))){const errors=[];apiGrantIdentityReview={scope:'Identity-domain audit only; not authorization or cleanup approval.',counts:await query('api-grant-identity',async()=>{const r=await db.query(`SELECT CASE WHEN e.id IS NULL THEN 'missing_endpoint' WHEN r.id IS NULL OR p.permission_key IS DISTINCT FROM 'api_permission_'||r.endpoint_code THEN 'unknown_key_origin' WHEN e.http_method IS DISTINCT FROM r.method OR e.route_path IS DISTINCT FROM r.endpoint_path THEN 'registry_endpoint_identity_mismatch' ELSE 'identity_matches_requires_authority_review' END classification,count(*) n FROM ${qtable(bySource.get('api_permissions').table)} p LEFT JOIN ${qtable(bySource.get('api_endpoints').table)} e ON e.id=p.api_id LEFT JOIN ${qtable(bySource.get('api_endpoint_registry').table)} r ON r.id=p.api_id GROUP BY 1`);return Object.fromEntries(r.rows.map(row=>[row.classification,number(row.n)]));},errors),checkErrors:errors};}
 let businessProcesses=null;
 if(bySource.has('virtual_workflow_definitions')){const table=qtable(bySource.get('virtual_workflow_definitions').table);const r=await db.query(`SELECT verification_status,count(*) n FROM ${table} WHERE flow_kind=$1 GROUP BY verification_status`,['business_process']);businessProcesses={total:r.rows.reduce((n,row)=>n+number(row.n),0),statuses:Object.fromEntries(r.rows.map(row=>[['missing','implemented-unverified','verified','blocked'].includes(row.verification_status)?row.verification_status:'unknown-status',number(row.n)]))};}
 for(const t of result){t.assessment=disposition(t);t.schemaInferredPurpose=t.sourceName?`Records described by source columns: ${t.columns.slice(0,8).join(', ')}. See source references for actual duties; no unstated purpose is assumed.`:'Import provenance or unregistered relation requiring schema review.';delete t.retirementPredicate;}
 return {tables:result,apiGrantIdentityReview,businessProcesses,inventoryDrift:{missingSourceTables:[...byPhysical.keys()].filter(name=>!inventory.includes(name)),unexpectedTables:inventory.filter(name=>name!==pin.manifestTable&&!byPhysical.has(name))},sourceIndexSummary:{scannedFiles:sourceIndex.scannedFiles,skippedFiles:sourceIndex.skippedFiles,limits:sourceIndex.limits},complete:result.every(t=>t.rows!==null&&t.contentSha256)&&result.every(t=>t.checkErrors.length===0),cleanupAuthorized:false,limitations:['No records were exported, deleted, changed or reclassified in the database.','Duplicates and retirement markers are review candidates, not approved deletions. Repeated evidence can be intentional.','Source primary/unique/foreign key declarations are metadata; they were not all recreated as PostgreSQL constraints.','Foreign-key checks with unresolved source affinity, collation or partial/expression semantics are explicitly not checked.','Static source mentions do not prove runtime use, and no mentions do not prove obsolescence. JSON/external references remain unresolved.','Date prefixes are observations, not retention eligibility. No retention policy is invented.','This audit is bound to the database snapshot/content fingerprints and repository source; rerun after either changes.']};
}
async function main(){
 const pin=JSON.parse(await readFile(resolve(here,'production-pin.json'),'utf8'));
 if(process.env.GOVERNANCE_ALLOW_SQLITE_FIXTURES==='1')throw Error('Production audit refuses SQLite fixture mode');
 const a=process.env.GOVERNANCE_DATABASE_URL,b=process.env.PRODUCTION_DATABASE_URL;if(a&&b&&a!==b)throw Error('Conflicting configuration');const url=new URL(a||b||'');
 if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres')throw Error('Unexpected database target');
 const db=new pg.Client({connectionString:url.href,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});
 try{await db.connect();await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await db.query("SET LOCAL statement_timeout='120s'");await db.query("SET LOCAL lock_timeout='5s'");
  if((await db.query('SHOW transaction_read_only')).rows[0].transaction_read_only!=='on')throw Error('Audit requires read-only snapshot');
  const rows=(await db.query(`SELECT manifest_sha256,manifest FROM ${quote(pin.schema)}.${quote(pin.manifestTable)}`)).rows;if(rows.length!==1||rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Manifest mismatch');
  const manifest=rows[0].manifest,input=JSON.stringify(manifest),root=resolve(here,'../..');
  const plan=JSON.parse(execFileSync('python3',[resolve(here,'audit-schema.py')],{input,encoding:'utf8',maxBuffer:32*1024*1024}));
  const sourceIndex=JSON.parse(execFileSync('python3',[resolve(here,'audit-source-index.py'),root],{input,encoding:'utf8',maxBuffer:32*1024*1024}));
  const snapshot=(await db.query('SELECT txid_current_snapshot()::text snapshot,current_timestamp audited_at')).rows[0];
  const result=await auditDatabase(db,pin,manifest,plan,sourceIndex,{progress:p=>process.stderr.write(JSON.stringify(p)+'\n')});
  const output=resolve(process.argv[2]||'/tmp/governance-table-audit.json');await mkdir(dirname(output),{recursive:true});
  await writeFile(output,JSON.stringify({auditVersion:1,sourceCommit:process.env.GITHUB_SHA||execFileSync('git',['rev-parse','HEAD'],{cwd:root,encoding:'utf8'}).trim(),pin,snapshot,...result},null,2)+'\n');
  await db.query('ROLLBACK');process.stdout.write(JSON.stringify({tables:result.tables.length,sourceRows:result.tables.filter(t=>t.kind==='source-table'||t.sourceName==='sqlite_sequence').reduce((n,t)=>n+(t.rows??0),0),complete:result.complete,cleanupAuthorized:false})+'\n');if(!result.complete)process.exitCode=1;
 }finally{await db.end();}
}
if(process.argv[1]&&resolve(process.argv[1])===fileURLToPath(import.meta.url))main().catch(e=>{process.stderr.write(JSON.stringify({phase:'audit-failed',code:e.code||e.name})+'\n');process.exitCode=1;});
