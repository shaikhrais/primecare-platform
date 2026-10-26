// Actual Worker runtime with synthetic WAV and stubbed biometric HTTP only.
import assert from 'node:assert/strict';import {build} from 'esbuild';import {Miniflare} from 'miniflare';
const bundle=await build({stdin:{contents:`
import {AculabVoiceprintProvider} from './packages/shared/src/communications/voiceprint-provider.mjs';
import {wav} from './scripts/fixtures/business-voiceprint-audio.mjs';
export default {async fetch(request){const operation=new URL(request.url).pathname;let requests=0;const subject='pc-11111111-1111-4111-8111-111111111111';
const provider=new AculabVoiceprintProvider({cloudId:'1-2-0',username:'fixture@example.test',groupKey:'fixture-group-key-1234',sensitivity:1,fetch:async(url,options)=>{requests++;const u=new URL(url);if(u.origin!=='https://ws-1-2-0.aculabcloud.net'||options.redirect!=='manual'||!options.headers.authorization.startsWith('Basic '))throw Error('Invalid request');if(u.pathname.endsWith('/delete'))return Response.json({transaction_id:'r',user_id:subject,deleted:'2026-10-25_00:00:00'});if(!(options.body instanceof Uint8Array)||options.body.length!==wav().length)throw Error('Invalid audio');if(u.pathname.endsWith('/verify')&&(u.searchParams.get('enable_pad')!=='true'||u.searchParams.get('text_dependent')!=='true'))throw Error('Missing verification protection');return Response.json({transaction_id:'r',application_instance_id:'vb-1',verified:true,confidence:2,...(operation==='/spoof'?{pad_detected:{type:'TypeC'}}:{})});}});
try{const input={subject,audio:operation==='/invalid'?new Uint8Array(44):wav(),signal:new AbortController().signal};const result=operation==='/enroll'?await provider.enroll(input):operation==='/remove'?await provider.remove(input):await provider.verify(input);return Response.json({result,requests});}catch{return Response.json({requests},{status:503});}finally{provider.close();}}};
`,resolveDir:process.cwd()},bundle:true,format:'esm',platform:'neutral',write:false});
const runtime=new Miniflare({modules:true,script:bundle.outputFiles[0].text,compatibilityDate:'2026-07-30'});
try{
 const get=async path=>(await runtime.dispatchFetch('https://fixture.invalid'+path));
 assert.equal((await(await get('/enroll')).json()).result.enrolled,true);
 assert.equal((await(await get('/verify')).json()).result.matched,true);
 const rejected=await(await get('/spoof')).json();assert.equal(rejected.result.matched,false);assert.equal(rejected.result.spoofed,true);
 const invalid=await get('/invalid');assert.equal(invalid.status,503);assert.equal((await invalid.json()).requests,0);
 assert.equal((await(await get('/remove')).json()).result.deleted,true);
 console.log('WORKERD_VOICEPRINT_PASS 7');
}finally{await runtime.dispose();}
// Exercise the actual runtime fetch primitive, not an injected JS function.
const {createFetchMock}=await import('miniflare');const mock=createFetchMock();mock.disableNetConnect();let outbound=0;
mock.get('https://ws-1-2-0.aculabcloud.net').intercept({path:/^\/voice_biometrics\/v1\/user\/verify\?/,method:'PUT'}).reply(200,()=>{outbound++;return JSON.stringify({transaction_id:'native-1',verified:true,confidence:2});},{headers:{'content-type':'application/json'}});
const nativeBundle=await build({stdin:{contents:`
import {AculabVoiceprintProvider} from './packages/shared/src/communications/voiceprint-provider.mjs';
import {wav} from './scripts/fixtures/business-voiceprint-audio.mjs';
export default {async fetch(){const p=new AculabVoiceprintProvider({cloudId:'1-2-0',username:'fixture@example.test',groupKey:'fixture-group-key-1234',sensitivity:1});try{return Response.json(await p.verify({subject:'pc-11111111-1111-4111-8111-111111111111',audio:wav(),signal:new AbortController().signal}));}catch{return new Response('unavailable',{status:503});}finally{p.close();}}};
`,resolveDir:process.cwd()},bundle:true,format:'esm',platform:'neutral',write:false});
const nativeRuntime=new Miniflare({modules:true,script:nativeBundle.outputFiles[0].text,compatibilityDate:'2026-07-30',fetchMock:mock});
try{const response=await nativeRuntime.dispatchFetch('https://fixture.invalid');assert.equal(response.status,200);assert.equal((await response.json()).matched,true);assert.equal(outbound,1);mock.assertNoPendingInterceptors();console.log('WORKERD_VOICEPRINT_NATIVE_FETCH_PASS');}finally{await nativeRuntime.dispose();}
