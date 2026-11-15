import test from 'node:test';import assert from 'node:assert/strict';import {readFile,mkdtemp,mkdir,writeFile,symlink,realpath,rm} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join,dirname} from 'node:path';import {pathToFileURL} from 'node:url';
import {createHash} from 'node:crypto';
import {PGlite} from '@electric-sql/pglite';import {discoverHelp} from '../tools/governance-production/pc10-help-discovery.mjs';
const pin=JSON.parse(await readFile(new URL('../tools/governance-production/production-pin.json',import.meta.url)));
const t=n=>'"'+pin.schema+'"."govt_'+n+'"';
async function fixture(){const db=new PGlite();await db.exec('CREATE SCHEMA "'+pin.schema+'"');
 for(const [name,columns] of Object.entries({source_manifest:'manifest_sha256 text',screens:'id bigint,screen_code text',api_endpoints:'id bigint,route_path text',roles:'id bigint,role_code text,active bigint',api_permissions:'id bigint,api_id bigint,role_id bigint,can_access bigint',role_screen_permissions:'screen_id bigint,role_id bigint,can_view bigint',screen_api_links:'screen_id bigint,api_id bigint',screen_components:'id bigint,screen_id bigint',screen_required_elements:'id bigint,screen_id bigint',primecare_ui_component_registry:'id bigint,component_code text',section_permissions:'screen_id bigint,role_id bigint,can_access bigint'}))await db.exec('CREATE TABLE '+t(name)+'('+columns+')');
 await db.query('INSERT INTO '+t('source_manifest')+' VALUES($1)',[pin.manifestSha256]);
 await db.exec('CREATE TABLE public.faqs(id uuid primary key,question text,answer text);CREATE TABLE public.tenants(id text primary key);CREATE TABLE public.users(id uuid primary key,tenant_id text REFERENCES public.tenants(id),password text);INSERT INTO public.faqs VALUES(gen_random_uuid(),\'PRIVATE-QUESTION-CANARY\',\'PRIVATE-ANSWER-CANARY\');INSERT INTO public.users VALUES(gen_random_uuid(),NULL,\'PRIVATE-PASSWORD-CANARY\');INSERT INTO '+t('screens')+" VALUES(685,'psw_help_support'),(999,'unrelated');INSERT INTO "+t('api_endpoints')+" VALUES(794,'/v1/psw/help-support');INSERT INTO "+t('roles')+" VALUES(51,'psw',1);INSERT INTO "+t('api_permissions')+' VALUES(1,794,51,1),(2,794,70,1);INSERT INTO '+t('role_screen_permissions')+' VALUES(685,51,1);INSERT INTO '+t('screen_api_links')+' VALUES(685,794);INSERT INTO '+t('screen_components')+' VALUES(779,2534),(5,685);INSERT INTO '+t('primecare_ui_component_registry')+" VALUES(779,'help');INSERT INTO "+t('section_permissions')+' VALUES(685,51,0),(999,70,1)');return db;}
test('reads actual schema and exact access, exposes no private rows, leaves legacy grants and content intact',async()=>{const db=await fixture();try{const before=(await db.query('SELECT * FROM '+t('api_permissions')+' ORDER BY id')).rows;const receipt=await discoverHelp(db);assert.equal(receipt.screens.length,1);assert.equal(receipt.apiPermissions.length,2);assert.equal(receipt.related.govt_section_permissions[0].can_access,0);assert.equal(receipt.registry[0].component_code,'help');assert.ok(receipt.businessColumns.some(c=>c.table_name==='tenants'&&c.column_name==='id'&&c.data_type==='text'));assert.ok(receipt.constraints.some(c=>c.contype==='f'));assert.ok(receipt.indexes.length);assert.doesNotMatch(JSON.stringify(receipt),/PRIVATE-/);assert.equal(receipt.writes,0);assert.equal(receipt.businessRowsRead,0);assert.equal(receipt.authorityInferred,false);assert.deepEqual((await db.query('SELECT * FROM '+t('api_permissions')+' ORDER BY id')).rows,before);assert.equal((await db.query('SELECT answer FROM public.faqs')).rows[0].answer,'PRIVATE-ANSWER-CANARY');}finally{await db.close();}});
test('rejects a manifest mismatch and releases the transaction',async()=>{const db=await fixture();try{await db.exec('UPDATE '+t('source_manifest')+" SET manifest_sha256='wrong'");await assert.rejects(discoverHelp(db),/Authority/);await db.exec('CREATE TABLE after_failure(id int)');}finally{await db.close();}});
test('fails rather than truncating grants or inferring a partial policy',async()=>{const db=await fixture();try{await db.exec('INSERT INTO '+t('api_permissions')+' SELECT n+10,794,n+100,1 FROM generate_series(1,301) n');await assert.rejects(discoverHelp(db),/bound/);}finally{await db.close();}});

