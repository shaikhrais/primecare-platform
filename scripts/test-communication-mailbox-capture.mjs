import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {mkdtemp,rm,readFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const dir=await mkdtemp(join(tmpdir(),'mailbox-capture-'));
try {
 await build({entryPoints:['packages/shared/src/communications/module-port.ts'],outfile:join(dir,'port.cjs'),bundle:true,platform:'node',format:'cjs'});
 const {CommunicationModulePort}=createRequire(import.meta.url)(join(dir,'port.cjs'));
 const labels=JSON.parse(await readFile('packages/primecare_ui/catalogs/communication-modules.registration.json','utf8')).locales.en;
 const scope={tenantId:'tenant-a',userId:'user-a',role:'admin',dataset:'live'};
 const query={search:'',offset:0};
 for(const timing of ['before','during']) {
  const mailbox={direction:'inbound',id:'captured-mailbox'},calls=[];
  const port=new CommunicationModulePort(scope,'mailbox',async(operation,value)=>{
   calls.push({operation,...value});
   if(operation==='email.inbox') {
    if(timing==='during'){mailbox.direction='outbound';delete mailbox.id;}
    return {items:[{id:'mail-1',version:1}],nextAfter:null};
   }
   return {id:'mail-1',version:1,tenantId:scope.tenantId,kind:'inbound_mail',mailboxId:'captured-mailbox',senderIdentityVerified:false,status:'quarantined',from:'sender@example.invalid',to:'inbox@example.invalid',contentPreview:{status:'available',text:'Captured preview'}};
  },labels,mailbox);
  if(timing==='before') mailbox.id='replacement-mailbox';
  const snapshot=await port.read(query,new AbortController().signal);
  assert.equal(calls[0].mailboxId,'captured-mailbox',timing+' request retains captured mailbox');
  assert.equal(snapshot.items[0].body,'Captured preview',timing+' response validates against captured mailbox');
  assert.equal(snapshot.items[0].actions.length,0);
  port.dispose();
  await assert.rejects(()=>port.read(query,new AbortController().signal),/closed/);
  assert.equal(calls.length,2,'closed adapter makes no additional calls');
 }
 // Changing the caller configuration cannot authorize a different mailbox response.
 const mailbox={direction:'inbound',id:'captured-mailbox'};
 const port=new CommunicationModulePort(scope,'mailbox',async op=>op==='email.inbox'?{items:[{id:'mail-2',version:1}],nextAfter:null}:{id:'mail-2',version:1,tenantId:scope.tenantId,kind:'inbound_mail',mailboxId:'replacement-mailbox',senderIdentityVerified:false,status:'quarantined',from:'x',to:'y',contentPreview:{status:'available',text:'Foreign mailbox preview'}},labels,mailbox);
 mailbox.id='replacement-mailbox';
 await assert.rejects(()=>port.read(query,new AbortController().signal),error=>error.code==='denied'&&error.status===403);
 port.dispose();
 console.log('PASS mailbox capture: before/during mutation, foreign-mailbox denial, read-only projection, teardown; no provider calls');
}finally{await rm(dir,{recursive:true,force:true});}
