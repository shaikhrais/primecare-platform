import {test} from 'node:test';
import assert from 'node:assert/strict';
import pg from 'pg';
import {randomUUID} from 'node:crypto';
import {bootstrapControlTenant,resolveCodeAdminControlTenant,rootPolicy} from './bootstrap-code-admin-control-tenant.mjs';
const url=process.env.CODE_ADMIN_ROOT_TEST_DATABASE_URL;if(!url)throw Error('Isolated PostgreSQL URL required');
for(const type of ['uuid','text'])test('control tenant transaction, collisions, attribution and recovery: '+type,async()=>{
 const schema='control_'+randomUUID().replaceAll('-','');const db=new pg.Client({connectionString:url});await db.connect();
 const options={policySchema:schema,tenantSchema:schema,receipt:{runId:'synthetic-run',actor:'synthetic-operator'}};
 const table='"'+schema+'"';const reset=async()=>{await db.query('DELETE FROM '+table+'.tenants');await db.query('UPDATE '+table+'.govt_platform_hierarchy_policy SET definition=$1',[JSON.stringify(rootPolicy)]);};
 await db.query('CREATE SCHEMA '+table);
 try{
  await db.query('CREATE TABLE '+table+'.tenants(id '+type+' PRIMARY KEY,slug text UNIQUE,name text,status text,updated_at timestamptz,created_at timestamptz DEFAULT NOW(),allowed_vpn_ranges text NOT NULL,cors_allowed_origins jsonb NOT NULL,cors_allowed_methods jsonb NOT NULL,cors_allowed_headers jsonb NOT NULL)');
  await db.query('CREATE TABLE '+table+'.govt_platform_hierarchy_policy(id text PRIMARY KEY,definition text NOT NULL)');
  await db.query('INSERT INTO '+table+'.govt_platform_hierarchy_policy VALUES($1,$2)',[rootPolicy.id,JSON.stringify(rootPolicy)]);
  const other=new pg.Client({connectionString:url});await other.connect();
  try{
   const result=await Promise.all([bootstrapControlTenant(db,options),bootstrapControlTenant(other,options)]);assert.equal(result.filter(r=>r.created).length,1);assert.ok(result.every(r=>r.rootTenantBound&&r.accountChanges===0));
  }finally{await other.end();}
  const id=await resolveCodeAdminControlTenant(db,options);assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM '+table+'.tenants')).rows[0].n,1);
  assert.equal((await bootstrapControlTenant(db,options)).created,false);
  assert.deepEqual((await db.query('SELECT allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers FROM '+table+'.tenants')).rows,[{allowed_vpn_ranges:'',cors_allowed_origins:[],cors_allowed_methods:[],cors_allowed_headers:[]}]);
  await db.query('UPDATE '+table+".tenants SET status='inactive' WHERE id::text=$1",[id]);await assert.rejects(resolveCodeAdminControlTenant(db,options),/missing or changed/);await assert.rejects(bootstrapControlTenant(db,options),/missing or changed/);
  await reset();const collision=randomUUID();await db.query('INSERT INTO '+table+".tenants(id,slug,name,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES($1,$2,'Existing tenant','active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)",[collision,rootPolicy.slug]);await assert.rejects(bootstrapControlTenant(db,options),/slug collision/);assert.equal((await db.query('SELECT name FROM '+table+'.tenants')).rows[0].name,'Existing tenant');
  await reset();await db.query('UPDATE '+table+'.govt_platform_hierarchy_policy SET definition=$1',[JSON.stringify({...rootPolicy,name:'Changed'})]);await assert.rejects(bootstrapControlTenant(db,options),/policy drift/);assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM '+table+'.tenants')).rows[0].n,0);
  await reset();await db.query('CREATE FUNCTION '+table+".reject_binding() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'synthetic binding failure'; END $$");await db.query('CREATE TRIGGER reject_binding BEFORE UPDATE ON '+table+'.govt_platform_hierarchy_policy FOR EACH ROW EXECUTE FUNCTION '+table+'.reject_binding()');
  await assert.rejects(bootstrapControlTenant(db,options),/synthetic binding failure/);assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM '+table+'.tenants')).rows[0].n,0);assert.equal(JSON.parse((await db.query('SELECT definition FROM '+table+'.govt_platform_hierarchy_policy')).rows[0].definition).tenantId,null);
  await assert.rejects(bootstrapControlTenant(db,{...options,receipt:null}),/attribution/);
 }finally{await db.query('DROP SCHEMA '+table+' CASCADE');await db.end();}
});
