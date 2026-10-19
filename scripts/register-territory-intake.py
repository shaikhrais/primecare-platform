"""Govern the continuation linking existing public marketing forms to territory routing."""
import argparse,json,runpy,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def register(db):
 growth=runpy.run_path(str(ROOT/'scripts/register-growth-governance.py'))['register'];seed=growth(db)
 runpy.run_path(str(ROOT/'scripts/register-look-manager.py'))['register'](db)
 runpy.run_path(str(ROOT/'scripts/register-media-look.py'))['register'](db)
 seed=growth(db)
 db.execute('CREATE TABLE IF NOT EXISTS territory_intake_policy(id TEXT PRIMARY KEY,definition TEXT NOT NULL,requirement TEXT NOT NULL)')
 policy={'roles':seed['intakePolicy']['managerRoles'],'modes':seed['intakePolicy']['routingModes'],'modeMutable':False,'territoryPipeline':'client','sharingConsentVersion':seed['intakePolicy']['sharingConsentVersion'],'legacyMode':'direct'}
 db.execute('INSERT OR REPLACE INTO territory_intake_policy VALUES(?,?,?)',('v1',json.dumps(policy),'User: Continue first platform bundle; connect existing public marketing intake to consented territory matching; 2026-10-16'))
 controls={'founder_growth_dashboard':[('growth-intake-routing-mode','select','prime_dropdown_web')],'growth_public_enquiry':[('enquiry-postal','input','prime_text_field'),('enquiry-service','select','prime_dropdown_web'),('enquiry-sharing-consent','checkbox','prime_checkbox_web')]}
 for code,items in controls.items():
  row=db.execute('SELECT id FROM screens WHERE screen_code=?',(code,)).fetchone()
  if not row:raise ValueError('Missing governed screen '+code)
  screen=row[0];sid=db.execute('SELECT id FROM screen_sections WHERE screen_id=? ORDER BY id LIMIT 1',(screen,)).fetchone()[0]
  for n,(key,kind,component) in enumerate(items):
   db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,api_usage,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,?,?,?,1,1,'/v1/governance/growth/enquiries/{key}',?,'partial','governed_content','action_pending','test_pending','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE screen_id=? AND element_key=?)",(sid,screen,key,kind,key,key,500+n,screen,key))
   eid=db.execute('SELECT id FROM screen_section_elements WHERE screen_id=? AND element_key=?',(screen,key)).fetchone()[0];cid=db.execute('SELECT id FROM primecare_ui_component_registry WHERE component_code=? AND active=1',(component,)).fetchone()[0]
   db.execute('UPDATE screen_section_elements SET api_usage=? WHERE id=?',('/v1/governance/growth/intake-links' if key.startswith('growth-intake') else '/v1/governance/growth/enquiries/{key}',eid))
   db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,?,?, 'html-accessible','Public territory intake',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)",(screen,sid,eid,kind,cid,eid))
 db.commit();return seed
def spec_export(db,seed):
 spec=json.loads((ROOT/'docs/marketing/growth.openapi.json').read_text())
 for c in seed['contracts']:
  if not (c['suffix'].startswith('/intake-links') or c['suffix']=='/enquiries/{key}'):continue
  path=seed['endpoint']+c['suffix'];op=spec['paths'][path][c['method'].lower()]
  request,response=db.execute("SELECT request_schema,response_schema FROM api_endpoints WHERE route_path=? AND http_method=? AND service_name='governance'",(path,c['method'])).fetchone()
  if c['method']!='GET':op.setdefault('requestBody',{'required':True})['content']={'application/json':{'schema':json.loads(request)}}
  if c.get('public'):
   op['responses']['200' if c['method']=='GET' else '202']['content']={'application/json':{'schema':json.loads(response)}}
  op['description']='Delivery mode is immutable. Legacy links use direct tenant delivery. Territory client forms require explicit sharing consent and are delivered only after recipient acceptance. Source tenants receive total submission counts without contact or duplicate classifications.'
 return json.dumps(spec,ensure_ascii=False,indent=2)+'\n'
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');p.add_argument('--database',type=Path,default=ROOT/'.agents/governance/governance.db');a=p.parse_args();source=sqlite3.connect(a.database);db=sqlite3.connect(':memory:') if a.check else source
 if a.check:source.backup(db)
 seed=register(db);spec=spec_export(db,seed)
 if a.check:
  assert json.loads((ROOT/'packages/shared/src/growth/registry.json').read_text())==seed,'Growth policy export differs'
  assert (ROOT/'docs/marketing/growth.openapi.json').read_text()==spec,'Intake OpenAPI differs'
 else:(ROOT/'docs/marketing/growth.openapi.json').write_text(spec)
 print('Territory intake policy, controls, contracts and EN/FR/ES registered')
