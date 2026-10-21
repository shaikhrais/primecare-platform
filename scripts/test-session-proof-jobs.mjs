import {test} from 'node:test';
import assert from 'node:assert/strict';
import {confirmedSessionProofJobs} from './session-proof-jobs.mjs';
const jobs=['proof (en, 320)','proof (fr, 768)','proof (es, 1440)'].map(name=>({name,status:'completed',conclusion:'success',started_at:'2026-10-21T14:00:00Z'}));
test('waits for all exact language jobs when completion event precedes matrix visibility',async()=>{
 let calls=0,pauses=0;
 const got=await confirmedSessionProofJobs(async()=>jobs.slice(0,++calls),{pause:async()=>{pauses++;}});
 assert.deepEqual(got,jobs);assert.equal(calls,3);assert.equal(pauses,2);
});
test('fails closed after bounded retry without accepting partial matrix',async()=>{
 let calls=0;await assert.rejects(confirmedSessionProofJobs(async()=>{calls++;return jobs.slice(1);},{attempts:3,pause:async()=>{}}),/Three exact/);assert.equal(calls,3);
});
test('failed, skipped, duplicate and substitute locale jobs cannot receive evidence credit',async()=>{
 for(const candidate of [[...jobs.slice(0,2),{...jobs[2],conclusion:'failure'}],[...jobs.slice(0,2),{...jobs[2],conclusion:'skipped'}],[jobs[0],jobs[0],jobs[2]],[...jobs.slice(0,2),{...jobs[2],name:'proof (de, 1440)'}]]) {
  let calls=0;await assert.rejects(confirmedSessionProofJobs(async()=>{calls++;return candidate;},{pause:async()=>{}}));assert.equal(calls,1);
 }
});
test('requires completed jobs and valid start timestamps',async()=>{
 await assert.rejects(confirmedSessionProofJobs(async()=>jobs.map(j=>({...j,status:'in_progress'})),{attempts:1}),/Three exact/);
 await assert.rejects(confirmedSessionProofJobs(async()=>jobs.map(j=>({...j,started_at:null}))),/timestamps/);
});
