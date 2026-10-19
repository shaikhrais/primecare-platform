"""Register RN/supervisor/support care workflow; no real credentials or assignments."""
import argparse,json,sqlite3,runpy
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]

def register(db):
 runpy.run_path(str(ROOT/'scripts/register-growth-governance.py'))['register'](db)
 seed=json.loads((ROOT/'docs/care/seed.json').read_text())
 assert all(set(v)==set(seed['locales']['en']) for v in seed['locales'].values())
 roles={r[0]:r[1] for r in db.execute('SELECT role_code,id FROM roles WHERE active=1')}
 assert set(seed['roles'])<=set(roles)
 db.execute('CREATE TABLE IF NOT EXISTS care_delivery_policy(id TEXT PRIMARY KEY,definition TEXT NOT NULL,requirement TEXT NOT NULL)')
 db.execute('INSERT OR REPLACE INTO care_delivery_policy VALUES(?,?,?)',('care-v1',json.dumps(seed),seed['requirement']))
 app=db.execute("SELECT id FROM apps WHERE app_code='ci'").fetchone()[0]
 db.execute("INSERT INTO screens(id,app_id,role_id,screen_code,screen_name,route_path,actual_file_path,stage,active,implementation_tag,content_tag,api_tag,test_tag) SELECT ?,?,?,'care_delivery','Care delivery','/care','websites/typescript/src/care/dashboard.ts','created',1,'partial','governed_content','care_connected','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screens WHERE screen_code='care_delivery')",(seed['screenId'],app,roles['rn']))
 screen=db.execute("SELECT id FROM screens WHERE screen_code='care_delivery'").fetchone()[0]
 db.execute("INSERT INTO screen_requirements(screen_id,business_purpose,user_story,sidebar_label,acceptance_criteria) SELECT ?,'Assigned, qualified care delivery','Supervisor assigns; nurse authors; independent clinician approves; support worker records care and concerns','Care delivery','Tenant/assignment isolation, credential expiry, consent, versioned plans, immutable notes, independent review and no controlled acts' WHERE NOT EXISTS(SELECT 1 FROM screen_requirements WHERE screen_id=?)",(screen,screen))
 for role in seed['roles']:
  db.execute('INSERT OR REPLACE INTO role_screen_permissions(role_id,screen_id,can_view,can_create,can_edit,can_delete,can_export) VALUES(?,?,1,1,1,0,0)',(roles[role],screen))
  if role!='tenant_admin':db.execute("UPDATE roles SET post_login_route='/care' WHERE role_code=?",(role,))
 db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status) SELECT ?,'care-workflow','Care workflow','dashboard',1,'Assignment, care record and clinical review',1,'websites/typescript/src/care/dashboard.ts','care-workflow','created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code='care-workflow')",(screen,screen))
 sid=db.execute("SELECT id FROM screen_sections WHERE screen_id=? AND section_code='care-workflow'",(screen,)).fetchone()[0]
 components={'card':'prime_card','form':'prime_card','input':'prime_text_field','textarea':'prime_textarea_web','select':'prime_dropdown_web','checkbox':'prime_checkbox_web','button':'prime_button','link':'prime_button','image':'prime_image_web','icon':'prime_icon_web'}
 for n,(key,kind) in enumerate(seed['controls'].items()):
  cid=db.execute('SELECT id FROM primecare_ui_component_registry WHERE component_code=? AND active=1',(components[kind],)).fetchone();assert cid
  db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,api_usage,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,?,?,?,1,1,?,?,'partial','governed_content','action_pending','care_connected','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)",(sid,screen,key,kind,key,key,seed['endpoint'],n,sid,key))
  eid=db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(sid,key)).fetchone()[0]
  db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,?,?,'html-accessible','Governed care workflow',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)",(screen,sid,eid,kind,cid[0],eid))
 api_app=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
 for c in seed['contracts']:
  route=seed['endpoint']+c['suffix'];code='CARE_'+c['method']+'_'+c['suffix'].replace('/','_').replace('{','').replace('}','')
  db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,?,'governance',1,'partial','care.current_staff_and_assignment',?,?,'care.actor',? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?)",(api_app,code,route,c['method'],json.dumps(c['request']),json.dumps(c['response']),int(c['method']=='GET'),api_app,route,c['method']))
  aid=db.execute('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?',(api_app,route,c['method'])).fetchone()[0]
  db.execute('UPDATE api_endpoints SET request_schema=?,response_schema=? WHERE id=?',(json.dumps(c['request']),json.dumps(c['response']),aid))
  db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(screen,aid,'Current staff, tenant and assignment purpose; no marketing access'))
 for lang,values in seed['locales'].items():
  lid=db.execute('SELECT language_id FROM languages WHERE language_code=?',(lang,)).fetchone()[0]
  for key,value in values.items():
   resource='care.'+key
   db.execute("INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,'care','Care delivery','care',1)",(resource,))
   rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(resource,)).fetchone()[0]
   db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) SELECT ?,?,?,0,0,'care-v1' WHERE NOT EXISTS(SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?)",(rid,lid,value,rid,lid))
 db.commit()
 seed=json.loads(db.execute("SELECT definition FROM care_delivery_policy WHERE id='care-v1'").fetchone()[0])
 seed['locales']={lang:{key[5:]:value for key,value in db.execute("SELECT r.resource_key,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='care' AND l.language_code=?",(lang,))} for lang in seed['locales']}
 grants=[dict(zip(['role','view','create','edit','delete','export'],r)) for r in db.execute('SELECT r.role_code,p.can_view,p.can_create,p.can_edit,p.can_delete,p.can_export FROM role_screen_permissions p JOIN roles r ON r.id=p.role_id WHERE p.screen_id=? AND r.active=1',(screen,))]
 sections=[{'code':'care-workflow','name':'Care workflow','type':'dashboard','purpose':'Scoped care workflow','testId':'care-workflow','elements':[dict(zip(['key','type','label','testId','actionRequired','apiUsage'],r)) for r in db.execute('SELECT element_key,element_type,label,test_id,action_required,api_usage FROM screen_section_elements WHERE screen_id=? ORDER BY element_order',(screen,))]}]
 contracts=[{'code':'CARE_'+c['method']+'_'+c['suffix'].replace('/','_').replace('{','').replace('}',''),'method':c['method'],'route':seed['endpoint']+c['suffix'],'implementation':'partial','permission':'care.current_staff_and_assignment','health':None,'lastTested':None,'requestSchema':c['request'],'responseSchema':c['response'],'schemas':1} for c in seed['contracts']]
 entry={'id':screen,'code':'care_delivery','name':'Care delivery','route':'/care','appCode':'ci','role':'rn','renderer':'dashboard','lifecycle':'created','productionReady':False,'blockers':['Independent clinical, privacy, accessibility and release acceptance pending'],'sections':sections,'grants':grants,'requirements':{'business_purpose':'Assigned care delivery','user_story':seed['requirement'],'acceptance_criteria':'Scoped care records and qualified human decisions'},'contracts':contracts,'pendingActions':[{'key':key,'label':key,'status':'action_pending','apiUsage':seed['endpoint']} for key in seed['controls']]}
 return seed,entry

