import {test} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp,readFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
import {build} from 'esbuild';

const require=createRequire(import.meta.url),dir=await mkdtemp(join(tmpdir(),'care-roster-'));
await build({entryPoints:['cloudflare/workers/src/care/repository.ts'],bundle:true,platform:'node',format:'cjs',outfile:join(dir,'repository.cjs')});
const {CareRepository}=require(join(dir,'repository.cjs'));
const adapter=process.env.PLATFORM_TEST_ADAPTER,connection=process.env.CARE_TEST_DATABASE_URL||(adapter?'postgres://local/test':null);if(!connection)throw Error('Set CARE_TEST_DATABASE_URL or PLATFORM_TEST_ADAPTER');
const {Client}=require(adapter||'pg'),db=new Client({connectionString:connection}),schema='care_roster_'+Date.now();await db.connect();await db.query(`CREATE SCHEMA ${schema};SET search_path TO ${schema}`);
try{
 await db.query(`CREATE TABLE users(id text PRIMARY KEY,tenant_id text,email text,roles text,status text);CREATE TABLE provider_profiles(id text,user_id text,tenant_id text,is_approved boolean,has_completed_induction boolean,is_locked_for_retraining boolean);CREATE TABLE care_staff_clearances(tenant_id text,staff_id text,version integer,status text,staff_role text,expires_on date,registration text,evidence text,reviewer_id text);`);
 await db.query(`INSERT INTO users SELECT 'staff-'||n,'tenant','a'||lpad(n::text,3,'0')||'@example.test','psw','active' FROM generate_series(1,205)n;INSERT INTO users VALUES('target','tenant','zebra%_!@example.test','rn','active'),('foreign','other','zebra%_!@example.test','rn','active'),('inactive','tenant','zebra%_!@example.test','rn','inactive');`);
 const repo=new CareRepository(db,{id:'scheduler',tenant_id:'tenant',roles:'scheduler'});
 await test('staff search reaches beyond initial roster and preserves tenant/activity scope',async()=>{
  const initial=await repo.staff(null);assert.equal(initial.length,201);assert.ok(!initial.some(p=>p.id==='target'));
  const rows=await repo.staff(null,false,'zEbRa');assert.deepEqual(rows.map(p=>p.id),['target']);
  assert.deepEqual((await repo.staff(null,false,'staff-205')).map(p=>p.id),['staff-205']);
 });
 await test('staff search treats SQL wildcard characters as literal text',async()=>{
  for(const value of ['%','_','!','%_!'])assert.deepEqual((await repo.staff(null,false,value)).map(p=>p.id),['target']);
  assert.deepEqual(await repo.staff(null,false,"' OR TRUE --"),[]);
 });
 await test('explicit staff scope cannot be expanded by matching another employee',async()=>{
  assert.deepEqual(await repo.staff(['staff-1'],false,'Zebra'),[]);
  assert.equal((await repo.staff(['staff-1']))[0].id,'staff-1');
 });
 await test('governed search controls and all translations exist',async()=>{
  const seed=JSON.parse(await readFile('docs/care/seed.json','utf8'));
  for(const lang of ['en','fr','es'])for(const key of ['roster_title','roster_search','roster_submit','roster_search_help'])assert.ok(seed.locales[lang][key]);
  assert.equal(seed.contracts[0].request.properties.rosterQuery.maxLength,100);
  for(const key of ['care-roster-search-form','care-roster-search','care-roster-search-save'])assert.ok(seed.controls[key]);
 });
}finally{await db.query('SET search_path TO public');await db.query(`DROP SCHEMA ${schema} CASCADE`);await db.end();}
