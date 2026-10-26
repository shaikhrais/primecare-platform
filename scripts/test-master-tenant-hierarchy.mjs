import pg from 'pg';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import {ensureMasterHierarchy} from './master-tenant-hierarchy.mjs';
const url=new URL(process.env.TWILIO_SMS_TEST_DATABASE_URL??'');
if(url.username!=='twilio_fixture'||url.pathname!=='/twilio_sms_test'||!['localhost','127.0.0.1'].includes(url.hostname))throw Error('Disposable local PostgreSQL required');
const db=new pg.Client({connectionString:url.href});await db.connect();
for(const type of ['text','uuid']){
 const ids=Array.from({length:6},()=>randomUUID()),[root,child,owner,client,future,foreign]=ids;let created=false;
 try{
  for(const table of ['tenants','users','platform_master_tenant','tenant_parent_links'])assert.equal((await db.query('SELECT to_regclass($1) AS relation',['public.'+table])).rows[0].relation,null);
  await db.query(`CREATE TABLE public.tenants(id ${type} PRIMARY KEY,status text);CREATE TABLE public.users(id ${type} PRIMARY KEY,tenant_id ${type} REFERENCES public.tenants(id),roles text,status text)`);created=true;
  await db.query("INSERT INTO tenants VALUES($1,'active'),($2,'active'),($3,'active')",[root,child,foreign]);
  await db.query("INSERT INTO users VALUES($1,$2,'code_admin','active'),($3,$4,'patient','active')",[owner,root,client,child]);
  const first=await ensureMasterHierarchy(db,{rootId:root,ownerId:owner,apply:true});assert.equal(first.childTenants,2);assert.equal(first.accountChanges,0);
  assert.deepEqual(await ensureMasterHierarchy(db,{rootId:root,ownerId:owner,apply:true}),first);
  assert.deepEqual(await ensureMasterHierarchy(db,{rootId:root,ownerId:owner}),first);
  await db.query("INSERT INTO tenants VALUES($1,'active')",[future]);assert.equal((await db.query('SELECT parent_tenant_id::text AS parent FROM tenant_parent_links WHERE tenant_id=$1',[future])).rows[0].parent,root);
  await assert.rejects(db.query('INSERT INTO tenant_parent_links VALUES($1,$1)',[root]));
  await assert.rejects(db.query('UPDATE tenant_parent_links SET parent_tenant_id=$1 WHERE tenant_id=$2',[foreign,child]));
  await assert.rejects(ensureMasterHierarchy(db,{rootId:root,ownerId:client,apply:true}),/master_owner_binding_required/);
  assert.equal((await db.query('SELECT tenant_id::text AS tenant FROM users WHERE id=$1',[client])).rows[0].tenant,child);
  await db.query("ALTER TABLE tenants DISABLE TRIGGER primecare_master_parent_insert");
  await assert.rejects(ensureMasterHierarchy(db,{rootId:root,ownerId:owner,apply:true}),/preserve_changed_master_trigger/);
  await db.query('ALTER TABLE tenants ENABLE TRIGGER primecare_master_parent_insert');
  assert.equal((await ensureMasterHierarchy(db,{rootId:root,ownerId:owner})).childTenants,3);
  console.log('MASTER_HIERARCHY_FIXTURE '+JSON.stringify({nativeIdentityType:type,passed:true,idempotent:true,futureChildLinked:true,cyclesAndForeignParentsDenied:true,clientCannotOwnMaster:true,tenantAccountAssignmentsPreserved:true,editedTriggerPreserved:true}));
 }finally{if(created)await db.query('DROP TABLE IF EXISTS public.tenant_parent_links,public.platform_master_tenant,public.users,public.tenants CASCADE;DROP FUNCTION IF EXISTS public.primecare_link_master_tenant()');}
}
await db.end();
