import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {createHash} from 'node:crypto';
import {BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';
import {VapiManagementClient} from '../packages/shared/src/communications/vapi-management.mjs';
const bounded=new BoundedBinaryAdapterBase(1048576);
const workerName='primecare-vapi-tools-api',assistantId='5ae2ab0c-fad0-454c-8cf7-64b81c91c850',phoneId='3e9cee92-b463-47c8-9e1a-cdbf179cb675',orgId='9e1d8550-4b84-4472-a782-67557fe73944';
const report={phase:'authenticated-boundary-only',deployed:false,credentialConfigured:false,unauthenticatedDenied:false,wrongCredentialDenied:false,authenticatedClosed:false,businessActionsEnabled:false,toolsAttached:false};
const required=name=>{const value=process.env[name];if(!value)throw Error('configuration_required');return value;};
function command(args,input){try{return execFileSync('node_modules/.bin/wrangler',args,{encoding:'utf8',input,maxBuffer:4*1024*1024,stdio:['pipe','pipe','pipe']});}catch{throw Error('cloudflare_cli_failed');}}
try{
 report.stage='configuration';
 const account=required('CLOUDFLARE_ACCOUNT_ID'),cfToken=required('CLOUDFLARE_API_TOKEN');
 if(!/^[a-f0-9]{32}$/i.test(account))throw Error('invalid_cloudflare_account');
 const cf=async(path,allowMissing=false)=>{
  const response=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+path,{redirect:'error',signal:AbortSignal.timeout(20000),headers:{authorization:'Bearer '+cfToken,accept:'application/json'}});
  if(allowMissing&&response.status===404){await response.body?.cancel();return null;}
  if(!response.ok){await response.body?.cancel();throw Error('cloudflare_read_failed');}
  const text=new TextDecoder().decode(await bounded.readBoundedBody(response.body));
  const data=JSON.parse(text);if(data.success!==true)throw Error('cloudflare_read_failed');return data.result;
 };
 const definitionBytes=await readFile('tools/governance-production/vapi-contracts-registration.json');
 const contract=JSON.parse(definitionBytes),pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
 const contractSha=createHash('sha256').update(definitionBytes).digest('hex');
 const registration=JSON.parse(await readFile('test-results/vapi/deployment-registration.json','utf8'));
 const apiId=registration.apiIds?.['vapi.tasks'];
 if(contract.operations?.length!==1||contract.operations[0].method!=='POST'||contract.operations[0].path!=='/v1/vapi/voice/tasks'||pin.vapiContractRegistrationWriter.definitionSha256!==contractSha||registration.independentReadback!==true||registration.writesAttempted!==false||registration.definitionSha256!==contractSha||!Number.isSafeInteger(apiId)||apiId<1)throw Error('registration_not_verified');
 report.stage='cloudflare-target-check';
 const subdomain=(await cf('/workers/subdomain'))?.subdomain;
 if(typeof subdomain!=='string'||!/^[a-z0-9][a-z0-9-]{0,62}$/.test(subdomain))throw Error('cloudflare_subdomain_required');
 const origin='https://'+workerName+'.'+subdomain+'.workers.dev',endpoint=origin+contract.operations[0].path;
 const existing=await cf('/workers/scripts/'+workerName+'/settings',true);
 if(existing){
  const bindings=existing.bindings;
  if(!Array.isArray(bindings)||bindings.find(b=>b.name==='VAPI_BOUNDARY_OWNER')?.text!=='primecare-vapi-16534'||bindings.find(b=>b.name==='VAPI_API_ID')?.text!==String(apiId)||bindings.find(b=>b.name==='VAPI_CONTRACT_SHA256')?.text!==contractSha)throw Error('existing_worker_preserved');
 }
 report.stage='vapi-scope-check';
 const client=new VapiManagementClient({apiKey:required('VAPI_PRIVATE_API_KEY')});
 const assistant=await client.assistant(assistantId),phone=await client.phoneNumber(phoneId);
 const expectedPrompt=(await readFile('docs/business/primecare-vapi-reception-prompt.txt','utf8')).replace(/\s+/g,' ').trim();
 if(assistant.orgId!==orgId||assistant.name!=='PrimeCare Reception - 4277'||assistant.prompt.replace(/\s+/g,' ').trim()!==expectedPrompt||assistant.toolCount!==0||assistant.serverConfigured||!assistant.recordingDisabled||phone.orgId!==orgId||phone.number!=='+12897994277'||phone.assistantId!==assistantId||phone.provider!=='twilio'||phone.squadConfigured||phone.workflowConfigured||phone.serverConfigured)throw Error('provider_scope_changed');
 await mkdir('.cloudflare-workers',{recursive:true});
 const config='.cloudflare-workers/vapi-tools.jsonc';
 await writeFile(config,JSON.stringify({name:workerName,main:'../cloudflare/workers/src/business-tasks/vapi-tool-boundary.ts',compatibility_date:'2026-09-27',compatibility_flags:['nodejs_compat'],workers_dev:true,preview_urls:false,observability:{enabled:false},vars:{VAPI_BOUNDARY_OWNER:'primecare-vapi-16534',VAPI_TOOLS_ORIGIN:origin,VAPI_API_ID:String(apiId),VAPI_CONTRACT_SHA256:contractSha},ratelimits:[{name:'VAPI_TOOL_LIMIT',namespace_id:'2026102401',simple:{limit:60,period:60}}]},null,2)+'\n');
 // This target is separate from existing governance/auth Workers. Unknown existing
 // targets are preserved above. No database or business credentials are deployed.
 report.stage='cloudflare-deploy';
 const output=command(['deploy','--config',config]);
 if(!output.includes(origin))throw Error('cloudflare_deployment_url_mismatch');
 report.deployed=true;report.endpoint=endpoint;report.apiId=apiId;
 let probeSecret;
 report.stage='credential-install';
 const credential=await client.installToolCredential(assistant,async({secret})=>{
  command(['secret','put','VAPI_TOOLS_SERVICE_SECRET','--config',config],secret);
  probeSecret=secret;
 });
 report.credentialConfigured=true;report.credentialId=credential.credentialId;report.credentialCreated=credential.created;
 const probe=async(authorization)=>{
  const response=await fetch(endpoint,{method:'POST',redirect:'error',signal:AbortSignal.timeout(20000),headers:{'content-type':'application/json',...(authorization?{authorization}:{})},body:JSON.stringify({action:'execute',intentId:'11111111-1111-4111-8111-111111111111',requestId:'22222222-2222-4222-8222-222222222222'})});
  const body=await response.text();if(body.length>1000||response.headers.get('cache-control')!=='no-store')throw Error('invalid_boundary_response');return {status:response.status,body};
 };
 // Read-only failure probes: no calls, user records or task writes. Give the
 // newly installed Worker secret a bounded propagation window; no write retries.
 report.stage='http-verification';
 for(let attempt=0;attempt<5;attempt++){
  const valid=await probe('Bearer '+probeSecret);
  if(valid.status===503&&valid.body===JSON.stringify({error:'Business tools are not enabled'})){report.authenticatedClosed=true;break;}
  if(attempt<4)await new Promise(resolve=>setTimeout(resolve,1000));
 }
 report.unauthenticatedDenied=(await probe()).status===401;
 report.wrongCredentialDenied=(await probe('Bearer '+'x'.repeat(43))).status===401;
 probeSecret=undefined;
 if(!report.authenticatedClosed||!report.unauthenticatedDenied||!report.wrongCredentialDenied)throw Error('boundary_probe_failed');
 report.status='authenticated_boundary_verified';report.stage='complete';
}catch(error){
 if(Number.isSafeInteger(error?.httpStatus)&&error.httpStatus>=400&&error.httpStatus<=599)report.providerHttpStatus=error.httpStatus;
 const allowed=['configuration_required','invalid_cloudflare_account','cloudflare_read_failed','cloudflare_response_limit','cloudflare_subdomain_required','registration_not_verified','existing_worker_preserved','provider_scope_changed','cloudflare_cli_failed','cloudflare_deployment_url_mismatch','invalid_boundary_response','boundary_probe_failed'];
 report.status=allowed.includes(error?.message)?error.message:['configuration_required','authentication_denied','resource_not_found','test_scope_changed','provider_unavailable','invalid_provider_response'].includes(error?.code)?error.code:'deployment_unavailable';process.exitCode=1;
}
await mkdir('test-results/vapi',{recursive:true});await writeFile('test-results/vapi/boundary-deployment.json',JSON.stringify(report,null,2)+'\n');console.log('VAPI_BOUNDARY_DEPLOYMENT '+JSON.stringify(report));
