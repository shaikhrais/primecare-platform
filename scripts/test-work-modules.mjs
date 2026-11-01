import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {mkdtemp,writeFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
import {tenantFixture} from './tenant-dashboard-fixture.mjs';
const dir=await mkdtemp(join(tmpdir(),'work-modules-'));
await build({stdin:{contents:`export * from './packages/domain/src/work_modules';export * from './packages/shared/src/work-modules/session';export * from './packages/shared/src/work-modules/tenant-task-adapter';`,resolveDir:process.cwd(),loader:'ts'},outfile:join(dir,'test.cjs'),bundle:true,platform:'node',format:'cjs'});
const model=createRequire(import.meta.url)(join(dir,'test.cjs')), {WorkModuleSession,TenantTaskModulePort}=model;
let checks=0;function ok(value){assert.ok(value);checks++;}
const feb=model.workMonth(2028,2,1);ok(feb.length===42);ok(feb.filter(x=>x.inMonth).length===29);ok(feb[0].date==='2028-01-31');ok(!model.validWorkDate('2027-02-29'));ok(model.recordSuffix('A')!==model.recordSuffix('a'));assert.throws(()=>model.workMonth(2028,13));checks++;
const f=await tenantFixture();
try {
 const scope={tenantId:f.tenants[0],userId:f.actors.admin.id,role:f.actors.admin.role,dataset:'live'};
 let writes=0;
 function port(module,role='admin',bound=scope){return new TenantTaskModulePort(bound,module,async(r)=>{if(r.method==='POST')writes++;const response=await f.call(role,r.method==='POST'?r.body:null,'?'+new URLSearchParams(r.filters),r.requestId);const data=await response.json();if(!response.ok)throw new model.WorkFailure(response.status===409?'conflict':response.status===403||response.status===401?'denied':response.status===400?'invalid':'error',response.status);return data;});}
 const response=await f.call('admin',{action:'create',value:{title:'B13 original task',ownerId:f.actors.psw.id,dueOn:'2026-11-05',priority:'normal',flowId:'fixture.tenant.process',notes:'Initial task instructions'}});assert.equal(response.status,200,JSON.stringify(await response.clone().json()));const created=(await response.json()).tasks.find(t=>t.title==='B13 original task');ok(!!created);
 const task=new WorkModuleSession(scope,'tasks',port('tasks'));await task.load();ok(task.status==='ready');
 await task.submit(created.id,'edit',{title:'B13 renamed task',body:'Revised instructions',date:'2026-11-06'},1);ok(task.status==='success');
 let row=(await f.db.query('SELECT title,notes,due_on::text,version,status FROM tenant_work_tasks WHERE id=$1',[created.id])).rows[0];assert.equal(row.title,'B13 renamed task');assert.equal(row.notes,'Revised instructions');ok(row.version===2);
 const fresh=new WorkModuleSession(scope,'tasks',port('tasks'));await fresh.load();ok(fresh.current.snapshot.items.some(i=>i.id===created.id&&i.title===row.title&&i.version===2));
 const notes=new WorkModuleSession(scope,'notes',port('notes'));await notes.load();await notes.submit(created.id,'edit',{body:'Saved task instructions from notes'},2);ok(notes.status==='success');
 const calendar=new WorkModuleSession(scope,'calendar',port('calendar'));await calendar.load();await calendar.submit(created.id,'reschedule',{date:'2026-11-09'},3);ok(calendar.status==='success');
 row=(await f.db.query('SELECT notes,due_on::text,version FROM tenant_work_tasks WHERE id=$1',[created.id])).rows[0];assert.equal(row.notes,'Saved task instructions from notes');assert.equal(row.due_on,'2026-11-09');ok(row.version===4);
 const board=new WorkModuleSession(scope,'board',port('board'));await board.load();ok(board.current.snapshot.items.find(i=>i.id===created.id).actions.some(a=>a.id==='start'));await board.submit(created.id,'start',{body:'Starting authorized task with evidence'},4);ok(board.status==='success');row=(await f.db.query('SELECT status,version FROM tenant_work_tasks WHERE id=$1',[created.id])).rows[0];assert.equal(row.status,'in_progress');ok(row.version===5);
 await assert.rejects(()=>fresh.submit(created.id,'edit',{title:'STALE',body:'Stale',date:'2026-11-09'},2));ok(fresh.status==='conflict');assert.notEqual((await f.db.query('SELECT title FROM tenant_work_tasks WHERE id=$1',[created.id])).rows[0].title,'STALE');
 const contacts=new WorkModuleSession(scope,'contacts',port('contacts'));await contacts.load();ok(contacts.status==='ready');ok(contacts.current.snapshot.items.every(i=>i.actions.length===0));ok(!JSON.stringify(contacts.current.snapshot).includes('PRIVATE Foreign Client'));const before=writes;await assert.rejects(()=>contacts.submit(contacts.current.snapshot.items[0].id,'edit',{body:'forbidden'}));ok(writes===before);
 const wrong=new WorkModuleSession(scope,'tasks',port('tasks','foreign'));await wrong.load();ok(wrong.status==='denied'&&wrong.current.snapshot===null);
 const raw=structuredClone(task.current.snapshot);raw.items.push(raw.items[0]);assert.throws(()=>model.validateWorkSnapshot(raw,scope,'tasks'));checks++;
 // A lost response retains one key; readback is required before success.
 const snapshot=structuredClone(task.current.snapshot),item=snapshot.items.find(i=>i.id===created.id);let attempt=0,keys=[];
 const uncertain=new WorkModuleSession(scope,'tasks',{read:async()=>snapshot,mutate:async(c,k)=>{keys.push(k);if(++attempt===1)throw Error('lost response');return{itemId:c.itemId,version:c.version+1,action:c.action,expected:{title:'Retry title'}};},readItem:async()=>({...snapshot,items:snapshot.items.map(i=>i.id===item.id?{...i,version:i.version+1,title:'Retry title'}:i)})});await uncertain.load();await assert.rejects(()=>uncertain.submit(item.id,'edit',{title:'Retry title',body:item.body,date:item.date},item.version));ok(uncertain.current.pending);await uncertain.retryPending();ok(uncertain.status==='success'&&keys[0]===keys[1]);
 // An acknowledged write must never be sent again merely because verification failed.
 let acknowledgedWrites=0,verificationReads=0;const acknowledged=new WorkModuleSession(scope,'tasks',{
  read:async()=>snapshot,
  mutate:async(c)=>{acknowledgedWrites++;return{itemId:c.itemId,version:c.version+1,action:c.action,expected:{title:'Verified once'}};},
  readItem:async()=>{if(++verificationReads===1)throw Error('read offline');return {...snapshot,items:snapshot.items.map(i=>i.id===item.id?{...i,version:i.version+1,title:'Verified once'}:i)};}
 });await acknowledged.load();await assert.rejects(()=>acknowledged.submit(item.id,'edit',{title:'Verified once',body:item.body,date:item.date},item.version));
 ok(acknowledged.current.pending);await assert.rejects(()=>acknowledged.load({search:'replacement',offset:0}));ok(acknowledged.current.snapshot.items[0].title===snapshot.items[0].title&&acknowledged.current.query.search==='');
 await acknowledged.retryPending();ok(acknowledged.status==='success'&&acknowledgedWrites===1&&verificationReads===2);acknowledged.dispose();
 let finish;const disposed=new WorkModuleSession(scope,'tasks',{read:()=>new Promise(r=>finish=r),mutate:async()=>{throw Error();},readItem:async()=>snapshot});const loading=disposed.load();disposed.dispose();finish(snapshot);await loading;ok(disposed.current.snapshot===null&&disposed.status==='disposed');
 for(const session of [task,fresh,notes,calendar,board,contacts,wrong,uncertain])session.dispose();
 console.log(`PASS work modules: ${checks} checks; ${f.native?'native PostgreSQL':'PGlite PostgreSQL'} API, independent SQL and fresh-session readback`);
}finally{await f.close();}