test('wide unrelated governance columns do not exhaust exact access-column discovery',async()=>{const db=await fixture();try{await db.exec('CREATE TABLE '+t('screen_wide')+'(screen_id bigint,'+Array.from({length:310},(_,i)=>'unrelated_'+i+' text').join(',')+')');const result=await discoverHelp(db);assert.ok(result.governanceColumns.some(c=>c.table_name==='govt_screen_wide'&&c.column_name==='screen_id'));assert.ok(!result.governanceColumns.some(c=>c.column_name.startsWith('unrelated_')));assert.deepEqual(result.related.govt_screen_wide,[]);}finally{await db.close();}});

test('joins historical text screen identities without casting business data or losing denial metadata',async()=>{const db=await fixture();try{await db.exec('CREATE TABLE '+t('screen_behavior_profiles')+"(screen_id text,behavior text);INSERT INTO "+t('screen_behavior_profiles')+" VALUES('685','owned'),('999','unrelated')");const result=await discoverHelp(db);assert.deepEqual(result.related.govt_screen_behavior_profiles,[{screen_id:'685',behavior:'owned'}]);}finally{await db.close();}});

test('reports exact writer column and uniqueness constraints without inferring new authority',async()=>{const db=await fixture();try{await db.exec('ALTER TABLE '+t('api_permissions')+' ADD CONSTRAINT exact_fixture_binding UNIQUE(api_id,role_id)');const r=await discoverHelp(db);assert.ok(r.bindingColumns.some(c=>c.table_name==='govt_api_permissions'&&c.column_name==='role_id'&&c.data_type==='bigint'));assert.ok(r.bindingConstraints.some(c=>c.conname==='exact_fixture_binding'&&c.definition==='UNIQUE (api_id, role_id)'));assert.ok(r.bindingIndexes.some(c=>c.indexname==='exact_fixture_binding'));assert.equal(r.authorityInferred,false);assert.equal(r.grantsChanged,0);assert.equal(r.hostActivated,false);}finally{await db.close();}});
test('runtime adapter discovery reads schema only, never operational audit/quota rows or policy values',async()=>{const db=await fixture();try{await db.exec('CREATE TABLE public.help_audit(user_id text,article_id text);INSERT INTO public.help_audit VALUES(\'PRIVATE-AUDIT-USER\',\'PRIVATE-GUIDE\');CREATE TABLE '+t('api_rate_limits')+'(permission_key text,limit_value int,private_note text);INSERT INTO '+t('api_rate_limits')+" VALUES('psw_published_help_read',17,'PRIVATE-QUOTA-POLICY')");const r=await discoverHelp(db);assert.ok(r.runtimeRelations.some(x=>x.table_schema==='public'&&x.table_name==='help_audit'));assert.ok(r.runtimeRelations.some(x=>x.table_name==='govt_api_rate_limits'));assert.ok(r.runtimePolicyColumns.some(x=>x.table_name==='govt_api_rate_limits'&&x.column_name==='limit_value'));assert.doesNotMatch(JSON.stringify(r),/PRIVATE-/);assert.equal(r.runtimePolicyValuesRead,0);assert.equal(r.businessRowsRead,0);assert.equal((await db.query('SELECT private_note FROM '+t('api_rate_limits'))).rows[0].private_note,'PRIVATE-QUOTA-POLICY');}finally{await db.close();}});
test('new runtime metadata enumeration retains the existing 300-row fail-closed bound',async()=>{const db=await fixture();try{await db.exec('CREATE TABLE '+t('audit_wide')+'('+Array.from({length:301},(_,i)=>'field_'+i+' text').join(',')+')');await assert.rejects(discoverHelp(db),/Metadata bound exceeded/);await db.exec('CREATE TABLE after_runtime_bound(id int)');}finally{await db.close();}});

