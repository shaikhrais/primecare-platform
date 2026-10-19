"""Register the requested administrative tenant monitor before implementation."""
import argparse,json,sqlite3,runpy
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def register(db):
 runpy.run_path(str(ROOT/'scripts/register-growth-governance.py'))['register'](db)
 seed=json.loads((ROOT/'docs/platform-operations/seed.json').read_text())
 assert all(set(v)==set(seed['locales']['en']) for v in seed['locales'].values())
 assert all(c['labelKey'] in seed['locales']['en'] and c['issue'] in seed['locales']['en'] and isinstance(c['minimum'],int) and 1<=c['minimum']<=100 for c in seed['checks'])
 db.execute('CREATE TABLE IF NOT EXISTS tenant_operations_policy(id TEXT PRIMARY KEY,definition TEXT NOT NULL,requirement TEXT NOT NULL)')
 db.execute('INSERT OR REPLACE INTO tenant_operations_policy VALUES(?,?,?)',('admin-v1',json.dumps(seed),'User: more platform features; central/tenant admins, operational gaps and fix navigation, API-owned database reads; 2026-10-16'))
 screen=db.execute("SELECT id FROM screens WHERE screen_code='PLATFORM_ADMINISTRATION'").fetchone()[0];section='platform-operations'
 db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status) SELECT ?,?,'Tenant operations overview','dashboard',26,'Find administrative setup gaps and navigate to fixes',1,'websites/typescript/src/tenant-operations/panel.ts',?,'created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code=?)",(screen,section,section,screen,section))
 sid=db.execute('SELECT id FROM screen_sections WHERE screen_id=? AND section_code=?',(screen,section)).fetchone()[0]
 db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status) SELECT ?,'admin-form-platform-master-form','Create master record','form',22,'Existing API-backed administration form',1,'websites/typescript/src/platform-admin.ts','admin-form-platform-master-form','created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code='admin-form-platform-master-form')",(screen,screen))
 master_sid=db.execute("SELECT id FROM screen_sections WHERE screen_id=? AND section_code='admin-form-platform-master-form'",(screen,)).fetchone()[0]
 controls=[('platform-nav-operations','link','prime_button'),('operations-board','card','prime_card'),('operations-summary','card','prime_card'),('operations-explanation','card','prime_card'),('operations-form','form','prime_card'),('operations-search','input','prime_text_field'),('operations-filter','select','prime_dropdown_web'),('operations-table','table','prime_table_web'),('operations-notice','card','prime_card'),('operations-range','card','prime_card'),('operations-row-{id}','card','prime_card')]+[('operations-'+k,'button','prime_button') for k in ['apply','refresh','previous','next','open-accounts-{id}','open-masters-{id}','open-territories-{id}']]
 controls += [('platform-master-create-type','select','prime_dropdown_web'),('platform-master-create-code','input','prime_text_field'),('platform-master-create-label','input','prime_text_field'),('platform-master-create-submit','button','prime_button')]
 operations_sid=sid
 for n,(key,kind,component) in enumerate(controls):
  sid=master_sid if key.startswith('platform-master-create-') else operations_sid
  db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,api_usage,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,?,?,?,1,1,?,?,'partial','governed_content','action_pending','test_pending','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)",(sid,screen,key,kind,key,key,seed['endpoint'],n,sid,key))
  eid=db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(sid,key)).fetchone()[0]
  db.execute('UPDATE screen_section_elements SET api_usage=? WHERE id=?',('/v1/governance/platform/tenants/{tenantId}/masters' if sid==master_sid else seed['endpoint'],eid))
  cid=db.execute('SELECT id FROM primecare_ui_component_registry WHERE component_code=? AND active=1',(component,)).fetchone()[0]
  db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,?,?, 'html-accessible','Tenant operations overview',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)",(screen,sid,eid,kind,cid,eid))
 app=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
 db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,'TENANT_OPERATIONS_GET',?,'GET','governance',1,'partial','tenant_operations_policy',?,?,'authenticated_read',1 WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method='GET')",(app,seed['endpoint'],json.dumps(seed['request']),json.dumps(seed['response']),app,seed['endpoint']))
 aid=db.execute("SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method='GET'",(app,seed['endpoint'])).fetchone()[0];db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(screen,aid,'Scoped administrative counts; no patient or employee contact data'))
 for lang,values in seed['locales'].items():
  lid=db.execute('SELECT language_id FROM languages WHERE language_code=?',(lang,)).fetchone()[0]
  for k,v in values.items():
   key='tenant_operations.'+k;db.execute("INSERT OR IGNORE INTO language_resources(resource_key,description,resource_group,context,active) VALUES(?,?,'tenant_operations','tenant_operations',1)",(key,seed['locales']['en'][k]));rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(key,)).fetchone()[0]
   db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) SELECT ?,?,?,0,0,'tenant-operations-v1' WHERE NOT EXISTS(SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?)",(rid,lid,v,rid,lid))
 db.commit();seed=json.loads(db.execute("SELECT definition FROM tenant_operations_policy WHERE id='admin-v1'").fetchone()[0]);seed['locales']={l:{k.split('.',1)[1]:v for k,v in db.execute("SELECT r.resource_key,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='tenant_operations' AND l.language_code=?",(l,))} for l in seed['locales']}
 return seed

def exports(seed):
 responses={'200':{'description':'Counts and scoped tenants from one repeatable-read snapshot','content':{'application/json':{'schema':seed['response']}}}}
 for code,message in [(400,'Unknown, duplicated or invalid query / tenant override'),(401,'Missing, expired or inactive session'),(403,'Administrator role required'),(404,'Unknown route'),(405,'Read-only endpoint'),(429,'Optional source limiter exceeded'),(503,'Unavailable data; no partial success response')]:
  responses[str(code)]={'description':message}
 operation={'summary':'Read scoped tenant setup counts and issue navigation','x-authorization':seed['roles'],'x-rate-limit':'Read-only endpoint; bounded 25-row pages and optional workspace source limiter','parameters':[{'name':k,'in':'query','schema':v} for k,v in seed['request']['properties'].items()],'responses':responses}
 spec={'openapi':'3.1.0','info':{'title':'PrimeCare Tenant Operations','version':'1.0.0'},'components':{'securitySchemes':{'bearer':{'type':'http','scheme':'bearer'}}},'security':[{'bearer':[]}],'paths':{seed['endpoint']:{'get':operation}}}
 return {'packages/shared/src/tenant-operations.json':json.dumps(seed,ensure_ascii=False,indent=2)+'\n','docs/platform-operations/openapi.json':json.dumps(spec,ensure_ascii=False,indent=2)+'\n'}
if __name__=='__main__':
 a=argparse.ArgumentParser();a.add_argument('--check',action='store_true');a.add_argument('--database',type=Path,default=ROOT/'.agents/governance/governance.db');args=a.parse_args();source=sqlite3.connect(args.database);db=sqlite3.connect(':memory:') if args.check else source
 if args.check:source.backup(db)
 for path,value in exports(register(db)).items():
  if args.check:assert (ROOT/path).read_text()==value,path+' differs from governance'
  else:(ROOT/path).write_text(value)
 print('Registered tenant operations section, 22 controls, scoped read API and EN/FR/ES resources')
