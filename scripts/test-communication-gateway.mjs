import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {build} from 'esbuild';
const built=await build({entryPoints:['cloudflare/workers/src/gateway.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {default:gateway}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const catalog=JSON.parse(readFileSync('packages/shared/src/communications/registered-contracts.json'));
test('all registered communication paths reach native governance unchanged and retain denial',async()=>{
 for(const api of catalog.apis){let forwarded;
  const response=await gateway.fetch(new Request('https://api.example.invalid'+api.path+'?probe=1',{method:api.method,headers:{authorization:'Bearer opaque','x-tenant-id':'selected'},...(api.method==='POST'?{body:'{}'}:{})}),{GOVERNANCE:{async fetch(request){forwarded=request;return Response.json({error:'Forbidden'},{status:403});}}});
  assert.equal(response.status,403);assert.equal(new URL(forwarded.url).pathname,api.path);assert.equal(new URL(forwarded.url).search,'?probe=1');assert.equal(forwarded.method,api.method);assert.equal(forwarded.headers.get('authorization'),'Bearer opaque');assert.equal(response.headers.get('cache-control'),'no-store');
 }
});
test('unregistered communication paths and methods cannot use a broad prefix mount',async()=>{
 const env={GOVERNANCE:{fetch:()=>assert.fail('Must not forward')}};
 for(const path of ['/v1/messages/unknown','/v1/messagesExtra','/v1/messages/pictures/extra'])assert.equal((await gateway.fetch(new Request('https://api.example.invalid'+path),env)).status,404);
 for(const api of catalog.apis)assert.equal((await gateway.fetch(new Request('https://api.example.invalid'+api.path,{method:'DELETE'}),env)).status,405);
});
test('only the three native contact contracts reach the dedicated binding unchanged and fail closed without it',async()=>{
 for(const action of ['status','start','check']){const path='/v1/voice/contact/'+action;let seen;
  const original=new Request('https://api.example.invalid'+path,{method:'POST',headers:{authorization:'Bearer native','cf-connecting-ip':'192.0.2.1'},body:'{}'});
  const response=await gateway.fetch(original,{VOICE_CONTACT:{async fetch(request){seen=request;return Response.json({error:'unauthorized'},{status:401});}},GOVERNANCE:{fetch:()=>assert.fail('Dedicated native service required')}});
  assert.equal(response.status,401);assert.equal(seen,original);assert.equal((await gateway.fetch(new Request(original.url,{method:'POST',body:'{}'}),{})).status,503);assert.equal((await gateway.fetch(new Request(original.url),{})).status,405);
 }
 assert.equal((await gateway.fetch(new Request('https://api.example.invalid/v1/voice/contact/unknown'),{})).status,404);
});
