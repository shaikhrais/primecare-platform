import assert from 'node:assert/strict';
import {portalIcon,portalManifest,portalServiceWorker} from './portal-pwa-assets.mjs';
import {inflateSync} from 'node:zlib';
import {readFile} from 'node:fs/promises';
import {test} from 'node:test';
import vm from 'node:vm';
test('manifest has standalone identity, scoped login and decoded opaque PNG icons',()=>{
 const m=portalManifest('PrimeCare Clinic');assert.equal(m.display,'standalone');assert.equal(m.scope,'/');assert.equal(m.start_url,'/login?source=pwa');assert.equal(m.prefer_related_applications,false);
 for(const size of [192,512]){
  const png=portalIcon(size);assert.equal(png.readUInt32BE(16),size);assert.equal(png.readUInt32BE(20),size);assert.equal(m.icons.find(i=>i.sizes===size+'x'+size).type,'image/png');
  const chunks=[];for(let i=8;i<png.length;){const count=png.readUInt32BE(i),type=png.toString('ascii',i+4,i+8);if(type==='IDAT')chunks.push(png.subarray(i+8,i+8+count));i+=count+12;}
  const pixels=inflateSync(Buffer.concat(chunks));assert.equal(pixels.length,size*(size*4+1));assert.equal(pixels[1+3],255);
 }
});
test('worker never handles private API or mutation requests and offers no cached authenticated page',async()=>{
 const handlers={};let fetches=0;const self={location:{origin:'https://portal.test'},addEventListener:(k,f)=>handlers[k]=f,skipWaiting:async()=>{},clients:{claim:async()=>{}}};
 vm.runInNewContext(portalServiceWorker,{self,URL,Response,fetch:async()=>{fetches++;throw Error('offline');}});
 for(const request of [{method:'POST',mode:'cors',url:'https://gateway.test/v1/auth/login'},{method:'GET',mode:'cors',url:'https://portal.test/private'},{method:'GET',mode:'navigate',url:'https://other.test/'}])handlers.fetch({request,respondWith(){throw Error('Request intercepted');}});
 let response;handlers.fetch({request:{method:'GET',mode:'navigate',url:'https://portal.test/platform/administration'},respondWith(p){response=p;}});
 const offline=await response;assert.equal(offline.status,503);assert.match(await offline.text(),/You are offline/);assert.equal(fetches,1);assert.doesNotMatch(portalServiceWorker,/caches\.|localStorage|sessionStorage|indexedDB/);
});
test('build connects public install assets and self-only microphone policy to every portal',async()=>{
 const index=await readFile('websites/typescript/index.html','utf8'),build=await readFile('scripts/build-typescript-websites.mjs','utf8');assert.match(index,/rel="manifest" href="\/manifest.webmanifest"/);assert.match(build,/writePortalPwa\(target/);assert.match(build,/microphone=\(self\)/);assert.match(build,/Cache-Control: no-cache/);
});
