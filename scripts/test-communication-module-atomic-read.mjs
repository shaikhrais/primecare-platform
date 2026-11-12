import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {readFile} from 'node:fs/promises';
const b=await build({entryPoints:['packages/shared/src/communications/module-port.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {CommunicationModulePort}=await import('data:text/javascript;base64,'+Buffer.from(b.outputFiles[0].text).toString('base64'));
const labels=JSON.parse(await readFile('packages/primecare_ui/catalogs/communication-modules.registration.json','utf8')).locales.en;
const scope={tenantId:'t',userId:'u',role:'admin',dataset:'live'},signal=new AbortController().signal,query={search:'',offset:0};
const row={id:'thread-1',version:1,kind:'conversation',tenantId:'t',members:['u'],businessReference:'Owned thread',messages:[],readThrough:{}};
const command={itemId:row.id,version:1,action:'send',fields:{body:'Kept draft'},target:''};
test('rejected duplicate page preserves previously accepted command version',async()=>{
 let malformed=false,calls=0;
 const p=new CommunicationModulePort(scope,'messenger',async op=>{
  if(op==='message.send'){calls++;return {id:row.id,version:2};}
  return {items:malformed?[{...row,version:2},{...row,version:2}]:[row]};
 },labels);
 try {
  await p.read(query,signal);malformed=true;
  await assert.rejects(()=>p.read(query,signal));
  const receipt=await p.mutate(command,'original-key',signal);
  assert.equal(receipt.version,2);assert.equal(calls,1);
 }finally{p.dispose();}
});
test('first rejected snapshot cannot seed records for a mutation',async()=>{
 let calls=0;
 const p=new CommunicationModulePort(scope,'messenger',async op=>{
  if(op==='message.send'){calls++;return {id:row.id,version:2};}
  return {items:[row,row]};
 },labels);
 try {
  await assert.rejects(()=>p.read(query,signal));
  await assert.rejects(()=>p.mutate(command,'unaccepted-key',signal),e=>e.code==='denied');
  assert.equal(calls,0);
 }finally{p.dispose();}
});
test('rejected mailbox page does not publish its next-page cursor',async()=>{
 let inboxCalls=0;
 const p=new CommunicationModulePort(scope,'mailbox',async(op,value)=>{
  if(op==='email.inbox'){inboxCalls++;return {items:[{id:'mail-1',version:1},{id:'mail-1',version:1}],nextAfter:'rejected-cursor'};}
  return {id:value.id,version:1,tenantId:'t',kind:'inbound_mail',mailboxId:'captured',senderIdentityVerified:false,status:'quarantined',from:'x',to:'y',contentPreview:{status:'available',text:'Preview'}};
 },labels,{direction:'inbound',id:'captured'});
 try {
  await assert.rejects(()=>p.read(query,signal));
  await assert.rejects(()=>p.read({search:'',offset:100},signal),e=>e.code==='invalid');
  assert.equal(inboxCalls,1);
 }finally{p.dispose();}
});
test('invalid detail cannot consume the pending message readback proof',async()=>{
 let reads=0;
 const p=new CommunicationModulePort(scope,'messenger',async op=>{
  if(op==='message.inbox')return {items:[row]};
  if(op==='message.send')return {id:row.id,version:2};
  reads++;
  return {...row,version:2,businessReference:reads===1?'x'.repeat(501):'Owned thread',messages:[{id:reads===1?'original-key':'different-key',authorId:'u',text:'Kept draft',pictureIds:[],sequence:1}]};
 },labels);
 try {
  await p.read(query,signal);await p.mutate(command,'original-key',signal);
  await assert.rejects(()=>p.readItem(row.id,signal),e=>e.code==='invalid');
  await assert.rejects(()=>p.readItem(row.id,signal),e=>e.code==='conflict');
 }finally{p.dispose();}
});
