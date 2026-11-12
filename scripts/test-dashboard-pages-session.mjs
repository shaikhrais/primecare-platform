import {test} from 'node:test';import assert from 'node:assert/strict';
import {DashboardPageSession} from '../packages/shared/src/dashboard-pages/session.mjs';
const scope={dataset:'live',userId:'u',tenantId:'t',role:'tenant_admin'};
const raw=(open=1)=>({dataset:'live',synthetic:false,identity:{userId:'u',role:'tenant_admin'},organization:{id:'t'},allowedViews:['tasks'],taskStats:{open,review:0,blocked:0,overdue:0,completed:0}});
test('latest request wins even when aborted transport resolves',async()=>{const pending=[];const s=new DashboardPageSession('project',scope,signal=>new Promise(resolve=>pending.push({signal,resolve})),()=>scope);const a=s.load(),b=s.load();assert.equal(pending[0].signal.aborted,true);pending[1].resolve(raw(2));await b;pending[0].resolve(raw(9));await a;assert.equal(s.state.projection.metrics[0].value,2);s.dispose();});
test('refresh immediately clears old values; failure retains no stale projection',async()=>{let fail=false;const s=new DashboardPageSession('project',scope,async()=>{if(fail)throw Error('offline');return raw();},()=>scope);await s.load();fail=true;const load=s.load();assert.equal(s.state.projection,null);await load;assert.equal(s.state.status,'error');s.dispose();});
test('scope changes, explicit invalidation and disposal defeat pending responses',async()=>{for(const mode of ['scope','invalidate','dispose']){let current=scope,resolve;const s=new DashboardPageSession('project',scope,()=>new Promise(r=>resolve=r),()=>current);const p=s.load();if(mode==='scope')current={...scope,role:'client'};else s[mode]();resolve(raw());await p;assert.equal(s.state.projection,null);assert.equal(s.state.status,mode==='dispose'?'disposed':'denied');s.dispose();}});
test('snapshot consumers cannot modify retained values',async()=>{const s=new DashboardPageSession('project',scope,async()=>raw(),()=>scope);await s.load();s.state.projection.metrics[0].value=7;assert.equal(s.state.projection.metrics[0].value,1);s.dispose();});

for(const mode of ['dispose','invalidate'])test('loading notification '+mode+' prevents transport dispatch',async()=>{
 let reads=0;const s=new DashboardPageSession('project',scope,async()=>{reads++;return raw();},()=>scope);
 s.subscribe(()=>{if(s.state.status==='loading')s[mode]();});await s.load();
 assert.equal(reads,0);assert.equal(s.state.status,mode==='dispose'?'disposed':'denied');assert.equal(s.state.projection,null);s.dispose();
});
test('nested load during notification retires the outer request before dispatch',async()=>{
 let nested,once=true,reads=0;const s=new DashboardPageSession('project',scope,async()=>{reads++;return raw(3);},()=>scope);
 s.subscribe(()=>{if(s.state.status==='loading'&&once){once=false;nested=s.load();}});await s.load();await nested;
 assert.equal(reads,1);assert.equal(s.state.projection.metrics[0].value,3);s.dispose();
});
for(const mode of ['dispose','invalidate'])test('projection callback cannot revive a '+mode+' session',async()=>{
 const s=new DashboardPageSession('project',scope,async()=>raw(),()=>scope,()=>{s[mode]();return {status:'ready',metrics:[{value:99}]};});await s.load();
 assert.equal(s.state.status,mode==='dispose'?'disposed':'denied');assert.equal(s.state.projection,null);s.dispose();
});
test('failed request rechecks changed account before reporting transport error',async()=>{
 let current=scope,reject;const s=new DashboardPageSession('project',scope,()=>new Promise((_,r)=>{reject=r;}),()=>current),pending=s.load();
 current={...scope,userId:'other'};reject(Error('offline'));await pending;assert.equal(s.state.status,'denied');assert.equal(s.state.projection,null);s.dispose();
});
test('throwing current-session provider denies without escaping from load',async()=>{
 const s=new DashboardPageSession('project',scope,async()=>raw(),()=>{throw Error('logged out');});await s.load();assert.equal(s.state.status,'denied');assert.equal(s.state.projection,null);s.dispose();
});
test('current-session callback disposal prevents dispatch even when it returns captured scope',async()=>{
 let reads=0;const s=new DashboardPageSession('project',scope,async()=>{reads++;return raw();},()=>{s.dispose();return scope;});await s.load();assert.equal(reads,0);assert.equal(s.state.status,'disposed');
});
test('projection callback account change denies its returned values',async()=>{
 let current=scope;const s=new DashboardPageSession('project',scope,async()=>raw(),()=>current,()=>{current={...scope,tenantId:'other'};return {status:'ready',metrics:[{value:99}]};});await s.load();assert.equal(s.state.status,'denied');assert.equal(s.state.projection,null);s.dispose();
});
