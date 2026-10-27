import assert from 'node:assert/strict';import {build} from 'esbuild';import {Miniflare,createFetchMock} from 'miniflare';import {builtinModules} from 'node:module';
const built=await build({stdin:{resolveDir:process.cwd(),contents:`
import handler from './cloudflare/workers/src/business-tasks/vapi-callback-worker.ts';
import {DurableObject} from 'cloudflare:workers';
export class FixtureRequests extends DurableObject {async fetch(request){return Response.json({forwarded:true,url:request.url,body:await request.text()},{status:409,headers:{'cache-control':'no-store'}});}}
export default {fetch(request,env,ctx){return handler.fetch(request,{...env,VAPI_TOOL_LIMIT:{async limit(){return {success:!request.headers.has('x-fixture-limit')};}}},ctx);}};
`},bundle:true,write:false,format:'esm',platform:'neutral',mainFields:['module','main'],external:['cloudflare:workers','node:*',...builtinModules],banner:{js:'import {createRequire} from "node:module";const require=createRequire("/worker.js");'}});
const mock=createFetchMock();mock.disableNetConnect();const source='a'.repeat(40),origin='https://primecare-vapi-tools-api.itpro-mohammed.workers.dev',secret='s'.repeat(43),id='11111111-1111-4111-8111-111111111111';
const runtime=new Miniflare({modules:true,script:built.outputFiles[0].text,compatibilityDate:process.env.LOCAL_WORKER_DATE||'2026-07-30',compatibilityFlags:['nodejs_compat'],durableObjects:{CALLBACK_REQUESTS:{className:'FixtureRequests',useSQLite:true}},bindings:{VAPI_CALLBACK_SOURCE:source,VAPI_TOOLS_ORIGIN:origin,VAPI_GATEWAY_ORIGIN:'https://primecare-api-gateway.itpro-mohammed.workers.dev',VAPI_TOOLS_SERVICE_SECRET:secret},fetchMock:mock});
const post=(path='/v1/vapi/voice/tasks',headers={},base=origin)=>runtime.dispatchFetch(base+path,{method:'POST',headers:{'content-type':'application/json',...headers},body:'{"action":"fixture"}'});
try{
 assert.equal((await post()).status,401);
 assert.equal((await post(undefined,{authorization:'Bearer '+'x'.repeat(43)})).status,401);
 const auth={authorization:'Bearer '+secret};assert.equal((await post(undefined,auth)).status,400);
 assert.equal((await post(undefined,{...auth,'x-fixture-limit':'1'})).status,429);
 assert.equal((await post('/unknown',auth)).status,404);
 assert.equal((await post(undefined,auth,'https://foreign.invalid')).status,404);
 assert.equal((await post('/v1/vapi/voice/tasks?override=1',auth)).status,400);
 const forwarded=await post(undefined,{...auth,'x-primecare-vapi-call-id':id});assert.equal(forwarded.status,409);assert.equal(forwarded.headers.get('x-primecare-vapi-callback-source'),source);assert.equal((await forwarded.json()).body,'{"action":"fixture"}');
 for(const action of ['preview','approve']){assert.equal((await post('/v1/voice/tasks/'+action)).status,401);assert.equal((await post('/v1/voice/tasks/'+action,{origin:'https://foreign.invalid'})).status,403);}
 console.log('VAPI_CALLBACK_WORKER_PASS provider authentication, canonical lookup-key bounds, rate limit, exact route/origin, unchanged private forwarding, separate native approval denials; no calls/SMS/database writes');
}finally{await runtime.dispose();}
