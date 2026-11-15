import test from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';

const compiled=await build({entryPoints:['packages/shared/src/help-reader/client.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {createHelpReaderClient}=await import('data:text/javascript;base64,'+Buffer.from(compiled.outputFiles[0].text).toString('base64'));
const scope={tenantId:'tenant-a',userId:'psw-a',role:'psw',dataset:'live'};
const request={version:1,locale:'en',action:'list',query:'',offset:0,limit:25};
const identity={status:'authenticated',userId:'psw-a',tenantId:'tenant-a',roles:'psw'};
const json=value=>Response.json(value);

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
 const wire={version:1,locale:'en',action:'list',scope,items:[],offset:0,limit:25,total:0};
 const client=createHelpReaderClient({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>true,fetcher:async url=>{
  calls++;return json(url.endsWith('/v1/auth/me')?identity:wire);
 }});
 try{assert.deepEqual(await client.read(request),wire);assert.equal(calls,3);}finally{client.dispose();}
});
