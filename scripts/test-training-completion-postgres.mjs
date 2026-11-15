import {test,before,after,beforeEach} from 'node:test';
import assert from 'node:assert/strict';
import {readFile,mkdtemp,writeFile,symlink,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {dirname,join} from 'node:path';
import {createRequire,stripTypeScriptTypes} from 'node:module';
import {pathToFileURL} from 'node:url';
import {execFile} from 'node:child_process';
import {promisify} from 'node:util';

const root=new URL('../',import.meta.url),require=createRequire(import.meta.url),execute=promisify(execFile);

export function validateTrainingCompletionFixtureEnvironment(env){
 const forbidden=Object.keys(env).some(name=>
  ['PRODUCTION_DATABASE_URL','GOVERNANCE_DATABASE_URL','DATABASE_URL','DB_URL','DIRECT_URL'].includes(name.toUpperCase())||
  (/(?:PRODUCTION|GOVERNANCE)/i.test(name)&&/(?:DATABASE|DB).*URL|URL.*(?:DATABASE|DB)/i.test(name)));
 if(forbidden)throw Error('Production or governance database markers are forbidden in the training fixture.');
 let url;try{url=new URL(env.TRAINING_TEST_DATABASE_URL??'');}catch{throw Error('Explicit isolated training PostgreSQL URL required.');}
 if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='127.0.0.1'||
    url.pathname!=='/training_completion_test'||(url.port!==''&&url.port!=='5432')||url.search||url.hash){
  throw Error('Explicit localhost training_completion_test PostgreSQL URL required.');
 }
 return url.toString();
}

async function actualTrainingService(){
 const result=stripTypeScriptTypes(await readFile(new URL('packages/domain/src/utils/Result.ts',root),'utf8'),{mode:'transform'});
 const resultUrl='data:text/javascript;base64,'+Buffer.from(result).toString('base64');
 const source=(await readFile(new URL('packages/domain/src/services/TrainingService.ts',root),'utf8'))
  .replace("import { PrismaClient } from '@primecare/database';","import type { PrismaClient } from '@primecare/database';")
  .replace("from '../utils/Result'","from '"+resultUrl+"'");
 return (await import('data:text/javascript;base64,'+Buffer.from(stripTypeScriptTypes(source,{mode:'transform'})).toString('base64'))).TrainingService;
}

async function prepareClient(connection){
 // No database command or generated fixture runs until the caller has validated
 // the captured URL and rejected every production/governance marker.
 const cliPackage=require.resolve('prisma/package.json'),clientPackage=require.resolve('@prisma/client/package.json');
 for(const path of [cliPackage,clientPackage])if(JSON.parse(await readFile(path,'utf8')).version!=='5.22.0')throw Error('Pinned Prisma and client 5.22.0 are required.');
 const source=await readFile(new URL('packages/database/prisma/schema/06_extensions.prisma',root),'utf8');
 const models=['TrainingModule','TrainingAssignment'].map(name=>{
  const matches=[...source.matchAll(new RegExp('model '+name+' \\{[\\s\\S]*?\\n\\}','g'))];
  if(matches.length!==1)throw Error('Actual training model fixture source is ambiguous.');return matches[0][0];
 }).join('\n\n');
 const dir=await mkdtemp(join(tmpdir(),'training-completion-postgres-'));
 try{
  await writeFile(join(dir,'package.json'),JSON.stringify({private:true,dependencies:{prisma:'5.22.0','@prisma/client':'5.22.0'}}));
  await symlink(dirname(dirname(cliPackage)),join(dir,'node_modules'),process.platform==='win32'?'junction':'dir');
  const schema='generator client {\n provider = "prisma-client-js"\n output = "./client"\n}\n'+
   'datasource db {\n provider = "postgresql"\n url = env("TRAINING_TEST_DATABASE_URL")\n}\n'+
   '// Minimal synthetic parent; training models below are copied verbatim from the repository.\n'+
   'model Tenant {\n id String @id\n trainingModules TrainingModule[]\n}\n'+models+'\n';
  const schemaPath=join(dir,'schema.prisma');await writeFile(schemaPath,schema);
  const env={TRAINING_TEST_DATABASE_URL:connection,PRISMA_GENERATE_SKIP_AUTOINSTALL:'1'};
  for(const name of ['PATH','HOME','TMPDIR','TEMP','SystemRoot','HTTP_PROXY','HTTPS_PROXY','ALL_PROXY','NO_PROXY','NODE_EXTRA_CA_CERTS','SSL_CERT_FILE','SSL_CERT_DIR'])if(process.env[name]!==undefined)env[name]=process.env[name];
  const cli=join(dirname(cliPackage),'build','index.js');
  for(const args of [['generate','--schema',schemaPath],['db','push','--force-reset','--accept-data-loss','--skip-generate','--schema',schemaPath]]){
   try{await execute(process.execPath,[cli,...args],{cwd:dir,env,timeout:120000,maxBuffer:1024*1024});}
   catch{throw Error('Isolated training fixture Prisma '+args[0]+' failed.');}
  }
  const generated=await import(pathToFileURL(join(dir,'client','index.js')).href);
  if(generated.Prisma.prismaVersion.client!=='5.22.0')throw Error('Generated training client version differs.');
  return {dir,PrismaClient:generated.PrismaClient};
 }catch(error){await rm(dir,{recursive:true,force:true});throw error;}
}

