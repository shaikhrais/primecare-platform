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
console.log(`PASS work receipt regressions: ${checks} cases; acknowledged retries read only, drafts retained, denial clears data, rejected writes unlock`);
