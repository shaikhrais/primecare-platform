import {build} from 'esbuild';import {test} from 'node:test';import assert from 'node:assert/strict';
const bundled=await build({entryPoints:['websites/typescript/src/training/progress.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {TrainingProgress}=await import('data:text/javascript;base64,'+Buffer.from(bundled.outputFiles[0].text).toString('base64'));
const values=new Map();const storage={getItem:k=>values.get(k)??null,setItem:(k,v)=>values.set(k,v),removeItem:k=>values.delete(k)};
test('wrong answers do not pass; results survive restart and are account/gateway scoped',()=>{
 const p=new TrainingProgress('https://one','a',storage);assert.equal(p.answer('authority',0),false);assert.equal(p.results().length,0);assert.equal(p.answer('authority',1),true);assert.equal(p.results().length,1);assert.equal(new TrainingProgress('https://one/','a',storage).results().length,1);assert.equal(new TrainingProgress('https://one','b',storage).results().length,0);assert.equal(new TrainingProgress('https://two','a',storage).results().length,0);p.answer('authority',1);assert.equal(p.results().length,1);assert.equal(p.summary().supervisorVerified,false);assert.equal(p.summary().recordType,'device-self-assessment');
});
test('invalid input and storage failure cannot create a passed record',()=>{
 const p=new TrainingProgress('https://fail','a',{getItem:()=>null,setItem:()=>{throw Error('full');},removeItem:()=>{throw Error('blocked');}});assert.throws(()=>p.answer('authority',1),/full/);assert.equal(p.results().length,0);for(const a of [-1,3,1.5,NaN])assert.throws(()=>p.answer('authority',a));assert.throws(()=>p.answer('unknown',1));assert.throws(()=>p.reset(),/blocked/);assert.throws(()=>new TrainingProgress('https://one','',storage));
});
test('corrupt, oversized and unknown results are rejected; reset removes only current account',()=>{
 const p=new TrainingProgress('https://one','a',storage);const key=[...values.keys()][0];values.set(key,'x'.repeat(32769));assert.deepEqual(p.results(),[]);values.set(key,JSON.stringify(Array(9).fill({lesson:'authority',passedAt:'2026-10-13'})));assert.deepEqual(p.results(),[]);values.set(key,'{invalid');assert.deepEqual(p.results(),[]);values.set(key,JSON.stringify([{lesson:'unknown',passedAt:'2026-10-13'}, {lesson:'authority',passedAt:'invalid'}]));assert.deepEqual(p.results(),[]);p.answer('authority',1);const other=new TrainingProgress('https://one','b',storage);other.answer('authority',1);p.reset();assert.equal(p.results().length,0);assert.equal(other.results().length,1);
});
