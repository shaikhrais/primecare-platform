// Actual workerd and official SDK signatures/XML. Directory and credentials are
// synthetic; returned TwiML is never sent to Twilio or used to make a phone call.
import assert from 'node:assert/strict';
import {builtinModules} from 'node:module';
import {mkdir,writeFile} from 'node:fs/promises';
import {Miniflare} from 'miniflare';
import {build} from 'esbuild';
import {getExpectedTwilioSignature} from 'twilio/lib/webhooks/webhooks.js';
const builtin=new Set(builtinModules.map(name=>name.replace(/^node:/,'')));
const config={accountSid:'AC'+'a'.repeat(32),authToken:'b'.repeat(32),sharedNumber:'+15550001000',numberVerified:true,incomingUrl:'https://fixture.invalid/provider?stage=incoming',gatherUrl:'https://fixture.invalid/provider?stage=extension',maxWebhookBytes:4096};
const bundle=await build({stdin:{contents:`
import {TwilioVoiceExtensionAdapter} from './packages/shared/src/communications/twilio-voice.mjs';
const config=${JSON.stringify(config)};
export default {async fetch(request){
 let queries=0;const mode=request.headers.get('x-test-mode');
 const row={extension:'100001',tenantId:'tenant-a',userId:'user-a',published:true,active:true,tenantActive:true,userActive:true};
 const adapter=new TwilioVoiceExtensionAdapter({...config,directory:{async lookup(){queries++;if(mode==='unknown'||mode==='revoked'&&queries>1)return [];return mode==='duplicate'?[row,row]:[row];}}});
 const response=await adapter.respond(request);response.headers.set('x-test-queries',String(queries));return response;
}};`,resolveDir:process.cwd()},bundle:true,format:'esm',platform:'neutral',mainFields:['module','main'],external:['node:*'],plugins:[{name:'native-node-builtins',setup(build){
 // Twilio's CJS helpers use bare Node names. Link them to real native modules,
 // never a crypto mock or a dynamic-require shim in the Worker isolate.
 build.onResolve({filter:/^[a-z][a-z0-9_:/-]*$/},args=>builtin.has(args.path)?{path:args.path,namespace:'native-builtin'}:undefined);
 build.onLoad({filter:/.*/,namespace:'native-builtin'},args=>({contents:'export * from "node:'+args.path+'";import native from "node:'+args.path+'";export default native;',loader:'js'}));
}}],write:false});
const runtime=new Miniflare({modules:true,script:bundle.outputFiles[0].text,compatibilityDate:'2026-07-30',compatibilityFlags:['nodejs_compat']});let checks=0;
async function send({stage='extension',params={},signature,mode,body}={}){
 const url=stage==='incoming'?config.incomingUrl:config.gatherUrl;
 const values={AccountSid:config.accountSid,CallSid:'CA'+'c'.repeat(32),To:config.sharedNumber,Direction:'inbound',...(stage==='extension'?{Digits:'100001'}:{}),...params};
 return runtime.dispatchFetch(url,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':signature??getExpectedTwilioSignature(config.authToken,url,values),...(mode?{'x-test-mode':mode}:{})},body:body??new URLSearchParams(values).toString()});
}
try{
 const prompt=await send({stage:'incoming'});assert.equal(prompt.status,200);assert.match(await prompt.text(),/<Gather/);assert.equal(prompt.headers.get('x-test-queries'),'0');checks++;
 const dial=await send();assert.equal(dial.status,200);assert.match(await dial.text(),/<Identity>primecare_[a-f0-9]{64}<\/Identity>/);assert.equal(dial.headers.get('x-test-queries'),'2');checks++;
 const invalid=await send({signature:'invalid'});assert.equal(invalid.status,403);assert.equal(invalid.headers.get('x-test-queries'),'0');checks++;
 const foreign=await send({params:{To:'+15550009999'}});assert.equal(foreign.status,403);assert.equal(foreign.headers.get('x-test-queries'),'0');checks++;
 for(const mode of ['unknown','duplicate','revoked']){const denied=await send({mode});assert.equal(denied.status,200);assert.doesNotMatch(await denied.text(),/<Dial/);checks++;}
 const bad=await send({body:'x=%FF'});assert.equal(bad.status,400);assert.equal(bad.headers.get('x-test-queries'),'0');checks++;
 await mkdir('test-results/communication-twilio',{recursive:true});
 await writeFile('test-results/communication-twilio/workerd.json',JSON.stringify({sourceCommit:process.env.GITHUB_SHA,checks,passed:true,engine:'workerd',sdk:'twilio@6.2.0',compatibilityFlags:['nodejs_compat'],officialSignatureValidation:true,officialTwimlBuilder:true,directory:'synthetic',liveProviderVerified:false,numbersPurchased:0,extensionsAssigned:0,callsPlaced:0,production:false},null,2));
 console.log('WORKERD_COMMUNICATION_TWILIO_PASS '+checks);
}finally{await runtime.dispose();}
