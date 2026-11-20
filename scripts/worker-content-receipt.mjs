/** Independently verify exact emitted modules when provider version IDs differ. */
import {createHash} from 'node:crypto';
import {readdir,readFile} from 'node:fs/promises';
import {join} from 'node:path';
import {verifyWorkerDeploymentEventually} from './worker-deployment-receipt.mjs';
const uuid=v=>typeof v==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(v);
const sha=bytes=>createHash('sha256').update(bytes).digest('hex');
export async function emittedModules(directory){
 const entries=await readdir(directory,{withFileTypes:true}),files={};
 for(const entry of entries){
  if(!entry.isFile())throw Error('Unexpected emitted module directory');
  if(entry.name==='README.md'||entry.name.endsWith('.map'))continue;
  if(!/^[a-zA-Z0-9_.-]+\.(?:m?js|wasm|bin|txt|json)$/.test(entry.name))throw Error('Unexpected emitted module file');
  files[entry.name]=await readFile(join(directory,entry.name));
 }
 if(!Object.keys(files).some(name=>/\.m?js$/.test(name)))throw Error('Emitted JavaScript module required');return files;
}
async function moduleHashes(response,expectedNames){
 if(!response.ok||!response.body)throw Error('Active Worker content unavailable');
 const reader=response.body.getReader(),chunks=[];let size=0;
 try{while(true){const part=await reader.read();if(part.done)break;size+=part.value.length;if(size>32*1024*1024)throw Error('Worker content bound exceeded');chunks.push(part.value);}}finally{await reader.cancel();}
 const bytes=Buffer.concat(chunks.map(b=>Buffer.from(b))),type=response.headers.get('content-type')??'',files={};
 if(/^multipart\/(?:form-data|mixed)/i.test(type)){
  const data=await new Response(bytes,{headers:{'content-type':type.replace(/^multipart\/mixed/i,'multipart/form-data')}}).formData();
  for(const [name,value] of data){
   if(name==='metadata')continue;
   if(typeof value==='string'||Object.hasOwn(files,name)||!name||name.includes('..'))throw Error('Invalid active module part');
   files[name]=sha(Buffer.from(await value.arrayBuffer()));
  }
 }else{
  const name=response.headers.get('cf-entrypoint')??(expectedNames.length===1?expectedNames[0]:null);if(!name||!/^application\/(?:javascript|ecmascript)/i.test(type))throw Error('Active module entrypoint unavailable');files[name]=sha(bytes);
 }
 return files;
}
export async function verifyPublishedWorker(input,{directory,readContent,expectedFiles,strictVerifier=verifyWorkerDeploymentEventually}={}){
 try{return await strictVerifier(input);}catch(error){
  // A real upload occurred; never label an unmatched version as the uploaded one.
  // Instead require exact independently read code bytes and stable active/latest lineage.
  if(!readContent||!(/^[a-f0-9]{40}$/.test(input.source??''))||!uuid(input.versionId)||!uuid(input.previousDeploymentId)||!['auth','governance','gateway'].includes(input.service)||input.worker!==(input.service==='gateway'?'primecare-api-gateway':'primecare-'+input.service+'-api'))throw error;
  const expected=expectedFiles??await emittedModules(directory),wanted=Object.fromEntries(Object.entries(expected).map(([name,bytes])=>[name,sha(bytes)]));
  if(!Object.keys(wanted).length)throw Error('Expected emitted modules unavailable');
  const base='/workers/scripts/'+input.worker;
  const snapshot=async()=>{
   const raw=await input.api(base+'/deployments?per_page=1'),active=raw?.deployments?.[0];
   if(!active||!uuid(active.id)||!Number.isFinite(Date.parse(active.created_on))||active.versions?.length!==1||!uuid(active.versions[0].version_id)||active.versions[0].percentage!==100)throw Error('Sole active version required for content verification');
   const list=await input.api(base+'/versions?per_page=100');
   if(!Array.isArray(list?.items)||list.items[0]?.id!==active.versions[0].version_id)throw Error('Latest version is not the active content version');
   return {id:active.id,versionId:active.versions[0].version_id,createdOn:active.created_on};
  };
  const before=await snapshot(),actual=await moduleHashes(await readContent(base+'/content/v2'),Object.keys(wanted));
  const names=Object.keys(wanted).sort();if(JSON.stringify(names)!==JSON.stringify(Object.keys(actual).sort())||names.some(name=>actual[name]!==wanted[name]))throw Error('Active Worker code differs from emitted CI modules');
  const after=await snapshot();if(before.id!==after.id||before.versionId!==after.versionId)throw Error('Active Worker changed during code verification');
  return {format:2,source:input.source,worker:input.worker,service:input.service,deploymentId:after.id,versionId:after.versionId,wranglerReportedVersionId:input.versionId,trafficPercent:100,createdOn:after.createdOn,independentlyReadDeployment:true,independentlyVerifiedCode:true,versionReadback:'active_content_and_listing',moduleSha256:names.map(name=>({name,sha256:actual[name]})),sourceAssociation:'verified CI checkout and exact emitted module hashes read from active Worker',registeredGovernanceArtifactId:null,grantAssociationApproved:false};
 }
}