const policyTables=async db=>db.exec('CREATE TABLE '+t('api_rate_limits')+'(id jsonb,api_id jsonb,runtime_artifact_id jsonb,limit_key jsonb,max_requests jsonb,time_window jsonb);CREATE TABLE '+t('audit_event_definitions')+'(id bigint,event_code text,event_name text,severity text,description text)');
test('reads only exact API794 JSONB policy definitions and Help audit definitions',async()=>{const db=await fixture();try{await policyTables(db);for(const [id,api,key]of [[1,794,'fixture_help'],[2,'794','fixture_second'],[3,795,'PRIVATE-UNRELATED']])await db.query('INSERT INTO '+t('api_rate_limits')+' VALUES($1::jsonb,$2::jsonb,$3::jsonb,$4::jsonb,$5::jsonb,$6::jsonb)',[id,api,9,key,17,null].map(v=>JSON.stringify(v)));await db.exec('INSERT INTO '+t('audit_event_definitions')+" VALUES(1,'help_read','Fixture Help','info','Definition only'),(2,'unrelated','PRIVATE-AUDIT','info','PRIVATE-DETAIL')");const before=(await db.query('SELECT * FROM '+t('api_rate_limits'))).rows;const r=await discoverHelp(db);assert.equal(r.policyDefinitionReadback.rateSchemaSupported,true);assert.deepEqual(r.policyDefinitionReadback.ratePolicies.map(p=>p.api_id),[794,'794']);assert.equal(r.policyDefinitionReadback.auditDefinitions.length,1);assert.equal(r.runtimePolicyValuesRead,3);assert.equal(r.policyDefinitionReadback.operationalRowsRead,0);assert.equal(r.authorityInferred,false);assert.doesNotMatch(JSON.stringify(r),/PRIVATE-/);assert.deepEqual((await db.query('SELECT * FROM '+t('api_rate_limits'))).rows,before);}finally{await db.close();}});
test('supported schema with no Help definitions reports absence without a fabricated default',async()=>{const db=await fixture();try{await policyTables(db);const r=await discoverHelp(db);assert.deepEqual(r.policyDefinitionReadback,{rateSchemaSupported:true,auditSchemaSupported:true,ratePolicies:[],auditDefinitions:[],authorityInferred:false,operationalRowsRead:0});assert.equal(r.runtimePolicyValuesRead,0);}finally{await db.close();}});
test('Help policy definition overflow fails closed and releases the transaction',async()=>{const db=await fixture();try{await policyTables(db);await db.exec('INSERT INTO '+t('api_rate_limits')+" SELECT to_jsonb(n),'794'::jsonb,'9'::jsonb,to_jsonb('fixture'::text),'17'::jsonb,'null'::jsonb FROM generate_series(1,301)n");await assert.rejects(discoverHelp(db),/bound/);await db.exec('CREATE TABLE after_policy_bound(id int)');}finally{await db.close();}});

const legacyKey='api_permission_api_v1_clinical_director_quality_metrics_list_get';
async function identityTables(db,json=false){
 await db.exec('ALTER TABLE '+t('api_permissions')+' ADD COLUMN permission_key text,ADD COLUMN runtime_artifact_id bigint;ALTER TABLE '+t('api_endpoints')+' ADD COLUMN http_method text,ADD COLUMN permission_key text;CREATE TABLE '+t('api_endpoint_registry')+'(id '+(json?'jsonb':'bigint')+',api_id '+(json?'jsonb':'bigint')+',endpoint_code '+(json?'jsonb':'text')+',method '+(json?'jsonb':'text')+',endpoint_path '+(json?'jsonb':'text')+',private_config text);CREATE TABLE '+t('runtime_artifacts')+'(id bigint,private_config text)');
 await db.query('UPDATE '+t('api_permissions')+' SET permission_key=$1,runtime_artifact_id=CASE WHEN id=1 THEN 9 ELSE 10 END',[legacyKey]);
 await db.exec('UPDATE '+t('api_endpoints')+" SET http_method='POST',permission_key='psw_published_help_read';INSERT INTO "+t('api_endpoints')+" VALUES(900,'/quality','GET','quality_read');INSERT INTO "+t('runtime_artifacts')+" VALUES(9,'PRIVATE-ARTIFACT'),(11,'PRIVATE-UNRELATED')");
 const values=[3,900,legacyKey.slice('api_permission_'.length),'GET','/quality'];
 await db.query('INSERT INTO '+t('api_endpoint_registry')+' VALUES('+values.map((_,i)=>'$'+(i+1)+(json?'::jsonb':'')).join(',')+",'PRIVATE-ORIGIN')",json?values.map(v=>JSON.stringify(v)):values);
}
for(const json of [false,true])test('legacy identity readback allows only exact origin/canonical fields, with '+(json?'JSONB':'native')+' registry columns',async()=>{const db=await fixture();try{await identityTables(db,json);const before=(await db.query('SELECT * FROM '+t('api_permissions')+' ORDER BY id')).rows;const r=await discoverHelp(db);const v=r.legacyIdentityReview;assert.equal(v.originSchemaSupported,true);assert.equal(v.endpointSchemaSupported,true);assert.equal(v.artifactSchemaSupported,true);assert.deepEqual(v.origins,[{id:3,api_id:900,endpoint_code:legacyKey.slice('api_permission_'.length),method:'GET',endpoint_path:'/quality'}]);assert.deepEqual(v.canonicalCandidates,[{id:900,http_method:'GET',route_path:'/quality',permission_key:'quality_read'}]);assert.deepEqual(v.referencedArtifactIds,['10','9']);assert.deepEqual(v.presentArtifactIds,['9']);assert.deepEqual(v.missingArtifactIds,['10']);assert.equal(v.members.length,2);assert.equal(v.authorityInferred,false);assert.equal(v.grantsChanged,0);assert.doesNotMatch(JSON.stringify(r),/PRIVATE-/);assert.deepEqual((await db.query('SELECT * FROM '+t('api_permissions')+' ORDER BY id')).rows,before);}finally{await db.close();}});
test('absent registry/artifact schema reports unsupported without guessing presence or authority',async()=>{const db=await fixture();try{const v=(await discoverHelp(db)).legacyIdentityReview;assert.equal(v.originSchemaSupported,false);assert.equal(v.artifactSchemaSupported,false);assert.deepEqual(v.origins,[]);assert.deepEqual(v.canonicalCandidates,[]);assert.equal(v.missingArtifactIds,null);}finally{await db.close();}});
test('supported registry with no exact canonical operation reports no candidate',async()=>{const db=await fixture();try{await identityTables(db);await db.exec('DELETE FROM '+t('api_endpoints')+' WHERE id=900');const v=(await discoverHelp(db)).legacyIdentityReview;assert.equal(v.endpointSchemaSupported,true);assert.deepEqual(v.canonicalCandidates,[]);assert.equal(v.authorityInferred,false);}finally{await db.close();}});
test('legacy origin overflow fails closed and releases transaction',async()=>{const db=await fixture();try{await identityTables(db);await db.query('INSERT INTO '+t('api_endpoint_registry')+' SELECT n+10,900,$1,\'GET\',\'/quality\',NULL FROM generate_series(1,301)n',[legacyKey.slice('api_permission_'.length)]);await assert.rejects(discoverHelp(db),/Metadata bound exceeded/);await db.exec('CREATE TABLE after_identity_bound(id int)');}finally{await db.close();}});

