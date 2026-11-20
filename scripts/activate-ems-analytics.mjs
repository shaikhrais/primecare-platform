/** Authorized EMS activation from CI secrets; no account assignments or email operations. */
import {mkdir,writeFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import pg from 'pg';
import {resolveCodeAdminControlTenant} from './bootstrap-code-admin-control-tenant.mjs';
import {verifyCodeAdminOwnerRegistration} from './code-admin-owner.mjs';
import {liveWorkerConfig,verifyUnchangedBindings} from './ems-analytics-live-config.mjs';
import {endpointAnalyticsConfigs} from './prepare-endpoint-analytics-config.mjs';
import {uploadedWorkerVersion,verifyWorkerDeploymentEventually} from './worker-deployment-receipt.mjs';
import {inspectEndpointManagement} from './endpoint-management-preflight.mjs';
const report={source:process.env.GITHUB_SHA,status:'blocked',accountAssignments:0,emailMessagesSent:0,providerWrites:0,workers:[]};
const account=process.env.CLOUDFLARE_ACCOUNT_ID,token=process.env.CLOUDFLARE_API_TOKEN,reader=process.env.ENDPOINT_ANALYTICS_READ_TOKEN||token;
async function main(){
 if(process.env.EMS_ACTIVATE_ANALYTICS!=='1'||process.env.GITHUB_REF!=='refs/heads/main'||!/^[a-f0-9]{40}$/.test(report.source??'')||execFileSync('git',['rev-parse','HEAD'],{encoding:'utf8'}).trim()!==report.source||!/^[a-f0-9]{32}$/i.test(account??'')||!token||!reader||!process.env.PRODUCTION_DATABASE_URL)throw Error('Protected current-main credentials required');
 execFileSync('git',['fetch','origin','main'],{stdio:'ignore'});if(execFileSync('git',['rev-parse','FETCH_HEAD'],{encoding:'utf8'}).trim()!==report.source)throw Error('Current main required');
 // Resolve only the existing governed control tenant. Never choose an arbitrary tenant.
 const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();let tenant;
 try{await db.query('BEGIN READ ONLY');await verifyCodeAdminOwnerRegistration(db);tenant=await resolveCodeAdminControlTenant(db);await db.query('ROLLBACK');}finally{await db.end();}
 const base='https://api.cloudflare.com/client/v4/accounts/'+account;
 async function api(path,options={}){
  const response=await fetch(base+path,{...options,headers:{authorization:'Bearer '+token,...options.headers},redirect:'error',signal:AbortSignal.timeout(30000)});
  const result=await response.json();if(!response.ok||result.success!==true)throw Error('Cloudflare activation request failed (HTTP '+response.status+')');return result.result;
 }
 // Validate the chosen reader with a query, before any settings or secret writes.
 const end=Math.floor((Date.now()-120000)/300000)*300000,date=n=>new Date(n).toISOString().slice(0,19).replace('T',' ');
 const check=await fetch(base+'/analytics_engine/sql',{method:'POST',headers:{authorization:'Bearer '+reader,'content-type':'text/plain'},body:`SELECT SUM(_sample_interval) AS requests FROM primecare_endpoint_traffic_v1 WHERE timestamp >= toDateTime('${date(end-300000)}') AND timestamp < toDateTime('${date(end)}') FORMAT JSON`,redirect:'error',signal:AbortSignal.timeout(15000)});
 if(!check.ok)throw Error('Selected analytics credential cannot query dataset');await check.body?.cancel();
 const names={gateway:'primecare-api-gateway',governance:'primecare-governance-api'},settings={},previous={};
 for(const [key,worker] of Object.entries(names)){
  settings[key]=await api('/workers/scripts/'+worker+'/settings');previous[key]=(await api('/workers/scripts/'+worker+'/deployments?per_page=1')).deployments?.[0]?.id;
  if(!/^[a-f0-9-]{36}$/i.test(previous[key]??''))throw Error('Existing deployment required');
 }
 const configs=endpointAnalyticsConfigs(liveWorkerConfig(names.gateway,settings.gateway),liveWorkerConfig(names.governance,settings.governance),account,'code_admin',{},tenant);
 // User explicitly authorized reuse of the existing GitHub Cloudflare credential.
 // It stays encrypted server-side and never enters generated config or artifacts.
 await api('/workers/scripts/'+names.governance+'/secrets',{method:'PUT',headers:{'content-type':'application/json'},body:JSON.stringify({name:'ENDPOINT_ANALYTICS_READ_TOKEN',type:'secret_text',text:reader})});report.providerWrites++;
 report.readerCredentialSource=process.env.ENDPOINT_ANALYTICS_READ_TOKEN?'dedicated_github_secret':'existing_cloudflare_github_secret';
 await mkdir('.cloudflare-workers',{recursive:true});
 for(const key of ['governance','gateway']){
  const file='.cloudflare-workers/ems-'+key+'.jsonc';await writeFile(file,JSON.stringify(configs[key]));
  let output;try{output=execFileSync('node_modules/.bin/wrangler',['deploy','--config',file,'--keep-vars'],{encoding:'utf8',stdio:['ignore','pipe','pipe'],maxBuffer:8*1024*1024});}catch{throw Error('EMS '+key+' deployment failed; inspect live settings before retrying');}
  report.providerWrites++;
  const versionId=uploadedWorkerVersion(output);
  const receipt=await verifyWorkerDeploymentEventually({api,worker:names[key],service:key==='gateway'?'gateway':'governance',source:report.source,versionId,previousDeploymentId:previous[key]});
  const after=await api('/workers/scripts/'+names[key]+'/settings');
  const allowed=key==='gateway'?['ENDPOINT_ANALYTICS','ENDPOINT_TRAFFIC_ENABLED']:['ENDPOINT_ANALYTICS_ACCOUNT_ID','ENDPOINT_ANALYTICS_READER_ROLE','ENDPOINT_ANALYTICS_READER_TENANT_ID','ENDPOINT_ANALYTICS_READ_TOKEN'];
  verifyUnchangedBindings(settings[key],after,allowed);report.workers.push({...receipt,unrelatedBindingsPreserved:true});
 }
 const preflight=await inspectEndpointManagement(process.env);report.configuration=preflight.configuration;report.health=preflight.health;
 if(preflight.blockers.length)throw Error('Live analytics configuration readback has blockers');
 for(const path of ['summary','endpoints','services','traffic','capacity','maintenance']){const r=await fetch('https://primecare-api-gateway.itpro-mohammed.workers.dev/v1/governance/platform/ems/'+path,{redirect:'error',signal:AbortSignal.timeout(15000)});await r.body?.cancel();if(r.status!==401)throw Error('Live EMS anonymous boundary failed');}
 report.status='configured';report.anonymousBoundariesPassed=6;report.liveDataPendingIngestion=true;
}
try{await main();}catch(error){
 const safe=new Set(['Registered control-tenant policy required','Control tenant is not provisioned','Registered control tenant is missing or changed','Governance authority mismatch','Approved Code Admin owner is not registered','Approved Code Admin owner binding differs','Protected current-main credentials required','Current main required','Selected analytics credential cannot query dataset','Live analytics configuration readback has blockers','Live EMS anonymous boundary failed']);
 report.blocker=safe.has(error.message)?error.message:'Activation stopped; protected configuration or provider verification failed';process.exitCode=1;
}finally{await mkdir('test-results/endpoint-management',{recursive:true});await writeFile('test-results/endpoint-management/activation.json',JSON.stringify(report,null,2)+'\n');console.log('EMS_ANALYTICS_ACTIVATION '+JSON.stringify(report));}
