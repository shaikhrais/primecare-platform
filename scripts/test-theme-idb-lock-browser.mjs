import assert from 'node:assert/strict';
import {createServer} from 'node:http';
import {build} from 'esbuild';
import {chromium} from 'playwright';
const bundle=await build({entryPoints:['packages/primecare_ui/web/theme-restore-storage.ts'],bundle:true,format:'iife',globalName:'ThemeLock',write:false});
const server=createServer((req,res)=>{if(req.url==='/lock.js'){res.setHeader('content-type','text/javascript');res.end(bundle.outputFiles[0].text);}else{res.setHeader('content-type','text/html');res.end('<!doctype html><script src="/lock.js"></script>');}});
await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
let browser,context;
try{
 browser=await chromium.launch({headless:true,args:['--no-sandbox']});context=await browser.newContext();
 await context.addInitScript(()=>Object.defineProperty(navigator,'locks',{configurable:true,value:undefined}));
 const first=await context.newPage(),second=await context.newPage();const origin='http://127.0.0.1:'+server.address().port;
 await Promise.all([first.goto(origin),second.goto(origin)]);
 // Keep one IndexedDB readwrite transaction active while the second tab requests a lock.
 const holdDatabase=()=>first.evaluate(async()=>{const db=await new Promise((resolve,reject)=>{const q=indexedDB.open('primecare-theme-write-lock',1);q.onupgradeneeded=()=>q.result.createObjectStore('locks');q.onsuccess=()=>resolve(q.result);q.onerror=()=>reject(q.error);});
  window.releaseHolder=false;await new Promise(resolve=>{const tx=db.transaction('locks','readwrite');tx.oncomplete=()=>db.close();let first=true;const pulse=()=>{const q=tx.objectStore('locks').get('fixture');q.onsuccess=()=>{if(first){first=false;resolve();}if(!window.releaseHolder)pulse();};};pulse();});});
 await holdDatabase();
 await second.evaluate(()=>{window.txCreated=false;window.workExecuted=false;window.lockFinished=false;const original=IDBDatabase.prototype.transaction;IDBDatabase.prototype.transaction=function(...args){const tx=original.apply(this,args);window.txCreated=true;return tx;};window.pendingLock=ThemeLock.withThemeLibraryLock('actor-a',()=>{window.workExecuted=true;localStorage.setItem('result','saved');}).then(()=>window.lockFinished=true);});
 await second.waitForFunction(()=>window.txCreated);assert.equal(await second.evaluate(()=>window.workExecuted),false);
 await first.evaluate(()=>window.releaseHolder=true);await second.waitForFunction(()=>window.lockFinished);assert.equal(await second.evaluate(()=>localStorage.getItem('result')),'saved');
 const error=await second.evaluate(async()=>{try{await ThemeLock.withThemeLibraryLock('actor-a',()=>{throw Error('fixture');});}catch(e){return e.message;}return 'not rejected';});assert.equal(error,'fixture');
 await second.evaluate(()=>ThemeLock.withThemeLibraryLock('actor-a',()=>localStorage.setItem('after-error','saved')));assert.equal(await second.evaluate(()=>localStorage.getItem('after-error')),'saved');
 // A new Web Locks tab also takes the database lock and coordinates with fallback tabs.
 await holdDatabase();
 const nativeAvailable=await second.evaluate(()=>{delete navigator.locks;return typeof navigator.locks?.request==='function';});assert.equal(nativeAvailable,true);
 await second.evaluate(()=>{window.txCreated=false;window.workExecuted=false;window.lockFinished=false;window.pendingLock=ThemeLock.withThemeLibraryLock('actor-a',()=>{window.workExecuted=true;}).then(()=>window.lockFinished=true);});
 await second.waitForFunction(()=>window.txCreated);assert.equal(await second.evaluate(()=>window.workExecuted),false);
 await first.evaluate(()=>window.releaseHolder=true);await second.waitForFunction(()=>window.lockFinished);assert.equal(await second.evaluate(()=>window.workExecuted),true);

 const denied=await context.newPage();await denied.goto(origin);const outcome=await denied.evaluate(async()=>{Object.defineProperty(globalThis,'indexedDB',{configurable:true,value:undefined});let ran=false;try{await ThemeLock.withThemeLibraryLock('actor-a',()=>{ran=true;});}catch(e){return {ran,error:e.message};}return {ran,error:'not rejected'};});assert.deepEqual(outcome,{ran:false,error:'theme_lock_unavailable'});
 console.log('IndexedDB fallback waits across browser tabs, releases after errors, and fails closed.');
}finally{await context?.close();await browser?.close();await new Promise(resolve=>server.close(resolve));}
