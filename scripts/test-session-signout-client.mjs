import {build} from 'esbuild';import assert from 'node:assert/strict';import {test} from 'node:test';
const output=await build({entryPoints:['websites/typescript/src/auth-client.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {signOut}=await import('data:text/javascript;base64,'+Buffer.from(output.outputFiles[0].text).toString('base64'));
test('sign-out confirms the canonical authenticated no-store request',async()=>{
 await signOut('https://gateway.test///','synthetic-session',async(url,init)=>{assert.equal(url,'https://gateway.test/v1/auth/logout');assert.equal(init.method,'POST');assert.equal(init.cache,'no-store');assert.deepEqual(init.headers,{authorization:'Bearer synthetic-session'});return Response.json({status:'signed_out'});});
});
test('sign-out rejects denied and unavailable responses without reading their body',async()=>{
 for(const status of [401,403,429,500,503]){let read=false;await assert.rejects(signOut('https://gateway.test','synthetic-session',async()=>({ok:false,status,json:async()=>{read=true;throw Error('Sensitive response must not be inspected');}})),/sign-out failed/);assert.equal(read,false);}
});
test('HTTP success without a valid sign-out acknowledgement is rejected',async()=>{
 for(const payload of [null,[],{},'signed_out',{status:'authenticated'},{status:1}])await assert.rejects(signOut('https://gateway.test','synthetic-session',async()=>Response.json(payload)),/Invalid sign-out response/);
 await assert.rejects(signOut('https://gateway.test','synthetic-session',async()=>new Response('<html>unavailable</html>')),/Invalid sign-out response/);
});
test('sign-out does not finish before acknowledgement parsing completes',async()=>{
 let release,finished=false;const held=new Promise(r=>release=r);const pending=signOut('https://gateway.test','synthetic-session',async()=>({ok:true,json:async()=>{await held;return{status:'signed_out'};}})).then(()=>finished=true);
 await Promise.resolve();await Promise.resolve();assert.equal(finished,false);release();await pending;assert.equal(finished,true);
});
test('network and body failures remain failed sign-outs',async()=>{
 await assert.rejects(signOut('https://gateway.test','synthetic-session',async()=>{throw Error('Synthetic offline');}),/Synthetic offline/);
 await assert.rejects(signOut('https://gateway.test','synthetic-session',async()=>({ok:true,json:async()=>{throw Error('Synthetic body outage');}})),/Invalid sign-out response/);
});
