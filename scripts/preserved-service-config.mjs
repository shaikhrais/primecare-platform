/** Reconstruct supported existing bindings without introducing service authority. */
export function preservedServiceConfig(settings,service){
 if(!['auth','governance'].includes(service)||!Array.isArray(settings?.bindings)||!settings.bindings.some(b=>b.name==='DB_URL'&&b.type==='secret_text'))throw Error('Existing scoped database binding required');
const config={name:'primecare-'+service+'-api',main:'../cloudflare/workers/src/service.ts',compatibility_date:settings.compatibility_date??'2026-09-27',compatibility_flags:settings.compatibility_flags??['nodejs_compat'],workers_dev:true,vars:{},services:[],ratelimits:[],send_email:[],observability:settings.observability??{enabled:true}};
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
if(config.vars.SERVICE_NAME!==service)throw Error('Service scope changed');
return config;
}
