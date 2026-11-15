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
const tenant='synthetic-tenant',foreignTenant='other-tenant',ownId='owned-assignment',foreignId='foreign-assignment';
function fixture({onUpdate,error}={}){
 const calls=[],rows=[{id:ownId,module:{tenantId:tenant},status:'assigned',completedAt:null},{id:foreignId,module:{tenantId:foreignTenant},status:'assigned',completedAt:null}];
 const db={trainingAssignment:{update:async query=>{
  calls.push(query);if(error)throw error;await onUpdate?.(rows);
  const row=rows.find(r=>r.id===query.where.id&&(!query.where.module||r.module.tenantId===query.where.module.tenantId));
  if(!row)throw Object.assign(Error('Synthetic record not found'),{code:'P2025'});
  Object.assign(row,query.data);return {...row};
 }}};
 return {db,calls,rows};
}
test('completion requires tenant context; the legacy two-argument call cannot complete a foreign assignment',async()=>{
 const f=fixture(),value=await TrainingService.completeAssignment(f.db,foreignId);
 assert.equal(value.isFailure,true);assert.equal(f.calls.length,0);
 assert.equal(f.rows[1].status,'assigned');assert.equal(f.rows[1].completedAt,null);assert.throws(()=>value.data);
});
test('a valid completion uses one tenant-filtered write through the module relation',async()=>{
 const f=fixture(),value=await TrainingService.completeAssignment(f.db,tenant,ownId);
 assert.equal(value.isSuccess,true);assert.equal(f.calls.length,1);
 assert.deepEqual(f.calls[0].where,{id:ownId,module:{tenantId:tenant}});
 assert.equal(f.calls[0].data.status,'completed');assert.ok(f.calls[0].data.completedAt instanceof Date);
 assert.ok(Number.isFinite(f.calls[0].data.completedAt.getTime()));assert.equal(value.data.status,'completed');
 assert.equal(f.rows[1].status,'assigned');
});
test('a foreign assignment is denied without changing either tenant record',async()=>{
 const f=fixture(),value=await TrainingService.completeAssignment(f.db,tenant,foreignId);
 assert.equal(value.isFailure,true);assert.deepEqual(f.calls.map(q=>q.where),[{id:foreignId,module:{tenantId:tenant}}]);
 assert.ok(f.rows.every(r=>r.status==='assigned'&&r.completedAt===null));
});
test('missing, blank and non-string tenant or assignment IDs fail before any Prisma access',async()=>{
 for(const invalid of [undefined,null,'','   ','\t\n',0,1,{},[],{in:[tenant]}]){
  for(const args of [[invalid,ownId],[tenant,invalid]]){
   const f=fixture(),value=await TrainingService.completeAssignment(f.db,...args);
   assert.equal(value.isFailure,true);assert.equal(f.calls.length,0);assert.ok(f.rows.every(r=>r.status==='assigned'));
  }
 }
});
test('ownership at the write boundary is required without a stale separate lookup',async()=>{
 const f=fixture({onUpdate:rows=>{rows[0].module.tenantId=foreignTenant;}}),value=await TrainingService.completeAssignment(f.db,tenant,ownId);
 assert.equal(value.isFailure,true);assert.deepEqual(f.calls.map(q=>q.where),[{id:ownId,module:{tenantId:tenant}}]);
 assert.equal(f.rows[0].status,'assigned');assert.equal(f.rows[0].completedAt,null);
});
test('missing records and database errors remain failed Results without fallback writes',async()=>{
 const f=fixture(),missing=await TrainingService.completeAssignment(f.db,tenant,'missing-assignment');
 assert.equal(missing.isFailure,true);assert.equal(f.calls.length,1);
 const broken=fixture({error:Error('Synthetic completion outage')}),value=await TrainingService.completeAssignment(broken.db,tenant,ownId);
 assert.equal(value.isFailure,true);assert.equal(value.error,'Synthetic completion outage');assert.equal(broken.calls.length,1);
 assert.ok(broken.rows.every(r=>r.status==='assigned'&&r.completedAt===null));
});
