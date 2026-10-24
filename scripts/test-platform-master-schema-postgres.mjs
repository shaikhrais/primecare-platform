import pg from 'pg';
import assert from 'node:assert/strict';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {createHash,randomUUID} from 'node:crypto';
import {platformMasterTables,platformMasterSchemaProfile,platformMasterMigrationBody} from './platform-master-schema-profile.mjs';
const connection=process.env.PLATFORM_SCHEMA_TEST_DATABASE_URL;
const target=new URL(connection||'https://invalid');
if(!['localhost','127.0.0.1'].includes(target.hostname)||target.pathname!=='/platform_schema_test')throw Error('Isolated platform schema fixture required');
const sql=await readFile('packages/database/migrations/20261011_platform_administration.sql','utf8'),body=platformMasterMigrationBody(sql);
const profiles={};const db=new pg.Client({connectionString:connection});await db.connect();
try{
 for(const tenantType of ['uuid','text'])for(const actorType of ['uuid','text']){
  const schema='platform_schema_'+randomUUID().replaceAll('-','');await db.query('CREATE SCHEMA '+schema);
  try{
   await db.query('SET search_path TO '+schema);
   await db.query('CREATE TABLE tenants(id '+tenantType+' PRIMARY KEY); CREATE TABLE users(id '+actorType+' PRIMARY KEY)');
   await db.query('BEGIN');await db.query(body);
   const profile={};for(const table of platformMasterTables){profile[table]=await platformMasterSchemaProfile(db,schema,table);assert.ok(profile[table].columns.length>0);assert.ok(profile[table].constraints.some(c=>c.type==='p'));}
   await db.query('ROLLBACK');
   for(const table of platformMasterTables)assert.equal((await db.query('SELECT to_regclass($1)::text AS name',[schema+'.'+table])).rows[0].name,null);
   for(let repeat=0;repeat<2;repeat++){
    await db.query('BEGIN');await db.query(body);
    for(const table of platformMasterTables)assert.deepEqual(await platformMasterSchemaProfile(db,schema,table),profile[table]);
    await db.query('COMMIT');
   }
   const tenant=randomUUID(),actor=randomUUID();await db.query('INSERT INTO tenants VALUES($1)',[tenant]);await db.query('INSERT INTO users VALUES($1)',[actor]);
   const record=(await db.query("INSERT INTO platform_master_records(tenant_id,type,code,label) VALUES($1,'department','hr','Human resources') RETURNING id,status,version",[tenant])).rows[0];
   assert.equal(record.status,'active');assert.equal(record.version,1);
   await assert.rejects(db.query("INSERT INTO platform_master_records(tenant_id,type,code,label) VALUES($1,'department','hr','Duplicate')",[tenant]),e=>e.code==='23505');
   await assert.rejects(db.query("INSERT INTO platform_master_records(tenant_id,type,code,label) VALUES($1,'department','other','Foreign')",[randomUUID()]),e=>e.code==='23503');
   await db.query("INSERT INTO platform_administration_audit(actor_id,tenant_id,target_id,action,previous_state,current_state) VALUES($1,$2,$3,'master_created','{}','{}')",[actor,tenant,record.id]);
   assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM platform_administration_audit')).rows[0].n,1);
   profiles[tenantType+':'+actorType]=profile;
  }finally{await db.query('ROLLBACK');await db.query('SET search_path TO public');await db.query('DROP SCHEMA '+schema+' CASCADE');}
 }
 const report={version:1,source:process.env.GITHUB_SHA,migrationSha256:createHash('sha256').update(sql).digest('hex'),nativePostgres:true,profiles};
 await mkdir('test-results/platform-master-schema',{recursive:true});await writeFile('test-results/platform-master-schema/manifest.json',JSON.stringify(report,null,2)+'\n');
 console.log('PLATFORM_MASTER_NATIVE_SCHEMA '+JSON.stringify({identityProfiles:Object.keys(profiles),dryRunRollback:true,idempotent:true,foreignKeys:true,uniqueDepartmentCodes:true,production:false}));
}finally{await db.end();}
