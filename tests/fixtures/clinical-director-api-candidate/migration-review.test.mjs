import {createRequire} from 'node:module';
import {readFile} from 'node:fs/promises';
import assert from 'node:assert/strict';
import {test} from 'node:test';
const {PGlite}=createRequire(import.meta.url)(process.env.PGLITE_FIXTURE_MODULE);
const load=n=>readFile(new URL('./'+n,import.meta.url),'utf8');
const db=new PGlite();
try {
 await db.exec(`
 CREATE TABLE tenants(id text PRIMARY KEY,status text NOT NULL);
 CREATE TABLE users(id text PRIMARY KEY,tenant_id text REFERENCES tenants(id),roles text,status text);
 INSERT INTO tenants VALUES('a','active'),('b','active');
 INSERT INTO users VALUES ('approved','a','tenant_admin','active'),('ordinary','a','tenant_admin','active'),
 ('disabled','a','tenant_admin','inactive'),('other','b','tenant_admin','active'),
 ('wrong-role-admin','a','therapist','active'),
 ('director','a','clinical_director','active'),('foreign','b','clinical_director','active'),
 ('not-director','a','therapist','active');
 `);
 await db.exec(await load('migration-review.sql'));
 const [grantSql,revokeSql]=await Promise.all([load('grant-review.sql'),load('revoke-review.sql')]);
 const grant=(a,b='director',c='east',exp='2099-12-31T00:00Z')=>db.query(grantSql,['a',a,b,c,exp]);
 const revoke=(a,b='director',c='east')=>db.query(revokeSql,['a',a,b,c]);
 const effective=()=>db.query('SELECT director_user_id,branch_id FROM clinical_branch_director_effective_scope');
 await test('migration itself grants nothing and exposes no PUBLIC table privileges',async()=>{
   assert.deepEqual((await effective()).rows,[]);
   const {rows}=await db.query("SELECT table_name FROM information_schema.table_privileges WHERE grantee='PUBLIC' AND table_schema=current_schema() AND table_name LIKE 'clinical_%'");
   assert.deepEqual(rows,[]);
 });
 await db.exec(`
  INSERT INTO clinical_verified_branches VALUES ('a','east','approved-fixture',CURRENT_TIMESTAMP-interval '1 day',NULL),
  ('a','retired','old-fixture',CURRENT_TIMESTAMP-interval '3 days',CURRENT_TIMESTAMP),
  ('b','west','other-fixture',CURRENT_TIMESTAMP-interval '1 day',NULL);
  INSERT INTO clinical_branch_grant_admins VALUES ('a','approved','test approval',TRUE),('a','ordinary','pending',FALSE),('a','disabled','old',TRUE),('a','wrong-role-admin','stale',TRUE),('b','other','tenant b',TRUE);
 `);
 for(const [label,args] of [
 ['ordinary admin',['ordinary']],['disabled identity',['disabled']],['admin role removed',['wrong-role-admin']],
 ['other tenant admin',['other']],['cross-tenant director',['approved','foreign']],['wrong target role',['approved','not-director']],
 ['unverified branch',['approved','director','west']],['retired branch',['approved','director','retired']],
 ['expired grant',['approved','director','east','2020-01-01T00:00Z']],
 ]) await test('denies '+label,async()=>assert.deepEqual((await grant(...args)).rows,[]));
 await test('authorized grant is effective and audited, with duplicate grant rejected',async()=>{
   assert.deepEqual((await grant('approved')).rows,[{action:'grant'}]);
   assert.deepEqual((await effective()).rows,[{director_user_id:'director',branch_id:'east'}]);
   assert.deepEqual((await grant('approved')).rows,[]);
 });
 await test('ordinary admin cannot revoke; an authorized revocation is immediate and audited',async()=>{
   assert.deepEqual((await revoke('ordinary')).rows,[]);
   assert.deepEqual((await revoke('approved')).rows,[{action:'revoke'}]);
   assert.deepEqual((await effective()).rows,[]);
   assert.deepEqual((await db.query('SELECT action FROM clinical_branch_access_audit ORDER BY id')).rows,[{action:'grant'},{action:'revoke'}]);
 });
 await test('audit failure rolls back the assignment rather than granting unaudited access',async()=>{
   await db.exec("ALTER TABLE clinical_branch_access_audit ADD CONSTRAINT reject_fixture_actor CHECK (actor_user_id <> 'approved') NOT VALID");
   await assert.rejects(grant('approved'));
   assert.deepEqual((await effective()).rows,[]);
 });
} finally {await db.close();}
