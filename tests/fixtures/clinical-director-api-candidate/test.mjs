import {createRequire} from 'node:module';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {test} from 'node:test';

const {PGlite}=createRequire(import.meta.url)(process.env.PGLITE_FIXTURE_MODULE);
const schema=await readFile(new URL('./proposed-schema.sql',import.meta.url),'utf8');
const query=await readFile(new URL('./scoped-bookings-example.sql',import.meta.url),'utf8');
const db=new PGlite();
try {
 await db.exec(`
 CREATE TABLE tenants(id text PRIMARY KEY,status text NOT NULL);
 CREATE TABLE users(id text PRIMARY KEY,tenant_id text REFERENCES tenants(id),roles text,status text);
 CREATE TABLE bookings(id text PRIMARY KEY,tenant_id text REFERENCES tenants(id),branch_id text,start_at timestamptz);
 INSERT INTO tenants VALUES ('tenant-a','active'),('tenant-b','active'),('tenant-c','inactive');
 INSERT INTO users VALUES ('assigned','tenant-a','clinical_director','active'),('no-grant','tenant-a','clinical_director','active'),('revoked','tenant-a','clinical_director','active'),('expired','tenant-a','clinical_director','active'),('future','tenant-a','clinical_director','active'),('wrong-role','tenant-a','therapist','active'),('disabled','tenant-a','clinical_director','inactive'),('foreign','tenant-b','clinical_director','active'),('inactive-tenant','tenant-c','clinical_director','active'),('empty','tenant-a','clinical_director','active');
 INSERT INTO bookings VALUES ('included','tenant-a','east','2026-11-18T18:00Z'),('unassigned-branch','tenant-a','west','2026-11-18T18:00Z'),('other-tenant','tenant-b','east','2026-11-18T18:00Z'),('unscoped-booking','tenant-a',null,'2026-11-18T18:00Z'),('end-exclusive','tenant-a','east','2026-11-19T00:00Z'),('start-inclusive','tenant-a','east','2026-11-18T00:00Z');
 `);
 await db.exec(schema);
 await db.exec(`
 INSERT INTO clinical_dashboard_branches VALUES ('tenant-a','east'),('tenant-a','west'),('tenant-a','none'),('tenant-b','east'),('tenant-c','east');
 INSERT INTO clinical_director_branch_assignments
 SELECT CASE id WHEN 'inactive-tenant' THEN 'tenant-c' ELSE 'tenant-a' END,CASE id WHEN 'empty' THEN 'none' ELSE 'east' END,id,
   CASE id WHEN 'future' THEN CURRENT_TIMESTAMP + interval '1 day' ELSE CURRENT_TIMESTAMP - interval '2 days' END,
   CASE id WHEN 'expired' THEN CURRENT_TIMESTAMP - interval '1 day' ELSE CURRENT_TIMESTAMP + interval '2 days' END,
   CASE id WHEN 'revoked' THEN CURRENT_TIMESTAMP ELSE NULL END
 FROM users WHERE id<>'no-grant';
 INSERT INTO clinical_director_branch_assignments VALUES ('tenant-a','east','assigned',CURRENT_TIMESTAMP - interval '1 day',CURRENT_TIMESTAMP + interval '2 days',NULL);
 `);
 const read=async(tenant,user)=>(await db.query(query,[tenant,user,'2026-11-18T00:00Z','2026-11-19T00:00Z'])).rows;
 await test('projects only counts for the assigned branch and tenant, within the reporting window',async()=>assert.deepEqual(await read('tenant-a','assigned'),[{booking_count:2}]));
 for (const user of ['no-grant','revoked','expired','future','wrong-role','disabled','foreign']) await test(`denies ${user}`,async()=>assert.deepEqual(await read('tenant-a',user),[]));
 await test('prevents tenant selection by an otherwise assigned user',async()=>assert.deepEqual(await read('tenant-b','assigned'),[]));
 await test('inactive tenant cannot return counts',async()=>assert.deepEqual(await read('tenant-c','inactive-tenant'),[]));
 await test('authorized branch with no bookings returns measured zero',async()=>assert.deepEqual(await read('tenant-a','empty'),[{booking_count:0}]));
 await test('revocation changes the very next read',async()=>{
  await db.exec("UPDATE clinical_director_branch_assignments SET revoked_at=CURRENT_TIMESTAMP WHERE director_user_id='assigned'");
  assert.deepEqual(await read('tenant-a','assigned'),[]);
 });
} finally {await db.close();}
