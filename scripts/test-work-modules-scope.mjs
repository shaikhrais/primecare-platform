import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {mkdtemp} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const dir=await mkdtemp(join(tmpdir(),'work-scope-'));
await build({stdin:{contents:`export * from './packages/shared/src/work-modules/tenant-task-adapter';export * from './packages/shared/src/work-modules/session';`,resolveDir:process.cwd(),loader:'ts'},outfile:join(dir,'test.cjs'),bundle:true,platform:'node',format:'cjs'});
const {TenantTaskModulePort,WorkModuleSession}=createRequire(import.meta.url)(join(dir,'test.cjs'));
const original={tenantId:'tenant-a',userId:'actor-a',role:'manager',dataset:'live'};
const raw={organization:{id:'tenant-a'},identity:{userId:'actor-a',role:'manager'},dataset:'live',synthetic:false,database:'PostgreSQL',tasks:[],users:[],clients:[],taskPage:{total:0}};
let checks=0;
// Caller-owned scope mutation must not switch the adapter's dataset or actor binding.
{
 const scope={...original},requests=[];
 const port=new TenantTaskModulePort(scope,'tasks',async(request)=>{requests.push(request);return raw;});
 Object.assign(scope,{tenantId:'tenant-b',userId:'actor-b',role:'other',dataset:'demo'});
 const result=await port.read({search:'',offset:0},new AbortController().signal);
 assert.equal(requests[0].filters.dataset,'live');assert.deepEqual(result.scope,original);assert.deepEqual(port.scope,original);assert.equal(Object.isFrozen(port.scope),true);
 port.dispose();checks++;
}
// Mutation during an in-flight read must not invalidate its original authorized reply.
{
 const scope={...original};let finish;
 const port=new TenantTaskModulePort(scope,'tasks',()=>new Promise(resolve=>{finish=resolve;}));
 const pending=port.read({search:'',offset:0},new AbortController().signal);
 scope.userId='actor-b';scope.tenantId='tenant-b';finish(raw);
 assert.deepEqual((await pending).scope,original);port.dispose();checks++;
}
// Capturing scope must not admit a foreign response or an actor that became unauthorized.
{
 const port=new TenantTaskModulePort({...original},'tasks',async()=>({...raw,organization:{id:'tenant-b'}}));
 await assert.rejects(()=>port.read({search:'',offset:0},new AbortController().signal),error=>error.code==='denied'&&error.status===403);port.dispose();checks++;
}
// A stale or mismatched matching row must not retire the original rename verification query.
for(const staleVersion of [1,2]){
 const task={id:'task-a',version:1,title:'Saved draft',notes:'Instructions',due_on:'2026-11-12',status:'open',evidence:'',actions:['edit'],owner_id:'actor-a',priority:'normal',flow_id:'existing-flow'};
 const saved={...task,version:2,title:'Saved'};let writes=0,readbacks=0;const searches=[];
 const port=new TenantTaskModulePort({...original},'tasks',async(request)=>{
  if(request.method==='POST'){writes++;return{...raw,tasks:[saved],taskPage:{total:1}};}
  if(request.filters.search==='')return{...raw,tasks:[task],taskPage:{total:1}};
  searches.push(request.filters.search);const row=++readbacks===1?{...task,version:staleVersion}:saved;
  const tasks=row.title.toLowerCase().includes(request.filters.search.toLowerCase())?[row]:[];
  return{...raw,tasks,taskPage:{total:tasks.length}};
 });
 const session=new WorkModuleSession(original,'tasks',port);await session.load();
 await assert.rejects(()=>session.submit(task.id,'edit',{title:'Saved',body:'Instructions',date:'2026-11-12'},1),error=>error.code==='conflict');
 assert.equal(session.current.pending,true);assert.equal(session.current.snapshot.items[0].title,'Saved draft');
 await session.retryPending();assert.equal(session.status,'success');assert.equal(writes,1);assert.deepEqual(searches,['Saved','Saved']);assert.equal(session.current.snapshot.items[0].title,'Saved');session.dispose();checks++;
}
// A delayed read must not replace the context supplied by a newer read.
{
 const task={id:'task-a',version:1,title:'Task',notes:'Instructions',due_on:'2026-11-12',status:'open',evidence:'',actions:['edit'],owner_id:'actor-a',priority:'normal',flow_id:'existing-flow'};
 let resolveOld,resolveLatest;const posted=[];
 const port=new TenantTaskModulePort(original,'tasks',request=>{
  if(request.method==='POST'){posted.push(request.body);return Promise.resolve({...raw,tasks:[{...task,version:3}],taskPage:{total:1}});}
  return new Promise(resolve=>{if(request.filters.search==='old')resolveOld=resolve;else resolveLatest=resolve;});
 });
 const signal=new AbortController().signal,old=port.read({search:'old',offset:0},signal),latest=port.read({search:'new',offset:0},signal);
 resolveLatest({...raw,tasks:[{...task,version:2}],taskPage:{total:1}});await latest;
 resolveOld({...raw,tasks:[task],taskPage:{total:1}});await assert.rejects(()=>old,error=>error.code==='unavailable');
 await port.mutate({itemId:task.id,version:2,action:'edit',fields:{title:'New',body:'Instructions',date:'2026-11-12'}},'11111111-1111-4111-8111-111111111111',signal);
 assert.equal(posted.length,1);assert.equal(posted[0].version,2);port.dispose();checks++;
}
// A failed projection must not poison an earlier validated mutation context.
{
 const task={id:'task-a',version:2,title:'Task',notes:'Instructions',due_on:'2026-11-12',status:'open',evidence:'',actions:['edit'],owner_id:'actor-a',priority:'normal',flow_id:'existing-flow'};let reads=0,writes=0;
 const port=new TenantTaskModulePort(original,'tasks',async request=>{
  if(request.method==='POST'){writes++;return{...raw,tasks:[{...task,version:3}],taskPage:{total:1}};}
  const tasks=++reads===1?[task]:[{...task,version:1},{...task,version:1}];return{...raw,tasks,taskPage:{total:tasks.length}};
 });
 const signal=new AbortController().signal;await port.read({search:'',offset:0},signal);
 await assert.rejects(()=>port.read({search:'invalid',offset:0},signal));
 await port.mutate({itemId:task.id,version:2,action:'edit',fields:{title:'New',body:'Instructions',date:'2026-11-12'}},'11111111-1111-4111-8111-111111111111',signal);
 assert.equal(writes,1);port.dispose();checks++;
}
// A transport may reuse its reply object; retained mutation fields belong to the read.
{
 const task={id:'task-a',version:1,title:'Task',notes:'Instructions',due_on:'2026-11-12',status:'open',evidence:'',actions:['edit'],owner_id:'actor-a',priority:'normal',flow_id:'existing-flow'};
 const reply={...raw,tasks:[task],taskPage:{total:1}};let posted;
 const port=new TenantTaskModulePort(original,'tasks',async request=>{
  if(request.method==='POST'){posted=request.body;return{...raw,tasks:[{...task,version:2}],taskPage:{total:1}};}
  return reply;
 });
 const signal=new AbortController().signal;await port.read({search:'',offset:0},signal);
 task.owner_id='different-owner';task.priority='urgent';task.flow_id='different-flow';
 await port.mutate({itemId:task.id,version:1,action:'edit',fields:{title:'Saved',body:'Instructions',date:'2026-11-12'}},'11111111-1111-4111-8111-111111111111',signal);
 assert.equal(posted.value.ownerId,'actor-a');assert.equal(posted.value.priority,'normal');assert.equal(posted.value.flowId,'existing-flow');port.dispose();checks++;
}
// Reusing a reply cannot insert an action that the captured projection never granted.
{
 const task={id:'task-a',version:1,title:'Task',notes:'Instructions',due_on:'2026-11-12',status:'open',evidence:'',actions:[],owner_id:'actor-a',priority:'normal',flow_id:'existing-flow'};let posts=0;
 const port=new TenantTaskModulePort(original,'tasks',async request=>{if(request.method==='POST'){posts++;return{...raw,tasks:[{...task,version:2}],taskPage:{total:1}};}return{...raw,tasks:[task],taskPage:{total:1}};});
 const signal=new AbortController().signal;await port.read({search:'',offset:0},signal);task.actions.push('edit');
 await assert.rejects(()=>port.mutate({itemId:task.id,version:1,action:'edit',fields:{title:'Saved',body:'Instructions',date:'2026-11-12'}},'11111111-1111-4111-8111-111111111111',signal),error=>error.code==='denied');
 assert.equal(posts,0);port.dispose();checks++;
}
// An uncertain write replays the original key AND body even if transport reuses its input.
{
 const task={id:'task-a',version:1,title:'Task',notes:'Instructions',due_on:'2026-11-12',status:'open',evidence:'',actions:['edit'],owner_id:'actor-a',priority:'normal',flow_id:'existing-flow'};
 const sent=[],keys=[];let posts=0;
 const port=new TenantTaskModulePort(original,'tasks',async request=>{
  if(request.method==='POST'){
   sent.push(structuredClone(request.body));keys.push(request.requestId);
   if(++posts===1){request.body.value.title='Transport changed';request.body.value.ownerId='Transport owner';throw Error('lost acknowledgment');}
   return{...raw,tasks:[{...task,version:2,title:'Saved'}],taskPage:{total:1}};
  }
  return{...raw,tasks:[posts?{...task,version:2,title:'Saved'}:task],taskPage:{total:1}};
 });
 const session=new WorkModuleSession(original,'tasks',port);await session.load();
 await assert.rejects(()=>session.submit(task.id,'edit',{title:'Saved',body:'Instructions',date:'2026-11-12'},1));
 assert.equal(session.current.pending,true);await session.retryPending();
 assert.equal(session.status,'success');assert.equal(keys.length,2);assert.equal(keys[0],keys[1]);assert.deepEqual(sent[0],sent[1]);assert.equal(sent[1].value.title,'Saved');assert.equal(sent[1].value.ownerId,'actor-a');session.dispose();checks++;
}
// Returned receipts must not expose the adapter's cached expected-value map.
{
 const task={id:'task-a',version:1,title:'Task',notes:'Instructions',due_on:'2026-11-12',status:'open',evidence:'',actions:['edit'],owner_id:'actor-a',priority:'normal',flow_id:'existing-flow'};
 const port=new TenantTaskModulePort(original,'tasks',async request=>({...raw,tasks:[request.method==='POST'?{...task,version:2,title:'Saved'}:task],taskPage:{total:1}}));
 const signal=new AbortController().signal;await port.read({search:'',offset:0},signal);
 const command={itemId:task.id,version:1,action:'edit',fields:{title:'Saved',body:'Instructions',date:'2026-11-12'}},key='11111111-1111-4111-8111-111111111111';
 const receipt=await port.mutate(command,key,signal);receipt.expected.title='Changed by consumer';
 const replay=await port.mutate(command,key,signal);assert.equal(replay.expected.title,'Saved');port.dispose();checks++;
}
// The adapter enforces the module's projected commands even when called without a session.
for(const denied of [
 {module:'notes',action:'edit',fields:{title:'Changed',body:'Instructions'}},
 {module:'board',action:'edit',fields:{title:'Changed',body:'Instructions',date:'2026-11-12'}},
 {module:'calendar',action:'start',fields:{body:'Starting work with evidence'}},
 {module:'tasks',action:'edit',fields:{title:'Changed',body:'Instructions',date:'2026-11-12',ownerId:'different-owner'}}
]){
 const task={id:'task-a',version:1,title:'Task',notes:'Instructions',due_on:'2026-11-12',status:'open',evidence:'',actions:['edit','start'],owner_id:'actor-a',priority:'normal',flow_id:'existing-flow'};let posts=0;
 const port=new TenantTaskModulePort(original,denied.module,async request=>{if(request.method==='POST')posts++;return{...raw,taskActorId:'actor-a',canManage:true,tasks:[{...task,version:request.method==='POST'?2:1}],taskPage:{total:1}};});
 const signal=new AbortController().signal;await port.read({search:'',offset:0},signal);
 await assert.rejects(()=>port.mutate({itemId:task.id,version:1,action:denied.action,fields:denied.fields},'11111111-1111-4111-8111-111111111111',signal),error=>['denied','invalid'].includes(error.code));
 assert.equal(posts,0,`${denied.module} forbidden fields/actions must not dispatch`);port.dispose();checks++;
}
// Other registered apps must use their own service adapters, not the tenant task port.
for(const module of ['mailbox','help','unregistered']){
 assert.throws(()=>new TenantTaskModulePort(original,module,async()=>raw),error=>error.code==='invalid');checks++;
}
// Cancellation before invocation must not dispatch or cache an uncertain mutation.
for(const mode of ['mutate','readItem'])for(const reason of ['abort','dispose']){
 const task={id:'task-a',version:1,title:'Task',notes:'Instructions',due_on:'2026-11-12',status:'open',evidence:'',actions:['edit'],owner_id:'actor-a',priority:'normal',flow_id:'existing-flow'};let calls=0;
 const port=new TenantTaskModulePort(original,'tasks',async request=>{calls++;return{...raw,tasks:[{...task,version:request.method==='POST'?2:1}],taskPage:{total:1}};});
 const controller=new AbortController();await port.read({search:'',offset:0},controller.signal);calls=0;
 if(reason==='abort')controller.abort();else port.dispose();
 await assert.rejects(()=>mode==='readItem'?port.readItem(task.id,controller.signal):port.mutate({itemId:task.id,version:1,action:'edit',fields:{title:'Saved',body:'Instructions',date:'2026-11-12'}},'11111111-1111-4111-8111-111111111111',controller.signal),error=>error.code==='unavailable');
 assert.equal(calls,0,`${reason} ${mode} must not dispatch`);port.dispose();checks++;
}
// Invalid request keys never reach the wire or occupy the adapter's replay cache.
for(const key of [undefined,'','not-a-request-key','11111111-1111-1111-8111-111111111111']){
 const task={id:'task-a',version:1,title:'Task',notes:'Instructions',due_on:'2026-11-12',status:'open',evidence:'',actions:['edit'],owner_id:'actor-a',priority:'normal',flow_id:'existing-flow'};let posts=0;
 const port=new TenantTaskModulePort(original,'tasks',async request=>{if(request.method==='POST')posts++;return{...raw,tasks:[{...task,version:request.method==='POST'?2:1}],taskPage:{total:1}};});
 const signal=new AbortController().signal;await port.read({search:'',offset:0},signal);
 await assert.rejects(()=>port.mutate({itemId:task.id,version:1,action:'edit',fields:{title:'Saved',body:'Instructions',date:'2026-11-12'}},key,signal),error=>error.code==='invalid');
 assert.equal(posts,0);port.dispose();checks++;
}
// The adapter accepts only the same bounded query shape as its session/native peer.
for(const query of [{search:'x'.repeat(101),offset:0},{search:[],offset:0},...[-1,0.5,NaN,Infinity,100001].map(offset=>({search:'',offset}))]){
 let calls=0;const port=new TenantTaskModulePort(original,'tasks',async()=>{calls++;return raw;});
 await assert.rejects(()=>port.read(query,new AbortController().signal),error=>error.code==='invalid');assert.equal(calls,0);port.dispose();checks++;
}
// A caller may reuse its command while transport is pending; acknowledgment stays bound.
{
 const task={id:'task-a',version:1,title:'Task',notes:'Instructions',due_on:'2026-11-12',status:'open',evidence:'',actions:['edit'],owner_id:'actor-a',priority:'normal',flow_id:'existing-flow'};let finish;
 const port=new TenantTaskModulePort(original,'tasks',request=>request.method==='POST'?new Promise(resolve=>{finish=resolve;}):Promise.resolve({...raw,tasks:[task],taskPage:{total:1}}));
 const signal=new AbortController().signal;await port.read({search:'',offset:0},signal);
 const command={itemId:task.id,version:1,action:'edit',fields:{title:'Saved',body:'Instructions',date:'2026-11-12'}};
 const pending=port.mutate(command,'11111111-1111-4111-8111-111111111111',signal);
 command.itemId='other-task';command.version=99;command.action='start';command.fields.title='Later draft';
 finish({...raw,tasks:[{...task,version:2,title:'Saved'}],taskPage:{total:1}});
 assert.deepEqual(await pending,{itemId:task.id,version:2,action:'edit',expected:{title:'Saved',body:'Instructions',date:'2026-11-12'}});port.dispose();checks++;
}
// Equivalent field/key order is the same original command, not a replay conflict.
{
 const task={id:'task-a',version:1,title:'Task',notes:'Instructions',due_on:'2026-11-12',status:'open',evidence:'',actions:['edit'],owner_id:'actor-a',priority:'normal',flow_id:'existing-flow'};const keys=[];let posts=0;
 const port=new TenantTaskModulePort(original,'tasks',async request=>{if(request.method==='POST'){keys.push(request.requestId);if(++posts===1)throw Error('lost acknowledgment');}return{...raw,tasks:[{...task,version:request.method==='POST'?2:1}],taskPage:{total:1}};});
 const signal=new AbortController().signal,key='11111111-1111-4111-8111-111111111111';await port.read({search:'',offset:0},signal);
 await assert.rejects(()=>port.mutate({itemId:task.id,version:1,action:'edit',fields:{title:'Saved',body:'Instructions',date:'2026-11-12'}},key,signal));
 const receipt=await port.mutate({fields:{date:'2026-11-12',body:'Instructions',title:'Saved'},action:'edit',version:1,itemId:task.id},key,signal);
 assert.equal(receipt.itemId,task.id);assert.deepEqual(keys,[key,key]);port.dispose();checks++;
}
// Validated queries must remain stable when callers reuse them during an async read.
for(const module of ['tasks','contacts']){
 let finish;const sent=[];
 const port=new TenantTaskModulePort(original,module,request=>{sent.push(request);return new Promise(resolve=>{finish=resolve;});});
 const query={search:module==='contacts'?'Alice':'Requested',offset:0};
 const pending=port.read(query,new AbortController().signal);query.search='Bob';query.offset=900;
 finish({...raw,users:[{id:'alice',name:'Alice',email:'alice@example.invalid'}]});const result=await pending;
 assert.equal(result.offset,0);if(module==='contacts')assert.deepEqual(result.items.map(i=>i.title),['Alice']);else assert.equal(sent[0].filters.search,'Requested');
 port.dispose();checks++;
}
console.log(`PASS tenant work scope: ${checks} cases; immutable actor/dataset binding and foreign response denial`);
