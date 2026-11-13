import {readFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
import {GENERIC_WORKER_SERVICES} from './check-generic-worker-deploy.mjs';
export function describeWorkerPreservation(service,settings,config){
 if(!GENERIC_WORKER_SERVICES.includes(service)||!Array.isArray(settings?.bindings)||!config)
  throw Error('Worker description metadata unavailable');
 const extra=settings.bindings.filter(x=>x.type==='secret_text'&&x.name!=='DB_URL');
 if(extra.some(x=>typeof x.name!=='string'||!x.name))throw Error('Secret binding name unavailable');
 // Binding names identify dependencies. Never include secret values, ordinary
 // binding values, credentials or arbitrary provider response fields.
 return {service,liveObservability:settings.observability??null,generatedObservability:config.observability??null,
  additionalSecretCount:extra.length,additionalSecretNames:extra.map(x=>x.name).sort()};
}
async function main(){
const account=process.env.CLOUDFLARE_ACCOUNT_ID, token=process.env.CLOUDFLARE_API_TOKEN;
if(!/^[a-f0-9]{32}$/i.test(account??'')||!token)throw Error('Scoped provider credentials required');
for(const service of GENERIC_WORKER_SERVICES){
 const name=service==='gateway'?'primecare-api-gateway':'primecare-'+service+'-api';
 const r=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+'/workers/scripts/'+name+'/settings',{redirect:'error',headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});
 const body=await r.json();if(!r.ok||body.success!==true||!Array.isArray(body.result?.bindings))throw Error('Live Worker settings unavailable: '+service);
 const config=JSON.parse(await readFile('.cloudflare-workers/'+service+'.jsonc','utf8'));
 console.log(JSON.stringify(describeWorkerPreservation(service,body.result,config)));
}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)
 main().catch(error=>{console.error(error.message);process.exitCode=1;});
