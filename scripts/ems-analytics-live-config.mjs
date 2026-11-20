/** Translate live bindings without dropping unrelated configuration or copying secrets. */
export function liveWorkerConfig(worker,settings){
 if(!['primecare-api-gateway','primecare-governance-api'].includes(worker)||!Array.isArray(settings?.bindings)||new Set(settings.bindings.map(b=>b.name)).size!==settings.bindings.length)throw Error('Unexpected live Worker settings');
 const gateway=worker==='primecare-api-gateway';
 const config={name:worker,main:gateway?'../cloudflare/workers/src/gateway.ts':'../cloudflare/workers/src/service.ts',compatibility_date:settings.compatibility_date??'2026-09-27',compatibility_flags:settings.compatibility_flags??['nodejs_compat'],workers_dev:true,vars:{},services:[],ratelimits:[],send_email:[],observability:settings.observability??{enabled:true}};
 for(const b of settings.bindings){
  if(b.type==='secret_text')continue;
  if(b.type==='plain_text'){config.vars[b.name]=b.text;continue;}
  if(b.type==='json'){config.vars[b.name]=b.json;continue;}
  if(b.type==='service'){config.services.push({binding:b.name,service:b.service,...(b.entrypoint?{entrypoint:b.entrypoint}:{})});continue;}
  if(b.type==='ratelimit'){config.ratelimits.push({name:b.name,namespace_id:String(b.namespace_id),simple:b.simple});continue;}
  if(b.type==='send_email'){config.send_email.push({name:b.name,...Object.fromEntries(['destination_address','allowed_destination_addresses','allowed_sender_addresses'].filter(k=>b[k]!==undefined).map(k=>[k,b[k]]))});continue;}
  if(b.type==='hyperdrive'){(config.hyperdrive??=[]).push({binding:b.name,id:b.id});continue;}
  if(b.type==='durable_object_namespace'){(config.durable_objects??={bindings:[]}).bindings.push({name:b.name,class_name:b.class_name,...(b.script_name?{script_name:b.script_name}:{})});continue;}
  if(b.type==='version_metadata'){config.version_metadata={binding:b.name};continue;}
  if(b.type==='analytics_engine'){(config.analytics_engine_datasets??=[]).push({binding:b.name,dataset:b.dataset});continue;}
  throw Error('Unsupported live binding; preserve existing deployment');
 }
 if(!gateway&&config.vars.SERVICE_NAME!=='governance')throw Error('Governance service scope mismatch');
 return config;
}
export function verifyUnchangedBindings(before,after,allowed){
 if(!Array.isArray(before?.bindings)||!Array.isArray(after?.bindings)||new Set(after.bindings.map(b=>b.name)).size!==after.bindings.length)throw Error('Invalid live binding readback');
 const canonical=v=>Array.isArray(v)?v.map(canonical):v&&typeof v==='object'?Object.fromEntries(Object.keys(v).sort().map(k=>[k,canonical(v[k])])):v;
 const clean=settings=>settings.bindings.filter(b=>!allowed.includes(b.name)).map(b=>canonical(b)).sort((a,b)=>a.name.localeCompare(b.name));
 if(JSON.stringify(clean(before))!==JSON.stringify(clean(after)))throw Error('Unrelated live bindings changed');
}
