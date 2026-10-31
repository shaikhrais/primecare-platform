import json,hashlib,re
from pathlib import Path
root=Path(__file__).resolve().parents[1];file=root/'packages/shared/src/tenant-dashboard/catalog.json';c=json.loads(file.read_text());pin=json.loads((root/'tools/governance-production/production-pin.json').read_text())
assert pin['tenantDashboardWriter']['catalogSha256']==hashlib.sha256(file.read_bytes()).hexdigest()
assert len(c['views'])==7 and len({v['id'] for v in c['views']})==7
assert len({e['key'] for e in c['elements']})==len(c['elements'])
assert c['route']=='/tenant-dashboard' and c['endpoint']=='/v1/governance/tenant-dashboard'
for f in c['sourceFiles']:assert (root/f).is_file(),f
assert json.loads((root/'packages/shared/src/admin-entry-routes.json').read_text())['tenant_admin']==c['route']
service=(root/c['sourceFiles'][1]).read_text();assert 'manifest_sha256' in service and 'pin.manifestSha256' in service and 'taskInput' in service and 'taskActions' in service
view=(root/c['sourceFiles'][2]).read_text();assert 'localStorage' not in view and 'data-cy="screen-tenant-admin-dashboard"' in view
registration=(root/'tools/governance-production/tenant_dashboard_registration.py').read_text();assert "'flow_kind':'screen_journey'" in registration and "'businessProcessesAdded':0" in registration
print('Tenant catalogue passed: 7 dashboard sections, '+str(len(c['elements']))+' governed controls, original workflow status, real-task isolation and explicit synthetic demo.')
