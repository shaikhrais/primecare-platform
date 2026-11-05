import assert from 'node:assert/strict';
import pg from 'pg';
import {recordThemeRestoreImplementation as record} from './record-theme-restore-implementation.mjs';
const url=new URL(process.env.THEME_RESTORE_RECORD_TEST_URL);
if(url.hostname!=='127.0.0.1'||url.pathname!=='/theme_restore_record_test'||process.env.PRODUCTION_DATABASE_URL)throw Error('Isolated database required');
const schema='governance_'+'a'.repeat(40),table=n=>'"'+schema+'"."govt_'+n+'"';
const pin={schema,tablePrefix:'govt_',manifestSha256:'fixture',themeRestoreWriter:{screenId:2534,roleId:72,apiId:777,controls:['theme-restore-review','theme-restore-confirm'],tables:['screen_components','screen_required_elements','language_resources','language_resource_values'],runtimeActivation:false,roleGrants:false}};
const db=new pg.Client({connectionString:url.href});await db.connect();
try{
 await db.query(`CREATE SCHEMA "${schema}";CREATE TABLE ${table('source_manifest')}(manifest_sha256 text);CREATE TABLE ${table('screens')}(id bigint,screen_code text,route_path text,active int);CREATE TABLE ${table('screen_components')}(id bigint,screen_id bigint,data_cy text,component_code text,component_type text,file_path text,implementation_status text);INSERT INTO ${table('source_manifest')} VALUES('fixture');INSERT INTO ${table('screens')} VALUES(2534,'tenant_admin_command_center','/tenant-dashboard',1);INSERT INTO ${table('screen_components')} VALUES(1,2534,'theme-restore-review','themeWorkspace.theme-restore-review','prime_button','packages/primecare_ui/web/advanced-theme-tenant-restore-control.ts','registered-unimplemented'),(2,2534,'theme-restore-confirm','themeWorkspace.theme-restore-confirm','prime_button','packages/primecare_ui/web/advanced-theme-tenant-restore-control.ts','registered-unimplemented');`);
 const status=async()=>(await db.query('SELECT implementation_status FROM '+table('screen_components')+' ORDER BY id')).rows.map(r=>r.implementation_status);
 await record(db,pin);assert.deepEqual(await status(),['registered-unimplemented','registered-unimplemented']);
 await assert.rejects(record(db,pin,{readback:true}),/readback/);
 assert.deepEqual(await record(db,pin,{apply:true}),{controls:2,committed:true,readback:false,runtimeActivated:false,humanReviewApproved:false});
 await record(db,pin,{readback:true});assert.deepEqual(await status(),['implemented-unverified','implemented-unverified']);
 await db.query("UPDATE "+table('screen_components')+" SET file_path='other' WHERE id=1");await assert.rejects(record(db,pin,{apply:true}),/identity/);
 assert.deepEqual(await status(),['implemented-unverified','implemented-unverified']);
 await assert.rejects(record(db,{...pin,manifestSha256:'other'},{apply:true}),/Authority/);
 console.log('Restore status recording: rollback, update, readback and mismatches passed.');
}finally{await db.end();}
