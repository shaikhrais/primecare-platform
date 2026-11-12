import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {mkdtemp,rm,readFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const dir=await mkdtemp(join(tmpdir(),'communication-cancellation-'));
try {
 await build({entryPoints:['packages/shared/src/communications/module-port.ts'],outfile:join(dir,'port.cjs'),bundle:true,platform:'node',format:'cjs'});
 const {CommunicationModulePort}=createRequire(import.meta.url)(join(dir,'port.cjs'));
 const labels=JSON.parse(await readFile('packages/primecare_ui/catalogs/communication-modules.registration.json','utf8')).locales.en;
 const scope={tenantId:'tenant-a',userId:'user-a',role:'admin',dataset:'live'};
 const query={search:'',offset:0},active=new AbortController().signal;
 const thread={id:'thread-1',version:1,kind:'conversation',tenantId:scope.tenantId,members:[scope.userId],businessReference:'Private thread',messages:[],readThrough:{}};
 const command={itemId:thread.id,version:1,action:'send',fields:{body:'Preserved draft'},target:''};
 const aborted=new AbortController();aborted.abort();
 for(const operation of ['read','readItem','mutate']) {
  let calls=0;
  const port=new CommunicationModulePort(scope,'messenger',async op=>{calls++;return op==='message.inbox'?{items:[thread]}:op==='message.read'?thread:{id:thread.id,version:2};},labels);
  await port.read(query,active);calls=0;
  await assert.rejects(()=>operation==='read'?port.read(query,aborted.signal):operation==='readItem'?port.readItem(thread.id,aborted.signal):port.mutate(command,'original-key',aborted.signal),error=>error.code==='unavailable');
  assert.equal(calls,0,operation+' must not dispatch after cancellation');
  port.dispose();
 }
 for(const stopAt of ['inbox','detail']) {
  const controller=new AbortController(),calls=[];
  const port=new CommunicationModulePort(scope,'mailbox',async(op,value)=>{
   calls.push(op);
   if(op==='email.inbox') {
    if(stopAt==='inbox')controller.abort();
    return {items:[{id:'mail-1',version:1},{id:'mail-2',version:1}],nextAfter:null};
   }
   controller.abort();
   return {id:value.id,version:1,tenantId:scope.tenantId,kind:'inbound_mail',mailboxId:'captured',senderIdentityVerified:false,status:'quarantined',from:'sender@example.invalid',to:'inbox@example.invalid',contentPreview:{status:'available',text:'Private preview'}};
  },labels,{direction:'inbound',id:'captured'});
  await assert.rejects(()=>port.read(query,controller.signal),error=>error.code==='unavailable');
  assert.deepEqual(calls,stopAt==='inbox'?['email.inbox']:['email.inbox','email.read'],'cancelled page must not continue detail reads');
  port.dispose();
 }
 // An uncertain send retains its original key/body for a later explicit retry.
 const controller=new AbortController(),keys=[];
 let delivered=false;
 const port=new CommunicationModulePort(scope,'messenger',async(op,value)=>{
  if(op==='message.inbox')return {items:[thread]};
  if(op==='message.send') {keys.push(value.key);if(!delivered){delivered=true;controller.abort();}return {id:thread.id,version:2};}
  return {...thread,version:2,messages:[{id:'original-key',authorId:scope.userId,text:'Preserved draft',pictureIds:[],sequence:1}]};
 },labels);
 await port.read(query,active);
 await assert.rejects(()=>port.mutate(command,'original-key',controller.signal),error=>error.code==='unavailable');
 const receipt=await port.mutate(command,'original-key',active);
 assert.deepEqual(keys,['original-key','original-key']);
 assert.equal(receipt.expected.body,'Preserved draft');
 const verified=await port.readItem(thread.id,active);
 assert.equal(verified.items[0].body,'Preserved draft');
 port.dispose();
 console.log('PASS module cancellation: pre-aborted read/readItem/mutate and inbox/detail cancellation stop transport dispatch; no live calls');
}finally{await rm(dir,{recursive:true,force:true});}
