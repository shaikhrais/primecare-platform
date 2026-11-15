import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {stripTypeScriptTypes} from 'node:module';

const result=stripTypeScriptTypes(readFileSync('packages/domain/src/utils/Result.ts','utf8'),{mode:'transform'});
const resultUrl='data:text/javascript;base64,'+Buffer.from(result).toString('base64');
const source=readFileSync('packages/domain/src/services/TrainingService.ts','utf8')
 .replace("import { PrismaClient } from '@primecare/database';","import type { PrismaClient } from '@primecare/database';")
 .replace("from '../utils/Result'","from '"+resultUrl+"'");
const {TrainingService}=await import('data:text/javascript;base64,'+Buffer.from(stripTypeScriptTypes(source,{mode:'transform'})).toString('base64'));
const tenant='synthetic-tenant',other='foreign-tenant';
const operations=[
 ['listModules',[]],['assignModule',[{moduleId:'foreign-module'}]],
 ['getTrainingComplianceSummary',[]],['verifyCertificate',[{staffName:'Foreign staff',certName:'Foreign certificate'}]],
 ['getRecentActivity',[]],['getCurricula',[]],['getCertifications',[]],
 ['createModule',[{title:'Synthetic module'}]],['updateModule',['foreign-module',{title:'Replacement'}]],
];
function fixture(){
 const calls=[],modules=[{id:'owned-module',tenantId:tenant,title:'Owned module'},{id:'foreign-module',tenantId:other,title:'Foreign module'}];
 const certificates=[{id:'own-cert',tenantId:tenant,staffName:'Own staff',certName:'Own certificate',status:'Compliant',expiresAt:new Date('2099-01-01'),createdAt:new Date('2026-01-01')},{id:'foreign-cert',tenantId:other,staffName:'Foreign staff',certName:'Foreign certificate',status:'Compliant',expiresAt:new Date('2099-01-01'),createdAt:new Date('2026-01-01')}];
 const assignments=[{id:'own-assignment',module:modules[0],status:'assigned',dueDate:null},{id:'foreign-assignment',module:modules[1],status:'assigned',dueDate:null}];
 const curricula=[{id:'own-curriculum',tenantId:tenant},{id:'foreign-curriculum',tenantId:other}];
 // Undefined predicates mirror Prisma's default omission behavior. Native tests
 // separately verify that behavior with the real pinned Prisma/PostgreSQL client.
 const scoped=(row,value)=>value===undefined||row.tenantId===value;
 const moduleMatches=(row,where)=>scoped(row,where.tenantId)&&(where.id===undefined||row.id===where.id);
 const db={
  trainingModule:{
   findMany:async q=>{calls.push(['modules.findMany',q]);return modules.filter(r=>moduleMatches(r,q.where));},
   findFirst:async q=>{calls.push(['modules.findFirst',q]);return modules.find(r=>moduleMatches(r,q.where))??null;},
   create:async q=>{calls.push(['modules.create',q]);const row={id:'new-module',...q.data};modules.push(row);return row;},
   update:async q=>{calls.push(['modules.update',q]);const row=modules.find(r=>moduleMatches(r,q.where));if(!row)throw Error('Synthetic module not found');Object.assign(row,q.data);return row;},
  },
  trainingAssignment:{
   findMany:async q=>{calls.push(['assignments.findMany',q]);return assignments.filter(r=>scoped(r.module,q.where.module.tenantId)&&(q.where.status===undefined||r.status===q.where.status));},
   create:async q=>{calls.push(['assignments.create',q]);const row={id:'new-assignment',...q.data};assignments.push(row);return row;},
  },
  certificationNode:{
   findMany:async q=>{calls.push(['certificates.findMany',q]);return certificates.filter(r=>scoped(r,q.where.tenantId));},
   findFirst:async q=>{calls.push(['certificates.findFirst',q]);return certificates.find(r=>scoped(r,q.where.tenantId)&&r.staffName.includes(q.where.staffName.contains)&&r.certName.includes(q.where.certName.contains))??null;},
  },
  curriculumNode:{findMany:async q=>{calls.push(['curricula.findMany',q]);return curricula.filter(r=>scoped(r,q.where.tenantId));}},
 };
 return {db,calls,modules,assignments};
}
for(const [method,args] of operations)test(`${method} refuses missing tenant context before accessing Prisma`,async()=>{
 const f=fixture(),value=await TrainingService[method](f.db,undefined,...args);
 assert.equal(value.isFailure,true);assert.equal(f.calls.length,0);assert.throws(()=>value.data);
});
test('blank and non-string tenant selectors cannot become Prisma predicates',async()=>{
 for(const value of [null,'','  ','\t\n',0,{},[],{not:tenant},new String(tenant)])for(const [method,args] of operations){
  const f=fixture(),result=await TrainingService[method](f.db,value,...args);
  assert.equal(result.isFailure,true,`${method} accepted invalid context`);assert.equal(f.calls.length,0);
 }
});
test('missing tenant cannot read foreign modules, certificates, curricula or compliance',async()=>{
 for(const [method,args] of operations.filter(([name])=>!['assignModule','createModule','updateModule'].includes(name))){
  const f=fixture(),value=await TrainingService[method](f.db,undefined,...args);
  assert.equal(value.isFailure,true);assert.equal(f.calls.length,0);
 }
});
test('missing tenant cannot check and then update or assign a foreign module',async()=>{
 for(const [method,args] of operations.filter(([name])=>['assignModule','updateModule'].includes(name))){
  const f=fixture(),before=structuredClone(f.modules),count=f.assignments.length,value=await TrainingService[method](f.db,undefined,...args);
  assert.equal(value.isFailure,true);assert.equal(f.calls.length,0);assert.deepEqual(f.modules,before);assert.equal(f.assignments.length,count);
 }
});
test('valid tenant reads preserve existing scoped results and ownership predicates',async()=>{
 for(const [method,args] of [['listModules',[]],['getCertifications',[]],['getCurricula',[]]]){
  const f=fixture(),value=await TrainingService[method](f.db,tenant,...args);
  assert.equal(value.isSuccess,true);assert.equal(value.data.length,1);assert.equal(value.data[0].tenantId,tenant);
  assert.equal(f.calls[0][1].where.tenantId,tenant);
 }
 const f=fixture(),foreign=await TrainingService.verifyCertificate(f.db,tenant,{staffName:'Foreign staff',certName:'Foreign certificate'});
 assert.equal(foreign.isSuccess,true);assert.equal(foreign.data.verified,false);assert.equal(f.calls[0][1].where.tenantId,tenant);
});
test('valid module writes retain exact tenant scope without changing assignment policy',async()=>{
 const f=fixture(),created=await TrainingService.createModule(f.db,tenant,{title:'New module'});
 assert.equal(created.isSuccess,true);assert.equal(created.data.tenantId,tenant);
 const updated=await TrainingService.updateModule(f.db,tenant,'owned-module',{title:'Updated owned module'});
 assert.equal(updated.isSuccess,true);assert.deepEqual(f.calls.at(-1)[1].where,{id:'owned-module',tenantId:tenant});
 const assigned=await TrainingService.assignModule(f.db,tenant,{moduleId:'owned-module'});
 assert.equal(assigned.isSuccess,true);assert.equal(assigned.data.moduleId,'owned-module');
 assert.equal(f.modules.find(r=>r.id==='foreign-module').title,'Foreign module');
});
