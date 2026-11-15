import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {stripTypeScriptTypes} from 'node:module';

// Execute the actual service without loading Prisma or a database. PrismaClient
// is a type-only annotation; Result is the real production failure wrapper.
const path='packages/domain/src/services/TrainingService.ts';
const result=stripTypeScriptTypes(readFileSync('packages/domain/src/utils/Result.ts','utf8'),{mode:'transform'});
const resultUrl='data:text/javascript;base64,'+Buffer.from(result).toString('base64');
const source=readFileSync(path,'utf8')
 .replace("import { PrismaClient } from '@primecare/database';","import type { PrismaClient } from '@primecare/database';")
 .replace("from '../utils/Result'","from '"+resultUrl+"'");
const service=stripTypeScriptTypes(source,{mode:'transform'});
const {TrainingService}=await import('data:text/javascript;base64,'+Buffer.from(service).toString('base64'));
const tenant='synthetic-tenant',request={staffName:'Synthetic staff',certName:'Synthetic certificate'};
const future=new Date('2099-01-01T00:00:00Z'),past=new Date('2000-01-01T00:00:00Z');
async function verify({status='Compliant',expiresAt=future,missing=false,error}={}){
 const calls=[];
 const db={certificationNode:{findFirst:async query=>{
  calls.push(query);if(error)throw error;
  return missing?null:{id:'synthetic-cert',tenantId:tenant,...request,status,expiresAt};
 }}};
 const value=await TrainingService.verifyCertificate(db,tenant,request);
 assert.deepEqual(calls,[{where:{tenantId:tenant,staffName:{contains:request.staffName,mode:'insensitive'},certName:{contains:request.certName,mode:'insensitive'}}}]);
 return value;
}
test('an explicitly Expired stored certificate stays unverified despite a future date',async()=>{
 const value=await verify({status:'Expired'});assert.equal(value.isSuccess,true);assert.equal(value.data.verified,false);assert.equal(value.data.status,'Expired');
});
test('a malformed required expiry fails instead of verifying a certificate',async()=>{
 const value=await verify({expiresAt:new Date('invalid')});assert.equal(value.isFailure,true);assert.throws(()=>value.data,/Cannot access data/);
});
test('missing required expiry fails instead of being accepted as perpetual',async()=>{
 for(const expiresAt of [null,undefined,'2099-01-01T00:00:00Z']){
  // Pass undefined explicitly as a record value rather than triggering the fixture default.
  const db={certificationNode:{findFirst:async()=>({...request,status:'Compliant',expiresAt})}};
  const value=await TrainingService.verifyCertificate(db,tenant,request);assert.equal(value.isFailure,true);assert.throws(()=>value.data);
 }
});
test('the exact expiry instant is no longer valid',async()=>{
 const originalNow=Date.now,instant=new Date('2030-01-01T00:00:00Z');
 try{Date.now=()=>instant.getTime();const value=await verify({expiresAt:instant});assert.equal(value.data.verified,false);}
 finally{Date.now=originalNow;}
});
test('the existing Compliant and Expiring states retain future-date validity',async()=>{
 for(const status of ['Compliant','Expiring']){const value=await verify({status});assert.equal(value.isSuccess,true);assert.equal(value.data.verified,true);assert.equal(value.data.status,status);assert.equal(value.data.expiresAt,future);}
});
test('past expiry, missing certificate and database failures retain failure boundaries',async()=>{
 const expired=await verify({expiresAt:past});assert.equal(expired.data.verified,false);
 const missing=await verify({missing:true});assert.equal(missing.data.verified,false);
 const failed=await verify({error:Error('Synthetic database outage')});assert.equal(failed.isFailure,true);assert.equal(failed.error,'Synthetic database outage');
});
