"""Read-only, reproducible dashboard audit. Never reads stored test passwords."""
import json,re,sqlite3
from pathlib import Path
from collections import Counter
root=Path(__file__).resolve().parents[1]
db=sqlite3.connect(root/'.agents/governance/governance.db');db.row_factory=sqlite3.Row
roles=[dict(r) for r in db.execute('SELECT id,role_code,test_email,primary_app_code,primary_app_url,post_login_route FROM roles WHERE active=1 ORDER BY id')]
patterns={'simulated_success':r'fully implemented|featuresEnabled|dataLoaded|100% READY', 'empty_action':r'onPressed:\s*\(\)\s*\{\s*\}', 'simulated_delay':r'Future[^\n]*delayed', 'stub':r'TODO|Stub call|Placeholder'}
for role in roles:
 screens=[dict(s) for s in db.execute('SELECT id,screen_code,role_id,app_id,route_path,actual_file_path,production_ready,api_tag,test_tag FROM screens WHERE route_path=? AND active=1',(role['post_login_route'],))]
 findings=[];evidence=[]
 if not screens:findings.append('post_login_route_not_in_screen_registry')
 for s in screens:
  item={'screen':s['screen_code'],'path':s['actual_file_path'],'findings':[]}
  if s['role_id']!=role['id']:item['findings'].append('screen_role_mismatch')
  p=root/(s['actual_file_path'] or '')
  if not p.is_file():item['findings'].append('screen_file_missing')
  else:
   source=p.read_text(errors='replace')
   for label,pattern in patterns.items():
    if re.search(pattern,source):item['findings'].append(label)
  api_ids={r[0] for r in db.execute('SELECT api_id FROM screen_api_links WHERE screen_id=? UNION SELECT api_id FROM screen_api_map WHERE screen_id=?',(s['id'],s['id']))}
  item['api_count']=len(api_ids)
  if not api_ids:item['findings'].append('no_governed_api_link')
  for api_id in api_ids:
   a=db.execute('SELECT route_path,permission_key,request_schema,response_schema FROM api_endpoints WHERE id=?',(api_id,)).fetchone()
   if not a or not a['permission_key'] or not a['response_schema']:item['findings'].append('incomplete_api_contract')
  if not s['production_ready']:item['findings'].append('not_marked_production_ready')
  evidence.append(item);findings+=item['findings']
 # The active corporate route may use a local wrapper rather than the registry file.
 role['screens']=evidence;role['static_findings']=sorted(set(findings))
 role['runtime_status']='not_run_missing_test_password'
 role['fully_functional']='not_verified' if not findings else 'blocked_by_static_findings'
summary={'roles':len(roles),'roles_with_static_findings':sum(bool(r['static_findings']) for r in roles),'runtime_verified':0,'findings':dict(Counter(f for r in roles for f in r['static_findings']))}
out=root/'docs/audits/role-dashboards';out.mkdir(parents=True,exist_ok=True)
(out/'inventory.json').write_text(json.dumps({'summary':summary,'roles':roles},indent=2)+'\n')
lines=['# Role dashboard audit','', 'This is a static source/governance audit, not proof of live functionality. Login and browser checks have not run because TEST_DEFAULT_PASSWORD is absent. No user passwords were read.','',f"Active roles: {len(roles)}. Roles with concrete static findings: {summary['roles_with_static_findings']}.",'','| Role | App | Findings |','|---|---|---|']
for r in roles:lines.append('| '+r['role_code']+' | '+str(r['primary_app_code'])+' | '+('; '.join(r['static_findings']) or 'Needs runtime verification')+' |')
(out/'REPORT.md').write_text('\n'.join(lines)+'\n')
print(json.dumps(summary,indent=2))
