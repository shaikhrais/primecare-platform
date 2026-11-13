/** Refuse generic Worker deployment unless generated config exactly preserves live metadata. */
import {readFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
const sortObject=value=>Array.isArray(value)?value.map(sortObject):value&&typeof value==='object'?Object.fromEntries(Object.keys(value).sort().map(k=>[k,sortObject(value[k])])):value;
const canonical=value=>JSON.stringify(sortObject(value));
const pick=(value,fields)=>Object.fromEntries(fields.filter(k=>value[k]!==undefined).map(k=>[k,value[k]]));
const sorted=list=>list.sort((a,b)=>String(a.name).localeCompare(String(b.name)));
export function assertGenericWorkerPreserves(settings,schedules,config,{requireDatabase=true}={}){
 if(!settings||!Array.isArray(settings.bindings)||!Array.isArray(schedules?.schedules)||!config||(config.vars!==undefined&&(!config.vars||typeof config.vars!=='object'||Array.isArray(config.vars))))throw Error('Worker preservation metadata unavailable');
 const bindings=settings.bindings;if(new Set(bindings.map(b=>b.name)).size!==bindings.length)throw Error('Duplicate live binding');
 const secrets=bindings.filter(b=>b.type==='secret_text');
 if(requireDatabase&&!secrets.some(b=>b.name==='DB_URL'))throw Error('Existing database binding required');
 if(secrets.some(b=>b.name!=='DB_URL'))throw Error('Generic deployment cannot prove secret preservation');
 const actual=[];
 for(const b of bindings){
  if(b.type==='secret_text')continue;
  if(b.type==='plain_text')actual.push({type:b.type,name:b.name,value:b.text});
  else if(b.type==='json')actual.push({type:b.type,name:b.name,value:b.json});
  else if(b.type==='service')actual.push({type:b.type,name:b.name,...pick(b,['service','entrypoint'])});
  else if(b.type==='ratelimit')actual.push({type:b.type,name:b.name,namespace_id:String(b.namespace_id),simple:b.simple});
  else if(b.type==='send_email')actual.push({type:b.type,name:b.name,...pick(b,['destination_address','allowed_destination_addresses','allowed_sender_addresses'])});
  else throw Error('Generic deployment cannot preserve an existing binding type');
 }
 const desired=[];
 for(const [name,value] of Object.entries(config.vars??{})){desired.push(typeof value==='string'?{type:'plain_text',name,value}:{type:'json',name,value});}
 for(const b of config.services??[])desired.push({type:'service',name:b.binding,...pick(b,['service','entrypoint'])});
 for(const b of config.ratelimits??[])desired.push({type:'ratelimit',name:b.name,namespace_id:String(b.namespace_id),simple:b.simple});
 for(const b of config.send_email??[])desired.push({type:'send_email',name:b.name,...pick(b,['destination_address','allowed_destination_addresses','allowed_sender_addresses'])});
 if(new Set(desired.map(b=>b.name)).size!==desired.length||canonical(sorted(actual))!==canonical(sorted(desired)))throw Error('Generated bindings differ from live Worker');
 if(settings.compatibility_date!==config.compatibility_date||canonical([...(settings.compatibility_flags??[])].sort())!==canonical([...(config.compatibility_flags??[])].sort()))throw Error('Generated compatibility differs from live Worker');
 const before=schedules.schedules.map(s=>s.cron).sort(),after=[...(config.triggers?.crons??[])].sort();
 if(canonical(before)!==canonical(after))throw Error('Generated schedules differ from live Worker');
 if(canonical(settings.observability??{})!==canonical(config.observability??{})){
  // Only non-secret observability metadata; never include bindings or credentials.
  const detail=canonical({live:settings.observability??null,generated:config.observability??null});
  throw Error('Generated observability differs from live Worker: '+(detail.length>4096?detail.slice(0,4096)+' [truncated]':detail));
 }
 return true;
}
async function main(){
 const account=process.env.CLOUDFLARE_ACCOUNT_ID,token=process.env.CLOUDFLARE_API_TOKEN;
 if(!/^[a-f0-9]{32}$/i.test(account??'')||!token)throw Error('Scoped provider credentials required');
 const services=['client','provider','visit','notes','billing','scheduling','notification','verification','compliance','governance','franchise-reporting','gateway'];
 const args=process.argv.slice(2);if(args.length&&!(args.length===2&&args[0]==='--service'&&services.includes(args[1])))throw Error('Invalid service selection');
 const selected=args.length?[args[1]]:services;
 const api=async path=>{const r=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+path,{redirect:'error',headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});const body=await r.json();if(!r.ok||body.success!==true)throw Error('Live Worker metadata unavailable');return body.result;};
 for(const service of selected){
  const name=service==='gateway'?'primecare-api-gateway':'primecare-'+service+'-api';
  const config=JSON.parse(await readFile('.cloudflare-workers/'+service+'.jsonc','utf8'));
  if(config.name!==name)throw Error('Generated Worker identity mismatch');
  const [settings,schedules]=await Promise.all([api('/workers/scripts/'+name+'/settings'),api('/workers/scripts/'+name+'/schedules')]);
  try{assertGenericWorkerPreserves(settings,schedules,config,{requireDatabase:service!=='gateway'});}catch(error){throw Error('Refusing generic '+service+' deployment: '+error.message);}
 }
 console.log('Generated Worker metadata matches current live state; no Worker changed during preflight.');
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(error=>{console.error(error.message);process.exitCode=1;});
