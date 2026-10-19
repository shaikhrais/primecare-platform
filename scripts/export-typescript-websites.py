#!/usr/bin/env python3
"""Export portal manifests from the pinned production governance database."""
import argparse, datetime, json, pathlib, sqlite3, sys
sys.path.insert(0,str(pathlib.Path(__file__).resolve().parents[1]/'tools/governance-production'))
from connection import connect
PORTALS = {
 'primecare-business-development':('bd',4,'PrimeCare Business Development'),
 'primecare-client':('cl',5,'PrimeCare Client'),'primecare-clinic':('ci',6,'PrimeCare Clinic'),
 'primecare-corporate':('co',7,'PrimeCare Corporate'),'primecare-franchise':('fr',9,'PrimeCare Franchise'),
 'primecare-marketing':('ma',11,'PrimeCare Marketing'),'primecare-support':('su',12,'PrimeCare Support'),
 'primecare-governance':('go',10,'PrimeCare Governance'),'primecare-enterprise-blueprint':('ui',1,'PrimeCare Enterprise Blueprint')}
TABLES=('theme_design_tokens','language_resources','language_resource_values','roles','screens','screen_sections','screen_section_elements','role_feature_permissions','features','workflow_definitions','workflow_steps')
def export(db_path,output,gateway,auth):
 with connect(db_path) as db:
  db.row_factory=sqlite3.Row
  data={name:[dict(r) for r in db.execute('SELECT * FROM '+name)] for name in TABLES}
  source=getattr(db,'pin',None)
 by=lambda table,key:{r[key]:r for r in data[table]}
 roles=by('roles','id');resources=by('language_resources','resource_id');features=by('features','id');screens=by('screens','id')
 theme={r['css_variable_name']:r['token_value'] for r in data['theme_design_tokens'] if r['theme_id']==1 and r['active']==1}
 labels={resources[r['resource_id']]['resource_key']:r['translated_text'] for r in data['language_resource_values'] if r['resource_id'] in resources and resources[r['resource_id']]['active']==1 and r['approved']==1 and r['language_id']==1}
 output.mkdir(parents=True,exist_ok=True)
 for project,(app_code,app_id,name) in PORTALS.items():
  app_screens=[s for s in data['screens'] if s['app_id']==app_id and s['active']==1]
  role_ids={s['role_id'] for s in app_screens if s['role_id'] in roles and roles[s['role_id']]['active']==1}
  role_list=sorted([{'id':rid,'code':roles[rid]['role_code'],'name':roles[rid]['role_name']} for rid in role_ids],key=lambda r:r['name'])
  screen_list=[]
  for s in sorted(app_screens,key=lambda s:((roles.get(s['role_id']) or {}).get('role_name') or '',s['screen_name'])):
   sections=[]
   for sec in sorted([r for r in data['screen_sections'] if r['screen_id']==s['id'] and r['required']==1],key=lambda r:r['section_order']):
    elements=[{'key':r['element_key'],'type':r['element_type'],'label':r['label'] if r['label'] is not None else r['element_key'],'testId':r['test_id'],'required':r['required']} for r in sorted([r for r in data['screen_section_elements'] if r['section_id']==sec['id'] and r['screen_id']==s['id'] and r['required']==1],key=lambda r:r['element_order'])]
    sections.append({'code':sec['section_code'],'name':sec['section_name'],'type':sec['section_type'],'purpose':sec['purpose'] if sec['purpose'] is not None else '','testId':sec['test_id'] if sec['test_id'] is not None else 'section-'+sec['section_code'],'elements':elements})
   screen_list.append({'id':s['id'],'code':s['screen_code'],'name':s['screen_name'],'route':s['route_path'],'role_id':s['role_id'],'roleName':(roles.get(s['role_id']) or {}).get('role_name'),'stage':s['stage'],'implementation':s['implementation_tag'],'api':s['api_tag'],'sections':sections})
  capabilities={}
  for rid in role_ids:
   capabilities[str(rid)]=[{'code':features[p['feature_id']]['feature_code'],'name':features[p['feature_id']]['feature_name'],'description':features[p['feature_id']]['description'] or '',**{key:p['can_'+key] for key in ('view','create','edit','delete','export')}} for p in sorted([p for p in data['role_feature_permissions'] if p['role_id']==rid and p['feature_id'] in features and features[p['feature_id']]['active']==1],key=lambda p:features[p['feature_id']]['feature_name'])]
  workflows=[]
  for w in sorted([w for w in data['workflow_definitions'] if w['app_id']==app_id and w['status']=='active'],key=lambda w:(w['role_id'] if w['role_id'] is not None else -1,w['workflow_name'])):
   steps=[{'order':r['step_order'],'name':r['step_name'],'screenId':r['screen_id'],'route':(screens.get(r['screen_id']) or {}).get('route_path'),'expected':r['expected_result'] if r['expected_result'] is not None else '','status':r['status']} for r in sorted([r for r in data['workflow_steps'] if r['workflow_id']==w['id'] and r['status']=='active'],key=lambda r:r['step_order'])]
   workflows.append({'code':w['workflow_code'],'name':w['workflow_name'],'roleId':w['role_id'],'steps':steps})
  manifest={'project':project,'appCode':app_code,'name':name,'apiGateway':gateway,'authPortal':'/login','roles':role_list,'screens':screen_list,'capabilities':capabilities,'workflows':workflows,'theme':theme,'resources':labels,'generatedAt':datetime.datetime.now(datetime.timezone.utc).isoformat()}
  if source:manifest['governanceSource']={'authority':source['authority'],'schema':source['schema'],'tablePrefix':source['tablePrefix'],'manifestSha256':source['manifestSha256']}
  target=output/project;target.mkdir(parents=True,exist_ok=True);(target/'portal.json').write_text(json.dumps(manifest,separators=(',',':')),encoding='utf8')
 return {'portals':len(PORTALS),'source':source['authority'] if source else 'explicit-sqlite-fixture','queries':len(TABLES)}
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--db',default=None,help='Fixture-only database; production is the default');p.add_argument('--output',default='websites/typescript/generated');p.add_argument('--gateway',required=True);p.add_argument('--auth',default='/login');a=p.parse_args();print(json.dumps(export(a.db,pathlib.Path(a.output),a.gateway,a.auth)))
