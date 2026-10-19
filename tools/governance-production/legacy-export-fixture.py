#!/usr/bin/env python3
import argparse, datetime, json, pathlib, sqlite3

PORTALS = {
  'primecare-business-development': ('bd', 4, 'PrimeCare Business Development'),
  'primecare-client': ('cl', 5, 'PrimeCare Client'),
  'primecare-clinic': ('ci', 6, 'PrimeCare Clinic'),
  'primecare-corporate': ('co', 7, 'PrimeCare Corporate'),
  'primecare-franchise': ('fr', 9, 'PrimeCare Franchise'),
  'primecare-marketing': ('ma', 11, 'PrimeCare Marketing'),
  'primecare-support': ('su', 12, 'PrimeCare Support'),
  'primecare-governance': ('go', 10, 'PrimeCare Governance'),
  'primecare-enterprise-blueprint': ('ui', 1, 'PrimeCare Enterprise Blueprint'),
}

def rows(cursor, query, args=()): return [dict(row) for row in cursor.execute(query, args)]

def export(db_path, output, gateway, auth):
  connection = sqlite3.connect(db_path); connection.row_factory = sqlite3.Row; cursor = connection.cursor()
  theme = {row['css_variable_name']: row['token_value'] for row in rows(cursor, "select css_variable_name,token_value from theme_design_tokens where theme_id=1 and active=1")}
  resources = {row['resource_key']: row['translated_text'] for row in rows(cursor, "select lr.resource_key,lrv.translated_text from language_resources lr join language_resource_values lrv on lrv.resource_id=lr.resource_id where lr.active=1 and lrv.approved=1 and lrv.language_id=1")}
  output.mkdir(parents=True, exist_ok=True)
  for project, (app_code, app_id, name) in PORTALS.items():
    role_list = rows(cursor, "select distinct r.id,r.role_code code,r.role_name name from roles r join screens s on s.role_id=r.id where s.app_id=? and r.active=1 and s.active=1 order by r.role_name", (app_id,))
    screen_list = rows(cursor, "select s.id,s.screen_code code,s.screen_name name,s.route_path route,s.role_id,r.role_name roleName,s.stage,s.implementation_tag implementation,s.api_tag api from screens s left join roles r on r.id=s.role_id where s.app_id=? and s.active=1 order by r.role_name,s.screen_name", (app_id,))
    for screen in screen_list:
      sections = rows(cursor, "select id,section_code code,section_name name,section_type type,coalesce(purpose,'') purpose,coalesce(test_id,'section-'||section_code) testId from screen_sections where screen_id=? and required=1 order by section_order", (screen['id'],))
      for section in sections:
        section['elements'] = rows(cursor, "select element_key key,element_type type,coalesce(label,element_key) label,test_id testId,required from screen_section_elements where section_id=? and screen_id=? and required=1 order by element_order", (section['id'], screen['id']))
        section.pop('id', None)
      screen['sections'] = sections
    role_ids = [role['id'] for role in role_list]
    capabilities = {}
    for role_id in role_ids:
      capabilities[str(role_id)] = rows(cursor, "select f.feature_code code,f.feature_name name,coalesce(f.description,'') description,p.can_view 'view',p.can_create 'create',p.can_edit 'edit',p.can_delete 'delete',p.can_export 'export' from role_feature_permissions p join features f on f.id=p.feature_id where p.role_id=? and f.active=1 order by f.feature_name", (role_id,))
    workflow_list = rows(cursor, "select w.id,w.workflow_code code,w.workflow_name name,w.role_id roleId from workflow_definitions w where w.app_id=? and w.status='active' order by w.role_id,w.workflow_name", (app_id,))
    for workflow in workflow_list:
      workflow['steps'] = rows(cursor, "select ws.step_order `order`,ws.step_name name,ws.screen_id screenId,s.route_path route,coalesce(ws.expected_result,'') expected,ws.status from workflow_steps ws left join screens s on s.id=ws.screen_id where ws.workflow_id=? and ws.status='active' order by ws.step_order", (workflow['id'],))
      workflow.pop('id', None)
    manifest = {'project':project,'appCode':app_code,'name':name,'apiGateway':gateway,'authPortal':'/login','roles':role_list,'screens':screen_list,'capabilities':capabilities,'workflows':workflow_list,'theme':theme,'resources':resources,'generatedAt':datetime.datetime.now(datetime.timezone.utc).isoformat()}
    target = output / project; target.mkdir(parents=True, exist_ok=True)
    (target / 'portal.json').write_text(json.dumps(manifest, separators=(',',':')), encoding='utf-8')
  connection.close()

if __name__ == '__main__':
  parser=argparse.ArgumentParser(); parser.add_argument('--db',default='.agents/governance/governance.db'); parser.add_argument('--output',default='websites/typescript/generated'); parser.add_argument('--gateway',required=True); parser.add_argument('--auth',default='/login')
  args=parser.parse_args(); export(args.db,pathlib.Path(args.output),args.gateway,args.auth)
