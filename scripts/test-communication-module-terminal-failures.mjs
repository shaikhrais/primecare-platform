import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';import {readFile} from 'node:fs/promises';
const b=await build({stdin:{contents:"export * from './packages/shared/src/communications/module-port';export * from './packages/domain/src/work_modules';",resolveDir:process.cwd()},bundle:true,platform:'node',format:'esm',write:false});
const {CommunicationModulePort,WorkFailure}=await import('data:text/javascript;base64,'+Buffer.from(b.outputFiles[0].text).toString('base64'));
const labels=JSON.parse(await readFile('packages/primecare_ui/catalogs/communication-modules.registration.json','utf8')).locales.en;
const scope={tenantId:'t',userId:'u',role:'psw',dataset:'live'},signal=new AbortController().signal;
const row={id:'thread1',version:1,kind:'conversation',tenantId:'t',members:['u'],businessReference:'Owned work',messages:[],readThrough:{}};
const command={itemId:row.id,version:1,action:'send',fields:{body:'Original draft'}};
for(const status of [400,401,403,404,409])test('definitive '+status+' failures do not exhaust pending capacity',async()=>{
 let allowed=false,calls=0;
 const p=new CommunicationModulePort(scope,'messenger',async op=>{
  if(op==='message.inbox')return {items:[row]};calls++;
  if(!allowed)throw new WorkFailure(status===409?'conflict':status===400?'invalid':'denied',status);
  return {id:row.id,version:2};
 },labels);
 try{
  await p.read({search:'',offset:0},signal);
  for(let i=0;i<12;i++)await assert.rejects(()=>p.mutate(command,'denied-key-'+i,signal),e=>e.status===status);
  allowed=true;const receipt=await p.mutate(command,'permitted-key',signal);
  assert.equal(receipt.version,2);assert.equal(calls,13);
 }finally{p.dispose();}
});
test('uncertain failure retains original command and rejects changed-body replay',async()=>{
 let calls=0;
 const p=new CommunicationModulePort(scope,'messenger',async op=>{
  if(op==='message.inbox')return {items:[row]};if(++calls===1)throw new WorkFailure('error',502);return {id:row.id,version:2};
 },labels);
 try{
  await p.read({search:'',offset:0},signal);
  await assert.rejects(()=>p.mutate(command,'original-key',signal),e=>e.status===502);
  await assert.rejects(()=>p.mutate({...command,fields:{body:'Changed'}},'original-key',signal),e=>e.code==='conflict');
  await p.mutate(command,'original-key',signal);assert.equal(calls,2);
 }finally{p.dispose();}
});
