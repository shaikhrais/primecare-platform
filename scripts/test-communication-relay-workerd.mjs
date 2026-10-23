import assert from 'node:assert/strict';import {builtinModules} from 'node:module';import {build} from 'esbuild';import {Miniflare} from 'miniflare';import {getExpectedTwilioSignature} from 'twilio/lib/webhooks/webhooks.js';
const accountSid='AC'+'a'.repeat(32),authToken='b'.repeat(32),callSid='CA'+'c'.repeat(32),url='https://fixture.invalid/relay';
const bundle=await build({stdin:{contents:`
import {TwilioRelaySocketAdapter} from './packages/shared/src/communications/twilio-relay-session.mjs';
const claims=new Set();
const adapter=new TwilioRelaySocketAdapter({accountSid:'${accountSid}',authToken:'${authToken}',sharedNumber:'+15550001000',socketUrl:'wss://fixture.invalid/relay',signatureUrl:'${url}',guard:{async current(){return {actor:{id:'fixture',tenantId:'tenant-a'},sessionId:'native-session',active:true,authentication:'otp',expiresAt:Date.now()+90000};}},claims:{async claim(input){if(claims.has(input.callSid))return null;claims.add(input.callSid);return '11111111-1111-4111-8111-111111111111';},async finish(){}},tasks:{async propose(){throw Error('unused');},async execute(){throw Error('unused');}},taskIds:['reception.callback.request'],async createModel(){return {async respond({text,tools}){if(tools.approve!==undefined)throw Error('approval exposed');return 'Heard '+text;},close(){}};}});
let currentSession;export default {fetch(request){if(new URL(request.url).pathname==='/probe')return Response.json({state:currentSession?.state});const pair=new WebSocketPair();try{currentSession=adapter.open(request,pair[1]);return new Response(null,{status:101,webSocket:pair[0]});}catch{return new Response(null,{status:403});}}};
`,resolveDir:process.cwd()},bundle:true,format:'esm',platform:'neutral',mainFields:['module','main'],external:['node:*',...new Set(builtinModules.map(x=>x.replace(/^node:/,'')))],banner:{js:'import {createRequire} from "node:module";const require=createRequire("/worker.js");'},write:false});
const runtime=new Miniflare({modules:true,script:bundle.outputFiles[0].text,compatibilityDate:'2026-07-30',compatibilityFlags:['nodejs_compat']});
const request=signature=>runtime.dispatchFetch(url,{headers:{upgrade:'websocket','x-twilio-signature':signature}});
try{
 assert.equal((await request('bad')).status,403);
 const response=await request(getExpectedTwilioSignature(authToken,url,{}));assert.equal(response.status,101);const socket=response.webSocket;socket.accept();const frames=[];socket.addEventListener('message',event=>frames.push(JSON.parse(event.data)));
 socket.send(JSON.stringify({type:'setup',accountSid,callSid,sessionId:'VX'+'d'.repeat(32),to:'+15550001000',direction:'inbound'}));
 // Setup crosses asynchronous guard/claim/model initialization; a valid prompt
 // follows its completed event turn, without weakening output assertions.
 const readyUntil=Date.now()+5000;let ready=false;while(Date.now()<readyUntil){if((await(await runtime.dispatchFetch('https://fixture.invalid/probe')).json()).state==='ready'){ready=true;break;}await new Promise(r=>setTimeout(r,20));}assert.equal(ready,true);socket.send(JSON.stringify({type:'prompt',voicePrompt:'Hello',last:true}));
 const until=Date.now()+5000;while(!frames.length&&Date.now()<until)await new Promise(r=>setTimeout(r,20));assert.equal(frames[0]?.type,'text');assert.equal(frames[0]?.token,'Heard Hello');assert.equal(frames[0]?.last,true);
 socket.send(JSON.stringify({type:'dtmf',digit:'0'}));const end=Date.now()+5000;while(!frames.some(x=>x.type==='end')&&Date.now()<end)await new Promise(r=>setTimeout(r,20));assert.ok(frames.some(x=>x.type==='end'));socket.close();console.log('WORKERD_RELAY_SESSION_PASS 7');
}finally{await runtime.dispose();}
