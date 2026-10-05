import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {test} from 'node:test';
import {readFileSync,mkdtempSync,rmSync} from 'node:fs';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {execFileSync} from 'node:child_process';

async function bundle(entry) {
 const result=await build({entryPoints:[entry],bundle:true,write:false,platform:'node',format:'esm',
  plugins:[{name:'no-database',setup(b){
   b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));
   b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){throw new Error("Unexpected database access")}}',loader:'js'}));
  }}]});
 return import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));
}
const {sourceLoginLimit}=await bundle('cloudflare/workers/src/auth-source-limit.ts');
const {default:service}=await bundle('cloudflare/workers/src/service.ts');
const {default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
const request=(path='/login',headers={},method='POST')=>new Request('https://auth.test'+path,{method,headers});
const address={'cf-connecting-ip':'192.0.2.15'};
test('allowed login uses a hashed source key',async()=>{
 let key; const response=await sourceLoginLimit(request('/login',address),{AUTH_SOURCE_LIMIT:{limit:async input=>{key=input.key;return {success:true}}}});
 assert.equal(response,null);assert.match(key,/^[a-f0-9]{64}$/);assert.ok(!key.includes(address['cf-connecting-ip']));
});
test('forwarded and real IP headers cannot select the source key',async()=>{
 const keys=[];const env={AUTH_SOURCE_LIMIT:{limit:async ({key})=>{keys.push(key);return {success:true}}}};
 await sourceLoginLimit(request('/login',address),env);
 await sourceLoginLimit(request('/login',{...address,'x-forwarded-for':'198.51.100.2','x-real-ip':'198.51.100.3'}),env);
 assert.equal(keys[0],keys[1]);
 await sourceLoginLimit(request('/login',{'cf-connecting-ip':'192.0.2.16'}),env);
 assert.notEqual(keys[0],keys[2]);
});
test('IPv6 sources are accepted',async()=>{
 assert.equal(await sourceLoginLimit(request('/login',{'cf-connecting-ip':'2001:db8::1'}),{AUTH_SOURCE_LIMIT:{limit:async()=>({success:true})}}),null);
});
test('denied source returns no-store 429 with retry window',async()=>{
 const response=await sourceLoginLimit(request('/login',address),{AUTH_SOURCE_LIMIT:{limit:async()=>({success:false})}});
 assert.equal(response.status,429);assert.equal(response.headers.get('retry-after'),'60');assert.equal(response.headers.get('cache-control'),'no-store');
});
test('missing or invalid Cloudflare address fails closed even with forwarded headers',async()=>{
 for(const ip of [undefined,'bad-address','192.0.2.1, 192.0.2.2']) {
  const headers={'x-forwarded-for':'192.0.2.1',...(ip?{'cf-connecting-ip':ip}:{})};
  const response=await sourceLoginLimit(request('/login',headers),{AUTH_SOURCE_LIMIT:{limit:async()=>assert.fail('must not allocate')}});
  assert.equal(response.status,503);
 }
});
test('missing or failed limiter never permits credential verification',async()=>{
 for(const env of [{},{AUTH_SOURCE_LIMIT:{limit:async()=>{throw Error('private-provider-details')}}}]) {
  const response=await sourceLoginLimit(request('/login',address),env);
  assert.equal(response.status,503);assert.ok(!(await response.text()).includes('private-provider-details'));
 }
});
test('logout, identity, health and preflight are outside the source login budget',async()=>{
 for(const [path,method] of [['/logout','POST'],['/me','GET'],['/health','GET'],['/login','OPTIONS']])
  assert.equal(await sourceLoginLimit(request(path,{},method),{}),null);
});
test('direct Worker and both gateway aliases enforce before database access',async()=>{
 const keys=[];const env={SERVICE_NAME:'auth',DB_URL:'fixture',AUTH_SOURCE_LIMIT:{limit:async ({key})=>{keys.push(key);return {success:false}}}};
 const direct=await service.fetch(request('/login',address),env);
 assert.equal(direct.status,429);
 for(const path of ['/v1/auth/login','/api/auth/login']) {
  const response=await gateway.fetch(request(path,{...address,origin:'https://primecare-clinic.pages.dev'}),{AUTH:{fetch:r=>service.fetch(r,env)}});
  assert.equal(response.status,429);assert.equal(response.headers.get('access-control-allow-origin'),'https://primecare-clinic.pages.dev');
 }
 assert.equal(new Set(keys).size,1);assert.equal(keys.length,3);
});
test('deployment generator attaches governed binding only to auth Worker',()=>{
 const dir=mkdtempSync(join(tmpdir(),'auth-source-config-'));
 try {
  execFileSync(process.execPath,['scripts/generate-cloudflare-worker-config.mjs',dir]);
  const policy=JSON.parse(readFileSync('cloudflare/workers/src/auth-source-policy.json','utf8')).login;
  const auth=JSON.parse(readFileSync(join(dir,'auth.jsonc'),'utf8'));
  assert.deepEqual(auth.ratelimits,[
    {name:'AUTH_SOURCE_LIMIT',namespace_id:policy.namespaceId,simple:{limit:policy.maxAttempts,period:policy.windowSeconds}},
    {name:'WORKSPACE_SOURCE_LIMIT',namespace_id:'2026100402',simple:{limit:120,period:60}},
  ]);
  const governance=JSON.parse(readFileSync(join(dir,'governance.jsonc'),'utf8'));
  assert.notEqual(governance.ratelimits[0].namespace_id,auth.ratelimits[1].namespace_id);
  const client=JSON.parse(readFileSync(join(dir,'client.jsonc'),'utf8'));
  assert.deepEqual(client.ratelimits,[{name:'WORKSPACE_SOURCE_LIMIT',namespace_id:'2026100403',simple:{limit:120,period:60}}]);
  for(const name of ['gateway'])assert.equal(JSON.parse(readFileSync(join(dir,name+'.jsonc'),'utf8')).ratelimits,undefined);
 } finally {rmSync(dir,{recursive:true,force:true})}
});

test('Flutter login preflight permits every header emitted by the existing client',async()=>{
 const names=['authorization','content-type','x-device-id','x-tenant-id','x-requested-with',
  'x-device-fingerprint','x-request-id','x-correlation-id','x-request-signature','x-app-version'];
 for(const target of [service,gateway]){
  const response=await target.fetch(request('/v1/auth/login',{
   origin:'https://primecare-clinic.pages.dev',
   'access-control-request-method':'POST',
   'access-control-request-headers':names.join(','),
  },'OPTIONS'),{SERVICE_NAME:'auth'});
  assert.equal(response.status,204);
  assert.equal(response.headers.get('access-control-allow-origin'),'https://primecare-clinic.pages.dev');
  const allowed=response.headers.get('access-control-allow-headers').toLowerCase().split(',');
  for(const name of names)assert.ok(allowed.includes(name),'Missing Flutter header: '+name);
 }
});
test('Flutter preflight from an untrusted origin remains rejected',async()=>{
 for(const target of [service,gateway]){
  const response=await target.fetch(request('/v1/auth/login',{
   origin:'https://untrusted.example','access-control-request-method':'POST',
   'access-control-request-headers':'authorization,x-requested-with',
  },'OPTIONS'),{SERVICE_NAME:'auth'});
  assert.equal(response.status,403);assert.equal(response.headers.get('access-control-allow-origin'),null);
 }
});
