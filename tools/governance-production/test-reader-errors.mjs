import {test} from 'node:test';
import assert from 'node:assert/strict';
import {spawnSync} from 'node:child_process';
import {mkdtemp,writeFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {pathToFileURL,fileURLToPath} from 'node:url';
import {GovernanceReaderFault,safeReaderErrorCode} from './reader-errors.mjs';
const bridge=fileURLToPath(new URL('./read-bridge.mjs',import.meta.url));
const secret='fixture-PRIVATE-user-password';
function isolatedEnv(extra={}){const env={...process.env,...extra};delete env.GOVERNANCE_DATABASE_URL;delete env.PRODUCTION_DATABASE_URL;delete env.GOVERNANCE_ALLOW_TEST_FIXTURE;delete env.NODE_OPTIONS;return {...env,...extra};}
function receipt(args,env,input=''){
 const result=spawnSync(process.execPath,args,{env,input,encoding:'utf8',timeout:10000});assert.equal(result.error,undefined);assert.equal(result.signal,null);assert.doesNotMatch(result.stdout+result.stderr,new RegExp(secret));
 return {status:result.status,rows:result.stdout.trim().split('\n').filter(Boolean).map(line=>JSON.parse(line)),stderr:result.stderr};
}
test('reader diagnostics allow known codes but never arbitrary provider codes, names or messages',()=>{
 assert.equal(safeReaderErrorCode(new GovernanceReaderFault('MANIFEST_MISMATCH')),'MANIFEST_MISMATCH');
 for(const code of ['28P01','42501','53300','ETIMEDOUT','ECONNRESET'])assert.equal(safeReaderErrorCode({code,message:secret}),code);
 for(const error of [null,{},Error(secret),{code:secret,name:secret,message:secret},{code:'ALICE'},{code:'error'}])assert.equal(safeReaderErrorCode(error),'unavailable');
 assert.throws(()=>new GovernanceReaderFault(secret));
});
test('Prisma plan restriction has a safe specific diagnostic even with generic provider code',()=>{
 assert.equal(safeReaderErrorCode({code:'error',message:secret+' Project restriction: {"error":"planLimitReached"}'}),'planLimitReached');
 assert.equal(safeReaderErrorCode({message:'notplanLimitReachedSuffix '+secret}),'unavailable');
 assert.equal(safeReaderErrorCode({message:'x'.repeat(8192)+'planLimitReached'}),'unavailable');
});
test('missing, malformed, conflicting and unexpected database targets fail before any connection',()=>{
 const url='postgres://user:'+secret+'@pooled.db.prisma.io/postgres';
 for(const [env,code] of [[{},'MISSING_DATABASE_URL'],[{PRODUCTION_DATABASE_URL:'malformed '+secret},'INVALID_DATABASE_URL'],[{GOVERNANCE_DATABASE_URL:url,PRODUCTION_DATABASE_URL:url+'?conflict=1'},'CONFLICTING_DATABASE_URLS'],[{PRODUCTION_DATABASE_URL:'postgres://user:'+secret+'@127.0.0.1/other'},'UNEXPECTED_DATABASE_TARGET']]){
  const r=receipt([bridge],isolatedEnv(env));assert.equal(r.status,1);assert.deepEqual(r.rows,[{ready:false,phase:'configuration',code}]);assert.equal(r.stderr,'');
 }
});
test('fixture mode remains explicit and cannot bypass the production target with a flag alone',()=>{
 const r=receipt([bridge,'--fixture','never-read.json'],isolatedEnv());assert.equal(r.status,1);assert.deepEqual(r.rows,[{ready:false,phase:'configuration',code:'FIXTURE_NOT_AUTHORIZED'}]);
});
test('isolated pg driver faults preserve connection phase, read-only snapshot and manifest pin checks',async()=>{
 const dir=await mkdtemp(join(tmpdir(),'governance-reader-fault-'));
 try{
  const stub=join(dir,'pg-stub.mjs'),loader=join(dir,'loader.mjs');
  await writeFile(stub,`import {readFileSync} from 'node:fs';
const pin=JSON.parse(readFileSync(${JSON.stringify(fileURLToPath(new URL('./production-pin.json',import.meta.url)))},'utf8'));
class Client {stage=0;async connect(){if(process.env.FAULT_MODE==='plan')throw Object.assign(Error('${secret} planLimitReached'),{code:'error'});if(process.env.FAULT_MODE==='auth')throw Object.assign(Error('${secret}'),{code:'28P01'});}
async query(query){if(query==='BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY'&&this.stage===0){this.stage=1;return {};}if(query==="SET LOCAL statement_timeout='120s'"&&this.stage===1){this.stage=2;return {};}if(query==='ROLLBACK')return {};if(this.stage===2&&typeof query==='string'&&query.startsWith('SELECT manifest_sha256,manifest'))return {rows:[{manifest_sha256:process.env.FAULT_MODE==='manifest'?'wrong':pin.manifestSha256,manifest:{tables:[],sqlite_objects:[]}}]};throw Object.assign(Error('${secret}'),{code:'42501'});}async end(){}}
export default {Client};`);
  await writeFile(loader,`import {registerHooks} from 'node:module';registerHooks({resolve(specifier,context,next){if(specifier==='pg')return {url:${JSON.stringify(pathToFileURL(stub).href)},shortCircuit:true};return next(specifier,context);}});`);
  for(const [mode,phase,code] of [['plan','connection','planLimitReached'],['auth','connection','28P01'],['manifest','manifest-validation','MANIFEST_MISMATCH']]){
   const r=receipt(['--import',loader,bridge],isolatedEnv({PRODUCTION_DATABASE_URL:'postgres://user:'+secret+'@pooled.db.prisma.io/postgres',FAULT_MODE:mode}));assert.equal(r.status,1);assert.deepEqual(r.rows,[{ready:false,phase,code}]);assert.equal(r.stderr,'');
  }
  const r=receipt(['--import',loader,bridge],isolatedEnv({PRODUCTION_DATABASE_URL:'postgres://user:'+secret+'@pooled.db.prisma.io/postgres',FAULT_MODE:'read'}),JSON.stringify({op:'query',sql:'SELECT no_business_access',parameters:[]})+'\n');
  assert.equal(r.rows[0].ready,true);assert.deepEqual(r.rows[1],{ok:false,code:'42501'});assert.equal(r.rows.length,2);
 }finally{await rm(dir,{recursive:true,force:true});}
});
