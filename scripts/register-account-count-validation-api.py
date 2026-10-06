"""Batches 203–204: exact counts for owned booking audit and self sessions."""
import json,sqlite3
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
sources=[
 (203,'ceo_dashboard','auth','auth_account_management_policy',ROOT/'docs/api/account-batch-2.openapi.json',[('GET','/v1/admin/users')]),
 (204,'ceo_dashboard','auth','auth_account_management_policy',ROOT/'docs/api/account-batch-3.openapi.json',[('GET','/v1/admin/users/{userId}/sessions'),('DELETE','/v1/admin/users/{userId}/sessions'),('GET','/v1/admin/users/audit')]),
 (204,'ceo_dashboard','auth','auth_account_management_policy',ROOT/'docs/api/account-batch-4.openapi.json',[('GET','/v1/admin/users/creation-audit')]),
]
paths={}
for source in [ROOT/'cloudflare/workers/src/account-management.ts',ROOT/'cloudflare/workers/src/account-admin.ts']:
 text=source.read_text()
 if 'const exactCount=' not in text or 'Number((await db.query' in text:raise RuntimeError('Exact count runtime guard missing: '+source.name)
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 for batch,screen_code,service,permission,source_file,routes in sources:
  document=json.loads(source_file.read_text());sid=db.execute('SELECT id FROM screens WHERE screen_code=?',(screen_code,)).fetchone()[0]
  for method,route in routes:
   rows=db.execute("SELECT id,service_name,auth_required,permission_key FROM api_endpoints WHERE app_id=(SELECT id FROM apps WHERE app_code='at') AND route_path=? AND http_method=?",(route,method)).fetchall()
   if len(rows)!=1 or rows[0][1:]!=(service,1,permission):raise RuntimeError('Owner/session count authority drift: '+method+' '+route)
   operation=document['paths'][route][method.lower()];schema=operation['responses']['200']['content']['application/json']['schema']
   count_schema=schema['properties']['pagination']['properties']['total'] if method=='GET' else schema['properties']['revokedSessions']
   if count_schema!={'type':'integer','minimum':0}:raise RuntimeError('Exact nonnegative count contract required: '+method+' '+route)
   db.execute('UPDATE api_endpoints SET response_schema=? WHERE id=?',(json.dumps(schema),rows[0][0]))
   db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,?, 'implemented','pending')",(method+' '+route,sid,batch,permission))
   operation['description']='Requires the existing active explicit CEO bearer session and matching non-null tenant. Target lookup remains tenant-scoped and self-revocation remains blocked. Counts must be nonnegative safe integers without coercion; malformed counts roll back and return a sanitized 503. Bounded paging, no-store, mutation limits and atomic audit behavior remain enforced. No additional role grants or clinical access.'
   paths.setdefault(route,{})[method.lower()]=operation
(ROOT/'docs/api/account-count-validation-batches-203-204.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Account Count Validation','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered batches 203–204 exact account counts; existing authority only.')
