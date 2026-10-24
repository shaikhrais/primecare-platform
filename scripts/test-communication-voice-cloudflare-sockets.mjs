import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {Miniflare} from 'miniflare';

test('real Workers socket host preserves 101 upgrade, bidirectional messages and close',async()=>{
 const bundle=await build({stdin:{contents:`
 import {createCloudflareVoiceSockets} from './cloudflare/workers/src/business-tasks/voice-cloudflare-sockets.ts';
 export default {async fetch(request){
  if(request.headers.get('upgrade')!=='websocket')return new Response(null,{status:426});
  const host=createCloudflareVoiceSockets({WebSocketPair,Response});
  const {client,server}=host.pair();
  server.addEventListener('message',event=>{if(event.data==='finish')server.close(1000,'Finished');else server.send('received:'+event.data);});
  server.accept();return host.upgrade(client);
 }};`,resolveDir:process.cwd()},bundle:true,format:'esm',platform:'neutral',write:false});
 const runtime=new Miniflare({modules:true,script:bundle.outputFiles[0].text,compatibilityDate:'2026-04-03'});
 try{
  assert.equal((await runtime.dispatchFetch('https://fixture.invalid')).status,426);
  const response=await runtime.dispatchFetch('https://fixture.invalid',{headers:{upgrade:'websocket'}});
  assert.equal(response.status,101);assert.ok(response.webSocket);response.webSocket.accept();
  const event=(name)=>new Promise((resolve,reject)=>{const timer=setTimeout(()=>reject(Error('Socket timeout')),3000);response.webSocket.addEventListener(name,value=>{clearTimeout(timer);resolve(value);},{once:true});});
  const message=event('message');response.webSocket.send('hello');assert.equal((await message).data,'received:hello');
  const close=event('close');response.webSocket.send('finish');assert.equal((await close).code,1000);
 }finally{await runtime.dispose();}
});
