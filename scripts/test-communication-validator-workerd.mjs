// Isolated actual Workers engine; no account, database, network or mail sends.
import assert from 'node:assert/strict';
import {mkdir,writeFile} from 'node:fs/promises';
import {Miniflare} from 'miniflare';
import {build} from 'esbuild';
const bundle=await build({stdin:{contents:`import catalog from './packages/shared/src/communications/registered-contracts.json';import {validateRegisteredCommunicationSchema as check} from './cloudflare/workers/src/business-tasks/schema-validator.ts';export default {async fetch(request){const {apiId,kind,value}=await request.json();const api=catalog.apis.find(api=>api.id===apiId);return Response.json({valid:check(api?.[kind+'Schema'],value)})}};`,resolveDir:process.cwd()},bundle:true,format:'esm',platform:'neutral',write:false});
const runtime=new Miniflare({modules:true,script:bundle.outputFiles[0].text,compatibilityDate:'2026-07-30'});
let checks=0;
try{
 for(const [apiId,kind,value,valid] of [
  [710,'request',{action:'read',id:'thread'},true],
  [710,'request',{action:'read',id:'thread',tenantId:'forged'},false],
  [710,'response',{id:'thread',version:1},true],
  [710,'response',{id:'thread'},false],
  [16510,'request',{action:'signal',id:'thread',key:'key',version:1,callId:'call',signal:{type:'ice',candidate:{candidate:'synthetic'}}},true],
  [16510,'request',{action:'signal',id:'thread',key:'key',version:1,callId:'call',signal:{type:'candidate',candidate:{candidate:'synthetic'}}},false],
  [16511,'request',{action:'queue',id:'mail',key:'key',to:'invalid',subject:'Subject',text:'Text'},false],
  [999,'request',{},false],
 ]){
  const response=await runtime.dispatchFetch('https://fixture.invalid/',{method:'POST',body:JSON.stringify({apiId,kind,value})});
  assert.equal(response.status,200);assert.deepEqual(await response.json(),{valid});checks++;
 }
 await mkdir('test-results/communication-validator',{recursive:true});
 await writeFile('test-results/communication-validator/workerd.json',JSON.stringify({sourceCommit:process.env.GITHUB_SHA,checks,passed:true,engine:'workerd',dynamicCompilation:false,production:false},null,2));
 console.log('WORKERD_COMMUNICATION_VALIDATOR_PASS '+checks);
}finally{await runtime.dispose();}
