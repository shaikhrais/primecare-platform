import {isBodylessDiagnostic,BODYLESS_CONTRACTS} from './primecare-diagnostic-body-policy.mjs';
/** Loopback-only Newman diagnostics against the actual bundled gateway/Workers. */
import {createServer} from 'node:http';
import {readFileSync,writeFileSync,mkdirSync} from 'node:fs';
import {createRequire} from 'node:module';
import {pathToFileURL} from 'node:url';
import {build} from 'esbuild';
import {createHash} from 'node:crypto';
export const sha256=value=>createHash('sha256').update(value).digest('hex');

export const NEWMAN_VERSION='6.2.1';
export function flatten(items){return items.flatMap(item=>item.item?flatten(item.item):[item]);}
export function classify(status,transport=false){
 if(transport)return 'transport_failure';
 if(status===401||status===403)return 'authentication_required';
 if(status===404)return 'route_not_found';
 if(status===405)return 'method_rejected';
 if(status===400||status===422)return 'request_contract_needed';
 if(status>=500)return 'unsupported_or_database_probe_blocked';
 if(status>=200&&status<300)return 'response_observed_not_verified';
 return 'other_http_status';
}
export function validateCoverage(collection,ledger){
 const expected=new Set(ledger.operations.filter(o=>o.stage!=='retired_with_evidence').map(o=>o.api));
 const actual=flatten(collection.item??[]).map(o=>o.name);
 if(expected.size!==ledger.summary.activeUniqueOperations||actual.length!==expected.size||new Set(actual).size!==actual.length||actual.some(api=>!expected.has(api)))throw Error('Exact active ledger identity coverage mismatch');
}
export function safeCollection(collection,baseUrl){
 const base=new URL(baseUrl);if(base.protocol!=='http:'||base.hostname!=='127.0.0.1')throw Error('Diagnostics require an IPv4 loopback HTTP origin');
 const seen=new Set();
 const item=flatten(collection.item??[]).map(entry=>{
  const match=/^(GET|POST|PUT|PATCH|DELETE|HEAD|OPTIONS) (\/[^\s]*)$/.exec(entry.name??'');
  if(!match||entry.request?.method!==match[1])throw Error('Collection identity/method mismatch');
  const [api,method,route]=match;if(seen.has(api))throw Error('Duplicate operation identity');seen.add(api);
  const concrete=route.replace(/\{[^}]+\}/g,'diagnostic-record').replace(/:[A-Za-z_][A-Za-z0-9_]*/g,'diagnostic-record');
  if(concrete.includes('{{')||concrete.includes('..')||concrete.includes('?')||concrete.includes('#'))throw Error('Unsafe canonical diagnostic path');
  return {name:api,request:{method,url:base.origin+concrete,header:[{key:'Content-Type',value:'application/json'}],...(method==='GET'||method==='HEAD'||isBodylessDiagnostic(api)?{}:{body:{mode:'raw',raw:'{}'}})}};
 });
 return {info:{name:'PrimeCare offline diagnostic requests',schema:'https://schema.getpostman.com/json/collection/v2.1.0/collection.json'},item};
}
export async function startGateway(){
 const guard={databaseAttempts:0,externalNetworkAttempts:0,methodObservations:[]};
 const plugin={name:'deny-database-and-network',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'denied-pg'}));b.onLoad({filter:/.*/,namespace:'denied-pg'},()=>({contents:`export class Client { async connect(){globalThis.__primecareDiagnosticGuard.databaseAttempts++;const error=Error('OFFLINE_DATABASE_DISABLED');error.stack='OFFLINE_DATABASE_DISABLED';throw error;} async query(){globalThis.__primecareDiagnosticGuard.databaseAttempts++;const error=Error('OFFLINE_DATABASE_DISABLED');error.stack='OFFLINE_DATABASE_DISABLED';throw error;} async end(){} }`,loader:'js'}));}};
 const output=await build({entryPoints:['cloudflare/workers/src/gateway.ts','cloudflare/workers/src/service.ts'],bundle:true,write:false,outdir:'diagnostics',platform:'node',format:'esm',plugins:[plugin],metafile:true,logLevel:'silent'});
 guard.sourceHashes=Object.fromEntries(Object.keys(output.metafile.inputs).filter(p=>!p.startsWith('denied-pg:')).map(p=>[p,sha256(readFileSync(p))]));
 const modules=await Promise.all(output.outputFiles.map(f=>import('data:text/javascript;base64,'+Buffer.from(f.text).toString('base64'))));
 const gateway=modules[output.outputFiles.findIndex(f=>f.path.endsWith('/gateway.js'))].default;
 const worker=modules[output.outputFiles.findIndex(f=>f.path.endsWith('/service.js'))].default;
 const originalFetch=globalThis.fetch,originalGuard=globalThis.__primecareDiagnosticGuard;
 globalThis.__primecareDiagnosticGuard=guard;
 globalThis.fetch=async()=>{guard.externalNetworkAttempts++;throw Error('OFFLINE_EXTERNAL_NETWORK_DISABLED');};
 const limit={limit:async()=>({success:true})};
 const env={};for(const service of ['auth','client','provider','visit','notes','billing','scheduling','notification','verification','compliance','governance','franchise-reporting']){
  env[service.toUpperCase().replaceAll('-','_')]={fetch:request=>worker.fetch(request,{SERVICE_NAME:service,DB_URL:'offline-disabled',AUTH_SOURCE_LIMIT:limit,WORKSPACE_SOURCE_LIMIT:limit,EMAIL:{send:async()=>{throw Error('OFFLINE_EMAIL_DISABLED');}},EMAIL_FROM:'diagnostics.invalid'})};
 }
 const server=createServer(async(req,res)=>{
  try{let body='';for await(const chunk of req){body+=chunk;if(body.length>4096)throw Error('Unexpected request body');}
   guard.methodObservations.push({method:req.method,path:new URL(req.url,'http://127.0.0.1').pathname});
   const response=await gateway.fetch(new Request('http://127.0.0.1'+req.url,{method:req.method,headers:{...req.headers,'cf-connecting-ip':'127.0.0.1'},...(req.method==='GET'||req.method==='HEAD'||body.length===0?{}:{body})}),env);
   res.writeHead(response.status,Object.fromEntries(response.headers));res.end(Buffer.from(await response.arrayBuffer()));
  }catch{res.writeHead(500,{'content-type':'application/json'});res.end('{}');}
 });
 await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
 return {baseUrl:'http://127.0.0.1:'+server.address().port,guard,close:async()=>{await new Promise(resolve=>server.close(resolve));globalThis.fetch=originalFetch;globalThis.__primecareDiagnosticGuard=originalGuard;}};
}
export function loadNewman(){
 const req=createRequire(process.env.PRIMECARE_NEWMAN_PACKAGE??import.meta.url);
 const pkg=req('newman/package.json');if(pkg.version!==NEWMAN_VERSION)throw Error('Newman version must be '+NEWMAN_VERSION);return req('newman');
}
export async function diagnose(collection,{newman=loadNewman(),baseUrl,guard={databaseAttempts:0,externalNetworkAttempts:0},summary={},stages={},sourceHashes={}}={}){
 const safe=safeCollection(collection,baseUrl), records=new Map(safe.item.map(i=>[i.name,{api:i.name,method:i.request.method,path:i.name.slice(i.request.method.length+1),stage:stages[i.name]??'not_supplied',status:null,classification:'not_executed',transportFailure:false}]));
 await new Promise((resolve,reject)=>{
  const run=newman.run({collection:safe,reporters:[],timeoutRequest:5000,timeoutScript:1000,ignoreRedirects:true,insecure:false},(error)=>error?reject(Error('Newman execution failed')):resolve());
  run.on('request',(error,args)=>{const row=records.get(args.item.name);if(!row)return;row.status=error?null:args.response?.code??null;row.transportFailure=Boolean(error);row.classification=classify(row.status,row.transportFailure);});
 });
 const operations=[...records.values()],counts={};for(const row of operations)counts[row.classification]=(counts[row.classification]??0)+1;
 if(operations.some(x=>x.classification==='not_executed'))throw Error('Incomplete diagnostic collection execution');
 return {scope:'offline_loopback_unauthenticated_newman',productionVerified:false,authorizationVerified:false,newmanVersion:NEWMAN_VERSION,countingRule:'Diagnostics and field repairs do not complete APIs.',limitations:'Unauthenticated synthetic probes cannot verify ownership or business behavior. Namespace or dynamic captures may return 2xx; responses remain unverified. Offline database denial can produce 5xx without implying a production outage.',baselineUniqueOperations:summary.uniqueOperations??1415,activeUniqueOperations:summary.activeUniqueOperations??operations.length,retiredOperations:summary.retiredOperations??9,executedUniqueOperations:operations.length,databaseAttemptsBlocked:guard.databaseAttempts,externalNetworkAttemptsBlocked:guard.externalNetworkAttempts,classificationCounts:counts,sourceHashes:{...guard.sourceHashes,...Object.fromEntries(['scripts/primecare-diagnostic-body-policy.mjs',...new Set(Object.values(BODYLESS_CONTRACTS))].map(p=>[p,sha256(readFileSync(p))])),...sourceHashes},operations};
}
async function main(){
 const collectionPath=process.argv[2]??'docs/api/PrimeCare.postman_collection.json',reportPath=process.argv[3]??'docs/api/primecare-api-error-report.json';
 const collection=JSON.parse(readFileSync(collectionPath)),ledger=JSON.parse(readFileSync('docs/api/api-delivery-checklist.json'));
 validateCoverage(collection,ledger);
 const fixture=await startGateway();try{const report=await diagnose(collection,{baseUrl:fixture.baseUrl,guard:fixture.guard,summary:ledger.summary,stages:Object.fromEntries(ledger.operations.map(o=>[o.api,o.stage])),sourceHashes:{[collectionPath]:sha256(readFileSync(collectionPath)),['docs/api/api-delivery-checklist.json']:sha256(readFileSync('docs/api/api-delivery-checklist.json')),['scripts/run-primecare-api-diagnostics.mjs']:sha256(readFileSync('scripts/run-primecare-api-diagnostics.mjs')),['scripts/generate-primecare-postman.mjs']:sha256(readFileSync('scripts/generate-primecare-postman.mjs'))}});if(report.executedUniqueOperations!==ledger.summary.activeUniqueOperations)throw Error('Collection active operation coverage mismatch');mkdirSync('docs/api',{recursive:true});writeFileSync(reportPath,JSON.stringify(report,null,2)+'\n');console.log(JSON.stringify({report:reportPath,executed:report.executedUniqueOperations,classifications:report.classificationCounts}));}finally{await fixture.close();}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(()=>{console.error('Offline API diagnostics failed; no complete report was written.');process.exitCode=1;});
