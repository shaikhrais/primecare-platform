"""Batches 249–253 validate existing CEO read projections without changing grants."""
import copy,json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sources=[
 (249,'account-batch-2.openapi.json','/v1/admin/users'),
 (250,'account-batch-4.openapi.json','/v1/admin/users/{userId}'),
 (251,'account-batch-3.openapi.json','/v1/admin/users/{userId}/sessions'),
 (252,'account-batch-3.openapi.json','/v1/admin/users/audit'),
 (253,'account-batch-4.openapi.json','/v1/admin/users/creation-audit'),
]
paths={}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 # Validate the entire family before updating any registered contract.
 identifiers={}
 for batch,filename,route in sources:
  rows=db.execute("SELECT id,service_name,auth_required,permission_key FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
  if len(rows)!=(2 if batch==249 else 1) or any(row[1:]!=('auth',1,'auth_account_management_policy') for row in rows):raise RuntimeError('Account read authority drift: GET '+route)
  identifiers[route]=[row[0] for row in rows]
 sid=db.execute("SELECT id FROM screens WHERE screen_code='ceo_dashboard' AND active=1").fetchone()[0]
 for batch,filename,route in sources:
  operation=copy.deepcopy(json.loads((ROOT/'docs/api'/filename).read_text())['paths'][route]['get'])
  schema=operation['responses']['200']['content']['application/json']['schema']
  if batch==249:
   user=schema['properties']['users']['items']
   if 'updated_at' not in user['required']:user['required'].append('updated_at')
   user['properties']['updated_at']['format']='date-time'
  operation['x-batch']=batch
  operation['description']+=' Explicit projections exclude unregistered adapter fields. Required identifiers and date-time fields are validated without coercion; invalid projected rows roll back and return sanitized no-store 503. Null account states are retained only where the existing contract allows them.'
  for aid in identifiers[route]:db.execute('UPDATE api_endpoints SET response_schema=? WHERE id=?',(json.dumps(schema),aid))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,'auth_account_management_policy','implemented','pending')",('GET '+route,sid,batch))
  paths[route]={'get':operation}
(ROOT/'docs/api/account-read-validation-batches-249-253.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare CEO Account Read Validation','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered batches 249–253 validated CEO read projections; existing authority only.')
