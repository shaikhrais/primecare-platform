import test from 'node:test';
import assert from 'node:assert/strict';
import {DashboardPageSession} from '../packages/shared/src/dashboard-pages/session.mjs';
const scope={userId:'u',tenantId:'t',role:'r',dataset:'live'};
const make=()=>new DashboardPageSession('tasks',scope,async()=>({}),()=>scope,()=>({status:'ready'}));
test('throwing loading and ready observers cannot block reads or later observers',async()=>{
 const s=make(),seen=[];s.subscribe(()=>{throw Error('render');});s.subscribe(v=>seen.push(v.status));
 await s.load();assert.equal(s.state.status,'ready');assert.deepEqual(seen,['loading','ready']);
});
test('throwing disposal observer cannot prevent cleanup',()=>{
 const s=make();let calls=0;s.subscribe(()=>{throw Error('render');});s.subscribe(()=>calls++);
 s.dispose();assert.equal(calls,1);assert.equal(s.state.status,'disposed');s.dispose();assert.equal(calls,1);
});
test('new observers join only the next notification',async()=>{
 const s=make(),seen=[];let added=false;s.subscribe(()=>{if(!added){added=true;s.subscribe(v=>seen.push(v.status));}});
 await s.load();assert.deepEqual(seen,['ready']);
});
test('duplicate subscriptions retain independent cleanup ownership',async()=>{
 const s=make();let calls=0;const listener=()=>calls++;const first=s.subscribe(listener);s.subscribe(listener);first();first();
 await s.load();assert.equal(calls,2);
});
test('unsubscribe during dispatch suppresses the removed observer',async()=>{
 const s=make();let calls=0;let off=()=>{};s.subscribe(()=>off());off=s.subscribe(()=>calls++);
 await s.load();assert.equal(calls,0);
});
test('subscriptions after disposal are inert',()=>{
 const s=make();s.dispose();let calls=0;const off=s.subscribe(()=>calls++);off();assert.equal(calls,0);
});
