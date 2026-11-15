import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {stripTypeScriptTypes} from 'node:module';

// Exercise the actual service and Result wrapper without requiring Prisma.
const result=stripTypeScriptTypes(readFileSync('packages/domain/src/utils/Result.ts','utf8'),{mode:'transform'});
const resultUrl='data:text/javascript;base64,'+Buffer.from(result).toString('base64');
const source=readFileSync('packages/domain/src/services/TrainingService.ts','utf8')
 .replace("import { PrismaClient } from '@primecare/database';","import type { PrismaClient } from '@primecare/database';")
 .replace("from '../utils/Result'","from '"+resultUrl+"'");
const {TrainingService}=await import('data:text/javascript;base64,'+Buffer.from(stripTypeScriptTypes(source,{mode:'transform'})).toString('base64'));
const tenant='synthetic-tenant',moduleId='synthetic-module',foreignModule='other-tenant-module';
function fixture({onRead,missing=false,readError,createError}={}){
 const calls=[];
 const db={trainingModule:{findFirst:async query=>{
  calls.push(['findFirst',query]);if(readError)throw readError;
  await onRead?.();return missing?null:{id:moduleId,tenantId:tenant};
 }},trainingAssignment:{create:async query=>{
  calls.push(['create',query]);if(createError)throw createError;
  return {id:'synthetic-assignment',...query.data};
 }}};
 return {db,calls};
}
test('caller mutation during ownership lookup cannot replace the checked module or assignment values',async()=>{
 const data={moduleId,staffId:'original-staff',providerId:'original-provider',dueDate:'2030-01-02T03:04:05Z'};
 const f=fixture({onRead:()=>Object.assign(data,{moduleId:foreignModule,staffId:'replacement-staff',providerId:'replacement-provider',dueDate:'2040-02-03T04:05:06Z'})});
 const value=await TrainingService.assignModule(f.db,tenant,data);
 assert.equal(value.isSuccess,true);
 assert.deepEqual(f.calls,[
  ['findFirst',{where:{id:moduleId,tenantId:tenant}}],
  ['create',{data:{moduleId,staffId:'original-staff',providerId:'original-provider',dueDate:new Date('2030-01-02T03:04:05Z'),status:'assigned'}}]
 ]);
 assert.equal(value.data.moduleId,moduleId);
});
test('declared input fields are captured once, rather than reevaluating accessors after validation',async()=>{
 const reads={moduleId:0,staffId:0,providerId:0,dueDate:0};
 const initial={moduleId,staffId:'original-staff',providerId:'original-provider',dueDate:'2030-01-02T03:04:05Z'};
 const data={};for(const key of Object.keys(reads))Object.defineProperty(data,key,{get:()=>++reads[key]===1?initial[key]:key==='moduleId'?foreignModule:'replacement'});
 const f=fixture(),value=await TrainingService.assignModule(f.db,tenant,data);
 assert.equal(value.isSuccess,true);assert.deepEqual(reads,{moduleId:1,staffId:1,providerId:1,dueDate:1});
 assert.deepEqual(f.calls.at(-1),['create',{data:{...initial,dueDate:new Date(initial.dueDate),status:'assigned'}}]);
});
test('optional fields and existing empty-date conversion retain their original behavior',async()=>{
 for(const data of [{moduleId},{moduleId,staffId:'staff'},{moduleId,providerId:'provider',dueDate:''}]){
  const f=fixture(),value=await TrainingService.assignModule(f.db,tenant,data);
  assert.equal(value.isSuccess,true);assert.deepEqual(f.calls.at(-1),['create',{data:{moduleId,staffId:data.staffId,providerId:data.providerId,dueDate:null,status:'assigned'}}]);
 }
});
test('failed ownership and database failures never fall back to an assignment write',async()=>{
 const absent=fixture({missing:true}),missing=await TrainingService.assignModule(absent.db,tenant,{moduleId});
 assert.equal(missing.isFailure,true);assert.equal(absent.calls.length,1);
 const failed=fixture({readError:Error('Synthetic ownership failure')}),read=await TrainingService.assignModule(failed.db,tenant,{moduleId});
 assert.equal(read.isFailure,true);assert.equal(read.error,'Synthetic ownership failure');assert.equal(failed.calls.length,1);
 const rejected=fixture({createError:Error('Synthetic assignment failure')}),write=await TrainingService.assignModule(rejected.db,tenant,{moduleId});
 assert.equal(write.isFailure,true);assert.equal(write.error,'Synthetic assignment failure');assert.equal(rejected.calls.length,2);
});
test('overlapping calls using a reused input record keep their own captured values',async()=>{
 let release;const held=new Promise(resolve=>release=resolve);
 const data={moduleId,staffId:'first-staff'},first=fixture({onRead:()=>held});
 const pending=TrainingService.assignModule(first.db,tenant,data);
 data.moduleId='second-module';data.staffId='second-staff';
 const second=fixture(),completed=await TrainingService.assignModule(second.db,tenant,data);
 release();const original=await pending;
 assert.equal(original.isSuccess,true);assert.equal(completed.isSuccess,true);
 assert.equal(first.calls.at(-1)[1].data.moduleId,moduleId);assert.equal(first.calls.at(-1)[1].data.staffId,'first-staff');
 assert.equal(second.calls.at(-1)[1].data.moduleId,'second-module');assert.equal(second.calls.at(-1)[1].data.staffId,'second-staff');
});
