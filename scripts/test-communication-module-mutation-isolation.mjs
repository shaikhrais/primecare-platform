import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';import {readFile} from 'node:fs/promises';
const b=await build({entryPoints:['packages/shared/src/communications/module-port.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {CommunicationModulePort}=await import('data:text/javascript;base64,'+Buffer.from(b.outputFiles[0].text).toString('base64'));
const labels=JSON.parse(await readFile('packages/primecare_ui/catalogs/communication-modules.registration.json','utf8')).locales.en;
const scope={tenantId:'t',userId:'u',role:'psw',dataset:'live'},signal=new AbortController().signal;
const row={id:'thread1',version:1,kind:'conversation',tenantId:'t',members:['u'],businessReference:'Owned work',messages:[],readThrough:{}};
const command=()=>({itemId:row.id,version:1,action:'send',fields:{body:'Original draft'}});
test('transport mutation cannot change original-key/body retry after lost acknowledgement',async()=>{
 const dispatched=[];let lost=true;
 const p=new CommunicationModulePort(scope,'messenger',async(op,value)=>{
  if(op==='message.inbox')return {items:[row]};
  dispatched.push(structuredClone(value));
  if(lost){lost=false;value.key='changed-key';value.text='Changed body';throw Error('Lost acknowledgement');}
  return {id:row.id,version:2};
 },labels);
 try{
  await p.read({search:'',offset:0},signal);
  await assert.rejects(()=>p.mutate(command(),'original-key',signal));
  await p.mutate(command(),'original-key',signal);
  assert.deepEqual(dispatched[1],dispatched[0]);assert.equal(dispatched[1].key,'original-key');assert.equal(dispatched[1].text,'Original draft');
 }finally{p.dispose();}
});
test('caller edits during send cannot change expected receipt or pending proof',async()=>{
 let finish;const c=command();
 const p=new CommunicationModulePort(scope,'messenger',async(op)=>{
  if(op==='message.inbox')return {items:[row]};
  if(op==='message.read')return {...row,version:2,messages:[{id:'original-key',authorId:'u',text:'Original draft',pictureIds:[],sequence:1}]};
  return new Promise(resolve=>finish=resolve);
 },labels);
 try{
  await p.read({search:'',offset:0},signal);
  const pending=p.mutate(c,'original-key',signal);c.fields.body='Caller replacement';finish({id:row.id,version:2});
  const receipt=await pending;assert.deepEqual(receipt.expected,{body:'Original draft'});
  assert.equal((await p.readItem(row.id,signal)).items[0].body,'Original draft');
 }finally{p.dispose();}
});
test('equivalent reordered command replays the original key and payload',async()=>{
 let lost=true;const dispatched=[];
 const p=new CommunicationModulePort(scope,'messenger',async(op,value)=>{
  if(op==='message.inbox')return {items:[row]};dispatched.push(structuredClone(value));
  if(lost){lost=false;throw Error('Lost acknowledgement');}return {id:row.id,version:2};
 },labels);
 try{
  await p.read({search:'',offset:0},signal);await assert.rejects(()=>p.mutate(command(),'original-key',signal));
  const original=command(),reordered={fields:original.fields,action:original.action,version:original.version,itemId:original.itemId};
  await p.mutate(reordered,'original-key',signal);assert.deepEqual(dispatched[1],dispatched[0]);assert.equal(dispatched.length,2);
 }finally{p.dispose();}
});
test('invalid request keys fail before retaining or dispatching a send',async()=>{
 let calls=0;const p=new CommunicationModulePort(scope,'messenger',async op=>{
  if(op==='message.inbox')return {items:[row]};calls++;return {id:row.id,version:2};
 },labels);
 try{
  await p.read({search:'',offset:0},signal);
  for(const key of ['',null,undefined,'x'.repeat(201),'key\u0000','key\n','key\u007f'])await assert.rejects(()=>p.mutate(command(),key,signal),e=>e.code==='invalid'&&e.status===400);
  assert.equal(calls,0);await p.mutate(command(),'valid-key',signal);assert.equal(calls,1);
 }finally{p.dispose();}
});
