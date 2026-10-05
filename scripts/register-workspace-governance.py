"""Reconcile governed routes and register the authenticated page renderer.

Created pages are partial until domain workflow, browser and accessibility
evidence exists. This script never turns template evidence into readiness.
"""
import csv, hashlib, json, re, sqlite3
import runpy
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / '.agents/governance/governance.db'
PORTALS = {'corporate': 'co', 'clinic': 'ci', 'clinical': 'ci', 'client': 'cl',
           'support': 'su', 'franchise': 'fr', 'marketing': 'ma',
           'business-development': 'bd', 'governance': 'go'}
runpy.run_path(str(ROOT/'scripts/register-provider-self-api.py'))
runpy.run_path(str(ROOT/'scripts/register-client-self-api.py'))
runpy.run_path(str(ROOT/'scripts/register-self-sessions-api.py'))
runpy.run_path(str(ROOT/'scripts/register-account-list-api.py'))
runpy.run_path(str(ROOT/'scripts/register-account-admin-batch.py'))
runpy.run_path(str(ROOT/'scripts/register-account-detail-batch.py'))
runpy.run_path(str(ROOT/'scripts/register-governance-api-batch.py'))
with sqlite3.connect(DB) as db:
    db.row_factory = sqlite3.Row
    db.execute('''CREATE TABLE IF NOT EXISTS screen_runtime_views (
      screen_id INTEGER PRIMARY KEY REFERENCES screens(id), renderer TEXT NOT NULL,
      lifecycle TEXT NOT NULL DEFAULT 'created', blockers_json TEXT NOT NULL,
      endpoint TEXT NOT NULL, evidence TEXT NOT NULL DEFAULT 'not_tested')''')
    db.execute('''CREATE TABLE IF NOT EXISTS runtime_catalog_permissions (
      role_id INTEGER PRIMARY KEY REFERENCES roles(id), can_view_inventory INTEGER NOT NULL DEFAULT 0,
      can_view_organization INTEGER NOT NULL DEFAULT 0)''')
    # Route role/office are explicit business requirements already in governance.
    roles = {r['role_code']: r for r in db.execute('SELECT id,role_code,post_login_route FROM roles WHERE active=1')}
    apps = {r['app_code']: r['id'] for r in db.execute('SELECT id,app_code FROM apps')}
    for screen in db.execute('SELECT id,route_path,role_id,app_id FROM screens WHERE active=1').fetchall():
        match = re.match(r'^/offices/([^/]+)/roles/([^/]+)/', screen['route_path'] or '')
        if match and match[2] in roles and match[1] in PORTALS:
            role_id, app_id = roles[match[2]]['id'], apps[PORTALS[match[1]]]
            if match[2] != 'guest':
                db.execute('DELETE FROM role_screen_permissions WHERE screen_id=? AND role_id=?',(screen['id'],roles['guest']['id']))
                db.execute('DELETE FROM role_screen_map WHERE screen_id=? AND role_id=?',(screen['id'],roles['guest']['id']))
            if (role_id, app_id) != (screen['role_id'], screen['app_id']):
                db.execute('DELETE FROM role_screen_permissions WHERE screen_id=? AND role_id<>?', (screen['id'], role_id))
                db.execute('DELETE FROM role_screen_map WHERE screen_id=? AND role_id<>?', (screen['id'], role_id))
                db.execute('UPDATE screens SET role_id=?,app_id=? WHERE id=?', (role_id, app_id, screen['id']))
                db.execute('UPDATE sidebar_items SET role_id=?,app_id=? WHERE screen_id=?', (role_id, app_id, screen['id']))
    for code in ['ceo', 'governance', 'maintenance']:
        r = db.execute('SELECT id FROM roles WHERE role_code=?', (code,)).fetchone()
        if r:
            db.execute('INSERT OR REPLACE INTO runtime_catalog_permissions VALUES(?,?,?)', (r[0], 1, int(code == 'ceo')))
    for code in ['screen_progress_dashboard', 'admin_screen_health']:
        item=db.execute('SELECT id FROM screens WHERE screen_code=? AND active=1',(code,)).fetchone()
        if not item: continue
        db.execute('UPDATE screens SET role_id=?,app_id=? WHERE id=?',(roles['governance']['id'],apps['go'],item[0]))
        for role_code in ['ceo','governance','maintenance']:
            if role_code in roles:
                db.execute('INSERT OR IGNORE INTO role_screen_permissions(role_id,screen_id,can_view) VALUES(?,?,1)',(roles[role_code]['id'],item[0]))
        if not db.execute('SELECT 1 FROM screen_sections WHERE screen_id=?',(item[0],)).fetchone():
            for order,(suffix,name,kind,purpose) in enumerate([
                ('header','Page status','header','Authenticated page context'),
                ('overview','Overview','metrics','Live workspace and organization counts'),
                ('activity','Recent activity','list','Recent tenant account and configuration changes'),
                ('navigation','Page navigation','action_bar','Open an authorized governed page')],1):
                section_code=code+'_'+suffix
                db.execute('''INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,
                  section_order,purpose,required,test_id,status) VALUES(?,?,?,?,?,?,1,?,\'created\')''',
                  (item[0],section_code,name,kind,order,purpose,'section-'+section_code.replace('_','-')))
    for role in roles.values():
        db.execute('''INSERT OR IGNORE INTO role_screen_permissions(role_id,screen_id,can_view)
          SELECT ?,id,1 FROM screens WHERE role_id=? AND active=1''', (role['id'], role['id']))
    endpoint = '/v1/governance/workspace'
    response_schema = json.dumps({'type': 'object', 'required': ['identity', 'screens', 'overview'],
      'properties': {'identity': {'type':'object'}, 'screens': {'type':'array'}, 'overview': {'type':'object'}}})
    db.execute('''INSERT OR IGNORE INTO api_endpoints(app_id,endpoint_code,route_path,http_method,
      service_name,auth_required,implementation_status,permission_key,response_schema,uses_pagination)
      VALUES(?, 'GOVERNED_WORKSPACE_READ',?,'GET','governance',1,'implemented',
      'role_screen_permissions.can_view',?,1)''', (apps['gv'], endpoint, response_schema))
    api_id = db.execute('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=\'GET\'', (apps['gv'],endpoint)).fetchone()[0]
    db.execute('UPDATE api_endpoints SET rate_limit_key=\'workspace.source\',uses_pagination=0 WHERE id=?',(api_id,))
    screens = []
    for row in db.execute('''SELECT s.*,r.role_code,a.app_code FROM screens s
      LEFT JOIN roles r ON r.id=s.role_id LEFT JOIN apps a ON a.id=s.app_id
      WHERE s.active=1 ORDER BY s.id''').fetchall():
        s = dict(row)
        protected_auth = s['screen_code'] in ['consent', 'mfa', 'reset_password', 'MAINTENANCE_CONFIGURATION'] or s['app_code']=='au'
        blockers = [] if protected_auth else ['Business workflow and domain data binding need verification',
          'Authenticated browser and accessibility evidence is pending']
        renderer = 'account' if protected_auth else 'dashboard' if 'dashboard' in s['screen_code'] else 'governed_page'
        db.execute('INSERT OR REPLACE INTO screen_runtime_views(screen_id,renderer,lifecycle,blockers_json,endpoint,evidence) VALUES(?,?,\'created\',?,?,\'not_tested\')', (s['id'],renderer,json.dumps(blockers),endpoint))
        if not protected_auth:
            db.execute('''UPDATE screens SET stage='created',implementation_tag='partial',content_tag='governed_content',
              api_tag='workspace_connected',test_tag='test_pending',review_tag='pending',
              runtime_verified=0,cypress_verified=0,production_ready=0,completeness_score=0,
              actual_file_path='packages/primecare_ui/lib/src/features/workspace/governed_workspace_screen.dart' WHERE id=?''', (s['id'],))
            db.execute('''UPDATE screen_sections SET implementation_tag='partial',test_tag='test_pending',
              api_tag='workspace_connected',status='created' WHERE screen_id=?''', (s['id'],))
            db.execute('''UPDATE screen_section_elements SET test_tag='test_pending',
              action_tag=CASE WHEN action_required=1 THEN 'action_pending' ELSE 'no_action' END,
              implementation_tag='partial',api_tag='workspace_connected' WHERE screen_id=?''',(s['id'],))
            db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,\'authenticated_workspace_read\')',(s['id'],api_id))
        sections=[]
        for sec in db.execute('SELECT section_code code,section_name name,section_type type,purpose,test_id testId,id FROM screen_sections WHERE screen_id=? AND required=1 ORDER BY section_order',(s['id'],)):
            section=dict(sec)
            section['elements']=[dict(e) for e in db.execute('SELECT element_key key,element_type type,label,test_id testId,action_required actionRequired,api_usage apiUsage FROM screen_section_elements WHERE section_id=? AND required=1 ORDER BY element_order',(sec['id'],))]
            section.pop('id');sections.append(section)
        grants=[dict(g) for g in db.execute('SELECT r.role_code role,p.can_view view,p.can_create \"create\",p.can_edit edit,p.can_delete \"delete\",p.can_export export FROM role_screen_permissions p JOIN roles r ON r.id=p.role_id WHERE p.screen_id=? AND p.can_view=1 AND r.active=1',(s['id'],))]
        name=re.sub(r'(?<=[a-z])(?=[A-Z])',' ',s['screen_name'] or s['screen_code']).removesuffix(' Screen')
        requirement=db.execute('SELECT business_purpose,user_story,acceptance_criteria FROM screen_requirements WHERE screen_id=?',(s['id'],)).fetchone()
        requirements=dict(requirement) if requirement else {}
        contracts=[dict(a) for a in db.execute('''SELECT DISTINCT a.endpoint_code code,a.http_method method,
          a.route_path route,a.implementation_status implementation,a.permission_key permission,
          a.health_status health,a.last_tested_at lastTested,
          a.request_schema requestSchema,a.response_schema responseSchema,
          CASE WHEN a.request_schema IS NOT NULL AND a.response_schema IS NOT NULL THEN 1 ELSE 0 END schemas
          FROM api_endpoints a WHERE a.id IN
          (SELECT api_id FROM screen_api_links WHERE screen_id=? UNION SELECT api_id FROM screen_api_map WHERE screen_id=?)
          ORDER BY a.route_path,a.http_method''',(s['id'],s['id']))]
        for contract in contracts:
            for field in ('requestSchema','responseSchema'):
                try: contract[field]=json.loads(contract[field]) if contract[field] else None
                except (ValueError,TypeError): contract[field]=None
        pending_actions=[dict(e) for e in db.execute('''SELECT element_key key,label,action_tag status,api_usage apiUsage
          FROM screen_section_elements WHERE screen_id=? AND required=1 AND action_required=1
          AND COALESCE(action_tag,'') NOT IN ('implemented','functional','action_implemented') ORDER BY element_order''',(s['id'],))]
        if not protected_auth:
            if not requirements.get('acceptance_criteria'): blockers.append('Acceptance criteria are missing')
            domain_contracts=[a for a in contracts if a['route']!=endpoint]
            if not domain_contracts: blockers.append('No domain API is linked to this page')
            elif any(not a['permission'] or not a['schemas'] for a in domain_contracts): blockers.append('Domain API authorization or schemas are incomplete')
            if pending_actions: blockers.append(f'{len(pending_actions)} required business actions are pending')
            db.execute('UPDATE screen_runtime_views SET blockers_json=? WHERE screen_id=?',(json.dumps(blockers),s['id']))
        screens.append({'id':s['id'],'code':s['screen_code'],'name':name,'route':s['route_path'],
          'appCode':s['app_code'],'role':s['role_code'],'renderer':renderer,'lifecycle':'created',
          'productionReady':False,'blockers':blockers,'sections':sections,'grants':grants,
          'requirements':requirements,'contracts':contracts,'pendingActions':pending_actions})
    permissions={r['role_code']:{'inventory':bool(r['can_view_inventory']),'organization':bool(r['can_view_organization'])} for r in db.execute('SELECT r.role_code,p.* FROM runtime_catalog_permissions p JOIN roles r ON r.id=p.role_id')}
    registry={'version':1,'endpoint':endpoint,'screens':screens,'permissions':permissions,
      'landings':{code:r['post_login_route'] for code,r in roles.items() if r['post_login_route']},
      'resources':{'workspace.title':'Organization overview','workspace.refresh':'Refresh','workspace.pages':'Pages',
        'workspace.pending':'Unfinished work','workspace.search':'Search pages','workspace.sign_out':'Sign out',
        'workspace.empty':'No activity yet','workspace.unavailable':'Unable to load the workspace. Try again.',
        'workspace.created':'Page created','workspace.account':'Account','workspace.open':'Open page',
        'workspace.users':'Active accounts','workspace.sessions':'Active sessions','workspace.roles':'Account roles',
        'workspace.activity':'Recent organization activity','workspace.inventory':'Page inventory',
        'workspace.export':'Download inventory','workspace.no_data':'No verified business data source is connected to this section yet.',
        'workspace.no_action':'This business action has no verified backend implementation yet.',
        'workspace.forbidden':'You do not have permission to view this page.',
        'workspace.loading':'Loading workspace','workspace.retry':'Retry','workspace.portal':'Portal',
        'workspace.role':'Role','workspace.status':'Status','workspace.current_password':'Current password',
        'workspace.new_password':'New password','workspace.change_password':'Change password',
        'workspace.clients':'Clients','workspace.providers':'Providers','workspace.visits':'Visits',
        'workspace.invoices':'Invoices','workspace.schedules':'Schedules','workspace.unconnected':'Data source unavailable',
        'workspace.request_failed':'Request failed','workspace.requirements':'Page requirements',
        'workspace.acceptance':'Acceptance criteria','workspace.contracts':'API connections',
        'workspace.pending_actions':'Pending actions','workspace.details':'View delivery details',
        'workspace.no_requirements':'No requirements are registered for this page.',
        'workspace.no_contracts':'No API contracts are registered for this page.',
        'workspace.no_pending_actions':'No pending actions are registered.',
        'workspace.previous':'Previous page','workspace.next':'Next page'}}
    target=ROOT/'cloudflare/workers/src/workspace-registry.json'
    target.write_text(json.dumps(registry,separators=(',',':'))+'\n')
    catalog_path=ROOT/'cloudflare/workers/src/governance-api-registry.json'
    catalog=json.loads(catalog_path.read_text())
    catalog['version']=hashlib.sha256(json.dumps({'bindings':catalog['bindings'],'roles':catalog['roles'],'hierarchy':catalog['hierarchy'],'workspace':registry},sort_keys=True).encode()).hexdigest()[:16]
    catalog_path.write_text(json.dumps(catalog,separators=(',',':'))+'\n')
    for key,text in registry['resources'].items():
        db.execute('INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,\'workspace\',?,\'Authenticated governed workspace\',1)',(key,text))
        resource=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(key,)).fetchone()[0]
        if not db.execute('SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=1',(resource,)).fetchone():
            db.execute('INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) VALUES(?,1,?,1,1,\'1\')',(resource,text))
    route_map={s['route']:s['code'] for s in screens if s['route'] and s['renderer']!='account'}
    dart='// Generated from governance.db by register-workspace-governance.py.\n'
    dart+='const governedWorkspaceRoutes = <String, String>'+json.dumps(route_map,indent=2)+';\n'
    dart+='const governedWorkspaceRoleRoutes = <String, List<String>>'+json.dumps({r:[s['route'] for s in screens if s['renderer']!='account' and any(g['role']==r and g['view'] for g in s['grants'])] for r in roles},indent=2)+';\n'
    landings={}
    for code,role in roles.items():
        allowed=[s for s in screens if s['renderer']!='account' and any(g['role']==code and g['view'] for g in s['grants'])]
        if allowed:
            configured=next((s for s in allowed if s['route']==role['post_login_route']),None)
            landings[code]=(configured or next((s for s in allowed if s['renderer']=='dashboard'),allowed[0]))['route']
    registry['landings']=landings
    target.write_text(json.dumps(registry,separators=(',',':'))+'\n')
    catalog_path=ROOT/'cloudflare/workers/src/governance-api-registry.json'
    catalog=json.loads(catalog_path.read_text())
    catalog['version']=hashlib.sha256(json.dumps({'bindings':catalog['bindings'],'roles':catalog['roles'],'hierarchy':catalog['hierarchy'],'workspace':registry},sort_keys=True).encode()).hexdigest()[:16]
    catalog_path.write_text(json.dumps(catalog,separators=(',',':'))+'\n')
    dart+='const governedWorkspaceLandings = <String, String>'+json.dumps(landings,indent=2)+';\n'
    out=ROOT/'packages/primecare_ui/lib/src/features/workspace/workspace_routes_generated.dart';out.parent.mkdir(parents=True,exist_ok=True);out.write_text(dart)
    report=ROOT/'docs/audits/page-readiness';report.mkdir(parents=True,exist_ok=True)
    with (report/'inventory.csv').open('w',newline='') as f:
        writer=csv.writer(f);writer.writerow(['Screen','Name','App','Role','Route','Page status','Production ready','Pending work','Required pending actions','Registered APIs','Acceptance criteria'])
        for s in screens:writer.writerow([s['code'],s['name'],s['appCode'],s['role'],s['route'],s['lifecycle'],'No','; '.join(s['blockers']) or 'Existing account flow requires separate evidence',
          '; '.join(a['label'] or a['key'] for a in s['pendingActions']),
          '; '.join(a['method']+' '+a['route'] for a in s['contracts']),s['requirements'].get('acceptance_criteria','')])
    (report/'README.md').write_text(f'# Page readiness\n\n{len(screens)} active screens are registered. Pages are created, with permission-controlled routes and an authenticated workspace API. Creation does not prove each business workflow is implemented.\n\nThe inventory records domain bindings and browser/accessibility verification still required. Previous blanket implemented/API-connected tags have been replaced with partial/workspace-connected status. No production-ready or test-passed flags are fabricated.\n')
    lines=['# Outstanding page implementation','',
      'Generated from governance.db. Created means an authorized shared page exists; it does not establish completion of its domain workflow.',
      '', '| App | Screens | Dashboards | Pending business actions |', '|---|---:|---:|---:|']
    for app in sorted({s['appCode'] for s in screens}):
        group=[s for s in screens if s['appCode']==app]
        lines.append(f"| {app} | {len(group)} | {sum(s['renderer']=='dashboard' for s in group)} | {sum(len(s['pendingActions']) for s in group)} |")
    lines.extend(['','## Registered blockers',''])
    for blocker,count in Counter(b for s in screens for b in s['blockers'] if not re.match(r'^\d+ required',b)).most_common():
        lines.append(f'- {count} pages: {blocker}.')
    lines.extend(['','The CSV inventory contains every page, its exact route, linked API methods, acceptance criteria and named pending actions.',
      'Live tenant workflows, authenticated browser tests, translations and accessibility remain release requirements.'])
    (report/'OUTSTANDING.md').write_text('\n'.join(lines)+'\n')
    for path in [ROOT/'packages/flutter_core/assets/translations/en.json', *ROOT.glob('apps/*/assets/translations/en.json')]:
        if path.is_file():
            translations=json.loads(path.read_text());translations['workspace']={k.split('.',1)[1]:v for k,v in registry['resources'].items()}
            path.write_text(json.dumps(translations,ensure_ascii=False,indent=4)+'\n')
print(json.dumps({'screens':len(screens),'created':sum(s['renderer']!='account' for s in screens),'production_ready':0}))
