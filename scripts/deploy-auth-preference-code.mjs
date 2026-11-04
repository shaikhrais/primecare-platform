/** Deploy only the accepted auth code; no grants, schema, key selection or preference activation. */
import {verifyReconciledAuth} from './auth-reconciled-source.mjs';
import {checkAuthSchema} from './check-auth-schema.mjs';
import {mkdir,writeFile,readFile} from 'node:fs/promises';import {execFileSync} from 'node:child_process';
import {authPreferenceDeploymentConfig} from './auth-preference-deployment-config.mjs';import {mfaKeyringSource} from './mfa-keyring-source.mjs';import {uploadedWorkerVersion,verifyWorkerDeployment} from './worker-deployment-receipt.mjs';
const worker='primecare-auth-api',account=process.env.CLOUDFLARE_ACCOUNT_ID,token=process.env.CLOUDFLARE_API_TOKEN,source=process.env.GITHUB_SHA;
if(process.env.DEPLOY_AUTH_PREFERENCE_CODE!=='1'||!/^[a-f0-9]{32}$/i.test(account??'')||!token||!/^[a-f0-9]{40}$/.test(source??'')||process.env.GITHUB_REF!=='refs/heads/main')throw Error('Explicit accepted main auth code release required');
if(execFileSync('git',['rev-parse','HEAD'],{encoding:'utf8'}).trim()!==source)throw Error('Checkout identity differs');execFileSync('git',['diff','--quiet','HEAD'],{stdio:'ignore'});
const currentMain=execFileSync('git',['ls-remote','origin','refs/heads/main'],{encoding:'utf8'}).trim().split(/\s/)[0];if(currentMain!==source)throw Error('Auth release source is stale');
const databaseUrl=new URL(process.env.PRODUCTION_DATABASE_URL??'');if(!['postgres:','postgresql:'].includes(databaseUrl.protocol)||databaseUrl.hostname!=='pooled.db.prisma.io'||databaseUrl.pathname!=='/postgres')throw Error('Pinned schema inspection target required');
if((await checkAuthSchema(databaseUrl.href)).length)throw Error('Production auth schema is incompatible with the accepted source');
const api=async path=>{const r=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+path,{redirect:'error',headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});const v=await r.json();if(!r.ok||v.success!==true)throw Error('Scoped Cloudflare read failed');return v.result;};
const base='/workers/scripts/'+worker,proof=JSON.parse(await readFile('docs/appearance/theme-auth-release-provenance.json','utf8')),before=(await api(base+'/deployments?per_page=1')).deployments?.[0];
if(proof.worker!==worker||before?.id!==proof.activeReadback.deploymentId||before.versions?.length!==1||before.versions[0].version_id!==proof.activeReadback.versionId||before.versions[0].percentage!==100){
 if(process.env.GITHUB_REPOSITORY!=='shaikhrais/primecare-platform'||!process.env.GH_TOKEN)throw Error('Auth lineage verification credentials required');
 const releaseSource='ca1d9edd6942ff5d960d7267a10c551c2f33a8cd';
 execFileSync('git',['fetch','--no-tags','--depth=1','origin',releaseSource],{stdio:'ignore'});
 const changedPaths=execFileSync('git',['diff','--name-only',releaseSource,source],{encoding:'utf8'}).trim().split('\n').filter(Boolean);
 const gh=args=>execFileSync('gh',args,{encoding:'utf8',maxBuffer:32*1024*1024,stdio:['ignore','pipe','pipe']});
 const run=JSON.parse(gh(['api','repos/shaikhrais/primecare-platform/actions/runs/41776405861']));
 const job=JSON.parse(gh(['api','repos/shaikhrais/primecare-platform/actions/jobs/126398355208']));
 const log=gh(['run','view','41776405861','--repo','shaikhrais/primecare-platform','--job','126398355208','--log']);
 const release=await api(base+'/versions/cefb0515-632a-437a-89f7-168c244fa33f');
 const active=await api(base+'/versions/ce2df651-30f7-4d1d-8bc4-8fa6689dff33');
 console.log('AUTH_RECONCILED_LINEAGE '+JSON.stringify(verifyReconciledAuth({before,run,job,log,release,active,changedPaths})));
}
const settings=await api(base+'/settings'),schedules=await api(base+'/schedules'),policy=JSON.parse(await readFile('cloudflare/workers/src/security/mfa-keyring-policy.json','utf8'));
const config=authPreferenceDeploymentConfig(settings,schedules,{sourceFingerprint:mfaKeyringSource(),activeKeyId:policy.activeKeyId,rotationFromKeyId:policy.migrateFromKeyId});
await mkdir('.cloudflare-workers',{recursive:true});await writeFile('.cloudflare-workers/accepted-auth-preferences.jsonc',JSON.stringify(config,null,2));
if((await api(base+'/deployments?per_page=1')).deployments?.[0]?.id!==before.id)throw Error('Auth deployment changed before publication');
let versionId;try{const output=execFileSync('node_modules/.bin/wrangler',['deploy','--config','.cloudflare-workers/accepted-auth-preferences.jsonc','--keep-vars'],{stdio:['ignore','pipe','pipe'],maxBuffer:8*1024*1024});versionId=uploadedWorkerVersion(output.toString());}catch{throw Error('Auth code publication failed; inspect provider and release status before retrying');}
const provenance=await verifyWorkerDeployment({api,worker,service:'auth',source,versionId,previousDeploymentId:before.id});
const after=await api(base+'/settings'),afterSchedules=await api(base+'/schedules');
const expected=settings.bindings.map(b=>b.type==='plain_text'&&['MFA_KEYRING_SOURCE_SHA256','PREFERENCE_SYNC_ENABLED'].includes(b.name)?{...b,text:config.vars[b.name]}:b);if(!expected.some(b=>b.name==='PREFERENCE_SYNC_ENABLED'))expected.push({name:'PREFERENCE_SYNC_ENABLED',type:'plain_text',text:'0'});
const fields=['name','type','text','json','service','entrypoint','id','namespace_id','simple','class_name','script_name','destination_address','allowed_destination_addresses','allowed_sender_addresses'];const canonical=x=>JSON.stringify(x,(_,v)=>v&&typeof v==='object'&&!Array.isArray(v)?Object.fromEntries(Object.keys(v).sort().map(k=>[k,v[k]])):v);const fingerprint=bindings=>canonical(bindings.map(b=>Object.fromEntries(fields.filter(k=>b[k]!==undefined&&(b.type!=='secret_text'||['name','type'].includes(k))).map(k=>[k,b[k]]))).sort((a,b)=>a.name.localeCompare(b.name)));
if(fingerprint(expected)!==fingerprint(after.bindings))throw Error('Auth live binding readback differs');if(canonical(config.triggers.crons)!==canonical(afterSchedules.schedules.map(s=>s.cron).sort()))throw Error('Auth cron readback differs');
const host='https://primecare-auth-api.itpro-mohammed.workers.dev';const health=await fetch(host+'/health',{signal:AbortSignal.timeout(30000)});if(health.status!==200)throw Error('Updated auth health check failed');
const disabled=await fetch(host+'/user/preferences',{method:'POST',headers:{'content-type':'application/json'},body:'{}',signal:AbortSignal.timeout(30000)});if(disabled.status!==503||(await disabled.json()).error!=='preference_sync_disabled')throw Error('Preference handler disabled-state probe failed');
const receipt={...provenance,sourceCheckoutVerified:true,existingBindingsPreserved:true,existingCronSchedulesPreserved:true,keySelectionChanged:false,sourceFingerprintUpdated:true,preferenceRuntimeActivated:false,productionGrantsChanged:0,productionSchemaChanged:false,healthStatus:200,disabledPreferenceProbe:503};
await mkdir('test-results/auth-preference-release',{recursive:true});await writeFile('test-results/auth-preference-release/receipt.json',JSON.stringify(receipt,null,2)+'\n');console.log('AUTH_PREFERENCE_CODE_DEPLOYED '+JSON.stringify(receipt));
