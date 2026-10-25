import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {createHash} from 'node:crypto';
import {nativeContactGatewayServices,assertOwnedNativeContactTarget} from './voice-contact-deployment-plan.mjs';
import {twilioApiKeySecret} from '../packages/shared/src/communications/twilio-webhook.mjs';
import {BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';
const config=JSON.parse(await readFile('cloudflare/workers/src/business-tasks/voice-contact-deployment.json','utf8'));
const bounded=new BoundedBinaryAdapterBase(131072);
const report={sourceCommit:process.env.GITHUB_SHA,scope:'native-own-phone-enrollment-only',deployed:false,gatewayConnected:false,verifyServiceReadback:false,unauthenticatedDenied:false,unknownSessionDenied:false,foreignOriginDenied:false,corsVerified:false,liveSmsVerified:false,contactsEnrolled:0,providerWrites:false,businessActionsEnabled:false,toolsAttached:false,numberRoutingChanged:false};
const required=name=>{const value=process.env[name];if(!value)throw Error('configuration_required');return value;};
const servicesEqual=(a,b)=>JSON.stringify(a)===JSON.stringify(b);
const digest=bytes=>createHash('sha256').update(bytes).digest('hex');
function command(args,input){try{return execFileSync('node_modules/.bin/wrangler',args,{input,encoding:'utf8',stdio:['pipe','pipe','pipe'],maxBuffer:4194304});}catch(error){const code=/\[code: (\d+)\]/.exec(String(error?.stderr??''))?.[1];if(code)report.cloudflareErrorCode=Number(code);throw Error('cloudflare_cli_failed');}}
function currentMain(){try{execFileSync('git',['fetch','origin','main'],{stdio:'pipe'});if(execFileSync('git',['rev-parse','FETCH_HEAD'],{encoding:'utf8'}).trim()!==process.env.GITHUB_SHA)throw Error();}catch{throw Error('stale_main_preserved');}}
try{
 report.stage='configuration';currentMain();
 const account=required('CLOUDFLARE_ACCOUNT_ID'),token=required('CLOUDFLARE_API_TOKEN');if(!/^[a-f0-9]{32}$/i.test(account)||!/^[a-f0-9]{40}$/.test(required('GITHUB_SHA')))throw Error('configuration_required');
 const cf=async(path,missing=false)=>{const r=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+path,{redirect:'error',signal:AbortSignal.timeout(20000),headers:{authorization:'Bearer '+token,accept:'application/json'}});if(missing&&r.status===404){await r.body?.cancel();return null;}if(!r.ok){await r.body?.cancel();throw Error('cloudflare_read_failed');}const d=JSON.parse(new TextDecoder().decode(await bounded.readBoundedBody(r.body)));if(d.success!==true)throw Error('cloudflare_read_failed');return d.result;};
 const contractBytes=await readFile('tools/governance-production/voice-contact-contracts-registration.json'),accessBytes=await readFile('tools/governance-production/voice-contact-access-registration.json'),contract=JSON.parse(contractBytes),access=JSON.parse(accessBytes),pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
 const receipt=JSON.parse(await readFile('test-results/voice-contact-native/registration.json','utf8'));
 const schemaReadiness=JSON.parse(await readFile('test-results/vapi/identity-readiness.json','utf8'));
 if(schemaReadiness.readinessMeasured!==true||schemaReadiness.nativeSessionCreationTimeAvailable!==true||pin.voiceIdentitySchemaMigration.tables.some(t=>schemaReadiness.tables?.[t]!==true))throw Error('native_schema_not_ready');
 if(receipt.contract.independentReadback!==true||receipt.contract.writesAttempted!==false||JSON.stringify(receipt.contract.apiIds)!==JSON.stringify(access.apiIds)||receipt.contract.definitionSha256!==digest(contractBytes)||receipt.access.independentReadback!==true||receipt.access.definitionSha256!==digest(accessBytes)||pin.voiceContactRegistrationWriter.definitionSha256!==digest(contractBytes)||pin.voiceContactAccessWriter.definitionSha256!==digest(accessBytes)||contract.operations.length!==3)throw Error('registration_not_verified');
 report.stage='target-preservation';
 const subdomain=(await cf('/workers/subdomain'))?.subdomain;if(typeof subdomain!=='string'||!/^[a-z0-9][a-z0-9-]{0,62}$/.test(subdomain))throw Error('cloudflare_subdomain_required');
 const nativeOrigin='https://'+config.workerName+'.'+subdomain+'.workers.dev',gatewayOrigin='https://'+config.gatewayName+'.'+subdomain+'.workers.dev';report.nativeOrigin=nativeOrigin;report.gatewayOrigin=gatewayOrigin;
 const gateway=await cf('/workers/scripts/'+config.gatewayName+'/settings');
 const gatewayServices=nativeContactGatewayServices(gateway,config);
 const existing=await cf('/workers/scripts/'+config.workerName+'/settings',true);assertOwnedNativeContactTarget(existing,config);
 report.stage='read-only-provider-preflight';
 const apiKey=required('TWILIO_API_KEY_SID'),secret=required('TWILIO_API_KEY_SECRET'),serviceSid=required('TWILIO_VERIFY_SERVICE_SID'),twilioAccount=required('TWILIO_ACCOUNT_SID');
 if(!/^SK[a-f0-9]{32}$/i.test(apiKey)||!twilioApiKeySecret(secret)||!/^VA[a-f0-9]{32}$/i.test(serviceSid)||!/^AC[a-f0-9]{32}$/i.test(twilioAccount))throw Error('configuration_required');
 const verify=await fetch('https://verify.twilio.com/v2/Services/'+serviceSid,{redirect:'error',signal:AbortSignal.timeout(15000),headers:{authorization:'Basic '+btoa(apiKey+':'+secret),accept:'application/json'}});
 if(verify.status!==200){await verify.body?.cancel();throw Error('verify_service_not_ready');}
 const details=JSON.parse(new TextDecoder().decode(await bounded.readBoundedBody(verify.body)));if(details.sid!==serviceSid||details.account_sid!==twilioAccount||details.code_length!==6)throw Error('verify_service_not_ready');report.verifyServiceReadback=true;
 report.stage='native-deploy';currentMain();await mkdir('.cloudflare-workers',{recursive:true});
 const nativeConfig='.cloudflare-workers/voice-contact.jsonc';
 await writeFile(nativeConfig,JSON.stringify({name:config.workerName,main:'../cloudflare/workers/src/business-tasks/voice-contact-worker.ts',compatibility_date:config.compatibilityDate,compatibility_flags:['nodejs_compat'],workers_dev:true,preview_urls:false,minify:true,observability:{enabled:false},vars:{VOICE_CONTACT_OWNER:config.owner,VOICE_CONTACT_SOURCE:process.env.GITHUB_SHA,VOICE_CONTACT_ORIGIN:nativeOrigin,VOICE_GATEWAY_ORIGIN:gatewayOrigin,VOICE_CONTACT_CONTRACT_SHA:digest(contractBytes),VOICE_CONTACT_ACCESS_SHA:digest(accessBytes)},ratelimits:[{name:'VOICE_CONTACT_LIMIT',namespace_id:config.rateNamespace,simple:{limit:config.rateLimit,period:config.ratePeriod}}]},null,2)+'\n');
 if(!command(['deploy','--config',nativeConfig]).includes(nativeOrigin))throw Error('deployment_origin_mismatch');report.deployed=true;
 report.stage='secret-install';
 command(['secret','bulk','--config',nativeConfig],JSON.stringify({DB_URL:required('PRODUCTION_DATABASE_URL'),TWILIO_ACCOUNT_SID:twilioAccount,TWILIO_API_KEY_SID:apiKey,TWILIO_API_KEY_SECRET:secret,TWILIO_VERIFY_SERVICE_SID:serviceSid}));
 const probe=async(origin,headers={})=>{const r=await fetch(origin+'/v1/voice/contact/status',{method:'POST',redirect:'error',signal:AbortSignal.timeout(20000),headers:{'content-type':'application/json',...headers},body:'{}'});const text=await r.text();if(text.length>1000||!r.headers.get('cache-control')?.includes('no-store')||r.headers.get('x-primecare-voice-contact-source')!==process.env.GITHUB_SHA)throw Error('invalid_native_probe');return {status:r.status,origin:r.headers.get('access-control-allow-origin')};};
 const fake='Bearer '+crypto.randomUUID().replaceAll('-','')+'n'.repeat(11);
 report.stage='native-readback';let ready=false;
 for(let i=0;i<5;i++){try{if((await probe(nativeOrigin)).status===401&&(await probe(nativeOrigin,{authorization:fake})).status===401){ready=true;break;}}catch{}if(i<4)await new Promise(r=>setTimeout(r,2000));}
 if(!ready)throw Error('native_boundary_not_ready');
 report.stage='gateway-deploy';currentMain();
 const now=await cf('/workers/scripts/'+config.gatewayName+'/settings');if(JSON.stringify(now.bindings)!==JSON.stringify(gateway.bindings))throw Error('gateway_settings_changed_preserved');
 const gatewayConfig='.cloudflare-workers/voice-contact-gateway.jsonc';
 await writeFile(gatewayConfig,JSON.stringify({name:config.gatewayName,main:'../cloudflare/workers/src/gateway.ts',compatibility_date:config.compatibilityDate,compatibility_flags:['nodejs_compat'],workers_dev:true,keep_vars:true,observability:gateway.observability??{enabled:true},services:gatewayServices},null,2)+'\n');
 if(!command(['deploy','--config',gatewayConfig]).includes(gatewayOrigin))throw Error('deployment_origin_mismatch');
 report.stage='gateway-http-verification';
 for(let i=0;i<5;i++){try{report.unauthenticatedDenied=(await probe(gatewayOrigin)).status===401;report.unknownSessionDenied=(await probe(gatewayOrigin,{authorization:fake})).status===401;report.foreignOriginDenied=(await probe(gatewayOrigin,{authorization:fake,origin:'https://foreign.invalid'})).status===403;const allowed=await probe(gatewayOrigin,{origin:config.appOrigins[0]});report.corsVerified=allowed.status===401&&allowed.origin===config.appOrigins[0];if(report.unauthenticatedDenied&&report.unknownSessionDenied&&report.foreignOriginDenied&&report.corsVerified)break;}catch{}if(i<4)await new Promise(r=>setTimeout(r,2000));}
 if(!report.unauthenticatedDenied||!report.unknownSessionDenied||!report.foreignOriginDenied||!report.corsVerified)throw Error('gateway_boundary_not_ready');
 const settings=await cf('/workers/scripts/'+config.gatewayName+'/settings');if(settings.bindings.filter(b=>b.name===config.gatewayBinding&&b.type==='service'&&b.service===config.workerName).length!==1)throw Error('gateway_boundary_not_ready');
 nativeContactGatewayServices(settings,config);
 const priorSecrets=gateway.bindings.filter(b=>b.type==='secret_text').map(b=>b.name);
 report.gatewaySecretsPreserved=priorSecrets.every(name=>settings.bindings.filter(b=>b.name===name&&b.type==='secret_text').length===1);
 report.gatewayServicesPreserved=servicesEqual(nativeContactGatewayServices(settings,config),gatewayServices);
 if(!report.gatewaySecretsPreserved||!report.gatewayServicesPreserved)throw Error('gateway_boundary_not_ready');
 report.gatewayConnected=true;report.status='native_enrollment_boundary_deployed';report.stage='complete';
}catch(error){const allowed=['configuration_required','native_schema_not_ready','stale_main_preserved','cloudflare_read_failed','registration_not_verified','cloudflare_subdomain_required','gateway_settings_changed_preserved','existing_worker_preserved','verify_service_not_ready','cloudflare_cli_failed','deployment_origin_mismatch','invalid_native_probe','native_boundary_not_ready','gateway_boundary_not_ready'];report.status=allowed.includes(error?.message)?error.message:'native_deployment_unavailable';process.exitCode=1;}
await mkdir('test-results/voice-contact-native',{recursive:true});await writeFile('test-results/voice-contact-native/deployment.json',JSON.stringify(report,null,2)+'\n');console.log('VOICE_CONTACT_DEPLOYMENT '+JSON.stringify(report));
