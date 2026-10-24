import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import pin from '../tools/governance-production/production-pin.json' with {type:'json'};
const bundle=await build({entryPoints:['cloudflare/workers/src/business-tasks/vapi-tool-boundary.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {VapiToolBoundaryWorker}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const origin='https://fixture.invalid',path='/v1/vapi/voice/tasks',secret='synthetic_fixture_secret_32_bytes_minimum_123456789';
const env=()=>({VAPI_TOOLS_ORIGIN:origin,VAPI_TOOLS_SERVICE_SECRET:secret,VAPI_CONTRACT_SHA256:pin.vapiContractRegistrationWriter.definitionSha256,VAPI_API_ID:'16534',VAPI_TOOL_LIMIT:{async limit(){return {success:true};}}});
const req=(authorization='Bearer '+secret)=>new Request(origin+path,{method:'POST',headers:authorization?{authorization}:{},body:'not parsed before business integration'});
test('registered boundary authenticates provider but never accepts a business task in this release phase',async()=>{
 const worker=new VapiToolBoundaryWorker(),request=req();const response=await worker.fetch(request,env());assert.equal(response.status,503);assert.deepEqual(await response.json(),{error:'Business tools are not enabled'});assert.equal(request.bodyUsed,false);assert.equal(response.headers.get('cache-control'),'no-store');
 for(const auth of ['', 'Bearer '+secret+'x','Basic '+secret]){const denied=req(auth);assert.equal((await worker.fetch(denied,env())).status,401);assert.equal(denied.bodyUsed,false);}
});
test('only exact registered method, origin and path can reach authentication',async()=>{
 const worker=new VapiToolBoundaryWorker();
 for(const [url,method,status] of [[origin+'/health','GET',404],[origin+path,'GET',405],[origin+path+'?secret=x','POST',400],['https://other.invalid'+path,'POST',404]])assert.equal((await worker.fetch(new Request(url,{method}),env())).status,status);
});
test('missing configuration, rate limit denials and provider exceptions fail closed without leaking',async()=>{
 const worker=new VapiToolBoundaryWorker();
 for(const change of [{VAPI_TOOLS_SERVICE_SECRET:''},{VAPI_CONTRACT_SHA256:'bad'},{VAPI_TOOL_LIMIT:null},{VAPI_API_ID:'bad'},{VAPI_TOOL_LIMIT:{async limit(){throw Error(secret);}}}]){const response=await worker.fetch(req(),{...env(),...change});assert.equal(response.status,503);assert.ok(!(await response.text()).includes(secret));}
 const limited=await worker.fetch(req(),{...env(),VAPI_TOOL_LIMIT:{async limit(){return {success:false};}}});assert.equal(limited.status,429);assert.equal(limited.headers.get('retry-after'),'60');
});
