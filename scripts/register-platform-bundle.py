"""Register the user-selected first bundle before implementation; export persisted rows."""
import argparse,json,sqlite3,runpy
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def register(db):
 runpy.run_path(str(ROOT/'scripts/register-tenant-operations.py'))['register'](db)
 seed=json.loads((ROOT/'docs/platform-bundle/seed.json').read_text())
 assert all(set(v)==set(seed['locales']['en']) for v in seed['locales'].values())
 db.execute('CREATE TABLE IF NOT EXISTS platform_bundle_policy(id TEXT PRIMARY KEY,definition TEXT NOT NULL,requirement TEXT NOT NULL)')
 db.execute('INSERT OR REPLACE INTO platform_bundle_policy VALUES(?,?,?)',('first-v1',json.dumps(seed),'User selected first bundle: tenant launch, document renewals, support tickets and territory lead routing; 2026-10-16'))
 screen=db.execute("SELECT id FROM screens WHERE screen_code='PLATFORM_ADMINISTRATION'").fetchone()[0]
 db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status) SELECT ?,'platform-bundle','Tenant launch and growth operations','dashboard',27,'User-selected first bundle',1,'websites/typescript/src/platform-bundle/panel.ts','platform-bundle','created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code='platform-bundle')",(screen,screen))
 sid=db.execute("SELECT id FROM screen_sections WHERE screen_id=? AND section_code='platform-bundle'",(screen,)).fetchone()[0]
 controls=[]
 def add(kind,component,items):controls.extend((k,kind,component) for k in items.split())
 add('card','prime_card','platform-bundle bundle-attention bundle-attention-summary bundle-attention-row-{key} bundle-attention-range bundle-history-viewer bundle-history-heading bundle-history-range bundle-history-item-{id} bundle-board bundle-notice bundle-launch bundle-documents bundle-support bundle-routing bundle-summary bundle-ticket-{id} bundle-route-{id} bundle-check-{key} bundle-launch-state bundle-launch-feedback bundle-range bundle-document-{id} bundle-message-{id} bundle-history-{id} bundle-launch-notes')
 add('link','prime_button','platform-nav-bundle')
 add('form','prime_card','bundle-attention-form bundle-training-form bundle-launch-form bundle-upload-form bundle-review-form-{id} bundle-ticket-form bundle-reply-form-{id} bundle-triage-form-{id} bundle-enquiry-form bundle-route-form-{id} bundle-filter-form')
 add('input','prime_text_field','bundle-attention-search bundle-training-evidence bundle-launch-evidence bundle-review-evidence-{id} bundle-expires bundle-file bundle-subject bundle-message bundle-reply-{id} bundle-triage-evidence-{id} bundle-name bundle-email bundle-phone bundle-postal bundle-consent bundle-route-evidence-{id} bundle-search')
 add('select','prime_dropdown_web','bundle-attention-kind bundle-kind bundle-priority bundle-owner-{id} bundle-ticket-status-{id} bundle-ticket-priority-{id} bundle-service bundle-list')
 add('input','prime_checkbox_web','bundle-confirm bundle-consent-confirm')
 add('table','prime_table_web','bundle-document-table')
 add('button','prime_button','bundle-tab-attention bundle-attention-apply bundle-attention-previous bundle-attention-next bundle-attention-open-{key} bundle-tab-launch bundle-tab-documents bundle-tab-support bundle-tab-routing bundle-history-documents bundle-history-messages-{id} bundle-history-deadlines-{id} bundle-history-launch bundle-history-close bundle-history-retry bundle-history-previous bundle-history-next bundle-history-download-{id} bundle-refresh bundle-apply bundle-previous bundle-next bundle-training-save bundle-launch-submit bundle-launch-approve bundle-launch-request-changes bundle-upload bundle-download-{id} bundle-document-approve-{id} bundle-document-reject-{id} bundle-ticket-create bundle-reply-save-{id} bundle-triage-save-{id} bundle-reopen-{id} bundle-route-create bundle-route-accept-{id} bundle-route-decline-{id} bundle-route-reroute-{id} bundle-route-withdraw-{id}')
 for n,(key,kind,component) in enumerate(controls):
  db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,api_usage,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,?,?,?,1,1,?,?,'partial','governed_content','action_pending','test_pending','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)",(sid,screen,key,kind,key,key,seed['endpoint'],n,sid,key))
  eid=db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(sid,key)).fetchone()[0];cid=db.execute('SELECT id FROM primecare_ui_component_registry WHERE component_code=? AND active=1',(component,)).fetchone()[0]
  if key.startswith('bundle-history'):
   db.execute('UPDATE screen_section_elements SET api_usage=? WHERE id=?',(seed['endpoint']+'/tenants/{tenantId}/history',eid))
  if key.startswith('bundle-attention') or key=='bundle-tab-attention':db.execute('UPDATE screen_section_elements SET api_usage=? WHERE id=?',(seed['endpoint']+'/attention',eid))
  db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,?,?, 'html-accessible','First platform bundle',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)",(screen,sid,eid,kind,cid,eid))
 app=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
 for i,c in enumerate(seed['contracts']):
  db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,?,'governance',1,'partial','platform_bundle_policy',?,?,'platform_bundle.actor',? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?)",(app,'PLATFORM_BUNDLE_'+str(i),c['path'],c['method'],json.dumps(c['request']),json.dumps(c['response']),int(c['method']=='GET' and 'download' not in c['path']),app,c['path'],c['method']))
  db.execute('UPDATE api_endpoints SET request_schema=?,response_schema=? WHERE app_id=? AND route_path=? AND http_method=?',(json.dumps(c['request']),json.dumps(c['response']),app,c['path'],c['method']))
  aid=db.execute('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?',(app,c['path'],c['method'])).fetchone()[0];db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(screen,aid,'API-owned tenant scope, evidence, deadlines and guarded lead distribution'))
 for lang,values in seed['locales'].items():
  lid=db.execute('SELECT language_id FROM languages WHERE language_code=?',(lang,)).fetchone()[0]
  for k,v in values.items():
   key='platform_bundle.'+k;db.execute("INSERT OR IGNORE INTO language_resources(resource_key,description,resource_group,context,active) VALUES(?,?,'platform_bundle','platform_bundle',1)",(key,seed['locales']['en'][k]));rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(key,)).fetchone()[0]
   db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) SELECT ?,?,?,0,0,'first-bundle-v1' WHERE NOT EXISTS(SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?)",(rid,lid,v,rid,lid))
 db.commit();seed=json.loads(db.execute("SELECT definition FROM platform_bundle_policy WHERE id='first-v1'").fetchone()[0]);seed['locales']={l:{k.split('.',1)[1]:v for k,v in db.execute("SELECT r.resource_key,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='platform_bundle' AND l.language_code=?",(l,))} for l in seed['locales']};return seed