test('operational registration shape reports exact defaults, uniqueness and indexes without reading counters or audit rows',async()=>{const db=await fixture();try{await policyTables(db);await db.exec('ALTER TABLE '+t('api_rate_limits')+' ADD CONSTRAINT fixture_policy_identity UNIQUE(api_id,limit_key);ALTER TABLE '+t('audit_event_definitions')+' ADD CONSTRAINT fixture_event_code UNIQUE(event_code);CREATE TABLE public.help_reader_rate(tenant_id text NOT NULL,user_id text NOT NULL,attempts integer DEFAULT 1 CHECK(attempts BETWEEN 1 AND 31),reset_at timestamptz,PRIMARY KEY(tenant_id,user_id));CREATE TABLE public.help_reader_audit(id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,private_note text,expires_at timestamptz DEFAULT statement_timestamp());CREATE INDEX fixture_expiry ON public.help_reader_audit(expires_at);INSERT INTO public.help_reader_audit(private_note) VALUES(\'PRIVATE-AUDIT-CANARY\');INSERT INTO public.help_reader_rate VALUES(\'PRIVATE-TENANT\',\'PRIVATE-USER\',7,now())');const v=(await discoverHelp(db)).operationalRegistrationShape;assert.ok(v.policies.constraints.some(c=>c.conname==='fixture_policy_identity'));assert.ok(v.policies.indexes.some(c=>c.indexname==='fixture_event_code'));assert.deepEqual(v.storage.presentTables,['help_reader_audit','help_reader_rate']);assert.ok(v.storage.columns.some(c=>c.column_name==='attempts'&&c.column_default==='1'&&c.data_type==='integer'));assert.ok(v.storage.constraints.some(c=>c.contype==='p'&&c.definition==='PRIMARY KEY (tenant_id, user_id)'));assert.ok(v.storage.indexes.some(c=>c.indexname==='fixture_expiry'));assert.equal(v.operationalRowsRead,0);assert.equal(v.writes,0);assert.equal(v.authorityInferred,false);assert.doesNotMatch(JSON.stringify(v),/PRIVATE-/);assert.equal((await db.query('SELECT attempts FROM public.help_reader_rate')).rows[0].attempts,7);}finally{await db.close();}});
test('absent operational registration/storage tables remain explicitly absent, without inferred policies',async()=>{const db=await fixture();try{const v=(await discoverHelp(db)).operationalRegistrationShape;assert.deepEqual(v.policies.presentTables,[]);assert.deepEqual(v.storage.presentTables,[]);assert.deepEqual(v.storage.constraints,[]);assert.deepEqual(v.storage.indexes,[]);assert.deepEqual(v.storage.columns,[]);assert.equal(v.authorityInferred,false);}finally{await db.close();}});
test('prospective storage shape retains 300-row bound and releases failed transaction',async()=>{const db=await fixture();try{await db.exec('CREATE TABLE public.help_reader_rate('+Array.from({length:301},(_,i)=>'field_'+i+' text').join(',')+')');await assert.rejects(discoverHelp(db),/Metadata bound exceeded/);await db.exec('CREATE TABLE after_storage_shape_bound(id int)');}finally{await db.close();}});

