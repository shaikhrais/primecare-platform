import test from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';

const compiled=await build({entryPoints:['packages/shared/src/help-reader/client.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {createHelpReaderClient}=await import('data:text/javascript;base64,'+Buffer.from(compiled.outputFiles[0].text).toString('base64'));
const scope={tenantId:'tenant-a',userId:'psw-a',role:'psw',dataset:'live'};
const request={version:1,locale:'en',action:'list',query:'',offset:0,limit:25};
const identity={status:'authenticated',userId:'psw-a',tenantId:'tenant-a',roles:'psw'};
const json=value=>Response.json(value);
const wire={version:1,locale:'en',action:'list',scope,items:[],offset:0,limit:25,total:0};
async function prompt(promise){
 let timer;
 try{return await Promise.race([promise,new Promise(resolve=>timer=setTimeout(()=>resolve('stalled'),150))]);}
 finally{clearTimeout(timer);}
}

for(const mode of ['dispose','external abort'])test('client settles '+mode+' while fetch ignores abort before headers',async()=>{
 let finish,entered;
 const held=new Promise(resolve=>finish=resolve),started=new Promise(resolve=>entered=resolve);
 const abort=new AbortController();let calls=0;
 const client=createHelpReaderClient({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>true,fetcher:()=>{calls++;entered();return held;}});
 const result=client.read(request,abort.signal).catch(error=>error);
 try{
  await started;if(mode==='dispose')client.dispose();else abort.abort();
  const received=await prompt(result);assert.notEqual(received,'stalled');assert.equal(received.code,'conflict');assert.equal(calls,1);
 }finally{finish(json(identity));await result;client.dispose();}
});

for(const mode of ['dispose','external abort'])test('client observes synchronous '+mode+' inside an uncooperative fetcher',async()=>{
 let finish,client;const held=new Promise(resolve=>finish=resolve),abort=new AbortController();
 client=createHelpReaderClient({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>true,fetcher:()=>{
  if(mode==='dispose')client.dispose();else abort.abort();return held;
 }});
 const result=client.read(request,abort.signal).catch(error=>error);
 try{const received=await prompt(result);assert.notEqual(received,'stalled');assert.equal(received.code,'conflict');}
 finally{finish(json(identity));await result;client.dispose();}
});

test('synchronous transport failure removes the owned abort listener and remains unavailable',async()=>{
 let removals=0;
 const client=createHelpReaderClient({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>true,fetcher:(url,init)=>{
  const signal=init.signal,remove=signal.removeEventListener.bind(signal);
  signal.removeEventListener=(type,...args)=>{if(type==='abort')removals++;return remove(type,...args);};
  throw new Error('synchronous transport failure');
 }});
 try{const received=await client.read(request).catch(error=>error);assert.equal(received.code,'unavailable');assert.equal(removals,1);}
 finally{client.dispose();}
});

test('superseding read settles an older uncooperative headers request and preserves the new scoped read',async()=>{
 let finish,entered,calls=0;
 const held=new Promise(resolve=>finish=resolve),started=new Promise(resolve=>entered=resolve);
 const client=createHelpReaderClient({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>true,fetcher:url=>{
  if(++calls===1){entered();return held;}return Promise.resolve(json(url.endsWith('/v1/auth/me')?identity:wire));
 }});
 const old=client.read(request).catch(error=>error);
 try{
  await started;const current=client.read(request);
  const received=await prompt(old);assert.notEqual(received,'stalled');assert.equal(received.code,'conflict');
  assert.deepEqual(await current,wire);assert.equal(calls,4);
 }finally{finish(json(identity));await old;client.dispose();}
});

test('late headers after cancellation are discarded without awaiting body cancellation',async()=>{
 let finish,entered,finishCancel,cancelled=0;
 const held=new Promise(resolve=>finish=resolve),started=new Promise(resolve=>entered=resolve),cancelHeld=new Promise(resolve=>finishCancel=resolve);
 const client=createHelpReaderClient({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>true,fetcher:()=>{entered();return held;}});
 const result=client.read(request).catch(error=>error);
 try{
  await started;client.dispose();const received=await prompt(result);
  assert.notEqual(received,'stalled');assert.equal(received.code,'conflict');
  finish(new Response(new ReadableStream({cancel(){cancelled++;return cancelHeld;}})));
  await new Promise(resolve=>setImmediate(resolve));assert.equal(cancelled,1);
 }finally{finish(json(identity));finishCancel();await result;client.dispose();}
});

test('late fetch rejection after cancellation is observed without unhandled rejection',async()=>{
 let rejectFetch,entered;const unhandled=[];
 const held=new Promise((resolve,reject)=>rejectFetch=reject),started=new Promise(resolve=>entered=resolve);
 const onUnhandled=error=>unhandled.push(error);process.on('unhandledRejection',onUnhandled);
 const client=createHelpReaderClient({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>true,fetcher:()=>{entered();return held;}});
 const result=client.read(request).catch(error=>error);
 try{
  await started;client.dispose();const received=await prompt(result);
  assert.notEqual(received,'stalled');assert.equal(received.code,'conflict');
  rejectFetch(new Error('late transport failure'));await new Promise(resolve=>setImmediate(resolve));
  assert.deepEqual(unhandled,[]);
 }finally{rejectFetch(new Error('fixture cleanup'));await result;client.dispose();process.removeListener('unhandledRejection',onUnhandled);}
});

for(const [name,status,type,code] of [
 ['forbidden',403,'application/json','forbidden'],
 ['quota denied',429,'application/json','rate_limited'],
 ['unavailable',503,'application/json','unavailable'],
 ['invalid content type',200,'text/plain','unavailable'],
])test('client promptly rejects '+name+' despite pending body cancellation',async()=>{
 let finish,cancelled=0,calls=0;
 const pending=new Promise(resolve=>finish=resolve);
 const client=createHelpReaderClient({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>true,fetcher:async()=>{
  calls++;if(calls===1)return json(identity);
  return new Response(new ReadableStream({cancel(){cancelled++;return pending;}}),{status,headers:{'content-type':type}});
 }});
 const result=client.read(request).catch(error=>error);
 let timer;
 try{
  const received=await Promise.race([result,new Promise(resolve=>timer=setTimeout(()=>resolve('stalled'),150))]);
  assert.notEqual(received,'stalled');assert.equal(received.code,code);assert.equal(cancelled,1);assert.equal(calls,2);
 }finally{clearTimeout(timer);finish();await result;client.dispose();}
});

test('disposal during denied-body cancellation promptly reports conflict',async()=>{
 let finish,cancelled=0,calls=0,client;
 const pending=new Promise(resolve=>finish=resolve);
 client=createHelpReaderClient({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>true,fetcher:async()=>{
  if(++calls===1)return json(identity);
  return new Response(new ReadableStream({cancel(){cancelled++;client.dispose();return pending;}}),{status:403});
 }});
 const result=client.read(request).catch(error=>error);let timer;
 try{
  const received=await Promise.race([result,new Promise(resolve=>timer=setTimeout(()=>resolve('stalled'),150))]);
  assert.notEqual(received,'stalled');assert.equal(received.code,'conflict');assert.equal(cancelled,1);assert.equal(calls,2);
 }finally{clearTimeout(timer);finish();await result;client.dispose();}
});

test('valid reader preserves identity checks and scoped projection',async()=>{
 let calls=0;
 const client=createHelpReaderClient({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>true,fetcher:async url=>{
  calls++;return json(url.endsWith('/v1/auth/me')?identity:wire);
 }});
 try{assert.deepEqual(await client.read(request),wire);assert.equal(calls,3);}finally{client.dispose();}
});

// Shared bounded decoder must not await cancellation of an uncooperative body.
const guardedBuild=await build({entryPoints:['packages/shared/src/guarded-json.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {guardedJson}=await import('data:text/javascript;base64,'+Buffer.from(guardedBuild.outputFiles[0].text).toString('base64'));
for(const [name,bytes,limit,expected] of [
 ['valid JSON',new TextEncoder().encode('{"ok":true}'),100,'ok'],
 ['invalid JSON',new TextEncoder().encode('{bad'),100,'invalid'],
 ['oversized JSON',new Uint8Array(20),10,'invalid'],
])test('shared decoder settles '+name+' without waiting for body cancellation',async()=>{
 let cancelled=0;
 const body=new ReadableStream({start(controller){controller.enqueue(bytes);controller.close();},cancel(){cancelled++;return new Promise(()=>{});}});
 const task=guardedJson(new Response(body),limit,()=>{},()=>new Error('invalid'));
 const settled=await prompt(task.then(value=>({value}),error=>({error})));
 assert.notEqual(settled,'stalled');
 if(expected==='ok')assert.deepEqual(settled.value,{ok:true});
 else assert.match(settled.error.message,/invalid/);
});
test('shared decoder abort settles despite a never-resolving stream cancellation',async()=>{
 const abort=new AbortController();let cancelled=0;
 const body=new ReadableStream({cancel(){cancelled++;return new Promise(()=>{});}});
 const task=guardedJson(new Response(body),100,()=>{if(abort.signal.aborted)throw Error('conflict');},()=>Error('invalid'),abort.signal);
 abort.abort();const settled=await prompt(task.then(()=>null,error=>error));
 assert.notEqual(settled,'stalled');assert.match(settled.message,/conflict/);assert.equal(cancelled,1);
});
