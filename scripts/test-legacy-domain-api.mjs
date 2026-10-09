import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';

let connections=0;
globalThis.__legacyConnection=()=>{connections++;throw Error('Legacy must never connect');};
const plugin={name:'deny-database',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){globalThis.__legacyConnection()} async end(){} async query(){throw Error("Unexpected SQL")}}',loader:'js'}));}};
async function bundle(path){const result=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins:[plugin]});return import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));}
const {default:service}=await bundle('cloudflare/workers/src/service.ts');
const {default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
const registry=JSON.parse(readFileSync('cloudflare/workers/src/legacy-domain-registry.json','utf8'));
const concrete=path=>path.replace('{providerId}','foreign-provider');
const call=(route,method,headers={},body)=>service.fetch(new Request('https://service'+concrete(route.path),{method,headers,body}),{SERVICE_NAME:route.service,DB_URL:'unused'});

for(const route of registry)for(const method of route.methods){
  test(`legacy ${route.service} ${method} ${route.path} denies anonymous and bearer callers without SQL`,async()=>{
    for(const headers of [{},{authorization:'Bearer '+'a'.repeat(43),'x-tenant-id':'foreign'}]){
      connections=0;const response=await call(route,method,headers,method==='POST'?'{invalid-json':undefined);
      assert.equal(response.status,501);assert.deepEqual(await response.json(),{error:'Legacy domain operation is not implemented securely',status:'not_implemented',code:'legacy_domain_disabled'});
      assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(connections,0);
    }
  });
}
test('legacy unsupported methods return 405 and registered Allow without parsing or SQL',async()=>{
  for(const route of registry){connections=0;const response=await call(route,'DELETE',{},'{invalid');assert.equal(response.status,405);assert.equal(response.headers.get('allow'),route.methods.join(', '));assert.equal(connections,0);}
});
test('legacy paths do not match another service, nested path or unknown endpoint',async()=>{
  for(const path of ['/api/providers/foreign-provider/extra','/api/unknown','/api/providers/']){connections=0;const response=await service.fetch(new Request('https://service'+path),{SERVICE_NAME:'provider',DB_URL:'unused'});assert.equal(response.status,404);assert.equal(connections,0);}
  const response=await service.fetch(new Request('https://service/api/clients'),{SERVICE_NAME:'provider',DB_URL:'unused'});assert.equal(response.status,404);
});
test('legacy guard preserves origin validation and preflight without SQL',async()=>{
  const route=registry[0];connections=0;assert.equal((await call(route,'GET',{origin:'https://untrusted.invalid'})).status,403);
  const response=await call(route,'OPTIONS',{origin:'https://primecare-client.pages.dev'});assert.equal(response.status,204);assert.equal(response.headers.get('access-control-allow-origin'),'https://primecare-client.pages.dev');assert.equal(connections,0);
});
test('gateway forwards legacy denial without changing status or enabling writes',async()=>{
  for(const route of registry)for(const method of route.methods){connections=0;const response=await gateway.fetch(new Request('https://gateway/v1/'+route.service+concrete(route.path),{method,body:method==='POST'?'{invalid':undefined}),{[route.service.toUpperCase()]:{fetch:request=>service.fetch(request,{SERVICE_NAME:route.service,DB_URL:'unused'})}});assert.equal(response.status,501);assert.equal(response.headers.get('x-primecare-gateway'),'cloudflare-worker-typescript');assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(connections,0);}
});
test('secured self APIs keep requiring bearer authentication',async()=>{
  for(const [name,path] of [['client','/home/profile'],['client','/visits'],['provider','/profile'],['provider','/availability']]){connections=0;const response=await service.fetch(new Request('https://service'+path),{SERVICE_NAME:name,DB_URL:'unused'});assert.equal(response.status,401);assert.equal(connections,0);}
});
test('root status remains available without database access',async()=>{
  connections=0;const response=await service.fetch(new Request('https://service/'),{SERVICE_NAME:'client'});assert.equal(response.status,200);assert.equal((await response.json()).status,'ok');assert.equal(connections,0);
});