async function retirementFixture(){
 const db=await fixture();await identityTables(db);
 await db.exec('ALTER TABLE '+t('api_permissions')+' ADD COLUMN _primecare_import_row bigint,ADD COLUMN created_at text;DELETE FROM '+t('api_permissions'));
 await db.query('INSERT INTO '+t('api_permissions')+'(id,api_id,role_id,can_access,permission_key,runtime_artifact_id,_primecare_import_row,created_at) SELECT 9007199254740992+n,794,n,1,$1,1,n,\'2026-01-01 12:34:56\' FROM generate_series(1,64)n',[legacyKey]);
 await db.exec('ALTER TABLE '+t('api_permissions')+' ADD PRIMARY KEY(_primecare_import_row);ALTER TABLE '+t('api_permissions')+' ADD UNIQUE(id)');return db;
}
test('retirement evidence retains all64 complete SQL JSONB rows and exact large numeric lexemes without mutation',async()=>{
 const db=await retirementFixture();try{
  const before=(await db.query('SELECT to_jsonb(x)::text original_row_text FROM '+t('api_permissions')+' x ORDER BY _primecare_import_row,id')).rows;
  const r=(await discoverHelp(db)).legacyRetirementDiscovery;
  assert.equal(r.rawRowsSupported,true);assert.equal(r.sourceRows.length,64);
  assert.equal(r.sourceRows[0].source_id,'9007199254740993');assert.equal(r.sourceRows[0].source_ordinal,'1');
  assert.match(r.sourceRows[0].original_row_text,/9007199254740993/);assert.match(r.sourceRows[0].original_row_text,/_primecare_import_row/);assert.match(r.sourceRows[0].original_row_text,/2026-01-01 12:34:56/);
  const digest=value=>createHash('sha256').update(value,'utf8').digest('hex');
  assert.deepEqual(r.sourceRows.map(x=>x.original_row_text),before.map(x=>x.original_row_text));
  assert.equal(r.sourceRowsSha256,digest(JSON.stringify(before.map(x=>x.original_row_text))));
  assert.ok(r.sourceRows.every(x=>x.sha256===digest(x.original_row_text)));
  assert.ok(r.sourceAndArchiveShape.constraints.some(x=>x.definition==='PRIMARY KEY (_primecare_import_row)'));
  assert.equal(r.archiveContentsRead,false);assert.equal(r.authorityInferred,false);assert.equal(r.businessRowsRead,0);assert.equal(r.writes,0);
  assert.deepEqual((await db.query('SELECT to_jsonb(x)::text original_row_text FROM '+t('api_permissions')+' x ORDER BY _primecare_import_row,id')).rows,before);
 }finally{await db.close();}
});
test('retirement discovery reports every physical inbound FK but counts only pinned metadata references',async()=>{
 const db=await retirementFixture();try{
  await db.exec('CREATE TABLE '+t('grant_reference')+'(id bigint,permission_id bigint REFERENCES '+t('api_permissions')+'(id));INSERT INTO '+t('grant_reference')+' VALUES(1,9007199254740993);CREATE TABLE public.private_grant_reference(private_note text,grant_id bigint REFERENCES '+t('api_permissions')+'(id));INSERT INTO public.private_grant_reference VALUES(\'PRIVATE-BUSINESS-CANARY\',9007199254740993)');
  const r=(await discoverHelp(db)).legacyRetirementDiscovery;
  const owned=r.incomingForeignKeys.find(x=>x.source_table==='govt_grant_reference');assert.deepEqual(owned.source_columns,['permission_id']);assert.deepEqual(owned.referenced_columns,['id']);assert.equal(owned.matchingRows,'1');assert.equal(owned.matchCountRead,true);
  const outside=r.incomingForeignKeys.find(x=>x.source_schema==='public');assert.equal(outside.outOfMetadataScope,true);assert.equal(outside.matchCountRead,false);assert.equal(outside.matchingRows,null);
  assert.doesNotMatch(JSON.stringify(r),/PRIVATE-BUSINESS-CANARY/);assert.equal(r.businessRowsRead,0);
 }finally{await db.close();}
});
test('logical retirement references match exact large grant IDs in scalar or imported JSONB fields without exposing other metadata',async()=>{
 const db=await retirementFixture();try{
  await db.exec('CREATE TABLE '+t('grant_logical_refs')+'(id bigint,grant_id jsonb,private_note text);INSERT INTO '+t('grant_logical_refs')+' VALUES(1,\'9007199254740993\',\'PRIVATE-REF\'),(2,\'{"t":"integer","v":9007199254740993}\',\'PRIVATE-REF\'),(3,\'90071992547409930\',\'PRIVATE-UNRELATED\');CREATE TABLE '+t('help_legacy_grant_archive')+'(source_ordinal bigint PRIMARY KEY,group_fingerprint text NOT NULL,original_row jsonb NOT NULL,operation_context jsonb NOT NULL,retired_at timestamptz NOT NULL DEFAULT clock_timestamp())');
  const r=(await discoverHelp(db)).legacyRetirementDiscovery;
  const ref=r.logicalReferences.find(x=>x.table_name==='govt_grant_logical_refs');assert.deepEqual(ref.matches,[{referenced_grant_id:'9007199254740993',matching_rows:'2',matchesSourceId:true,matchesSourceOrdinal:false}]);
  assert.ok(r.sourceAndArchiveShape.presentTables.includes('govt_help_legacy_grant_archive'));assert.ok(r.sourceAndArchiveShape.columns.some(x=>x.table_name==='govt_help_legacy_grant_archive'&&x.column_name==='original_row'&&x.data_type==='jsonb'));
  assert.doesNotMatch(JSON.stringify(r),/PRIVATE-/);assert.equal(r.authorityInferred,false);
 }finally{await db.close();}
});
test('incomplete grant row schema is explicit and never presents a fabricated archival hash',async()=>{
 const db=await fixture();try{const r=(await discoverHelp(db)).legacyRetirementDiscovery;assert.equal(r.rawRowsSupported,false);assert.deepEqual(r.sourceRows,[]);assert.equal(r.sourceRowsSha256,null);}finally{await db.close();}
});
test('more than64 exact retirement candidates fails closed and releases the read-only transaction',async()=>{
 const db=await retirementFixture();try{await db.query('INSERT INTO '+t('api_permissions')+' VALUES(999,794,65,1,$1,1,65,\'unexpected\')',[legacyKey]);await assert.rejects(discoverHelp(db),/retirement row bound/);await db.exec('CREATE TABLE after_retirement_bound(id int)');}finally{await db.close();}
});
test('retirement inventory finds array, ordinal and permission-key candidates without inferring reference ownership',async()=>{
 const db=await retirementFixture();try{
  await db.exec('CREATE TABLE '+t('grant_array_refs')+'(id bigint,permission_ids jsonb,grant_import_row bigint,permission_key text);INSERT INTO '+t('grant_array_refs')+' VALUES(1,\'[9007199254740993,9007199254740993,{"t":"int","v":9007199254740994}]\',1,NULL)');await db.query('UPDATE '+t('grant_array_refs')+' SET permission_key=$1',[legacyKey]);
  const r=(await discoverHelp(db)).legacyRetirementDiscovery,refs=r.logicalReferences.filter(x=>x.table_name==='govt_grant_array_refs');
  assert.equal(refs.length,3);const array=refs.find(x=>x.column_name==='permission_ids');assert.deepEqual(array.matches.map(x=>[x.referenced_grant_id,x.matching_rows]),[['9007199254740993','1'],['9007199254740994','1']]);
  const ordinal=refs.find(x=>x.column_name==='grant_import_row').matches[0];assert.equal(ordinal.referenced_grant_id,'1');assert.equal(ordinal.matchesSourceOrdinal,true);assert.equal(ordinal.matchesSourceId,false);
  assert.equal(refs.find(x=>x.column_name==='permission_key').matches[0].referenced_grant_id,legacyKey);assert.ok(refs.every(x=>x.authorityInferred===false));
 }finally{await db.close();}
});
test('manifest retirement discovery emits only declared API permission schema objects and never executes them',async()=>{
 const db=await retirementFixture();try{
  await db.exec('ALTER TABLE '+t('source_manifest')+' ADD COLUMN manifest jsonb');
  const source={format:'primecare-governance-snapshot-v1',sqlite_objects:[['table','fixture_reference','fixture_reference','CREATE TABLE fixture_reference(permission_row_id INTEGER REFERENCES api_permissions(id))'],['trigger','fixture_delete','api_permissions','CREATE TRIGGER fixture_delete AFTER DELETE ON api_permissions BEGIN DELETE FROM fixture_reference; END'],['table','unrelated','unrelated','CREATE TABLE unrelated(private_note TEXT DEFAULT \'PRIVATE-UNRELATED\')']]};
  await db.query('UPDATE '+t('source_manifest')+' SET manifest=$1::jsonb',[JSON.stringify(source)]);
  const r=(await discoverHelp(db)).legacyRetirementDiscovery;
  assert.equal(r.manifestDeclaredReferences.supported,true);assert.equal(r.manifestDeclaredReferences.objects.length,2);assert.equal(r.manifestDeclaredReferences.inspectionRequired,true);assert.equal(r.manifestDeclaredReferences.sqlExecuted,false);assert.doesNotMatch(JSON.stringify(r),/PRIVATE-UNRELATED/);
  assert.equal((await db.query("SELECT to_regclass('fixture_reference') AS relation")).rows[0].relation,null);
  assert.equal((await db.query('SELECT COUNT(*)::int n FROM '+t('api_permissions'))).rows[0].n,64);
 }finally{await db.close();}
});
test('outside-schema logical reference shapes are explicit and never read business rows',async()=>{
 const db=await retirementFixture();try{
  await db.exec('CREATE SCHEMA business;CREATE TABLE business.private_refs(grant_id bigint,private_note text);INSERT INTO business.private_refs VALUES(9007199254740993,\'PRIVATE-LOGICAL-CANARY\');CREATE TABLE public.private_permission(permission_ids jsonb);INSERT INTO public.private_permission VALUES(\'[9007199254740993]\')');
  const r=(await discoverHelp(db)).legacyRetirementDiscovery;
  for(const name of ['private_refs','private_permission']){const v=r.logicalReferences.find(x=>x.table_name===name);assert.equal(v.outOfMetadataScope,true);assert.equal(v.matchCountRead,false);assert.deepEqual(v.matches,[]);}
  assert.doesNotMatch(JSON.stringify(r),/PRIVATE-LOGICAL-CANARY/);assert.equal(r.businessRowsRead,0);
 }finally{await db.close();}
});
test('retirement reports source DELETE triggers and RLS policy metadata without firing them',async()=>{
 const db=await retirementFixture();try{
  await db.exec('CREATE TABLE public.trigger_canary(id int);CREATE FUNCTION public.retirement_trigger_canary() RETURNS trigger LANGUAGE plpgsql AS $$BEGIN INSERT INTO public.trigger_canary VALUES(1);RETURN OLD;END$$;CREATE TRIGGER unexpected_delete AFTER DELETE ON '+t('api_permissions')+' FOR EACH ROW EXECUTE FUNCTION public.retirement_trigger_canary();ALTER TABLE '+t('api_permissions')+' ENABLE ROW LEVEL SECURITY;CREATE POLICY retirement_fixture_policy ON '+t('api_permissions')+' USING(true)');
  const r=(await discoverHelp(db)).legacyRetirementDiscovery;
  assert.ok(r.triggers.some(x=>x.trigger_name==='unexpected_delete'&&/AFTER DELETE/.test(x.definition)));assert.ok(r.relationSecurity.some(x=>x.table_name==='govt_api_permissions'&&x.row_security===true));assert.ok(r.rowSecurityPolicies.some(x=>x.policy_name==='retirement_fixture_policy'));
  assert.equal((await db.query('SELECT COUNT(*)::int n FROM public.trigger_canary')).rows[0].n,0);
 }finally{await db.close();}
});
test('unsupported declared reference manifest stays explicit instead of asserting no inbound references',async()=>{
 const db=await retirementFixture();try{
  await db.exec('ALTER TABLE '+t('source_manifest')+' ADD COLUMN manifest jsonb');await db.query('UPDATE '+t('source_manifest')+' SET manifest=$1::jsonb',[JSON.stringify({format:'unknown',sqlite_objects:[]})]);
  const v=(await discoverHelp(db)).legacyRetirementDiscovery.manifestDeclaredReferences;
  assert.equal(v.supported,false);assert.match(v.unsupportedReason,/Missing supported/);assert.equal(v.inspectionRequired,true);assert.deepEqual(v.objects,[]);
 }finally{await db.close();}
});
test('logical reference shape inventory overflow fails closed rather than truncating outside-schema candidates',async()=>{
 const db=await retirementFixture();try{
  await db.exec(Array.from({length:301},(_,i)=>'CREATE TABLE public.retirement_ref_'+i+'(grant_id bigint)').join(';'));
  await assert.rejects(discoverHelp(db),/Metadata bound exceeded/);await db.exec('CREATE TABLE after_logical_reference_bound(id int)');
 }finally{await db.close();}
});
test('oversized full-row retirement metadata fails before emitting an incomplete preservation packet',async()=>{
 const db=await retirementFixture();try{
  await db.query('UPDATE '+t('api_permissions')+' SET created_at=$1 WHERE _primecare_import_row=1',['x'.repeat(16385)]);
  await assert.rejects(discoverHelp(db),/Unsupported retirement row encoding/);assert.equal((await db.query('SELECT length(created_at)::int n FROM '+t('api_permissions')+' WHERE _primecare_import_row=1')).rows[0].n,16385);
 }finally{await db.close();}
});
test('declared permission source-object overflow fails closed without executing source SQL',async()=>{
 const db=await retirementFixture();try{
  await db.exec('ALTER TABLE '+t('source_manifest')+' ADD COLUMN manifest jsonb');
  await db.query('UPDATE '+t('source_manifest')+' SET manifest=$1::jsonb',[JSON.stringify({format:'primecare-governance-snapshot-v1',sqlite_objects:Array.from({length:301},(_,i)=>['view','ref_'+i,'ref_'+i,'CREATE VIEW ref_'+i+' AS SELECT id FROM api_permissions'])})]);
  await assert.rejects(discoverHelp(db),/Metadata bound exceeded/);await db.exec('CREATE TABLE after_declared_reference_bound(id int)');
 }finally{await db.close();}
});
test('the one reviewed public OTP column exposes only a bounded reference count and preserves every private field',async()=>{
 const db=await retirementFixture();try{
  await db.exec('CREATE TABLE public.communication_voice_otp(grant_id text,phone text,token text);INSERT INTO public.communication_voice_otp VALUES(\'123e4567-e89b-12d3-a456-426614174000\',\'PRIVATE-PHONE\',\'PRIVATE-TOKEN\')');
  const before=(await db.query('SELECT * FROM public.communication_voice_otp')).rows,queries=[];
  const receipt=await discoverHelp({query:(sql,args)=>{queries.push(sql);return db.query(sql,args);}}),r=receipt.legacyRetirementDiscovery;
  const otp=r.logicalReferences.find(x=>x.table_schema==='public'&&x.table_name==='communication_voice_otp');
  assert.equal(otp.reviewedCountOnly,true);assert.equal(otp.matchCountRead,true);assert.equal(otp.matching_rows,'0');assert.equal(otp.retirementBlocked,false);assert.deepEqual(otp.matches,[]);assert.equal(otp.businessRowPayloadsRead,0);
  assert.equal(r.reviewedOutsideColumns.length,1);assert.equal(r.reviewedOutsideColumns[0].requiredApplyLock,'SHARE');assert.equal(r.reviewedOutsideColumns[0].evidence.length,2);assert.equal(r.outsideReferenceCountQueries,1);
  assert.deepEqual(queries.filter(sql=>sql.includes('"public"."communication_voice_otp"')),['SELECT COUNT(*)::text AS matching_rows FROM "public"."communication_voice_otp" WHERE "grant_id"=ANY($1::text[])']);
  assert.doesNotMatch(JSON.stringify(receipt),/PRIVATE-PHONE|PRIVATE-TOKEN|123e4567-e89b-12d3-a456-426614174000/);assert.deepEqual((await db.query('SELECT * FROM public.communication_voice_otp')).rows,before);
 }finally{await db.close();}
});
test('any exact API grant ID or source ordinal match in the reviewed OTP column blocks retirement without exposing rows',async()=>{
 const db=await retirementFixture();try{
  await db.exec('CREATE TABLE public.communication_voice_otp(grant_id text,private_note text);INSERT INTO public.communication_voice_otp VALUES(\'9007199254740993\',\'PRIVATE-ONE\'),(\'1\',\'PRIVATE-TWO\'),(\'90071992547409930\',\'PRIVATE-UNRELATED\')');
  const r=(await discoverHelp(db)).legacyRetirementDiscovery,otp=r.logicalReferences.find(x=>x.table_schema==='public'&&x.table_name==='communication_voice_otp');
  assert.equal(otp.matching_rows,'2');assert.equal(otp.retirementBlocked,true);assert.deepEqual(otp.matches,[]);assert.doesNotMatch(JSON.stringify(r),/PRIVATE-/);
  assert.equal((await db.query('SELECT COUNT(*)::int n FROM public.communication_voice_otp')).rows[0].n,3);
 }finally{await db.close();}
});
test('reviewed OTP count rejects datatype drift rather than querying business values under another interpretation',async()=>{
 const db=await retirementFixture();try{
  await db.exec('CREATE TABLE public.communication_voice_otp(grant_id bigint)');let counted=0;
  await assert.rejects(discoverHelp({query:(sql,args)=>{if(sql.includes('"public"."communication_voice_otp"'))counted++;return db.query(sql,args);}}),/Reviewed outside reference shape differs/);assert.equal(counted,0);
 }finally{await db.close();}
});
test('reviewed OTP count rejects RLS visibility instead of accepting a potentially hidden zero',async()=>{
 const db=await retirementFixture();try{
  await db.exec('CREATE TABLE public.communication_voice_otp(grant_id text);ALTER TABLE public.communication_voice_otp ENABLE ROW LEVEL SECURITY');let counted=0;
  await assert.rejects(discoverHelp({query:(sql,args)=>{if(sql.includes('"public"."communication_voice_otp"'))counted++;return db.query(sql,args);}}),/Reviewed outside reference visibility differs/);assert.equal(counted,0);
 }finally{await db.close();}
});
test('an altered OTP source evidence file cannot authorize even the count-only exception',async()=>{
 const db=await retirementFixture(),dir=await mkdtemp(join(tmpdir(),'help-otp-reference-pin-'));try{
  await db.exec('CREATE TABLE public.communication_voice_otp(grant_id text)');
  for(const file of ['tools/governance-production/pc10-help-discovery.mjs','tools/governance-production/production-pin.json','cloudflare/workers/src/business-tasks/voice-otp.ts','packages/database/migrations/20261023_communication_voice_otp.sql']){
   await mkdir(dirname(join(dir,file)),{recursive:true});let content=await readFile(new URL('../'+file,import.meta.url));if(file.endsWith('voice-otp.ts'))content=Buffer.concat([content,Buffer.from('\n// altered source\n')]);await writeFile(join(dir,file),content);
  }
  await symlink(await realpath(new URL('../node_modules',import.meta.url)),join(dir,'node_modules'),'dir');
  const module=await import(pathToFileURL(join(dir,'tools/governance-production/pc10-help-discovery.mjs')).href);let counted=0;
  await assert.rejects(module.discoverHelp({query:(sql,args)=>{if(sql.includes('"public"."communication_voice_otp"'))counted++;return db.query(sql,args);}}),/Reviewed outside reference source differs/);assert.equal(counted,0);
 }finally{await db.close();await rm(dir,{recursive:true,force:true});}
});

