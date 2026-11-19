import {test} from 'node:test';
import assert from 'node:assert/strict';
import {makeFixtureHandler} from './endpoint-prototype.mjs';

const path='/v1/clinical/dashboard';
const actor={userId:'director',tenantId:'tenant-a',role:'clinical_director'};
const cases=[
 ['missing session',null,0,'GET',path,401,0],
 ['other role',{...actor,role:'therapist'},0,'GET',path,403,0],
 ['wrong method',actor,0,'POST',path,405,0],
 ['caller-selected tenant',actor,0,'GET',path+'?tenantId=tenant-b',400,0],
 ['caller-selected branch',actor,0,'GET',path+'?branchId=branch-b',400,0],
 ['no assigned branch',actor,null,'GET',path,403,1],
 ['authorized empty branch',actor,{booking_count:0},'GET',path,200,1],
 ['malformed database response',actor,{booking_count:-1},'GET',path,503,1],
 ['data source unavailable',actor,new Error('fixture internal detail'),'GET',path,503,1],
];
for(const [name,session,row,method,url,status,readsExpected] of cases) test(name,async()=>{
 let reads=0;
 const handler=makeFixtureHandler({
  verifySession:async()=>session,
  readScopedCounts:async identity=>{
   ++reads;
   assert.deepEqual(identity,{userId:'director',tenantId:'tenant-a'});
   if(row instanceof Error)throw row;
   return row;
  }
 });
 const resp=await handler(new Request('https://fixture.invalid'+url,{method}));
 assert.equal(resp.status,status);
 assert.equal(reads,readsExpected);
 assert.equal(resp.headers.get('cache-control'),'no-store');
 if(status===405) assert.equal(resp.headers.get('allow'),'GET');
 const body=await resp.json();
 if(status===200)assert.deepEqual(body,{bookingCount:0});
 else assert.deepEqual(Object.keys(body),['error']);
});
