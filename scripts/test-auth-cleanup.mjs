import {test} from 'node:test';
import assert from 'node:assert/strict';
import {cleanupRateLimits} from './cleanup-auth-rate-limits.mjs';

test('cleanup defaults to preview without issuing a delete',async()=>{
  const db={async query(sql,values){assert.ok(sql.startsWith('SELECT'));assert.deepEqual(values,[10000]);return {rows:[{expired:7}]};}};
  assert.deepEqual(await cleanupRateLimits(db),{mode:'preview',expiredUpToLimit:7,limit:10000});
});
test('cleanup bounds each batch and stops after the maximum',async()=>{
  let calls=0;
  const db={async query(sql,values){calls++;assert.match(sql,/SKIP LOCKED/);assert.deepEqual(values,[2]);return {rowCount:2};}};
  assert.deepEqual(await cleanupRateLimits(db,{apply:true,batchSize:2,maxBatches:3}),{mode:'apply',deleted:6,batchLimitReached:true});
  assert.equal(calls,3);
});
test('cleanup stops when fewer than a full batch are eligible',async()=>{
  let calls=0;
  const db={async query(){calls++;return {rowCount:0};}};
  assert.deepEqual(await cleanupRateLimits(db,{apply:true}),{mode:'apply',deleted:0,batchLimitReached:false});
  assert.equal(calls,1);
});
test('invalid cleanup options never reach the database',async()=>{
  const db={query(){throw new Error('Unexpected query');}};
  for(const options of [{apply:'true'},{batchSize:0},{batchSize:1001},{maxBatches:11},{maxBatches:1.5}]) {
    await assert.rejects(cleanupRateLimits(db,options),/Invalid cleanup options/);
  }
});
