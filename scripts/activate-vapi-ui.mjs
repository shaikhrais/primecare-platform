import {readFile,writeFile,mkdir} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
const report={source:process.env.GITHUB_SHA,deployed:false,phoneRoutingChanged:false,businessToolsEnabled:false};
try{
 execFileSync('git',['fetch','origin','main'],{stdio:'pipe'});if(execFileSync('git',['rev-parse','FETCH_HEAD'],{encoding:'utf8'}).trim()!==report.source)throw Error('stale_main');
 const registration=JSON.parse(await readFile('test-results/vapi/ui-registration.json','utf8'));if(registration.apiIds?.length!==4||registration.role!=='code_admin')throw Error('registration_required');
 const response=await fetch('https://api.cloudflare.com/client/v4/accounts/'+process.env.CLOUDFLARE_ACCOUNT_ID+'/workers/scripts/primecare-governance-api/settings',{headers:{authorization:'Bearer '+process.env.CLOUDFLARE_API_TOKEN},signal:AbortSignal.timeout(20000)});if(!response.ok)throw Error('configuration_read_failed');const settings=(await response.json()).result;
 const allowed=['DB_URL','EMAIL','EMAIL_FROM','EMAIL_ALLOWED_SENDER','SERVICE_NAME','WORKSPACE_SOURCE_LIMIT','LOOK_AI','LOOK_SOURCE','VAPI_PRIVATE_API_KEY','VAPI_ADMIN_ORG_ID','VAPI_ADMIN_TEMPLATE_ID','VAPI_ADMIN_CATALOG'];
 if(!Array.isArray(settings?.bindings)||settings.bindings.some(b=>!allowed.includes(b.name)))throw Error('unreviewed_binding');
 process.env.LOOK_AI_SERVICE='primecare-look-ai';execFileSync(process.execPath,['scripts/generate-cloudflare-worker-config.mjs'],{stdio:'pipe'});
 const config=JSON.parse(await readFile('.cloudflare-workers/governance.jsonc','utf8'));config.keep_vars=true;config.vars={...config.vars,...Object.fromEntries(settings.bindings.filter(b=>b.type==='plain_text').map(b=>[b.name,b.text])),LOOK_SOURCE:report.source,VAPI_ADMIN_ORG_ID:'9e1d8550-4b84-4472-a782-67557fe73944',VAPI_ADMIN_TEMPLATE_ID:'5ae2ab0c-fad0-454c-8cf7-64b81c91c850',VAPI_ADMIN_CATALOG:'[]'};
 const path='.cloudflare-workers/vapi-admin-governance.jsonc';await writeFile(path,JSON.stringify(config));
 const cli=(args,input)=>execFileSync('node_modules/.bin/wrangler',args,{encoding:'utf8',input,stdio:['pipe','pipe','pipe'],maxBuffer:4194304});
 cli(['deploy','--config',path]);cli(['secret','bulk','--config',path],JSON.stringify({VAPI_PRIVATE_API_KEY:process.env.VAPI_PRIVATE_API_KEY}));report.deployed=true;await new Promise(r=>setTimeout(r,8000));
 const denied=await fetch('https://primecare-api-gateway.itpro-mohammed.workers.dev/v1/governance/platform/vapi/inventory');report.anonymousStatus=denied.status;await denied.body?.cancel();if(denied.status!==401)throw Error('anonymous_readback_failed');
}catch(e){report.error=/^[a-z_]+$/.test(e?.message??'')?e.message:'deployment_failed';process.exitCode=1;}
await mkdir('test-results/vapi',{recursive:true});await writeFile('test-results/vapi/ui-deployment.json',JSON.stringify(report,null,2));console.log('VAPI_UI_DEPLOYMENT '+JSON.stringify(report));
