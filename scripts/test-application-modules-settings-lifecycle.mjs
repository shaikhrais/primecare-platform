import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const built=await build({stdin:{contents:"export {ApplicationSettingsPort} from './packages/shared/src/application-modules/settings-port';",resolveDir:process.cwd()},bundle:true,write:false,platform:'node',format:'esm'});
const {ApplicationSettingsPort}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const scope={userId:'user',tenantId:'tenant',role:'psw',dataset:'live'},key='12345678-1234-4234-8234-123456789012',command={itemId:'navigation',action:'edit',fields:{body:'Overview'},version:1};
function fixture(){
 const state={reads:0,writes:[],cacheWrites:0,revision:0,document:null,onCache:()=>{},onWrite:()=>{}};
 const binding={scope,kind:'shortcuts',resource:'navigation',policy:{panelIds:[],screenIds:['1']}};
 const snapshot=()=>({version:1,scope,kind:'shortcuts',resource:'navigation',revision:state.revision,document:state.document});
 const port=new ApplicationSettingsPort(binding,async request=>{if(request.action==='read')state.reads++;else{assert.equal(request.revision,state.revision);state.writes.push(structuredClone(request));state.revision++;state.document=request.document;state.onWrite();}return snapshot();},{read:async()=>null,write:async(k,v)=>{state.cacheWrites++;state.onCache(JSON.parse(v));},remove:async()=>{}},{'1':'Overview'},{shortcuts:'Shortcuts',editShortcuts:'Edit'});
 return {port,state};
}
const signal=()=>new AbortController().signal;
test('cancelled settings load performs no transport or cache work',async()=>{
 const {port,state}=fixture(),abort=new AbortController();abort.abort();
 await assert.rejects(()=>port.read({search:'',offset:0},abort.signal),e=>e.code==='unavailable');
 assert.equal(state.reads,0);assert.equal(state.cacheWrites,0);port.dispose();
});
test('cancelled settings save does not stage or dispatch a new mutation',async()=>{
 const {port,state}=fixture();await port.read({search:'',offset:0},signal());const before=state.cacheWrites,abort=new AbortController();abort.abort();
 await assert.rejects(()=>port.mutate(command,key,abort.signal),e=>e.code==='unavailable');
 assert.equal(state.writes.length,0);assert.equal(state.cacheWrites,before);assert.equal(port.recovery.dirty,false);port.dispose();
});
test('cancellation after durable staging retains draft and explicit retry reuses original key',async()=>{
 const {port,state}=fixture(),abort=new AbortController();await port.read({search:'',offset:0},signal());
 state.onCache=record=>{if(record.dirty&&!record.pending)abort.abort();};
 await assert.rejects(()=>port.mutate(command,key,abort.signal),e=>e.code==='unavailable');
 assert.equal(state.writes.length,0);assert.equal(port.recovery.dirty,true);assert.deepEqual(port.recovery.draft,{version:1,screenIds:['1']});
 state.onCache=()=>{};const receipt=await port.mutate(command,key,signal());assert.equal(receipt.version,2);assert.equal(state.writes.length,1);assert.equal(state.writes[0].requestId,key);
 const verified=await port.readItem('navigation',signal());assert.equal(verified.items[0].version,2);port.dispose();
});
test('disposal during draft persistence sends no mutation and does not revive the port',async()=>{
 const {port,state}=fixture();await port.read({search:'',offset:0},signal());state.onCache=record=>{if(record.dirty&&!record.pending)port.dispose();};
 await assert.rejects(()=>port.mutate(command,key,signal()),e=>e.code==='unavailable');assert.equal(state.writes.length,0);
 await assert.rejects(()=>port.read({search:'',offset:0},signal()),e=>e.code==='unavailable');port.dispose();
});
test('cancelled verification does not dispatch an independent read',async()=>{
 const {port,state}=fixture(),abort=new AbortController();abort.abort();await assert.rejects(()=>port.readItem('navigation',abort.signal),e=>e.code==='unavailable');assert.equal(state.reads,0);port.dispose();
});