function nativeTests(){
 // This executes before CLI resolution, temporary fixture creation or any SQL.
 const connection=validateTrainingCompletionFixtureEnvironment(process.env);
 const tenant='synthetic-training-tenant',otherTenant='synthetic-other-tenant',ownId='owned-assignment',foreignId='foreign-assignment';
 let fixture,prisma,TrainingService,queries=[];
 before(async()=>{
  fixture=await prepareClient(connection);
  prisma=new fixture.PrismaClient({datasources:{db:{url:connection}},log:[{emit:'event',level:'query'}]});
  prisma.$on('query',event=>queries.push(event));await prisma.$connect();
  TrainingService=await actualTrainingService();
 });
 after(async()=>{try{if(prisma)await prisma.$disconnect();}finally{if(fixture)await rm(fixture.dir,{recursive:true,force:true});}});
 beforeEach(async()=>{
  await prisma.trainingAssignment.deleteMany();await prisma.trainingModule.deleteMany();await prisma.tenant.deleteMany();
  await prisma.tenant.createMany({data:[{id:tenant},{id:otherTenant}]});
  await prisma.trainingModule.createMany({data:[{id:'owned-module',tenantId:tenant,title:'Synthetic owned module'},{id:'foreign-module',tenantId:otherTenant,title:'Synthetic foreign module'}]});
  await prisma.trainingAssignment.createMany({data:[{id:ownId,moduleId:'owned-module',status:'assigned'},{id:foreignId,moduleId:'foreign-module',status:'assigned'}]});
  queries=[];
 });
 test('native actual Prisma 5.22 completion updates and independently reads only the owning tenant assignment',async()=>{
  const value=await TrainingService.completeAssignment(prisma,tenant,ownId);
  assert.equal(value.isSuccess,true);assert.equal(value.data.id,ownId);assert.equal(value.data.status,'completed');
  assert.ok(value.data.completedAt instanceof Date);assert.ok(Number.isFinite(value.data.completedAt.getTime()));
  const own=await prisma.trainingAssignment.findUnique({where:{id:ownId}}),foreign=await prisma.trainingAssignment.findUnique({where:{id:foreignId}});
  assert.equal(own.status,'completed');assert.equal(own.completedAt.getTime(),value.data.completedAt.getTime());
  assert.equal(foreign.status,'assigned');assert.equal(foreign.completedAt,null);
 });
 test('native actual Prisma relation filter denies a foreign tenant and preserves its complete stored row',async()=>{
  const before=await prisma.trainingAssignment.findUnique({where:{id:foreignId}});
  const value=await TrainingService.completeAssignment(prisma,tenant,foreignId);
  assert.equal(value.isFailure,true);assert.throws(()=>value.data);
  assert.deepEqual(await prisma.trainingAssignment.findUnique({where:{id:foreignId}}),before);
  assert.equal((await prisma.trainingAssignment.findUnique({where:{id:ownId}})).status,'assigned');
 });
 test('native legacy two-argument call and malformed context are denied before issuing any SQL',async()=>{
  const old=await TrainingService.completeAssignment(prisma,foreignId);assert.equal(old.isFailure,true);assert.equal(queries.length,0);
  for(const value of [undefined,null,'','   ',0,{},[]])for(const args of [[value,ownId],[tenant,value]]){
   const result=await TrainingService.completeAssignment(prisma,...args);assert.equal(result.isFailure,true);assert.equal(queries.length,0);
  }
  assert.equal((await prisma.trainingAssignment.findUnique({where:{id:foreignId}})).status,'assigned');
 });
 test('native missing assignment remains a failed Result with both tenant rows unchanged',async()=>{
  const before=await prisma.trainingAssignment.findMany({orderBy:{id:'asc'}});
  const value=await TrainingService.completeAssignment(prisma,tenant,'missing-assignment');
  assert.equal(value.isFailure,true);assert.throws(()=>value.data);
  assert.deepEqual(await prisma.trainingAssignment.findMany({orderBy:{id:'asc'}}),before);
 });
 test('native real database failure remains an error without a fallback completion',async()=>{
  const before=await prisma.trainingAssignment.findMany({orderBy:{id:'asc'}});
  await prisma.$executeRawUnsafe('ALTER TABLE "training_assignments" ADD CONSTRAINT "synthetic_reject_training_completion" CHECK (status <> \'completed\')');
  try{
   const value=await TrainingService.completeAssignment(prisma,tenant,ownId);
   assert.equal(value.isFailure,true);assert.ok(value.error.length>0);assert.throws(()=>value.data);
  }finally{await prisma.$executeRawUnsafe('ALTER TABLE "training_assignments" DROP CONSTRAINT "synthetic_reject_training_completion"');}
  assert.deepEqual(await prisma.trainingAssignment.findMany({orderBy:{id:'asc'}}),before);
 });
}

if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)nativeTests();