def exports(seed):
 paths={}
 for c in seed['contracts']:
  op={'summary':c['method']+' '+c['path'],'x-authorization':seed['roles'],'x-rate-limit':'30 mutations/minute per actor; 120 authenticated reads/minute per actor','parameters':[{'name':p,'in':'path','required':True,'schema':{'type':'string'}} for p in ['tenantId','id'] if '{'+p+'}' in c['path']],'responses':{'200':{'description':'Scoped current state or authenticated attachment'},'201':{'description':'Created'},**{str(n):{'description':v} for n,v in [(400,'Invalid fields'),(401,'Invalid session'),(403,'Forbidden'),(404,'Not found'),(405,'Method not allowed'),(409,'Version, readiness or workflow conflict'),(413,'Body too large'),(429,'Rate limit'),(503,'Unavailable; no partial transaction')]}}}
  op['responses']['200']['content']={('application/octet-stream' if 'download' in c['path'] else 'application/json'):{'schema':c['response']}}
  if c['method']=='POST':
   op['responses']['201']['content']={'application/json':{'schema':c['response']}}
   op['parameters'].append({'name':'Idempotency-Key','in':'header','required':True,'schema':{'type':'string','minLength':16,'maxLength':100}})
   op['requestBody']={'required':True,'content':{'application/json':{'schema':c['request']}}}
  elif 'download' not in c['path']:
   op['parameters'] += [{'name':k,'in':'query','schema':v} for k,v in (c['request']['properties'] if c['path'].endswith(('/attention','/history')) else {'offset':{'type':'integer','minimum':0,'maximum':100000},'list':{'enum':['tickets','routes']},'search':{'type':'string','maxLength':100}}).items()]
  paths.setdefault(c['path'],{})[c['method'].lower()]=op
 return {'packages/shared/src/platform-bundle/registry.json':json.dumps(seed,ensure_ascii=False,indent=2)+'\n','docs/platform-bundle/openapi.json':json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare First Platform Bundle','version':'1.0.0'},'security':[{'bearer':[]}],'components':{'securitySchemes':{'bearer':{'type':'http','scheme':'bearer'}}},'paths':paths},ensure_ascii=False,indent=2)+'\n'}
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');p.add_argument('--database',type=Path,default=ROOT/'.agents/governance/governance.db');args=p.parse_args();source=sqlite3.connect(args.database);db=sqlite3.connect(':memory:') if args.check else source
 if args.check:source.backup(db)
 for path,value in exports(register(db)).items():
  if args.check:assert (ROOT/path).read_text()==value,path+' differs from governance'
  else:(ROOT/path).write_text(value)
 print('First bundle registered: controls, API contracts, scope policy and EN/FR/ES')