test('cancellation during pending-receipt persistence blocks dispatch and retains original-key replay',async()=>{
 const {port,state}=fixture(),abort=new AbortController();await port.read({search:'',offset:0},signal());
 state.onCache=record=>{if(record.pending)abort.abort();};
 await assert.rejects(()=>port.mutate(command,key,abort.signal),e=>e.code==='unavailable');
 assert.equal(state.writes.length,0);assert.equal(port.recovery.pending.requestId,key);
 state.onCache=()=>{};await port.mutate(command,key,signal());assert.equal(state.writes.length,1);assert.equal(state.writes[0].requestId,key);port.dispose();
});
test('staged cancellation rejects changed command or replacement key without losing draft',async()=>{
 const {port,state}=fixture(),abort=new AbortController();await port.read({search:'',offset:0},signal());state.onCache=record=>{if(record.dirty&&!record.pending)abort.abort();};
 await assert.rejects(()=>port.mutate(command,key,abort.signal),e=>e.code==='unavailable');state.onCache=()=>{};
 await assert.rejects(()=>port.mutate({...command,fields:{body:''}},key,signal()),e=>e.code==='conflict');
 await assert.rejects(()=>port.mutate(command,'87654321-1234-4234-8234-123456789012',signal()),e=>e.code==='conflict');
 assert.deepEqual(port.recovery.draft,{version:1,screenIds:['1']});assert.equal(state.writes.length,0);await port.mutate(command,key,signal());assert.equal(state.writes.length,1);port.dispose();
});
test('cancellation after initial load prevents a second independent read',async()=>{
 const {port,state}=fixture(),abort=new AbortController();state.onCache=()=>abort.abort();await assert.rejects(()=>port.read({search:'',offset:0},abort.signal),e=>e.code==='unavailable');assert.equal(state.reads,1);port.dispose();
});

test('cancellation after acknowledged write preserves receipt without a second mutation',async()=>{
 const {port,state}=fixture(),abort=new AbortController();await port.read({search:'',offset:0},signal());state.onWrite=()=>abort.abort();
 await assert.rejects(()=>port.mutate(command,key,abort.signal),e=>e.code==='unavailable');assert.equal(state.writes.length,1);assert.equal(port.recovery.pending,null);
 const receipt=await port.mutate(command,key,signal());assert.equal(receipt.version,2);assert.equal(state.writes.length,1);await port.readItem('navigation',signal());port.dispose();
});

for(const mode of ['extra-field','missing-body','oversized-body','invalid-key'])test('invalid settings '+mode+' is rejected before durable staging',async()=>{
 const {port,state}=fixture();await port.read({search:'',offset:0},signal());const before=state.cacheWrites;
 const invalid=mode==='extra-field'?{...command,fields:{body:'Overview',role:'admin'}}:mode==='missing-body'?{...command,fields:{}}:mode==='oversized-body'?{...command,fields:{body:'Overview'+' '.repeat(10001)}}:command;
 await assert.rejects(()=>port.mutate(invalid,mode==='invalid-key'?'not-a-uuid':key,signal()),e=>e.code==='invalid');
 assert.equal(state.writes.length,0);assert.equal(state.cacheWrites,before);assert.equal(port.recovery.dirty,false);port.dispose();
});
test('settings snapshots caller defaults and localized labels at construction',async()=>{
 const defaults=['1'],labels={shortcuts:'Shortcuts',editShortcuts:'Edit'},binding={scope,kind:'shortcuts',resource:'navigation',policy:{panelIds:[],screenIds:['1','2']}};
 const raw={version:1,scope,kind:'shortcuts',resource:'navigation',revision:0,document:null};
 const port=new ApplicationSettingsPort(binding,async()=>raw,{read:async()=>null,write:async()=>{},remove:async()=>{}},{'1':'Overview','2':'Schedule'},labels,defaults);
 defaults[0]='2';labels.shortcuts='Changed';labels.editShortcuts='Changed';
 const projected=await port.read({search:'',offset:0},signal());assert.equal(projected.items[0].body,'Overview');assert.equal(projected.items[0].title,'Shortcuts');assert.equal(projected.items[0].actions[0].label,'Edit');port.dispose();
});

test('settings mutation uses captured command when caller changes it before acknowledgement',async()=>{
 const {port,state}=fixture();await port.read({search:'',offset:0},signal());const caller=structuredClone(command);
 state.onWrite=()=>{caller.version=99;caller.fields.body='Changed after send';};
 const receipt=await port.mutate(caller,key,signal());assert.equal(receipt.version,2);assert.equal(receipt.expected.body,'Overview');assert.equal(state.writes.length,1);await port.readItem('navigation',signal());port.dispose();
});
test('settings read uses captured query through cache and independent readback',async()=>{
 const {port,state}=fixture(),query={search:'',offset:0};state.onCache=()=>{query.search='No matching item';};const result=await port.read(query,signal());assert.equal(result.items.length,1);assert.equal(result.items[0].id,'navigation');port.dispose();
});
for(const search of ['x'.repeat(101),null,5])test('invalid direct settings search is rejected before dispatch: '+String(search).slice(0,8),async()=>{
 const {port,state}=fixture();await assert.rejects(()=>port.read({search,offset:0},signal()),e=>e.code==='invalid');assert.equal(state.reads,0);assert.equal(state.cacheWrites,0);port.dispose();
});
