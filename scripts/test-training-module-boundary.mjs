import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {stripTypeScriptTypes} from 'node:module';
const result=stripTypeScriptTypes(readFileSync('packages/domain/src/utils/Result.ts','utf8'),{mode:'transform'});
const resultUrl='data:text/javascript;base64,'+Buffer.from(result).toString('base64');
const source=readFileSync('packages/domain/src/services/TrainingService.ts','utf8').replace("import { PrismaClient } from '@primecare/database';","import type { PrismaClient } from '@primecare/database';").replace("from '../utils/Result'","from '"+resultUrl+"'");
const {TrainingService}=await import('data:text/javascript;base64,'+Buffer.from(stripTypeScriptTypes(source,{mode:'transform'})).toString('base64'));
const tenant='synthetic-tenant',id='synthetic-module';
function fixture({onRead,missing=false,moved=false,error}={}){
 const calls=[],db={trainingModule:{
  findFirst:async query=>{calls.push(['findFirst',query]);if(error)throw error;await onRead?.();return missing?null:{id,tenantId:tenant};},
  create:async query=>{calls.push(['create',query]);if(error)throw error;return {id,...query.data};},
  update:async query=>{calls.push(['update',query]);if(error)throw error;if(moved&&query.where.tenantId===tenant)throw Error('Record no longer belongs to tenant');return {id,tenantId:moved?'other-tenant':tenant,...query.data};}
 }};return {db,calls};
}
const write=(f,operation,data)=>operation==='create'?TrainingService.createModule(f.db,tenant,data):TrainingService.updateModule(f.db,tenant,id,data);
test('reject undeclared tenant, identity, timestamp and nested Prisma fields before database access',async()=>{
 for(const extra of [{tenantId:'other-tenant'},{id:'other-module'},{createdAt:new Date()},{assignments:{create:{status:'completed'}}}])for(const operation of ['create','update']){
  const f=fixture(),value=await write(f,operation,{title:'Module',...extra});assert.equal(value.isFailure,true);assert.equal(f.calls.length,0);assert.throws(()=>value.data);
 }
});
test('reject arrays, primitives, invalid declared types and inherited input objects before Prisma',async()=>{
 for(const data of [null,undefined,[],{title:123},{title:null},{title:'Module',description:123},Object.assign(Object.create({tenantId:'other-tenant'}),{title:'Module'})])for(const operation of ['create','update']){
  const f=fixture(),value=await write(f,operation,data);assert.equal(value.isFailure,true);assert.equal(f.calls.length,0);
 }
});
test('reject own unknown nonenumerable and symbol keys',async()=>{
 for(const key of ['tenantId',Symbol('nested-write')]){const data={title:'Module'};Object.defineProperty(data,key,{value:'other',enumerable:false});const f=fixture(),value=await write(f,'create',data);assert.equal(value.isFailure,true);assert.equal(f.calls.length,0);}
});
test('preserve declared strings, nullable model fields, optional undefined and own null-prototype records',async()=>{
 const data=Object.assign(Object.create(null),{title:'Module',description:null,category:undefined,videoUrl:'stored:reference'}),created=fixture(),creation=await write(created,'create',data);
 assert.equal(creation.isSuccess,true);assert.deepEqual(created.calls,[['create',{data:{...data,tenantId:tenant}}]]);
 const updated=fixture(),update=await write(updated,'update',data);assert.equal(update.isSuccess,true);assert.deepEqual(updated.calls,[['findFirst',{where:{id,tenantId:tenant}}],['update',{where:{id,tenantId:tenant},data:{...data}}]]);
});
test('preserve optional update fields and schema-permitted empty strings without inventing content rules',async()=>{
 for(const data of [{},{title:undefined,description:undefined},{title:'',description:'',category:'',videoUrl:''}]){
  const f=fixture(),value=await write(f,'update',data);assert.equal(value.isSuccess,true);assert.deepEqual(f.calls.at(-1),['update',{where:{id,tenantId:tenant},data}]);
 }
 for(const data of [{},{title:undefined}]){const f=fixture(),value=await write(f,'create',data);assert.equal(value.isFailure,true);assert.equal(f.calls.length,0);}
});
test('capture declared fields before ownership await and repeat tenant predicate at actual write',async()=>{
 const data={title:'Original title'},f=fixture({onRead:()=>{data.title='Late replacement';data.tenantId='other-tenant';data.assignments={deleteMany:{}};}}),value=await write(f,'update',data);assert.equal(value.isSuccess,true);assert.deepEqual(f.calls.at(-1),['update',{where:{id,tenantId:tenant},data:{title:'Original title'}}]);
 const moved=fixture({moved:true}),lost=await write(moved,'update',{title:'Scoped update'});assert.equal(lost.isFailure,true);assert.equal(moved.calls.at(-1)[1].where.tenantId,tenant);
});
test('preserve missing ownership and actual Prisma Result failures without fallback writes',async()=>{
 const missing=fixture({missing:true}),value=await write(missing,'update',{title:'Module'});assert.equal(value.isFailure,true);assert.equal(missing.calls.length,1);
 for(const operation of ['create','update']){const f=fixture({error:Error('Synthetic Prisma outage')}),value=await write(f,operation,{title:'Module'});assert.equal(value.isFailure,true);assert.equal(value.error,'Synthetic Prisma outage');assert.equal(f.calls.length,1);}
});
