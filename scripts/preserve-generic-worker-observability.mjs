/** Prepare local generic configs; this module never contacts or changes a Worker. */
import {readFile,writeFile} from 'node:fs/promises';
import {join} from 'node:path';
import {pathToFileURL} from 'node:url';
import {GENERIC_WORKER_SERVICES} from './check-generic-worker-deploy.mjs';

// Exact non-secret settings read for all 12 services by run 43400654469,
// job 131802372568, 2026-11-13. The live preservation guard must still verify
// every prepared config; this observation grants no deployment authority.
const observed={enabled:true,head_sampling_rate:1,redact_query_string:false,
 logs:{enabled:true,head_sampling_rate:1,persist:true,invocation_logs:true},
 traces:{enabled:false,persist:true,head_sampling_rate:1}};
const canonical=value=>JSON.stringify(value&&typeof value==='object'&&!Array.isArray(value)
 ?Object.fromEntries(Object.keys(value).sort().map(key=>[key,JSON.parse(canonical(value[key]))])):value);

export function preserveGenericObservability(service,config){
 const name=service==='gateway'?'primecare-api-gateway':`primecare-${service}-api`;
 const main=service==='gateway'?'../cloudflare/workers/src/gateway.ts':'../cloudflare/workers/src/service.ts';
 if(!GENERIC_WORKER_SERVICES.includes(service)||!config||config.name!==name||config.main!==main)
  throw Error('Unexpected generic Worker identity');
 const current=canonical(config.observability);
 if(current!==canonical({enabled:true})&&current!==canonical(observed))
  throw Error('Unreviewed generated observability; preserve it for review');
 return {...structuredClone(config),observability:structuredClone(observed)};
}

export async function prepareGenericObservability(directory){
 // Validate the complete generated set before modifying any local config.
 const prepared=await Promise.all(GENERIC_WORKER_SERVICES.map(async service=>{
  const path=join(directory,service+'.jsonc');
  const config=JSON.parse(await readFile(path,'utf8'));
  return {path,config:preserveGenericObservability(service,config)};
 }));
 for(const {path,config} of prepared)await writeFile(path,JSON.stringify(config,null,2)+'\n');
 return prepared.length;
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){
 if(process.argv.length>3)throw Error('Expected at most one generated config directory');
 prepareGenericObservability(process.argv[2]??'.cloudflare-workers')
  .then(count=>console.log(`Prepared ${count} local generic configurations; live preservation and deployment authorization remain required.`))
  .catch(error=>{console.error(error.message);process.exitCode=1;});
}
