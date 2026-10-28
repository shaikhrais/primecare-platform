/** Update only governance code; preserve and verify its existing live bindings. */
import {mkdir,writeFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
const account=process.env.CLOUDFLARE_ACCOUNT_ID,token=process.env.CLOUDFLARE_API_TOKEN,worker='primecare-governance-api';
if(!/^[a-f0-9]{32}$/i.test(account??'')||!token)throw Error('Cloudflare configuration required');
const api=async path=>{const r=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+path,{headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});const value=await r.json();if(!r.ok||value.success!==true)throw Error('Cloudflare metadata request failed');return value.result;};
const settings=await api('/workers/scripts/'+worker+'/settings');
if(!Array.isArray(settings.bindings)||!settings.bindings.some(b=>b.name==='DB_URL'&&b.type==='secret_text'))throw Error('Existing encrypted database binding required');
const config={name:worker,main:'../cloudflare/workers/src/service.ts',compatibility_date:settings.compatibility_date??'2026-09-27',compatibility_flags:settings.compatibility_flags??['nodejs_compat'],workers_dev:true,vars:{},services:[],ratelimits:[],send_email:[],observability:settings.observability??{enabled:true}};
for(const binding of settings.bindings){
 const b=binding;
 if(b.type==='secret_text')continue; // Wrangler preserves secrets, and --keep-vars preserves existing vars.
 if(b.type==='plain_text'){config.vars[b.name]=b.text;continue;}
 if(b.type==='json'){config.vars[b.name]=b.json;continue;}
 if(b.type==='service'){config.services.push({binding:b.name,service:b.service,...(b.entrypoint?{entrypoint:b.entrypoint}:{})});continue;}
 if(b.type==='ratelimit'){config.ratelimits.push({name:b.name,namespace_id:String(b.namespace_id),simple:b.simple});continue;}
 if(b.type==='send_email'){config.send_email.push({name:b.name,...Object.fromEntries(['destination_address','allowed_destination_addresses','allowed_sender_addresses'].filter(k=>b[k]!==undefined).map(k=>[k,b[k]]))});continue;}
 if(b.type==='hyperdrive'){(config.hyperdrive??=[]).push({binding:b.name,id:b.id});continue;}
 if(b.type==='durable_object_namespace'){(config.durable_objects??={bindings:[]}).bindings.push({name:b.name,class_name:b.class_name,...(b.script_name?{script_name:b.script_name}:{})});continue;}
 if(b.type==='version_metadata'){config.version_metadata={binding:b.name};continue;}
 throw Error('Unsupported live binding; deployment refused: '+b.type);
}
if(config.vars.SERVICE_NAME!=='governance')throw Error('Governance service scope changed');
await mkdir('.cloudflare-workers',{recursive:true});await writeFile('.cloudflare-workers/approved-governance.jsonc',JSON.stringify(config,null,2));
try{execFileSync('node_modules/.bin/wrangler',['deploy','--config','.cloudflare-workers/approved-governance.jsonc','--keep-vars'],{stdio:['ignore','pipe','pipe'],maxBuffer:8*1024*1024});}catch(error){let diagnostic=String(error.stderr??'')+'\n'+String(error.stdout??'');for(const value of [token,account,process.env.PRODUCTION_DATABASE_URL,...Object.values(config.vars).filter(v=>typeof v==='string'&&v.length>3)])if(value)diagnostic=diagnostic.split(value).join('[redacted]');diagnostic=diagnostic.replace(/postgres(?:ql)?:\/\/[^\s\"']+/g,'[redacted database]');console.error(diagnostic.slice(-12000));throw Error('Governance worker publication failed; no other worker targeted');}
const after=await api('/workers/scripts/'+worker+'/settings');
const fingerprint=bindings=>JSON.stringify(bindings.map(b=>({name:b.name,type:b.type,...(b.service?{service:b.service}:{}),...(b.entrypoint?{entrypoint:b.entrypoint}:{}),...(b.id?{id:b.id}:{})})).sort((a,b)=>a.name.localeCompare(b.name)));
if(fingerprint(settings.bindings)!==fingerprint(after.bindings))throw Error('Live binding preservation readback failed');
const subdomain=await api('/workers/subdomain');if(subdomain.subdomain!=='itpro-mohammed')throw Error('Worker host scope changed');
const response=await fetch('https://'+worker+'.'+subdomain.subdomain+'.workers.dev/health',{signal:AbortSignal.timeout(30000)});if(!response.ok)throw Error('Published governance health readback failed');
await mkdir('test-results/approved-code-admin-release',{recursive:true});await writeFile('test-results/approved-code-admin-release/worker.json',JSON.stringify({source:process.env.GITHUB_SHA,worker,deployed:true,existingBindingsPreserved:true,healthStatus:response.status,otherWorkersModified:0,providerActions:0},null,2));
console.log('APPROVED_GOVERNANCE_DEPLOYED existing bindings preserved; other workers untouched');
