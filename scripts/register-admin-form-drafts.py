"""Register presentation-only retention for existing admin forms."""
import argparse,json,sqlite3
from pathlib import Path
root=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');a=p.parse_args()
source=sqlite3.connect(root/'.agents/governance/governance.db');db=sqlite3.connect(':memory:') if a.check else source
if a.check:source.backup(db)
assert db.execute("SELECT id FROM screens WHERE screen_code='PLATFORM_ADMINISTRATION'").fetchone()
sid=db.execute("SELECT id FROM screens WHERE screen_code='PLATFORM_ADMINISTRATION'").fetchone()[0]
cid=db.execute("SELECT id FROM primecare_ui_component_registry WHERE component_code='prime_card'").fetchone()[0]
for index,(key,label,endpoint) in enumerate([('platform-tenant-form','Create tenant','/v1/governance/platform/tenants'),('platform-account-form','Create account','/v1/governance/platform/tenants/{tenantId}/accounts'),('platform-master-form','Create master record','/v1/governance/platform/tenants/{tenantId}/masters')]):
 section='admin-form-'+key
 db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status) SELECT ?,?,?,'form',?, 'Existing API-backed administration form',1,'websites/typescript/src/platform-admin.ts',?,'created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code=?)",(sid,section,label,20+index,section,sid,section))
 sec=db.execute('SELECT id FROM screen_sections WHERE screen_id=? AND section_code=?',(sid,section)).fetchone()[0]
 db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,api_usage,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,'form',?,?,1,1,?,0,'partial','governed_content','api_action','auth_connected','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)",(sec,sid,key,label,key,endpoint,sec,key))
 eid=db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(sec,key)).fetchone()[0]
 db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,'form',?,'html-accessible','Existing form draft preservation',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)",(sid,sec,eid,cid,eid))
# Existing row controls retain only unsaved presentation values, never permissions.
for table,controls in [('platform-users',['role','status','save']),('platform-masters',['label','status','save'])]:
 db.execute('CREATE TABLE IF NOT EXISTS admin_row_draft_surfaces(screen_id INTEGER,table_test_id TEXT,controls_json TEXT,PRIMARY KEY(screen_id,table_test_id))')
 db.execute('INSERT OR REPLACE INTO admin_row_draft_surfaces VALUES(?,?,?)',(sid,table,json.dumps(controls)))
policy={'formTestIds':['platform-tenant-form','platform-account-form','platform-master-form'],'formPrefixes':['platform-onboarding-form-'],'scope':'actor_tenant_view','storage':'memory','excludeInputTypes':['password','hidden'],'clearOn':'successful_submission_or_scope_change','rowTables':['platform-users','platform-masters'],'rowFields':['data-role','data-status','data-label'],'rowClearOn':['successful_row_save','scope_change','explicit_refresh','server_baseline_change']}
db.execute('CREATE TABLE IF NOT EXISTS admin_form_draft_policy(id TEXT PRIMARY KEY,definition TEXT NOT NULL)')
db.execute('INSERT OR REPLACE INTO admin_form_draft_policy VALUES(?,?)',('admin-forms-v1',json.dumps(policy)));db.commit()
out=root/'packages/shared/src/admin-form-draft.json';text=json.dumps(policy,indent=2)+'\n'
if a.check:assert out.read_text()==text
else:out.write_text(text)
print('Registered existing admin form retention; no new screens or APIs')
