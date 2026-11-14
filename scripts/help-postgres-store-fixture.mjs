import pg from 'pg';import {helpFixture,table} from './help-reader-service-fixture.mjs';
import {migrateHelpStorage} from '../tools/governance-production/pc10-help-storage.mjs';
import {registerHelpPolicy} from '../tools/governance-production/pc10-help-policy.mjs';
export async function postgresStoreFixture(){
 if(['PRODUCTION_DATABASE_URL','GOVERNANCE_DATABASE_URL','DB_URL'].some(k=>Object.hasOwn(process.env,k)))throw Error('Production credentials forbidden in store fixtures');
 if(process.env.HELP_SERVICE_TEST_DATABASE_URL!==undefined){const u=new URL(process.env.HELP_SERVICE_TEST_DATABASE_URL);if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='127.0.0.1'||u.pathname!=='/help_service'||u.search||u.hash)throw Error('Explicit isolated store fixture required');}
 const f=await helpFixture();let connection;
 try{
  await f.db.exec('CREATE TABLE '+table('api_rate_limits')+'(_primecare_import_row bigint PRIMARY KEY,id jsonb,api_id jsonb,runtime_artifact_id jsonb,limit_key jsonb,max_requests jsonb,time_window jsonb,created_at jsonb);CREATE TABLE '+table('audit_event_definitions')+'(_primecare_import_row bigint PRIMARY KEY,id bigint,event_code text,event_name text,severity text,description text)');
  await migrateHelpStorage(f.db,{apply:true});await registerHelpPolicy(f.db,{apply:true});await f.allow();
  // Local engine cases run outside reader transactions. Only native PostgreSQL
  // cases below prove separate autocommit connections and rollback survival.
  let quota={query:(...args)=>f.db.query(...args)};
  if(process.env.HELP_SERVICE_TEST_DATABASE_URL){connection=new pg.Client({connectionString:process.env.HELP_SERVICE_TEST_DATABASE_URL});await connection.connect();quota=connection;}
  const close=f.close;return {...f,quota,close:async()=>{try{await connection?.end();}finally{await close();}}};
 }catch(error){await connection?.end();await f.close();throw error;}
}
