import {test} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
import {build} from 'esbuild';

const require=createRequire(import.meta.url),dir=await mkdtemp(join(tmpdir(),'care-visit-picker-'));
await build({entryPoints:['cloudflare/workers/src/care/visit-picker.ts'],bundle:true,platform:'node',format:'cjs',outfile:join(dir,'picker.cjs')});
const {visitPicker}=require(join(dir,'picker.cjs'));
const adapter=process.env.PLATFORM_TEST_ADAPTER,connection=process.env.CARE_TEST_DATABASE_URL||(adapter?'postgres://local/test':null);if(!connection)throw Error('Set CARE_TEST_DATABASE_URL or PLATFORM_TEST_ADAPTER');
const {Client}=require(adapter||'pg');
for(const identity of ['text','uuid']){
 const db=new Client({connectionString:connection}),schema='care_picker_'+identity+'_'+Date.now(),id=label=>identity==='uuid'?crypto.randomUUID():label,tenant=id('tenant'),foreign=id('foreign'),client=id('client'),foreignClient=id('foreign-client'),inactive=id('inactive-client'),user=id('user'),foreignUser=id('foreign-user'),inactiveUser=id('inactive-user');
 const repo={db,actor:{id:id('scheduler'),tenant_id:tenant,roles:'scheduler'}};
 await db.connect();await db.query(`CREATE SCHEMA ${schema};SET search_path TO ${schema}`);
 try{
  await db.query(`CREATE TABLE users(id ${identity},tenant_id ${identity},status text);CREATE TABLE client_profiles(id ${identity},tenant_id ${identity},user_id ${identity},full_name text);CREATE TABLE visits(id ${identity},tenant_id ${identity},client_id ${identity},status text,requested_start_at timestamptz);CREATE TABLE care_cases(tenant_id ${identity},visit_id ${identity});`);
  await db.query("INSERT INTO users VALUES($1,$2,'active'),($3,$4,'active'),($5,$2,'inactive')",[user,tenant,foreignUser,foreign,inactiveUser]);
  await db.query("INSERT INTO client_profiles VALUES($1,$2,$3,'Synthetic%_! Client'),($4,$5,$6,'Foreign Client'),($7,$2,$8,'Inactive Client')",[client,tenant,user,foreignClient,foreign,foreignUser,inactive,inactiveUser]);
  const expected=[];for(let n=0;n<106;n++){const visit=id('visit-'+String(n).padStart(3,'0'));expected.push(visit);await db.query("INSERT INTO visits VALUES($1,$2,$3,'requested','2027-01-01T12:00Z')",[visit,tenant,client]);}
  for(const [visit,scope,c,status] of [[id('other-visit'),foreign,foreignClient,'requested'],[id('inactive-visit'),tenant,inactive,'requested'],[id('cancelled'),tenant,client,'cancelled'],[id('rejected'),tenant,client,'rejected'],[id('completed'),tenant,client,'completed']])await db.query("INSERT INTO visits VALUES($1,$2,$3,$4,'2027-01-01T12:00Z')",[visit,scope,c,status]);
  await db.query('INSERT INTO care_cases VALUES($1,$2)',[tenant,expected[0]]);const eligible=expected.slice(1).sort();
  await test(`${identity}: unassigned visit paging reaches beyond 100 with stable ordering`,async()=>{
   const found=[];for(let offset=0;offset<105;offset+=25){const page=await visitPicker(repo,offset);assert.equal(page.total,105);assert.equal(page.limit,25);assert.equal(page.offset,offset);found.push(...page.records.map(r=>r.id));}
   assert.deepEqual(found,eligible);assert.equal(new Set(found).size,105);assert.equal((await visitPicker(repo,999)).records.length,0);
  });
  await test(`${identity}: visit search is literal, case-insensitive and applied before paging`,async()=>{
   assert.equal((await visitPicker(repo,100,'sYnThEtIc%_!')).records.length,5);
   for(const q of ['%','_','!'])assert.equal((await visitPicker(repo,0,q)).total,105);
   const page=await visitPicker(repo,0,eligible[104]);assert.deepEqual(page.records.map(r=>r.id),[eligible[104]]);assert.equal(page.total,1);
   assert.equal((await visitPicker(repo,0,"' OR TRUE --")).total,0);
  });
  await test(`${identity}: appointment selector excludes foreign, inactive, terminal and already-assigned visits`,async()=>{
   assert.equal((await visitPicker(repo,0,'Foreign')).total,0);assert.equal((await visitPicker(repo,0,'Inactive')).total,0);assert.equal((await visitPicker(repo,0,expected[0])).total,0);
   assert.ok((await visitPicker(repo)).records.every(r=>Object.keys(r).sort().join(',')==='full_name,id,requested_start_at'));
  });
  await test(`${identity}: recurring sources page beyond 100 and require active service and skills`,async()=>{
   const service=id('service'),disabled=id('disabled');await db.query(`CREATE TABLE services(id ${identity},tenant_id ${identity},is_active boolean);ALTER TABLE visits ADD COLUMN service_id ${identity};ALTER TABLE visits ADD COLUMN required_skills text;`);
   await db.query('INSERT INTO services VALUES($1,$2,TRUE),($3,$2,FALSE)',[service,tenant,disabled]);await db.query("UPDATE visits SET service_id=$1,required_skills='Synthetic support skills'",[service]);
   let page=await visitPicker(repo,100,'Synthetic','recurring');assert.equal(page.total,107);assert.equal(page.records.length,7);
   // Completed and already-assigned appointments are valid sources, unlike the assignment picker.
   assert.equal((await visitPicker(repo,0,expected[0],'recurring')).total,1);
   await db.query('UPDATE visits SET service_id=$1 WHERE id=$2',[disabled,expected[1]]);await db.query("UPDATE visits SET required_skills='   ' WHERE id=$1",[expected[2]]);
   page=await visitPicker(repo,100,'Synthetic','recurring');assert.equal(page.total,105);assert.equal(page.records.length,5);
   for(const query of ['%','_','!'])assert.equal((await visitPicker(repo,0,query,'recurring')).total,105);
   assert.equal((await visitPicker(repo,0,'Foreign','recurring')).total,0);
   const result=await visitPicker({actor:{...repo.actor,roles:'psw'},db:{query(){throw Error('No source query permitted');}}},0,'Synthetic','recurring');assert.equal(result.total,0);
  });
  await test(`${identity}: support staff receive no appointment metadata and trigger no appointment query`,async()=>{
   let calls=0;const result=await visitPicker({actor:{...repo.actor,roles:'psw'},db:{query(){calls++;throw Error('Must not query appointments');}}},100,'Synthetic');
   assert.deepEqual(result,{records:[],total:0,offset:0,limit:25,query:''});assert.equal(calls,0);
  });
 }finally{await db.query('SET search_path TO public');await db.query(`DROP SCHEMA ${schema} CASCADE`);await db.end();}
}