if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');args=p.parse_args();source=sqlite3.connect(ROOT/'.agents/governance/governance.db');db=sqlite3.connect(':memory:') if args.check else source
 if args.check:source.backup(db)
 seed,entry=register(db);out=ROOT/'packages/shared/src/care/registry.json';text=json.dumps(seed,ensure_ascii=False,indent=2)+'\n'
 workspace_path=ROOT/'cloudflare/workers/src/workspace-registry.json';workspace=json.loads(workspace_path.read_text());workspace['screens']=[s for s in workspace['screens'] if s['code']!='care_delivery']+[entry]
 for role in seed['roles']:
  if role!='tenant_admin':workspace['landings'][role]='/care'
 rendered=json.dumps(workspace,separators=(',',':'))+'\n'
 paths={}
 for c in seed['contracts']:
  route=seed['endpoint']+c['suffix']
  operation={'summary':'Scoped care '+c['suffix'].strip('/').replace('/',' ') if c['suffix'] else 'Read assigned care worklist and record','security':[{'session':[]}],'description':'Active tenant and governed care role required. Current clearance, assignment purpose, independent reviewer and state/version checks apply. Manual human verification is not live regulator verification. No controlled-act or medication authority is granted.','responses':{'200' if c['suffix']!='/cases' else '201':{'description':'Persisted scoped care result','content':{'application/json':{'schema':c['response']}}}}}
  for status,label in [(400,'Invalid fields, consent or tenant override'),(401,'Session inactive or expired'),(403,'Role, qualification or action denied'),(404,'Hidden or missing record'),(405,'Method denied'),(409,'Stale version or workflow state'),(413,'Record limit'),(429,'Rate limit'),(503,'Storage or schema unavailable')]:operation['responses'][str(status)]={'description':label}
  operation['parameters']=([{'name':'id','in':'path','required':True,'schema':{'type':'string','format':'uuid'}}] if '{id}' in route else [])
  if c['method']=='GET':operation['parameters'] += [{'name':k,'in':'query','schema':v} for k,v in c['request']['properties'].items()]
  else:
   operation['parameters'].append({'name':'idempotency-key','in':'header','required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9_-]{16,100}$'}})
   operation['requestBody']={'required':True,'content':{'application/json':{'schema':c['request']}}}
  paths.setdefault(route,{})[c['method'].lower()]=operation
 api=ROOT/'docs/care/openapi.json';api_text=json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare RN, supervisor and support care','version':'1.0.0'},'components':{'securitySchemes':{'session':{'type':'http','scheme':'bearer'}}},'paths':paths},ensure_ascii=False,indent=2)+'\n'
 if args.check:assert out.read_text()==text and workspace_path.read_text()==rendered and api.read_text()==api_text,'Care exports differ'
 else:out.write_text(text);workspace_path.write_text(rendered);api.write_text(api_text)
 print('Registered care role workflow, controls, API contracts and EN/FR/ES; real assignments created: 0')
