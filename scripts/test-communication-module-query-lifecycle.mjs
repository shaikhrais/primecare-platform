import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';import {readFile} from 'node:fs/promises';
const b=await build({entryPoints:['packages/shared/src/communications/module-port.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {CommunicationModulePort}=await import('data:text/javascript;base64,'+Buffer.from(b.outputFiles[0].text).toString('base64'));
const labels=JSON.parse(await readFile('packages/primecare_ui/catalogs/communication-modules.registration.json','utf8')).locales.en;
const scope={tenantId:'t',userId:'u',role:'psw',dataset:'live'},signal=new AbortController().signal,query={search:'',offset:0};
const row={id:'thread1',version:1,kind:'conversation',tenantId:'t',members:['u'],businessReference:'Owned work',messages:[],readThrough:{}};
test('superseded messenger reply cannot replace the newer accepted command version',async()=>{
 let release,calls=0;
 const p=new CommunicationModulePort(scope,'messenger',async op=>{
  if(op==='message.send')return {id:row.id,version:3};
  if(++calls===1)return new Promise(resolve=>release=resolve);
  return {items:[{...row,version:2}]};
 },labels);
 try{
  const old=p.read(query,signal),rejected=assert.rejects(old,e=>e.code==='unavailable');
  const latest=await p.read(query,signal);assert.equal(latest.items[0].version,2);
  release({items:[row]});await rejected;
  const receipt=await p.mutate({itemId:row.id,version:2,action:'send',fields:{body:'Newer draft'}},'original-key',signal);
  assert.equal(receipt.version,3);
 }finally{p.dispose();}
});
test('superseded mailbox inbox cannot dispatch obsolete details or replace the active cursor',async()=>{
 let release,inboxes=0;const detailIds=[],afters=[];
 const p=new CommunicationModulePort(scope,'mailbox',async(op,value)=>{
  if(op==='email.inbox'){
   inboxes++;afters.push(value.after);
   if(inboxes===1)return new Promise(resolve=>release=resolve);
   return {items:[{id:'new-mail',version:1}],nextAfter:inboxes===2?'new-cursor':null};
  }
  detailIds.push(value.id);
  return {id:value.id,version:1,tenantId:'t',kind:'inbound_mail',mailboxId:'captured',senderIdentityVerified:false,status:'quarantined',from:'x',to:'y',contentPreview:{status:'available',text:'Preview'}};
 },labels,{direction:'inbound',id:'captured'});
 try{
  const old=p.read(query,signal),rejected=assert.rejects(old,e=>e.code==='unavailable');
  await p.read(query,signal);
  release({items:[{id:'old-mail',version:1}],nextAfter:'old-cursor'});await rejected;
  await p.read({search:'',offset:100},signal);
  assert.deepEqual(detailIds,['new-mail','new-mail']);assert.deepEqual(afters,[undefined,undefined,'new-cursor']);
 }finally{p.dispose();}
});

test('messenger read owns its query while the inbox response is pending',async()=>{
 let release;
 const p=new CommunicationModulePort(scope,'messenger',async()=>new Promise(resolve=>release=resolve),labels);
 try{
  const input={search:'Owned',offset:0},pending=p.read(input,signal);
  input.search='Unrelated';input.offset=100;
  release({items:[row]});
  const result=await pending;
  assert.equal(result.offset,0);assert.equal(result.items[0]?.id,row.id);assert.equal(result.total,1);
 }finally{p.dispose();}
});

test('mailbox read owns its filter and next-page cursor offset while inbox is pending',async()=>{
 let release,calls=0;const afters=[];
 const p=new CommunicationModulePort(scope,'mailbox',async(op,value)=>{
  if(op==='email.inbox'){
   afters.push(value.after);
   if(++calls===1)return new Promise(resolve=>release=resolve);
   return {items:[],nextAfter:null};
  }
  return {id:value.id,version:1,tenantId:'t',kind:'inbound_mail',mailboxId:'captured',senderIdentityVerified:false,status:'quarantined',from:'x',to:'y',contentPreview:{status:'available',text:'Owned preview'}};
 },labels,{direction:'inbound',id:'captured'});
 try{
  const input={search:'Owned',offset:0},pending=p.read(input,signal);
  input.search='Unrelated';input.offset=400;
  release({items:[{id:'owned-mail',version:1}],nextAfter:'captured-cursor'});
  const result=await pending;
  assert.equal(result.offset,0);assert.equal(result.items[0]?.id,'owned-mail');
  await p.read({search:'',offset:100},signal);
  assert.deepEqual(afters,[undefined,'captured-cursor']);
 }finally{p.dispose();}
});
