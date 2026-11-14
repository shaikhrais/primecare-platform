import {readFile} from 'node:fs/promises';import {PGlite} from '@electric-sql/pglite';import pg from 'pg';
import {migrateHelpSchema} from '../tools/governance-production/pc10-help-schema.mjs';
export const pin=JSON.parse(await readFile(new URL('../tools/governance-production/production-pin.json',import.meta.url)));
export const contract=JSON.parse(await readFile(new URL('../tools/governance-production/pc10-help-reader-contract.json',import.meta.url)));
export const table=n=>'"'+pin.schema+'"."'+pin.tablePrefix+n+'"';
export async function helpFixture(){
 let db;if(process.env.HELP_SERVICE_TEST_DATABASE_URL){
  const u=new URL(process.env.HELP_SERVICE_TEST_DATABASE_URL);if(u.hostname!=='127.0.0.1'||u.pathname!=='/help_service'||process.env.PRODUCTION_DATABASE_URL)throw Error('Isolated Help service fixture only');
  const c=new pg.Client({connectionString:u.toString()});await c.connect();db={query:(...a)=>c.query(...a),exec:s=>c.query(s),close:()=>c.end()};
  await db.exec('DROP SCHEMA public CASCADE;CREATE SCHEMA public;DROP SCHEMA IF EXISTS "'+pin.schema+'" CASCADE');
 }else db=new PGlite();
 await db.exec('CREATE SCHEMA "'+pin.schema+'";CREATE TABLE '+table('source_manifest')+'(manifest_sha256 text);CREATE TABLE public.tenants(id text PRIMARY KEY,status text);CREATE TABLE public.users(id text PRIMARY KEY,tenant_id text,roles text,status text);CREATE TABLE public.auth_sessions(token_hash text PRIMARY KEY,user_id text,expires_at timestamptz);CREATE TABLE public.faqs(id text PRIMARY KEY,question text NOT NULL,answer text NOT NULL,category text NOT NULL,created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,updated_at timestamp NOT NULL);CREATE TABLE public.test_help_quota(user_id text PRIMARY KEY,n int);CREATE TABLE public.test_help_audit(user_id text,tenant_id text,action text,locale text,returned int)');
 await db.query('INSERT INTO '+table('source_manifest')+' VALUES($1)',[pin.manifestSha256]);
 await db.exec("INSERT INTO tenants VALUES('tenant-a','active'),('tenant-b','active');INSERT INTO users VALUES('psw-a','tenant-a','psw','active'),('psw-b','tenant-b','psw','active'),('guest','tenant-a','guest','active');INSERT INTO auth_sessions VALUES(repeat('a',64),'psw-a',now()+interval '1 hour'),(repeat('b',64),'psw-b',now()+interval '1 hour'),(repeat('c',64),'guest',now()+interval '1 hour')");
 await migrateHelpSchema(db,{apply:true});
 await db.exec('CREATE TABLE '+table('api_endpoints')+'(id int PRIMARY KEY,http_method text,route_path text,auth_required int,permission_key text,rate_limit_key text,service_name text,implementation_status text,request_schema text,response_schema text);CREATE TABLE '+table('roles')+'(id int PRIMARY KEY,role_code text,active int);CREATE TABLE '+table('api_permissions')+'(api_id int,role_id int,can_access int,permission_key text);CREATE TABLE '+table('screens')+'(id int PRIMARY KEY,screen_code text,route_path text,active int);CREATE TABLE '+table('role_screen_permissions')+'(screen_id int,role_id int,can_view int);CREATE TABLE '+table('role_screen_map')+'(screen_id int,role_id int,can_view int);CREATE TABLE '+table('screen_api_links')+'(id int,screen_id int,api_id int,purpose text)');
 await db.query('INSERT INTO '+table('api_endpoints')+' VALUES(794,$1,$2,1,$3,$4,$5,$6,$7,$8)',[contract.method,contract.path,contract.permissionKey,contract.rateLimitKey,contract.service,'implemented-unverified',JSON.stringify(contract.requestSchema),JSON.stringify(contract.responseSchema)]);
 await db.exec('INSERT INTO '+table('roles')+" VALUES(51,'psw',1);INSERT INTO "+table('api_permissions')+" VALUES(794,51,1,'unrelated_legacy_key');INSERT INTO "+table('screens')+" VALUES(685,'psw_help_support','/generated/psw-help-support',1);INSERT INTO "+table('screen_api_links')+" VALUES(1,685,794,'Published current-tenant PSW Help guides')");
 const publish=async(id,tenant,locale,title,summary='Summary',body='Reviewed fixture body')=>{
  await db.query("INSERT INTO faqs(id,question,answer,category,updated_at,tenant_id,locale,summary) VALUES($1,$2,$3,'general',now(),$4,$5,$6)",[id,title,body,tenant,locale,summary]);
  await db.query("UPDATE faqs SET publication_state='published',published_at=CURRENT_TIMESTAMP WHERE id=$1",[id]);
 };
 await publish('a-en','tenant-a','en','Guide 100%_\\','Exact %_ literal');await publish('a-fr','tenant-a','fr','Guide français');await publish('a-es','tenant-a','es','Guía');await publish('b-en','tenant-b','en','PRIVATE other tenant');
 await db.exec("INSERT INTO faqs(id,question,answer,category,updated_at) VALUES('legacy','Private legacy','Private answer','general',now());INSERT INTO faqs(id,question,answer,category,updated_at,tenant_id,locale) VALUES('draft','Private draft','Private answer','general',now(),'tenant-a','en')");
 const allow=async()=>{await db.query('UPDATE '+table('api_permissions')+' SET permission_key=$1',[contract.permissionKey]);await db.exec('INSERT INTO '+table('role_screen_permissions')+' VALUES(685,51,1);INSERT INTO '+table('role_screen_map')+' VALUES(685,51,1)');};
 let alive=true;const events=[];
 const effects={isCurrent:()=>alive,consumeQuota:async(actor,key)=>{events.push('quota');if(key!==contract.rateLimitKey)throw Error('Wrong quota key');await db.query('INSERT INTO test_help_quota VALUES($1,1) ON CONFLICT(user_id) DO UPDATE SET n=test_help_quota.n+1',[actor.userId]);},auditRead:async(actor,event)=>{events.push('audit');await db.query('INSERT INTO test_help_audit VALUES($1,$2,$3,$4,$5)',[actor.userId,actor.tenantId,event.action,event.locale,event.returned]);}};
 return{db,allow,publish,effects,events,stale:()=>alive=false,close:()=>db.close()};
}
