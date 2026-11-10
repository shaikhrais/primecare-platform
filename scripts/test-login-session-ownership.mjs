import {build} from 'esbuild';
import {JSDOM} from 'jsdom';
import assert from 'node:assert/strict';
import {test} from 'node:test';
const bundled=await build({entryPoints:['websites/typescript/src/auth-screen.ts'],bundle:true,write:false,platform:'node',format:'esm',plugins:[{name:'isolated-view-dependencies',setup(b){
 const modules={
  './auth-client':`export const authenticate=(...args)=>globalThis.loginProbe.authenticate(...args);export const revokeProvisionalSession=(...args)=>globalThis.loginProbe.revoke(...args);export const verifyMfa=()=>{};`,
  './auth-mfa':`export const requestMfa=()=>{};`,
  './screen-text':`export const liveScreenText=()=>({text:(_s,_l,_k,f)=>f,subscribe:()=>()=>{}});`,
  './media-look':`export const applyMediaTokens=()=>{};export class EntryMediaLook{render(){return ''}brand(){return ''}text(){return ''}icon(){return ''}}`,
  './shell':`export const renderShell=(root,options)=>{root.innerHTML=options.content;};`
 };
 b.onResolve({filter:/^\.\/(auth-client|auth-mfa|screen-text|media-look|shell)$/},a=>({path:a.path,namespace:'probe'}));
 b.onLoad({filter:/.*/,namespace:'probe'},a=>({contents:modules[a.path],loader:'js'}));
}}]});
const {renderAuth}=await import('data:text/javascript;base64,'+Buffer.from(bundled.outputFiles[0].text).toString('base64'));
for(const replacement of ['newer-token',null,'provisional-token'])test(`pending login preserves replacement ${replacement}`,async()=>{
 const dom=new JSDOM('<main></main>',{url:'https://fixture.invalid/login'});
 Object.assign(globalThis,{document:dom.window.document,FormData:dom.window.FormData,sessionStorage:dom.window.sessionStorage});
 const navigation=[];globalThis.location={search:'',assign:value=>navigation.push(value)};
 sessionStorage.setItem('primecare_session','starting-token');
 let resolve;const pending=new Promise(r=>{resolve=r}),revoked=[];
 globalThis.loginProbe={authenticate:()=>pending,revoke:async(_gateway,token)=>{revoked.push(token)}};
 const root=document.querySelector('main');renderAuth(root,'https://gateway.invalid','Fixture','en');
 const form=root.querySelector('[data-cy=login-form]');form.dispatchEvent(new dom.window.Event('submit',{cancelable:true}));
 if(replacement===null)sessionStorage.removeItem('primecare_session');else sessionStorage.setItem('primecare_session',replacement);
 resolve({token:'provisional-token',identity:{roles:'psw',userId:'fixture',status:'authenticated'}});
 await new Promise(setImmediate);await new Promise(setImmediate);
 assert.equal(sessionStorage.getItem('primecare_session'),replacement);
 assert.deepEqual(revoked,replacement==='provisional-token'?[]:['provisional-token']);
 assert.deepEqual(navigation,[]);
 dom.window.close();
});
test('unavailable browser storage rejects before credential exchange and permits retry',async()=>{
 const dom=new JSDOM('<main></main>',{url:'https://fixture.invalid/login'});
 const storage=dom.window.sessionStorage;
 Object.assign(globalThis,{document:dom.window.document,FormData:dom.window.FormData,sessionStorage:{getItem(){throw new Error('Storage denied')}}});
 const navigation=[];globalThis.location={search:'',assign:value=>navigation.push(value)};
 let calls=0;globalThis.loginProbe={authenticate:async()=>{calls++;return {token:'confirmed-token',identity:{roles:'psw',userId:'fixture',status:'authenticated'}}},revoke:async()=>{}};
 const root=document.querySelector('main');renderAuth(root,'https://gateway.invalid','Fixture','en');
 const form=root.querySelector('[data-cy=login-form]');
 form.dispatchEvent(new dom.window.Event('submit',{cancelable:true}));
 await new Promise(setImmediate);
 assert.equal(calls,0);assert.deepEqual(navigation,[]);
 assert.notEqual(root.querySelector('[data-cy=api-status]').value,'');
 globalThis.sessionStorage=storage;
 form.dispatchEvent(new dom.window.Event('submit',{cancelable:true}));
 await new Promise(setImmediate);
 assert.equal(calls,1);assert.equal(storage.getItem('primecare_session'),'confirmed-token');
 assert.equal(navigation.length,1);
 dom.window.close();
});
