import test from 'node:test';import assert from 'node:assert/strict';import {readFile} from 'node:fs/promises';
import {PGlite} from '@electric-sql/pglite';
import {registerNativeApplicationHost} from '../tools/governance-production/native-application-host-registration.mjs';
const pin=JSON.parse(await readFile(new URL('../tools/governance-production/production-pin.json',import.meta.url)));
const contracts=JSON.parse(await readFile(new URL('../tools/governance-production/auth-session-tenant-contracts.json',import.meta.url)));
const schema=contracts.contracts.find(c=>c.reviewed.id===16402).response;
const t=name=>'"'+pin.schema+'"."'+pin.tablePrefix+name+'"';
async function fixture(){
 const db=new PGlite();await db.exec('CREATE SCHEMA "'+pin.schema+'"');
 await db.exec('CREATE TABLE '+t('source_manifest')+'(manifest_sha256 text);CREATE TABLE '+t('api_endpoints')+'(id bigint,http_method text,route_path text,auth_required bigint,permission_key text,response_schema text);CREATE TABLE '+t('screens')+'(id bigint,screen_code text,route_path text,active bigint);CREATE TABLE '+t('roles')+'(id bigint,role_code text,active bigint);CREATE TABLE '+t('role_screen_permissions')+'(screen_id bigint,role_id bigint,can_view bigint);CREATE TABLE '+t('api_permissions')+'(id bigint,api_id bigint,role_id bigint,can_access bigint,permission_key text);CREATE TABLE '+t('screen_api_links')+'(id bigint,_primecare_import_row bigint,screen_id bigint,api_id bigint,purpose text)');
 await db.query('INSERT INTO '+t('source_manifest')+' VALUES($1)',[pin.manifestSha256]);
 await db.query('INSERT INTO '+t('api_endpoints')+" VALUES(16402,'GET','/v1/auth/me',1,'authenticated_self_session',$1)",[JSON.stringify(schema)]);
 await db.exec('INSERT INTO '+t('screens')+" VALUES(2534,'tenant_admin_command_center','/tenant-dashboard',1);INSERT INTO "+t('roles')+" VALUES(72,'tenant_admin',1);INSERT INTO "+t('role_screen_permissions')+' VALUES(2534,72,1);INSERT INTO '+t('api_permissions')+" VALUES(80124,777,72,1,'authenticated_self_preferences');INSERT INTO "+t('screen_api_links')+" VALUES(1,1,2534,777,'Authenticated self-preferences via API 777'),(2,2,2518,16402,'Session restore')");return db;
}
test('native registration plans without writes, rolls back dry run, applies exactly one link and is idempotent',async()=>{
 const db=await fixture();try{
  const before=(await db.query('SELECT * FROM '+t('api_permissions'))).rows;
  assert.equal((await registerNativeApplicationHost(db,{readOnly:true})).missing,true);
  assert.equal((await registerNativeApplicationHost(db)).writes,0);
  assert.equal((await db.query('SELECT * FROM '+t('screen_api_links'))).rows.length,2);
  const result=await registerNativeApplicationHost(db,{commit:true});assert.equal(result.writes,1);assert.equal(result.grantsChanged,0);
  assert.equal((await registerNativeApplicationHost(db,{commit:true})).writes,0);
  assert.equal((await registerNativeApplicationHost(db,{readOnly:true})).missing,false);
  assert.deepEqual((await db.query('SELECT * FROM '+t('api_permissions'))).rows,before);
  assert.equal((await db.query('SELECT * FROM '+t('screen_api_links')+' WHERE screen_id=2518')).rows.length,1);
 }finally{await db.close();}
});
for(const [name,sql] of [
 ['manifest','UPDATE '+t('source_manifest')+" SET manifest_sha256='wrong'"],
 ['screen route','UPDATE '+t('screens')+" SET route_path='/other'"],
 ['view grant','UPDATE '+t('role_screen_permissions')+' SET can_view=0'],
 ['API permission','UPDATE '+t('api_endpoints')+" SET permission_key='other'"],
 ['API response','UPDATE '+t('api_endpoints')+" SET response_schema='{}'"],
 ['existing shortcut link','DELETE FROM '+t('screen_api_links')+' WHERE api_id=777'],
 ['conflicting link','INSERT INTO '+t('screen_api_links')+" VALUES(3,3,2534,16402,'other')"],
])test('native registration rejects changed '+name+' without inserting a link',async()=>{
 const db=await fixture();try{await db.exec(sql);const before=(await db.query('SELECT * FROM '+t('screen_api_links')+' ORDER BY id')).rows;await assert.rejects(registerNativeApplicationHost(db,{commit:true}));assert.deepEqual((await db.query('SELECT * FROM '+t('screen_api_links')+' ORDER BY id')).rows,before);}finally{await db.close();}
});
