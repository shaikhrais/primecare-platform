/** Bounded activation of existing API777; never grants roles or edits application code. */
import {readFile,writeFile,mkdir,rename} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {execFileSync} from 'node:child_process';
import {pathToFileURL} from 'node:url';
import pg from 'pg';
import {definition,checkPreferenceDefinition,readbackPreferences} from './preference-sync-registration.mjs';
import {approvedAdminRows} from './admin-self-preference-policy.mjs';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url)));
const accepted=JSON.parse(await readFile(new URL('../auth-verification/accepted-auth-live-proof-release.json',import.meta.url)));
export const canonical=value=>JSON.stringify(value,(_,v)=>v&&typeof v==='object'&&!Array.isArray(v)?Object.fromEntries(Object.keys(v).sort().map(k=>[k,v[k]])):v);
const fingerprint=value=>createHash('sha256').update(canonical(value)).digest('hex');
const table=name=>'"'+pin.schema+'"."'+pin.tablePrefix+name+'"';
const expected=accepted.currentCodeRelease;
const retryBaseline=JSON.parse(await readFile(new URL('./pc10-preference-retry-baseline.json',import.meta.url)));
const worker='primecare-auth-api',base='/workers/scripts/'+worker,journalPath='test-results/pc10-preferences/activation.json';
const configKeys=['cache_options','compatibility_date','compatibility_flags','limits','logpush','observability','placement','tags','tail_consumers','usage_model'];
export function activationSettings(settings,flag='1'){
 if(!['0','1'].includes(flag)||!Array.isArray(settings?.bindings)||new Set(settings.bindings.map(b=>b.name)).size!==settings.bindings.length||settings.bindings.some(b=>!b.name||!b.type)||!settings.bindings.some(b=>b.name==='DB_URL'&&b.type==='secret_text')||!settings.bindings.some(b=>b.name==='SERVICE_NAME'&&b.type==='plain_text'&&b.text==='auth'))throw Error('Existing Auth binding scope required');
 const flags=settings.bindings.filter(b=>b.name==='PREFERENCE_SYNC_ENABLED');
 if(flags.length!==1||flags[0].type!=='plain_text'||!['0','1'].includes(flags[0].text))throw Error('Explicit existing preference flag required');
 return {...Object.fromEntries(configKeys.filter(k=>settings[k]!==undefined&&settings[k]!==null).map(k=>[k,settings[k]])),bindings:settings.bindings.map(b=>b.name==='PREFERENCE_SYNC_ENABLED'?{name:b.name,type:'plain_text',text:flag}:{name:b.name,type:'inherit'})};
}
export function verifySettings(before,after,flag){
 activationSettings(before,flag);activationSettings(after,flag);
 const normalize=bindings=>bindings.map(b=>b.type==='secret_text'?{name:b.name,type:b.type}:b).sort((a,b)=>a.name.localeCompare(b.name));
 const wanted=before.bindings.map(b=>b.name==='PREFERENCE_SYNC_ENABLED'?{...b,text:flag}:b);
 if(canonical(normalize(wanted))!==canonical(normalize(after.bindings))||configKeys.some(k=>canonical(before[k])!==canonical(after[k])))throw Error('Settings changed beyond the preference flag');
}
export function reviewedRetrySettings({before,latestVersion,etag,settings},plan){
 if(plan.format!==1||plan.failedSource!=='19d76d8e076c63e2246c01938b538e16ba154b4a'||plan.failedRun!==43508698188||plan.failedJob!==132173573294||plan.runtimeRestored!==true||plan.metadataRestored!==true||plan.grantsChanged!==0||before.id!==plan.rollbackDeployment||before.version!==plan.activeVersion||latestVersion!==plan.stagedVersion||etag!==plan.codeEtag)throw Error('Reviewed rollback identity mismatch');
 const normalized=structuredClone(settings);const flag=normalized.bindings?.find(b=>b.name==='PREFERENCE_SYNC_ENABLED');
 if(flag?.type!=='plain_text'||!['0','1'].includes(flag.text))throw Error('Rollback binding type changed');
 flag.text='0';activationSettings(normalized);
 if(fingerprint(normalized.bindings)!==plan.disabledBindingFingerprint)throw Error('Rollback bindings changed beyond staged preference flag');
 return normalized;
}
export async function promoteMetadata(db,{apply=false,restore=false}={}){
 await checkPreferenceDefinition();await readbackPreferences(db);
 await db.query('BEGIN ISOLATION LEVEL SERIALIZABLE');
 try{
  await db.query("SET LOCAL lock_timeout='5s'");await db.query("SET LOCAL statement_timeout='20s'");
  const grants=(await db.query('SELECT id,api_id,role_id,can_access,permission_key,runtime_artifact_id FROM '+table('api_permissions')+' WHERE api_id=777 ORDER BY role_id FOR SHARE')).rows;
  const original=grants.filter(g=>Number(g.role_id)<=64),extra=grants.filter(g=>Number(g.role_id)>64);
  if(original.length!==64||original.some((g,i)=>Number(g.id)!==49665+i||Number(g.role_id)!==i+1||Number(g.can_access)!==1||g.permission_key!==definition.permissionKey)||extra.length!==3||!approvedAdminRows(extra))throw Error('Existing 67 grants must remain exact');
  const links=(await db.query('SELECT screen_id FROM '+table('screen_api_links')+' WHERE api_id=777 AND screen_id IN (1269,2534) FOR SHARE')).rows;
  if(![1269,2534].every(id=>links.some(row=>Number(row.screen_id)===id)))throw Error('Approved preference host links required');
  const e=(await db.query('SELECT * FROM '+table('api_endpoints')+' WHERE id=777 FOR UPDATE')).rows;
  if(e.length!==1||e[0].route_path!==definition.path||e[0].http_method!=='POST'||Number(e[0].auth_required)!==1||e[0].service_name!=='auth'||e[0].permission_key!==definition.permissionKey||e[0].rate_limit_key!==definition.rateLimitKey||e[0].request_schema!==JSON.stringify(definition.requestSchema)||e[0].response_schema!==JSON.stringify(definition.responseSchema)||!['registered-unimplemented','implemented-unverified'].includes(e[0].implementation_status))throw Error('Canonical endpoint changed');
  const target=restore?'registered-unimplemented':'implemented-unverified',changed=e[0].implementation_status!==target;
  if(changed){const update=await db.query('UPDATE '+table('api_endpoints')+' SET implementation_status=$1 WHERE id=777 AND implementation_status=$2',[target,e[0].implementation_status]);if(update.rowCount!==1)throw Error('Status compare-and-swap failed');}
  await db.query(apply?'COMMIT':'ROLLBACK');
  return {committed:apply,changed:apply&&changed,previousStatus:e[0].implementation_status,targetStatus:target,grantsChanged:0,schemaChanged:false};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
async function saveJournal(value){await mkdir('test-results/pc10-preferences',{recursive:true});await writeFile(journalPath+'.tmp',JSON.stringify(value,null,2)+'\n');await rename(journalPath+'.tmp',journalPath);}
async function main(){
 const apply=process.argv.includes('--apply'),rollback=process.argv.includes('--rollback'),source=process.env.GITHUB_SHA;
 if((apply||rollback)&&process.env.ACTIVATE_PC10_PREFERENCES!=='1')throw Error('Explicit activation opt-in required');
 if(!/^[a-f0-9]{40}$/.test(source??'')||process.env.GITHUB_REF!=='refs/heads/main'||process.env.GITHUB_REPOSITORY!=='shaikhrais/primecare-platform')throw Error('Exact repository/main CI source required');
 if(execFileSync('git',['rev-parse','HEAD'],{encoding:'utf8'}).trim()!==source)throw Error('Checkout source mismatch');
 if(apply&&execFileSync('git',['ls-remote','origin','refs/heads/main'],{encoding:'utf8'}).trim().split(/\s/)[0]!==source)throw Error('Activation source is stale');
 const url=new URL(process.env.PRODUCTION_DATABASE_URL??'');if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres')throw Error('Pinned database required');
 const account=process.env.CLOUDFLARE_ACCOUNT_ID,token=process.env.CLOUDFLARE_API_TOKEN;
 if(!/^[a-f0-9]{32}$/i.test(account??'')||!token||expected?.preferenceRuntimeActivated!==false)throw Error('Accepted disabled Auth version and scoped provider required');
 const api=async(path,options={})=>{const r=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+path,{...options,redirect:'error',headers:{authorization:'Bearer '+token,...options.headers},signal:AbortSignal.timeout(30000)});const value=await r.json();if(!r.ok||value.success!==true)throw Error('Scoped provider operation failed: '+path.split('?')[0]+' HTTP '+r.status+' '+JSON.stringify((value.errors??[]).map(e=>({code:e.code,message:String(e.message??'').replaceAll(token,'[redacted]').replace(/postgres(?:ql)?:\/\/\S+/gi,'[redacted database URL]').slice(0,300)}))));return value.result;};
 const deployment=async()=>{const result=await api(base+'/deployments?per_page=1');const value=result.deployments?.[0];if(!value||value.versions?.length!==1||value.versions[0].percentage!==100)throw Error('Single current deployment required');return {id:value.id,version:value.versions[0].version_id};};
 const latest=async()=>{const value=await api(base+'/versions?per_page=1');const item=value.items?.[0];if(!item?.id)throw Error('Latest version identity unavailable');return item.id;};
 const deploy=async version=>api(base+'/deployments',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({strategy:'percentage',versions:[{version_id:version,percentage:100}]})});
 const db=new pg.Client({connectionString:url.href,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});await db.connect();
 try{
  if(rollback){
   let journal;try{journal=JSON.parse(await readFile(journalPath));}catch(error){if(error.code==='ENOENT')return;throw error;}
   if(journal.source!==source||journal.before?.version!==expected.versionId)throw Error('Rollback journal identity mismatch');
   const active=await deployment();
   if(active.version!==journal.before.version){
    const version=await api(base+'/versions/'+active.version);
    if(active.version!==journal.newVersion&&version.metadata?.annotations?.['workers/tag']!=='pc10-'+source.slice(0,12))throw Error('Unowned deployment; rollback refused');
    await deploy(journal.before.version);
   }
   const restored=await deployment();if(restored.version!==journal.before.version)throw Error('Runtime rollback not confirmed');
   let disabled=false;
   for(let attempt=0;attempt<6;attempt++){
    const probe=await fetch('https://primecare-auth-api.itpro-mohammed.workers.dev/user/preferences',{method:'POST',headers:{'content-type':'application/json'},body:'{}',signal:AbortSignal.timeout(30000)});
    const body=await probe.json();if(probe.status===503&&body.error==='preference_sync_disabled'){disabled=true;break;}
    if(attempt<5)await new Promise(resolve=>setTimeout(resolve,2000));
   }
   if(!disabled)throw Error('Runtime rollback disabled-state probe failed');
   if(journal.metadata?.changed)await promoteMetadata(db,{apply:true,restore:true});
   journal.rolledBack=true;journal.restored=restored;await saveJournal(journal);console.log('PC10_ACTIVATION_ROLLBACK '+JSON.stringify({source,runtimeRestored:true,restoredDeployment:restored.id,restoredVersion:restored.version,metadataRestored:!!journal.metadata?.changed,grantsChanged:0}));return;
  }
  const before=await deployment(),uploadedSettings=await api(base+'/settings'),schedules=await api(base+'/schedules'),latestVersion=await latest();
  const oldVersion=await api(base+'/versions/'+before.version),etag=oldVersion.resources?.script?.etag;
  let settings=uploadedSettings,reviewedStaged=false;
  if(before.id===expected.deploymentId&&before.version===expected.versionId&&latestVersion===before.version){
   if(!etag||settings.bindings.find(b=>b.name==='PREFERENCE_SYNC_ENABLED')?.text!=='0')throw Error('Expected disabled code version required');
  }else{
   settings=reviewedRetrySettings({before,latestVersion,etag,settings:uploadedSettings},retryBaseline);reviewedStaged=true;
   if(before.version!==expected.versionId)throw Error('Rollback code version differs from accepted code');
   const probe=await fetch('https://primecare-auth-api.itpro-mohammed.workers.dev/user/preferences',{method:'POST',headers:{'content-type':'application/json'},body:'{}',signal:AbortSignal.timeout(30000)});
   const body=await probe.json();if(probe.status!==503||body.error!=='preference_sync_disabled')throw Error('Reviewed retry requires independently disabled runtime');
  }
  const patch=activationSettings(settings,'1');
  const plan=await promoteMetadata(db);console.log('PC10_ACTIVATION_PLAN '+JSON.stringify({source,before,metadata:plan,existingBindings:settings.bindings.map(b=>({name:b.name,type:b.type})),grantsChanged:0,codeChanged:false}));
  if(!apply)return;
  const journal={source,before,metadata:null,patchAttempted:false,newVersion:null,bindingFingerprint:fingerprint(settings.bindings),codeEtag:etag};await saveJournal(journal);
  if(canonical(await deployment())!==canonical(before)||await latest()!==latestVersion)throw Error('Provider changed before metadata promotion');
  journal.metadata=await promoteMetadata(db,{apply:true});await saveJournal(journal);
  if(canonical(await deployment())!==canonical(before)||await latest()!==latestVersion)throw Error('Provider changed before activation');
  if(reviewedStaged){
   // The reviewed immutable upload already has the desired flag and preserved
   // code/bindings. Deploy it instead of recreating settings after rollback.
   verifySettings(settings,uploadedSettings,'1');
   journal.newVersion=latestVersion;journal.reusedReviewedUpload=true;await saveJournal(journal);
  }else{
   journal.patchAttempted=true;await saveJournal(journal);
   const form=new FormData();form.set('settings',JSON.stringify({...patch,annotations:{'workers/message':'Activate reviewed existing PC10 own preferences; code preserved','workers/tag':'pc10-'+source.slice(0,12)}}));
   await api(base+'/settings',{method:'PATCH',body:form});
   journal.newVersion=await latest();await saveJournal(journal);
  }
  const uploaded=await api(base+'/versions/'+journal.newVersion);
  if(journal.newVersion===before.version||uploaded.resources?.script?.etag!==etag)throw Error('Activation must preserve code in a distinct version');
  verifySettings(settings,await api(base+'/settings'),'1');
  if(canonical(schedules)!==canonical(await api(base+'/schedules')))throw Error('Auth schedules changed');
  const active=await deployment();if(active.version===before.version)await deploy(journal.newVersion);else if(active.version!==journal.newVersion)throw Error('Unexpected active version after settings update');
  journal.active=await deployment();if(journal.active.version!==journal.newVersion)throw Error('Activation deployment not confirmed');
  verifySettings(settings,await api(base+'/settings'),'1');
  let healthy=false;
  for(let attempt=0;attempt<6;attempt++){
   const health=await fetch('https://primecare-auth-api.itpro-mohammed.workers.dev/health',{signal:AbortSignal.timeout(30000)});
   const unauth=await fetch('https://primecare-auth-api.itpro-mohammed.workers.dev/user/preferences',{method:'POST',headers:{'content-type':'application/json'},body:'{}',signal:AbortSignal.timeout(30000)});
   if(health.status===200&&unauth.status===401){healthy=true;break;}
   if(attempt<5)await new Promise(resolve=>setTimeout(resolve,2000));
  }
  if(!healthy)throw Error('Live Auth health or preference authorization readback failed');
  journal.runtimeActivated=true;journal.codePreserved=true;journal.bindingsPreserved=true;journal.schedulesPreserved=true;journal.grantsChanged=0;await saveJournal(journal);console.log('PC10_PREFERENCES_ACTIVATED '+JSON.stringify(journal));
 }finally{await db.end();}
}
if(import.meta.url===pathToFileURL(process.argv[1]??'').href)main().catch(error=>{console.error(error.message);process.exitCode=1;});
