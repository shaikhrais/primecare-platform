/** Retire exact misidentified grants atomically with their full metadata archive. New grants stay disabled. */
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
import pg from 'pg';
import {metadataStorage} from './auth-preference-artifact-storage.mjs';
import {inspectAuthArtifact} from './auth-preference-artifact.mjs';
export const policy=JSON.parse(await readFile(new URL('./messaging-authority-plan.json',import.meta.url),'utf8'));
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url),'utf8'));
const contracts=JSON.parse(await readFile(new URL('../../packages/shared/src/communications/registered-contracts.json',import.meta.url),'utf8')).apis.slice(0,2);
export const canonical=x=>JSON.stringify(x,(_,v)=>v&&typeof v==='object'&&!Array.isArray(v)?Object.fromEntries(Object.keys(v).sort().map(k=>[k,v[k]])):v);
const same=(a,b)=>canonical(a)===canonical(b),hash=x=>createHash('sha256').update(x).digest('hex');
const table=n=>'"'+pin.schema+'"."'+pin.tablePrefix+n+'"';
const fields=['id','api_id','role_id','runtime_artifact_id','permission_key','can_access'];
const normalized=rows=>rows.map(r=>Object.fromEntries(fields.map(k=>[k,k==='permission_key'?r[k]:Number(r[k])])));
export async function checkMessagingPlan(){
 const expected={optInVariable:'RECONCILE_MESSAGING_AUTHORITY',planSha256:hash(await readFile(new URL('./messaging-authority-plan.json',import.meta.url))),tables:['runtime_artifacts','api_permissions','virtual_flow_catalog_snapshots'],apiIds:[710,857],roleIds:[12,15,51,61,70,72,80],artifactId:3,retiredRows:128,stagedRows:14,newEnabledGrants:0,screenViewsChanged:false,runtimeActivation:false,businessDataWrites:false};
 if(!same(pin.messagingAuthorityWriter,expected)||!/^\w+$/.test(pin.schema)||!/^\w+$/.test(pin.tablePrefix)||policy.activation!==false||policy.stagedCanAccess!==0||policy.artifact.id!==3||policy.artifact.physical_path!=='cloudflare/workers/src/business-tasks/http.ts'||hash(await readFile(policy.artifact.physical_path))!==policy.artifact.checksum||!same(policy.roles.map(r=>r.id),expected.roleIds)||policy.retiredRows.length!==128||policy.stagedRows.length!==14||policy.retiredRows.some((r,i)=>r.api_id!==[710,857][Math.floor(i/64)]||r.role_id!==i%64+1||r.runtime_artifact_id!==1)||policy.stagedRows.some((r,i)=>r.id!==80126+i||r.api_id!==[710,857][Math.floor(i/7)]||r.role_id!==expected.roleIds[i%7]||r.can_access!==0||r.runtime_artifact_id!==3||r.permission_key!=='role_screen_permissions'))throw Error('Exact staged messaging policy required');
 const receipt=policy.releaseEvidence.receipt;
 if(receipt.source!==policy.sourceCommit||receipt.versionId!==policy.versionId||receipt.deploymentId!==policy.deploymentId||receipt.worker!==policy.worker||receipt.sourceCheckoutVerified!==true||receipt.independentlyReadDeployment!==true)throw Error('Deployment-backed source receipt required');
}
async function authority(db){
 const rows=(await db.query('SELECT manifest_sha256,manifest FROM '+table('source_manifest'))).rows;
 if(rows.length!==1||rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Pinned authority changed');
 return rows[0].manifest;
}
async function checkContracts(db,manifest,lock=false){
 const storage=await metadataStorage(db,pin,manifest,'api_endpoints');
 const keys=['id','http_method','route_path','auth_required','permission_key','service_name','request_schema','response_schema','implementation_status'];
 const endpoints=(await db.query('SELECT '+keys.join(',')+' FROM '+table('api_endpoints')+' WHERE id IN (710,857) ORDER BY id'+(lock?' FOR SHARE':''))).rows.map(r=>Object.fromEntries(keys.map(k=>[k,storage.decode(k,r[k])])));
 if(endpoints.length!==2||endpoints.some((e,i)=>{const c=contracts[i];return e.id!==c.id||e.http_method!==c.method||e.route_path!==c.path||e.auth_required!==1||e.permission_key!==c.permission||e.service_name!=='governance'||!same(JSON.parse(e.request_schema),c.requestSchema)||!same(JSON.parse(e.response_schema),c.responseSchema)||!['registered-unimplemented','implemented-unverified'].includes(e.implementation_status);}))throw Error('Registered messaging contract changed');
 const roles=(await db.query('SELECT id,role_code,active FROM '+table('roles')+' WHERE id IN (12,15,51,61,70,72,80) ORDER BY id'+(lock?' FOR SHARE':''))).rows;
 if(roles.length!==7||roles.some((r,i)=>Number(r.id)!==policy.roles[i].id||r.role_code?.toLowerCase()!==policy.roles[i].code||Number(r.active)!==1))throw Error('Existing approved roles changed');
 const origins=(await db.query('SELECT id,api_id,endpoint_code,endpoint_path,method FROM '+table('api_endpoint_registry')+' WHERE id IN (710,857) ORDER BY id'+(lock?' FOR SHARE':''))).rows.map(r=>({...r,id:Number(r.id),api_id:Number(r.api_id)}));
 if(!same(origins,policy.legacyOrigins))throw Error('Legacy origin declarations changed');
 const restored=(await db.query('SELECT id FROM '+table('api_endpoints')+' WHERE id IN (4957,5104) OR (http_method=$1 AND route_path IN ($2,$3))',['GET',...policy.legacyOrigins.map(o=>o.endpoint_path)])).rows;
 if(restored.length)throw Error('Legacy endpoint restored; preserve its authority for review');
}
async function current(db){return normalized((await db.query('SELECT '+fields.join(',')+' FROM '+table('api_permissions')+' WHERE api_id IN (710,857) ORDER BY id')).rows);}
async function audit(db,storage){
 const rows=(await db.query('SELECT summary_json FROM '+table('virtual_flow_catalog_snapshots')+' WHERE name=$1',[storage.encode('name',policy.auditSnapshotName)])).rows;
 if(!rows.length)return null;if(rows.length!==1)throw Error('Duplicate migration archive');
 const a=JSON.parse(storage.decode('summary_json',rows[0].summary_json));
 if(a.planSha256!==pin.messagingAuthorityWriter.planSha256||!same(a.retiredRows,policy.retiredRows)||!same(normalized(a.physicalBefore),policy.retiredRows)||a.physicalBeforeSha256!==hash(canonical(a.physicalBefore))||!same(a.stagedRows,policy.stagedRows)||a.physicalBefore.some(r=>!Object.hasOwn(r,'_primecare_import_row')||!Object.hasOwn(r,'created_at')))throw Error('Migration archive differs');return a;
}
async function artifact(db,storage){const keys=Object.keys(policy.artifact);const rows=(await db.query('SELECT '+keys.join(',')+' FROM '+table('runtime_artifacts')+' WHERE id=$1',[storage.encode('id',3)])).rows;return rows.map(r=>Object.fromEntries(keys.map(k=>[k,storage.decode(k,r[k])])));}
async function insert(db,name,storage,values,ordinal){const keys=Object.keys(values);await db.query('INSERT INTO '+table(name)+' (_primecare_import_row,'+keys.join(',')+') VALUES ('+[ordinal,...keys].map((_,i)=>'$'+(i+1)).join(',')+')',[ordinal,...keys.map(k=>storage.encode(k,values[k]))]);}
async function ordinal(db,name){const n=Number((await db.query('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 AS ordinal FROM '+table(name))).rows[0].ordinal);if(!Number.isSafeInteger(n)||n<0)throw Error('Invalid internal row allocation');return n;}
export async function reconcileMessaging(db,{apply=false,verifyDeployment=async()=>{}}={}){
 await checkMessagingPlan();await db.query('BEGIN');try{
  await db.query("SET LOCAL lock_timeout='10s'");await db.query("SET LOCAL statement_timeout='60s'");
  await db.query('LOCK TABLE '+['api_permissions','runtime_artifacts','virtual_flow_catalog_snapshots'].map(table).join(',')+' IN SHARE ROW EXCLUSIVE MODE');
  const manifest=await authority(db);await checkContracts(db,manifest,true);
  const auth=await inspectAuthArtifact(db);if(auth.approvedAdminGrantReferences!==3)throw Error('All 67 self-preference grants required');
  const grantStorage=await metadataStorage(db,pin,manifest,'api_permissions'),artifactStorage=await metadataStorage(db,pin,manifest,'runtime_artifacts'),snapshotStorage=await metadataStorage(db,pin,manifest,'virtual_flow_catalog_snapshots');
  const before=await current(db),archive=await audit(db,snapshotStorage),artifacts=await artifact(db,artifactStorage),already=same(before,policy.stagedRows)&&same(artifacts,[policy.artifact])&&!!archive;
  const unrelated=(await db.query('SELECT * FROM '+table('api_permissions')+' WHERE api_id NOT IN (710,857) ORDER BY id')).rows;
  if(!already){
   const allArtifacts=(await db.query('SELECT id FROM '+table('runtime_artifacts'))).rows.map(r=>artifactStorage.decode('id',r.id));
   const maxima=(await db.query('SELECT max(id) AS id,max(runtime_artifact_id) AS artifact FROM '+table('api_permissions'))).rows[0];
   if(archive||artifacts.length||!same(allArtifacts,[2])||Number(maxima.id)!==80125||Number(maxima.artifact)!==2||!same(before,policy.retiredRows))throw Error('Exact before-state changed; preserve it');
   const full=(await db.query('SELECT * FROM '+table('api_permissions')+' WHERE api_id IN (710,857) ORDER BY id')).rows;
   const saved={format:1,planSha256:pin.messagingAuthorityWriter.planSha256,retiredRows:before,physicalBefore:full,physicalBeforeSha256:hash(canonical(full)),stagedRows:policy.stagedRows,releaseEvidence:policy.releaseEvidence,migrationSource:process.env.GITHUB_SHA??'isolated-test',recordedAt:new Date().toISOString()};
   const first=await ordinal(db,'api_permissions');
   await insert(db,'virtual_flow_catalog_snapshots',snapshotStorage,{name:policy.auditSnapshotName,summary_json:JSON.stringify(saved),updated_at:saved.recordedAt},await ordinal(db,'virtual_flow_catalog_snapshots'));
   await insert(db,'runtime_artifacts',artifactStorage,policy.artifact,await ordinal(db,'runtime_artifacts'));
   const removed=(await db.query('DELETE FROM '+table('api_permissions')+' WHERE api_id IN (710,857) RETURNING id')).rows.map(r=>Number(r.id)).sort((a,b)=>a-b);
   if(!same(removed,policy.retiredRows.map(r=>r.id)))throw Error('Retirement scope changed');
   for(const [i,row] of policy.stagedRows.entries())await insert(db,'api_permissions',grantStorage,{...row,created_at:saved.recordedAt},first+i);
  }
  if(!same(await current(db),policy.stagedRows)||!same(await artifact(db,artifactStorage),[policy.artifact])||!await audit(db,snapshotStorage)||!same((await db.query('SELECT * FROM '+table('api_permissions')+' WHERE api_id NOT IN (710,857) ORDER BY id')).rows,unrelated))throw Error('Transaction scope verification failed');
  await inspectAuthArtifact(db);await verifyDeployment();await db.query(apply?'COMMIT':'ROLLBACK');
  return {committed:apply,alreadyReconciled:already,retiredIncorrectRows:already?0:128,newDisabledRows:already?0:14,enabledMessagingGrants:0,artifactId:3,archivedRows:128,archiveName:policy.auditSnapshotName,preferenceGrantsPreserved:67,otherApiGrantsChanged:0,screenViewsChanged:0,runtimeActivated:false};
 }catch(e){await db.query('ROLLBACK');throw e;}
}
export async function readMessaging(db){await checkMessagingPlan();await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');try{const m=await authority(db),s=await metadataStorage(db,pin,m,'virtual_flow_catalog_snapshots'),a=await metadataStorage(db,pin,m,'runtime_artifacts');await checkContracts(db,m);if(!same(await current(db),policy.stagedRows)||!same(await artifact(db,a),[policy.artifact])||!await audit(db,s))throw Error('Independent messaging readback differs');const auth=await inspectAuthArtifact(db);if(auth.approvedAdminGrantReferences!==3)throw Error('Preference grants changed');await db.query('ROLLBACK');return {independentReadback:true,disabledMessagingRows:14,enabledMessagingGrants:0,archivedRows:128,preferenceGrants:67,runtimeActivated:false};}catch(e){await db.query('ROLLBACK');throw e;}}
/** A staged grant may reference a real previously deployed version; activation needs fresh active-version acceptance. */
export async function verifyMessagingOwner({account=process.env.CLOUDFLARE_ACCOUNT_ID,token=process.env.CLOUDFLARE_API_TOKEN,fetcher=fetch}={}){
 if(!/^[a-f0-9]{32}$/i.test(account??'')||!token)throw Error('Scoped provider configuration required');
 const get=async suffix=>{const r=await fetcher('https://api.cloudflare.com/client/v4/accounts/'+account+'/workers/scripts/'+policy.worker+suffix,{method:'GET',redirect:'error',signal:AbortSignal.timeout(30000),headers:{authorization:'Bearer '+token}});if(!r.ok)throw Error('Provider identity read rejected');const j=await r.json();if(j.success!==true)throw Error('Provider identity rejected');return j.result;};
 const settings=await get('/settings'),version=await get('/versions/'+policy.versionId);
 const service=settings.bindings?.filter(b=>b.name==='SERVICE_NAME'&&b.type==='plain_text');
 if(service?.length!==1||service[0].text!=='governance'||version.id!==policy.versionId)throw Error('Known deployed messaging owner unavailable');
 return {knownDeployedVersionVerified:true,activationApproved:false};
}
let phase='configuration';async function main(){if(process.env.RECONCILE_MESSAGING_AUTHORITY!=='1')throw Error('Explicit reconciliation required');await checkMessagingPlan();const raw=process.env.PRODUCTION_DATABASE_URL;if(!raw||process.env.GOVERNANCE_DATABASE_URL&&raw!==process.env.GOVERNANCE_DATABASE_URL)throw Error('Pinned target required');const u=new URL(raw);if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres')throw Error('Pinned target required');phase='worker_identity';await verifyMessagingOwner();const db=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});await db.connect();let result;try{phase=process.argv.includes('--readback')?'readback':process.argv.includes('--apply')?'apply':'preview';result=phase==='readback'?await readMessaging(db):await reconcileMessaging(db,{apply:phase==='apply',verifyDeployment:verifyMessagingOwner});}finally{await db.end();}await mkdir('test-results/messaging-authority',{recursive:true});await writeFile('test-results/messaging-authority/'+phase+'.json',JSON.stringify(result,null,2)+'\n');console.log('MESSAGING_AUTHORITY '+JSON.stringify(result));}
if(import.meta.url===pathToFileURL(process.argv[1]??'').href)main().catch(e=>{console.error('MESSAGING_AUTHORITY_FAILURE '+JSON.stringify({phase,code:/^[A-Z0-9_]{5,24}$/.test(e?.code??'')?e.code:'scope_or_provider_validation'}));process.exitCode=1;});
