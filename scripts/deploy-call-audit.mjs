import {readFile,mkdir,writeFile} from 'node:fs/promises';import {execFileSync} from 'node:child_process';import {randomBytes} from 'node:crypto';import {isDeepStrictEqual} from 'node:util';import pg from 'pg';
import {build} from 'esbuild';import {pathToFileURL} from 'node:url';
const org='9e1d8550-4b84-4472-a782-67557fe73944',phoneId='3e9cee92-b463-47c8-9e1a-cdbf179cb675',worker='primecare-call-audit-api';
let auditPool;
const report={source:process.env.GITHUB_SHA,deployed:false,phoneRoutingPreserved:false,customerWrites:0,callsMade:0,smsSent:0};
const required=k=>{if(!process.env[k])throw Error('configuration_required');return process.env[k];};
const cli=(args,input)=>{try{return execFileSync('node_modules/.bin/wrangler',args,{encoding:'utf8',input,stdio:['pipe','pipe','pipe'],maxBuffer:4194304});}catch{throw Error('worker_deployment_failed');}};
async function json(url,auth,method='GET',body){const r=await fetch(url,{method,redirect:'error',headers:{authorization:auth,accept:'application/json',...(body===undefined?{}:{'content-type':'application/json'})},...(body===undefined?{}:{body:JSON.stringify(body)}),signal:AbortSignal.timeout(25000)});if(!r.ok){await r.body?.cancel();throw Error('provider_http_'+r.status);}return r.json();}
const lease=()=>{execFileSync('git',['fetch','origin','main'],{stdio:'pipe'});if(execFileSync('git',['rev-parse','FETCH_HEAD'],{encoding:'utf8'}).trim()!==process.env.GITHUB_SHA)throw Error('stale_main');};
try{
 lease();const account=required('CLOUDFLARE_ACCOUNT_ID'),cfAuth='Bearer '+required('CLOUDFLARE_API_TOKEN'),vapiAuth='Bearer '+required('VAPI_PRIVATE_API_KEY');
 if(!/^[a-f0-9]{32}$/i.test(account))throw Error('configuration_required');
 const cf=(path,method,body)=>json('https://api.cloudflare.com/client/v4/accounts/'+account+path,cfAuth,method,body).then(r=>r.result);
 const vapi=(path,method,body)=>json('https://api.vapi.ai'+path,vapiAuth,method,body);
 const subdomain=(await cf('/workers/subdomain')).subdomain;if(subdomain!=='itpro-mohammed')throw Error('target_scope_changed');
 const origin='https://'+worker+'.'+subdomain+'.workers.dev',endpoint=origin+'/v1/vapi/calls/audit';
 const receipt=JSON.parse(await readFile('test-results/call-audit/api-registration.json','utf8'));if(receipt.independentReadback!==true||!Number.isSafeInteger(receipt.apiIds?.['vapi.call_audit']))throw Error('registration_not_verified');
 const phone=await vapi('/phone-number/'+phoneId);if(phone.orgId!==org||phone.number!=='+12897994277'||phone.assistantId!=='5ae2ab0c-fad0-454c-8cf7-64b81c91c850')throw Error('routing_scope_changed');
 const ids=['5ae2ab0c-fad0-454c-8cf7-64b81c91c850',...Object.values(JSON.parse(await readFile('packages/shared/src/vapi-agent-targets.json','utf8')))];
 const before=[];for(const id of ids){const a=await vapi('/assistant/'+id);if(a.orgId!==org||a.server?.url&&a.server.url!==endpoint)throw Error('existing_server_preserved');before.push(a);}
 report.stage='audit-worker';await mkdir('.cloudflare-workers',{recursive:true});
 const credentialName='PrimeCare Call Audit Events';let credentials=await vapi('/credential'),matches=credentials.filter(c=>c.name===credentialName);if(matches.length>1)throw Error('ambiguous_audit_credential');
 let credential=matches[0];if(credential&&(credential.orgId!==org||credential.provider!=='custom-credential'))throw Error('credential_scope_changed');
 const secret=randomBytes(32).toString('base64url');
 if(!credential)credential=await vapi('/credential','POST',{provider:'custom-credential',name:credentialName,authenticationPlan:{type:'bearer',token:secret,headerName:'Authorization',bearerPrefixEnabled:true}});
 const file='.cloudflare-workers/call-audit.jsonc';
 await writeFile(file,JSON.stringify({name:worker,main:'../cloudflare/workers/src/business-tasks/call-audit-events-worker.ts',compatibility_date:'2026-09-27',compatibility_flags:['nodejs_compat'],workers_dev:true,keep_vars:true,preview_urls:false,observability:{enabled:false},triggers:{crons:['*/5 * * * *']},vars:{CALL_AUDIT_ORIGIN:origin,CALL_AUDIT_API_ID:String(receipt.apiIds['vapi.call_audit']),CALL_AUDIT_SOURCE:process.env.GITHUB_SHA}}));
 cli(['deploy','--config',file]);
 const values={DB_URL:required('PRODUCTION_DATABASE_URL'),CALL_AUDIT_SECRET:secret,VAPI_PRIVATE_API_KEY:required('VAPI_PRIVATE_API_KEY'),TWILIO_ACCOUNT_SID:required('TWILIO_ACCOUNT_SID'),TWILIO_API_KEY_SID:required('TWILIO_API_KEY_SID'),TWILIO_API_KEY_SECRET:required('TWILIO_API_KEY_SECRET')};
 cli(['secret','bulk','--config',file],JSON.stringify(values));
 if(matches.length)await vapi('/credential/'+credential.id,'PATCH',{provider:'custom-credential',authenticationPlan:{type:'bearer',token:secret,headerName:'Authorization',bearerPrefixEnabled:true}});
 const negative=await fetch(endpoint,{method:'POST',headers:{'content-type':'application/json'},body:'{}'});if(negative.status!==401)throw Error('anonymous_denial_failed');await negative.body?.cancel();
 report.stage='existing-workers';
 for(const [name,entry] of [['primecare-vapi-verification-api','vapi-spoken-worker'],['primecare-vapi-tools-api','vapi-callback-worker']]){
  lease();const settings=await cf('/workers/scripts/'+name+'/settings');
  const config={name,main:'../cloudflare/workers/src/business-tasks/'+entry+'.ts',compatibility_date:settings.compatibility_date??'2026-09-27',compatibility_flags:settings.compatibility_flags??['nodejs_compat'],workers_dev:true,preview_urls:false,keep_vars:true,observability:settings.observability??{enabled:false},vars:{},durable_objects:{bindings:[]},services:[],ratelimits:[]};
  for(const b of settings.bindings??[]){
   if(b.type==='plain_text')config.vars[b.name]=b.text;
   else if(b.type==='json')config.vars[b.name]=b.json;
   else if(b.type==='secret_text')continue;
   else if(b.type==='durable_object_namespace')config.durable_objects.bindings.push({name:b.name,class_name:b.class_name,...(b.script_name&&b.script_name!==name?{script_name:b.script_name}:{}),...(b.environment?{environment:b.environment}:{})});
   else if(b.type==='service')config.services.push({binding:b.name,service:b.service,...(b.environment?{environment:b.environment}:{})});
   else if(b.type==='ratelimit')config.ratelimits.push({name:b.name,namespace_id:String(b.namespace_id),simple:b.simple});
   else throw Error('unsupported_existing_binding');
  }
  const p='.cloudflare-workers/audited-'+entry+'.jsonc';await writeFile(p,JSON.stringify(config));cli(['deploy','--config',p]);
  const after=await cf('/workers/scripts/'+name+'/settings');
  // Stable named binding projection detects lost secrets, namespace IDs and URLs.
  const stable=x=>[...x.bindings].sort((a,b)=>a.name.localeCompare(b.name));if(!isDeepStrictEqual(stable(settings),stable(after)))throw Error('existing_bindings_changed');
  const path=entry==='vapi-spoken-worker'?'/v1/vapi/voice/verification':'/v1/vapi/voice/tasks';
  const probe=await fetch('https://'+name+'.'+subdomain+'.workers.dev'+path,{method:'POST',headers:{'content-type':'application/json'},body:'{}'});
  if(probe.status!==401||!probe.headers.get('x-primecare-audit-id'))throw Error('audited_denial_not_verified');await probe.body?.cancel();
 }
 report.stage='assistant-webhooks';
 await build({stdin:{resolveDir:process.cwd(),contents:"export {PostgresCallAudit,hash} from './cloudflare/workers/src/business-tasks/call-audit.ts';export {nativePostgresOptions} from './cloudflare/workers/src/business-tasks/native-postgres.ts';"},outfile:'test-results/call-audit/repository.mjs',bundle:true,format:'esm',platform:'node',external:['pg']});
 const {PostgresCallAudit,hash,nativePostgresOptions}=await import(pathToFileURL(process.cwd()+'/test-results/call-audit/repository.mjs'));auditPool=new pg.Pool(nativePostgresOptions(process.env.PRODUCTION_DATABASE_URL));const ledger=new PostgresCallAudit(auditPool),toolCache=new Map();

 for(const a of before){
  lease();const current=await vapi('/assistant/'+a.id);if(!isDeepStrictEqual(current,a))throw Error('concurrent_assistant_change');
  const server={...(a.server??{}),url:endpoint,credentialId:credential.id,timeoutSeconds:20};
  const serverMessages=[...new Set([...(a.serverMessages??[]),'tool-calls','status-update','end-of-call-report','conversation-update'])];
  await vapi('/assistant/'+a.id,'PATCH',{server,serverMessages});const saved=await vapi('/assistant/'+a.id);
  if(!isDeepStrictEqual(saved.server,server)||!isDeepStrictEqual(saved.serverMessages,serverMessages)||Object.keys(a).filter(k=>!['server','serverMessages','updatedAt','latestVersion'].includes(k)).some(k=>!isDeepStrictEqual(saved[k],a[k])))throw Error('assistant_configuration_changed');
  const configurationHash=await hash({model:saved.model,server:saved.server,serverMessages:saved.serverMessages,artifactPlan:saved.artifactPlan??null});
  const at=new Date(saved.updatedAt).toISOString();
  await ledger.append('assistant:'+a.id,'config:'+configurationHash,{kind:'configuration_snapshot',source:'primecare_deployment',at,assistantId:a.id,configurationHash,coverage:'backend_direct_and_provider_observations'});
  for(const toolId of saved.model?.toolIds??[]){
   let t=toolCache.get(toolId);if(!t){t=await vapi('/tool/'+toolId);toolCache.set(toolId,t);}
   const target=t.server?.url??t.url;
   const coverage=target?.startsWith('https://primecare-vapi-verification-api.itpro-mohammed.workers.dev/')||target?.startsWith('https://primecare-vapi-tools-api.itpro-mohammed.workers.dev/')?'direct_backend':target?'coverage_gap':'provider_observed_only';
   await ledger.append('assistant:'+a.id,'tool:'+configurationHash+':'+toolId,{kind:'tool_inventory',source:'primecare_deployment',at,assistantId:a.id,configurationHash,resultId:toolId,toolName:String(t.function?.name??t.name??t.type).replace(/[^a-zA-Z0-9_.:-]/g,'_').slice(0,120),coverage});
   if(coverage==='coverage_gap')throw Error('external_tool_coverage_gap');
  }
 }
 if(!isDeepStrictEqual(await vapi('/phone-number/'+phoneId),phone))throw Error('phone_routing_changed');report.phoneRoutingPreserved=true;
 report.stage='backfill-and-readback';
 report.deployed=true;report.assistantsConfigured=before.length;report.endpoint=endpoint;report.status='configured_pending_independent_readback';
}catch(e){report.status=/^[a-z_0-9]+$/.test(e.message??'')?e.message:'audit_release_failed';process.exitCode=1;}
await auditPool?.end();
await mkdir('test-results/call-audit',{recursive:true});await writeFile('test-results/call-audit/deployment.json',JSON.stringify(report,null,2));console.log('CALL_AUDIT_DEPLOYMENT '+JSON.stringify(report));
