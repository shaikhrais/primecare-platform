import fs from 'node:fs';import path from 'node:path';import {fileURLToPath} from 'node:url';
export const remoteGuard=`const refuse=(message)=>{pm.execution.skipRequest();throw new Error(message);};
const raw=pm.variables.replaceIn(pm.request.url.toString());
// Postman sandbox does not expose the browser URL constructor.
const match=/^(https?):\\/\\/([^/?#]+)(?:[/?#]|$)/i.exec(raw);
if(!match||/[\\s\\\\@]/.test(match[2])){refuse('Invalid diagnostic URL scheme or embedded credentials');}
const authority=/^(\\[[0-9a-f:]+\\]|[a-z0-9.-]+)(?::([0-9]+))?$/i.exec(match[2]);
if(!authority||authority[2]&&(Number(authority[2])<1||Number(authority[2])>65535)){refuse('Invalid diagnostic URL authority');}
const host=authority[1].toLowerCase();
if(!['127.0.0.1','localhost','[::1]','::1'].includes(host)&&String(pm.variables.get('allowRemote'))!=='true'){refuse('Remote diagnostics disabled; explicitly review and set allowRemote=true to proceed');}`;
export const aggregateTests=`const api=pm.request.headers.get('X-PrimeCare-Diagnostic-Operation');
const stage=pm.request.headers.get('X-PrimeCare-Diagnostic-Stage');
const status=pm.response.code;
const outcome=status===401||status===403?'requires_auth':status===404||status===405?'routing_failure':status>=500?'handler_or_database_failure':status>=400?'request_or_workflow_rejected':'response_received';
const result={api,stage,status,outcome,businessVerified:false};
let results;try{results=JSON.parse(pm.collectionVariables.get('operationResults')||'[]');}catch(e){results=[];}
results=results.filter(r=>r.api!==api);results.push(result);
pm.collectionVariables.set('operationResults',JSON.stringify(results));
pm.collectionVariables.set('errorReport',JSON.stringify(results.filter(r=>r.status>=400)));
pm.test('Diagnostic response recorded (not business completion)',()=>pm.expect(status).to.be.within(100,599));`;
export function buildCollection(checklist,openapi={}){
 const ops=checklist.operations.filter(o=>o.stage!=='retired_with_evidence');
 if(new Set(ops.map(o=>o.api)).size!==ops.length)throw Error('Duplicate method/path in checklist');
 return {info:{name:'PrimeCare finite API diagnostics',description:'One request per active exact method/path. Diagnostic responses are not workflow completion. Unknown mutation bodies are empty diagnostic objects. No credentials or real record identifiers are supplied.',schema:'https://schema.getpostman.com/json/collection/v2.1.0/collection.json'},variable:[{key:'baseUrl',value:'http://127.0.0.1:8787'},{key:'allowRemote',value:'false'},{key:'operationResults',value:'[]'},{key:'errorReport',value:'[]'}],auth:{type:'noauth'},event:[{listen:'prerequest',script:{type:'text/javascript',exec:remoteGuard.split('\n')}},{listen:'test',script:{type:'text/javascript',exec:aggregateTests.split('\n')}}],item:ops.map(o=>{
 const params=[...o.route.matchAll(/\{([^}]+)\}/g)].map(m=>({key:m[1],value:'audit-record',description:'Synthetic diagnostic identifier; replace only in your reviewed environment.'}));
 const route=o.route.replace(/\{([^}]+)\}/g,':$1');
 const request={method:o.method,header:[{key:'X-PrimeCare-Diagnostic-Operation',value:o.api},{key:'X-PrimeCare-Diagnostic-Stage',value:o.stage}],auth:{type:'noauth'},url:{raw:'{{baseUrl}}'+route,host:['{{baseUrl}}'],path:route.slice(1).split('/'),...(params.length?{variable:params}:{})},description:'Stage: '+o.stage+'. '+o.nextAction+'; no automatic retry or business verification.'};
 if(!['GET','HEAD'].includes(o.method)){
  const media=openapi.paths?.[o.route]?.[o.method.toLowerCase()]?.requestBody?.content?.['application/json'];
  const example=media?.example??Object.values(media?.examples??{}).find(e=>Object.hasOwn(e,'value'))?.value;
  request.body={mode:'raw',raw:JSON.stringify(example??{}),options:{raw:{language:'json'}}};request.header.push({key:'Content-Type',value:'application/json'});
 }
 return {name:o.api,request};})};
}
export function buildEnvironment(){return {name:'PrimeCare local diagnostic environment',values:[{key:'baseUrl',value:'http://127.0.0.1:8787',enabled:true,type:'default'},{key:'allowRemote',value:'false',enabled:true,type:'default'}],_postman_variable_scope:'environment'};}
if(process.argv[1]===fileURLToPath(import.meta.url)){
 const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'..');
 const checklist=JSON.parse(fs.readFileSync(path.join(root,'docs/api/api-delivery-checklist.json')));
 // Explicit examples only; no synthetic request-contract fields or credentials.
 const collection=buildCollection(checklist);
 fs.writeFileSync(path.join(root,'docs/api/PrimeCare.postman_collection.json'),JSON.stringify(collection,null,2)+'\n');
 fs.writeFileSync(path.join(root,'docs/api/PrimeCare.local.postman_environment.json'),JSON.stringify(buildEnvironment(),null,2)+'\n');
 console.log('Generated '+collection.item.length+' active exact operation diagnostics.');
}
