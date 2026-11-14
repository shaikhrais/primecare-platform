import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {mkdtemp} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const dir=await mkdtemp(join(tmpdir(),'work-receipts-'));
await build({stdin:{contents:`export * from './packages/shared/src/work-modules/session';export * from './packages/domain/src/work_modules';`,resolveDir:process.cwd(),loader:'ts'},outfile:join(dir,'test.cjs'),bundle:true,platform:'node',format:'cjs'});
const {WorkModuleSession,WorkFailure}=createRequire(import.meta.url)(join(dir,'test.cjs'));
const scope={tenantId:'tenant-a',userId:'actor-a',role:'manager',dataset:'live'};
const item={id:'task-a',version:1,title:'Original',body:'Draft instructions',date:'2026-11-12',lane:'',meta:'',actions:[{id:'edit',label:'Edit',fields:['title'],target:''}]};
const snapshot={scope,module:'tasks',items:[item],lanes:[],offset:0,total:1,partial:false};
let checks=0;
// An acknowledged mutation stays acknowledged even when independent readback fails.
for(const status of [400,404,409,503]){
 let writes=0,reads=0,keys=0;
 const session=new WorkModuleSession(scope,'tasks',{
  read:async()=>snapshot,
  mutate:async()=>{writes++;return{itemId:item.id,version:2,action:'edit',expected:{title:'Saved'}};},
  readItem:async()=>{if(++reads===1)throw new WorkFailure(status===409?'conflict':'error',status);return{...snapshot,items:[{...item,version:2,title:'Saved'}]};}
 },()=>{keys++;return'11111111-1111-4111-8111-111111111111';});
 await session.load();await assert.rejects(()=>session.submit(item.id,'edit',{title:'Saved'},1));
 assert.equal(session.current.pending,true,`acknowledged receipt lost after readback ${status}`);
 assert.equal(session.current.snapshot.items[0].body,item.body);
 await assert.rejects(()=>session.submit(item.id,'edit',{title:'Another draft'},1));
 await assert.rejects(()=>session.load());
 await session.retryPending();
 assert.equal(session.status,'success');assert.equal(writes,1);assert.equal(reads,2);assert.equal(keys,1);
 assert.equal(session.current.snapshot.items[0].title,'Saved');session.dispose();checks++;
}
// A mismatched readback is also verification-only; it must not enable a new write.
let writes=0,reads=0;
const mismatch=new WorkModuleSession(scope,'tasks',{read:async()=>snapshot,mutate:async()=>{writes++;return{itemId:item.id,version:2,action:'edit',expected:{title:'Saved'}};},readItem:async()=>({...snapshot,items:[++reads===1?item:{...item,version:2,title:'Saved'}]})});
await mismatch.load();await assert.rejects(()=>mismatch.submit(item.id,'edit',{title:'Saved'},1));assert.equal(mismatch.current.pending,true);await mismatch.retryPending();assert.equal(writes,1);assert.equal(mismatch.status,'success');mismatch.dispose();checks++;
// Authentication/authorization denial still tears down protected data and pending state.
for(const status of [401,403]){
 const session=new WorkModuleSession(scope,'tasks',{read:async()=>snapshot,mutate:async()=>({itemId:item.id,version:2,action:'edit',expected:{title:'Saved'}}),readItem:async()=>{throw new WorkFailure('denied',status);}});
 await session.load();await assert.rejects(()=>session.submit(item.id,'edit',{title:'Saved'},1));assert.equal(session.current.pending,false);assert.equal(session.current.snapshot,null);assert.equal(session.status,'denied');session.dispose();checks++;
}
// A rejected mutation (before acknowledgment) remains terminal and unlocks the draft.
const rejected=new WorkModuleSession(scope,'tasks',{read:async()=>snapshot,mutate:async()=>{throw new WorkFailure('conflict',409);},readItem:async()=>{throw Error('unexpected read');}});
await rejected.load();await assert.rejects(()=>rejected.submit(item.id,'edit',{title:'Saved'},1));assert.equal(rejected.current.pending,false);assert.equal(rejected.current.snapshot.items[0].title,'Original');rejected.dispose();checks++;
// A notification may synchronously retire its host before any port call begins.
for(const mode of ['load','submit','retry-unacknowledged','retry-acknowledged']){
 let readCalls=0,mutationCalls=0,verificationCalls=0;
 const session=new WorkModuleSession(scope,'tasks',{
  read:async()=>{readCalls++;return snapshot;},
  mutate:async()=>{mutationCalls++;if(mode==='retry-unacknowledged')throw Error('lost response');return{itemId:item.id,version:2,action:'edit',expected:{title:'Saved'}};},
  readItem:async()=>{verificationCalls++;throw Error('verification offline');}
 });
 if(mode!=='load')await session.load();
 if(mode.startsWith('retry'))await assert.rejects(()=>session.submit(item.id,'edit',{title:'Saved'},1));
 const before=[readCalls,mutationCalls,verificationCalls];
 session.subscribe(()=>{if(session.status==='loading'||session.status==='saving')session.dispose();});
 if(mode==='load')await session.load();
 else if(mode==='submit')await session.submit(item.id,'edit',{title:'Saved'},1);
 else await session.retryPending();
 assert.deepEqual([readCalls,mutationCalls,verificationCalls],before,`disposed ${mode} must not dispatch`);
 assert.equal(session.status,'disposed');assert.equal(session.current.snapshot,null);assert.equal(session.current.pending,false);checks++;
}
// A nested reload supersedes the notifying generation before its read is dispatched.
let nested,redirected=false;const searches=[];
const reentrant=new WorkModuleSession(scope,'tasks',{read:async(query)=>{searches.push(query.search);return snapshot;},mutate:async()=>{throw Error('unexpected mutation');},readItem:async()=>snapshot});
reentrant.subscribe(()=>{if(reentrant.status==='loading'&&!redirected){redirected=true;nested=reentrant.load({search:'latest',offset:0});}});
await reentrant.load({search:'retired',offset:0});await nested;assert.deepEqual(searches,['latest']);assert.equal(reentrant.current.query.search,'latest');assert.equal(reentrant.status,'ready');reentrant.dispose();checks++;
// The port owns its returned object and may reuse it while readback is in flight.
// Verification must compare against the receipt captured before that asynchronous work.
{
 let writes=0,reads=0;const external={itemId:item.id,version:2,action:'edit',expected:{title:'Saved'}};
 const session=new WorkModuleSession(scope,'tasks',{
  read:async()=>snapshot,
  mutate:async()=>{writes++;return external;},
  readItem:async()=>{reads++;if(reads===1){external.expected.title='Incorrect';return{...snapshot,items:[{...item,version:2,title:'Incorrect'}]};}return{...snapshot,items:[{...item,version:2,title:'Saved'}]};}
 });
 await session.load();await assert.rejects(()=>session.submit(item.id,'edit',{title:'Saved'},1),error=>error.code==='conflict');
 assert.equal(session.current.pending,true);assert.equal(session.current.snapshot.items[0].title,'Original');
 await session.retryPending();assert.equal(session.status,'success');assert.equal(session.current.snapshot.items[0].title,'Saved');assert.equal(writes,1);assert.equal(reads,2);session.dispose();checks++;
}
// Query state belongs to the session, even when a port retains/reuses its read argument.
{
 let captured;
 const session=new WorkModuleSession(scope,'tasks',{
  read:async query=>{captured=query;query.search='Port replacement';query.offset=900;return snapshot;},
  mutate:async()=>{throw Error('unexpected mutation');},readItem:async()=>snapshot
 });
 const query={search:'Requested',offset:100};await session.load(query);
 query.search='Caller replacement';captured.search='Later port replacement';
 assert.deepEqual(session.current.query,{search:'Requested',offset:100});assert.equal(session.status,'ready');session.dispose();checks++;
}
// Host observer failures must not control transport/persistence or retain busy state.
const observerFailures=[];
async function observerCase(name,run){try{await run();checks++;console.log('PASS observer '+name);}catch(error){observerFailures.push(name+': '+error.message);console.log('FAIL observer '+name+': '+error.message);}}
function observerFixture({readError,writeError,verifyOnce=false}={}){
 let reads=0,writes=0,verifications=0;
 const session=new WorkModuleSession(scope,'tasks',{
  read:async()=>{reads++;if(readError)throw readError;return snapshot;},
  mutate:async()=>{writes++;if(writeError)throw writeError;return{itemId:item.id,version:2,action:'edit',expected:{title:'Saved'}};},
  readItem:async()=>{verifications++;if(verifyOnce&&verifications===1)throw new WorkFailure('error',503);return{...snapshot,items:[{...item,version:2,title:'Saved'}]};}
 });return{session,counts:()=>({reads,writes,verifications})};
}
for(const status of ['loading','ready','error'])await observerCase(status+' observer exception preserves read outcome',async()=>{
 const f=observerFixture({readError:status==='error'?new WorkFailure('error',503):undefined});
 f.session.subscribe(()=>{if(f.session.status===status)throw Error('Host render failed');});
 let later=0;f.session.subscribe(()=>later++);await f.session.load();
 assert.equal(f.session.status,status==='error'?'error':'ready');assert.equal(f.counts().reads,1);assert.equal(later,2);f.session.dispose();
});
for(const status of ['saving','success'])await observerCase(status+' observer exception preserves acknowledged save',async()=>{
 const f=observerFixture();await f.session.load();f.session.subscribe(()=>{if(f.session.status===status)throw Error('Host render failed');});
 await f.session.submit(item.id,'edit',{title:'Saved'},1);assert.equal(f.session.status,'success');assert.equal(f.session.current.pending,false);assert.equal(f.session.current.snapshot.items[0].title,'Saved');assert.equal(f.counts().writes,1);
 await f.session.load();assert.equal(f.session.status,'ready');assert.equal(f.counts().reads,2);f.session.dispose();
});
await observerCase('real denial remains denial after render exception',async()=>{const f=observerFixture({writeError:new WorkFailure('denied',403)});await f.session.load();f.session.subscribe(()=>{throw Error('Host render failed');});await assert.rejects(()=>f.session.submit(item.id,'edit',{title:'Saved'},1),e=>e.code==='denied');assert.equal(f.session.status,'denied');assert.equal(f.session.current.snapshot,null);assert.equal(f.session.current.pending,false);assert.equal(f.counts().writes,1);f.session.dispose();});
await observerCase('acknowledged retry remains read-only with throwing observer',async()=>{const f=observerFixture({verifyOnce:true});await f.session.load();f.session.subscribe(()=>{throw Error('Host render failed');});await assert.rejects(()=>f.session.submit(item.id,'edit',{title:'Saved'},1),e=>e.code==='error');assert.equal(f.session.current.pending,true);await f.session.retryPending();assert.equal(f.session.status,'success');assert.deepEqual(f.counts(),{reads:1,writes:1,verifications:2});f.session.dispose();});
await observerCase('new subscriptions wait until the next emission; removed subscriptions stay removed',async()=>{const f=observerFixture();const calls=[];let added=false,remove;f.session.subscribe(()=>{calls.push('first');if(!added){added=true;f.session.subscribe(()=>calls.push('new'));remove();}});remove=f.session.subscribe(()=>calls.push('removed'));await f.session.load();assert.deepEqual(calls,['first','first','new']);f.session.dispose();});
await observerCase('duplicate listener cleanup owns only its subscription',async()=>{const f=observerFixture();let calls=0;const listener=()=>calls++;const first=f.session.subscribe(listener);f.session.subscribe(listener);first();first();await f.session.load();assert.equal(calls,2);f.session.dispose();});
await observerCase('disposal stops captured observers and transport even when disposing observer throws',async()=>{const f=observerFixture();let later=0;f.session.subscribe(()=>{f.session.dispose();throw Error('Host removed');});f.session.subscribe(()=>later++);await f.session.load();assert.equal(f.session.status,'disposed');assert.equal(later,0);assert.equal(f.counts().reads,0);});
await observerCase('throwing owned port cleanup still clears private records and retires the session',async()=>{
 let cleanup=0;const session=new WorkModuleSession(scope,'tasks',{read:async()=>snapshot,mutate:async()=>{throw new WorkFailure('error',503);},readItem:async()=>snapshot,dispose:()=>{cleanup++;throw Error('Owned transport cleanup failed');}});
 await session.load();await assert.rejects(()=>session.submit(item.id,'edit',{title:'Saved'},1));assert.equal(session.current.pending,true);
 assert.throws(()=>session.dispose(),/Owned transport cleanup failed/);assert.equal(session.status,'disposed');assert.equal(session.current.snapshot,null);assert.equal(session.current.pending,false);session.dispose();assert.equal(cleanup,1);await session.load();assert.equal(session.status,'disposed');
});
for(const action of ['dispose','reload'])await observerCase('successful receipt outcome survives observer '+action,async()=>{
 let reads=0,writes=0,release,reload,once=true;const saved={...snapshot,items:[{...item,version:2,title:'Saved'}]};
 const s=new WorkModuleSession(scope,'tasks',{read:async()=>{if(++reads===1)return snapshot;return new Promise(resolve=>release=()=>resolve(saved));},mutate:async()=>{writes++;return{itemId:item.id,version:2,action:'edit',expected:{title:'Saved'}};},readItem:async()=>saved});
 await s.load();s.subscribe(()=>{if(s.status==='success'&&once){once=false;if(action==='dispose')s.dispose();else reload=s.load();}});
 try{await assert.doesNotReject(()=>s.submit(item.id,'edit',{title:'Saved'},1));assert.equal(s.status,action==='dispose'?'disposed':'loading');assert.equal(s.current.pending,false);assert.equal(writes,1);}finally{if(release)release();if(reload)await reload;s.dispose();}
});
for(const phase of ['mutation','readback'])for(const action of ['retry','dispose'])await observerCase('failed '+phase+' outcome survives observer '+action,async()=>{
 let writes=0,reads=0,release,retry,once=true;const keys=[],saved={...snapshot,items:[{...item,version:2,title:'Saved'}]};
 const s=new WorkModuleSession(scope,'tasks',{read:async()=>snapshot,mutate:async(_,key)=>{writes++;keys.push(key);if(phase==='mutation'&&writes===1)throw new WorkFailure('error',503);if(phase==='mutation')return new Promise(resolve=>release=()=>resolve({itemId:item.id,version:2,action:'edit',expected:{title:'Saved'}}));return{itemId:item.id,version:2,action:'edit',expected:{title:'Saved'}};},readItem:async()=>{reads++;if(phase==='readback'&&reads===1)throw new WorkFailure('error',503);if(phase==='readback')return new Promise(resolve=>release=()=>resolve(saved));return saved;}});
 await s.load();s.subscribe(()=>{if(s.status==='error'&&once){once=false;if(action==='dispose')s.dispose();else retry=s.retryPending();}});
 try{await assert.rejects(()=>s.submit(item.id,'edit',{title:'Saved'},1),e=>e.code==='error');assert.equal(s.status,action==='dispose'?'disposed':'saving');assert.equal(writes,phase==='mutation'&&action==='retry'?2:1);if(keys.length===2)assert.equal(keys[0],keys[1]);}finally{if(release)release();if(retry)await retry;s.dispose();}
});
assert.deepEqual(observerFailures,[],'Observer regressions must all pass');
console.log(`PASS work receipt regressions: ${checks} cases; acknowledged retries read only, drafts retained, denial clears data, rejected writes unlock`);
