import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {resolve,dirname} from 'node:path';
import {execFileSync} from 'node:child_process';
import {createHash} from 'node:crypto';

const path='packages/domain/src/services/TrainingService.ts';
const base='96ee5d1af5c6c1404edf740cf995212ddfe8d11f';
const blob='d663ccf7b3f6c847db62b67eba73fe07ed23d237';
let historical;
try {historical=execFileSync('git',['show',base+':'+path],{timeout:30000});}
catch {execFileSync('git',['fetch','--no-tags','--depth=1','origin',base],{timeout:90000});historical=execFileSync('git',['show',base+':'+path],{timeout:30000});}
assert.equal(createHash('sha1').update('blob '+historical.length+'\0').update(historical).digest('hex'),blob,'Never refresh the historical failure control silently');
async function load(source){
 const result=await build({stdin:{contents:source,loader:'ts',resolveDir:dirname(resolve(path)),sourcefile:path},bundle:true,write:false,platform:'node',format:'esm'});
 return (await import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'))).TrainingService;
}
const old=await load(historical.toString('utf8'));
const current=await load(readFileSync(path,'utf8'));
const tenant='synthetic-owned-tenant';
const request={staffName:'Synthetic trainee',certName:'Synthetic certificate'};
const methods=['getTrainingComplianceSummary','verifyCertificate','getRecentActivity','getCurricula','getCertifications'];
const future=new Date('2099-01-01T00:00:00Z'),past=new Date('2000-01-01T00:00:00Z');
function fixture({error,mode='async',empty=false,expired=false,failModel}={}){
 const calls=[];
 const cert={id:'real-fixture-cert',tenantId:tenant,staffName:request.staffName,certName:request.certName,status:expired?'Expired':'Active',expiresAt:expired?past:future,createdAt:past};
 const assignment={id:'real-fixture-assignment',module:{title:'Real fixture module'},status:'completed',completedAt:past,assignedAt:past,dueDate:past,providerId:'synthetic-provider',staffId:null};
 function read(model,method,rows){return query=>{
  calls.push({model,method,query});
  if(error&&(!failModel||failModel===model)){if(mode==='sync')throw error;return Promise.reject(error);}
  return Promise.resolve(empty?(method==='findFirst'?null:[]):rows);
 };}
 return {calls,db:{
  trainingAssignment:{findMany:read('trainingAssignment','findMany',[assignment])},
  certificationNode:{findFirst:read('certificationNode','findFirst',cert),findMany:read('certificationNode','findMany',[cert])},
  curriculumNode:{findMany:read('curriculumNode','findMany',[{id:'real-fixture-curriculum',programName:'Real fixture curriculum'}])},
 }};
}
function call(service,method,f){return service[method](f.db,tenant,...(method==='verifyCertificate'?[request]:method==='getRecentActivity'?[1]:[]));}

// Run the old implementation, rather than accepting authored tests as a reproduction.
for(const method of methods)test('pinned old '+method+' fabricates success after synchronous Prisma failure',async()=>{
 const result=await call(old,method,fixture({error:Error('Prisma Accelerate unavailable'),mode:'sync'}));
 assert.equal(result.isSuccess,true);
 if(method==='verifyCertificate'){assert.equal(result.data.verified,true);assert.match(result.data.message,/\[MOCK\]/);}
 else if(method==='getTrainingComplianceSummary')assert.equal(result.data.totalActiveAssignments,154);
 else assert.ok(result.data.length>0);
});
for(const method of methods.slice(0,3))test('pinned old '+method+' fabricates success after asynchronous Prisma failure',async()=>{
 const result=await call(old,method,fixture({error:Error('prisma connection unavailable')}));
 assert.equal(result.isSuccess,true);
});
for(const method of methods)for(const mode of ['sync','async'])for(const message of ['Prisma Accelerate unavailable','prisma connection unavailable','generic database failure','']){
 test(method+' preserves '+mode+' failure '+JSON.stringify(message),async()=>{
  const f=fixture({error:Error(message),mode});const result=await call(current,method,f);
  assert.equal(result.isFailure,true);assert.equal(result.isSuccess,false);
  assert.equal(result.error,message||'An unexpected error occurred');
  assert.throws(()=>result.data,/Cannot access data/);
  assert.ok(f.calls.length>0);
 });
}
for(const method of ['getTrainingComplianceSummary','getRecentActivity'])for(const failModel of ['trainingAssignment','certificationNode'])test(method+' never returns partial success when '+failModel+' fails',async()=>{
 const result=await call(current,method,fixture({error:Error('prisma partial read failure'),failModel}));
 assert.equal(result.isFailure,true);assert.throws(()=>result.data);
});
for(const method of methods)for(const options of [{},{empty:true},{expired:true}])test(method+' preserves actual data and scoped query '+JSON.stringify(options),async()=>{
 const before=fixture(options),after=fixture(options);
 const expected=await call(old,method,before),actual=await call(current,method,after);
 assert.equal(expected.isSuccess,true);assert.equal(actual.isSuccess,true);
 assert.deepEqual(actual.data,expected.data);assert.deepEqual(after.calls,before.calls);
 for(const {model,query} of after.calls){
  assert.equal(model==='trainingAssignment'?query.where.module.tenantId:query.where.tenantId,tenant);
 }
});
test('a real expired certificate or missing record stays unverified',async()=>{
 for(const options of [{expired:true},{empty:true}]){
  const result=await call(current,'verifyCertificate',fixture(options));
  assert.equal(result.isSuccess,true);assert.equal(result.data.verified,false);
 }
});
console.log('PC10_TRAINING_FAILURE_CONTROL source='+base+' blob='+blob+' syntheticOnly=true liveDatabaseTested=false');
