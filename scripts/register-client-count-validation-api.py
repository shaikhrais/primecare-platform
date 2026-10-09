"""Batch 195: exact non-coercive counts for existing owned client reads."""
import json,sqlite3
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
source=ROOT/'docs/api/booking-payment-batches-23-25.openapi.json'
document=json.loads(source.read_text())
routes=['/v1/client/booking-requests/summary','/v1/client/invoices/{invoiceId}/payments','/v1/client/invoices/{invoiceId}/payments/summary']
paths={}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 sid=db.execute("SELECT id FROM screens WHERE screen_code='client_profile'").fetchone()[0]
 for route in routes:
  rows=db.execute("SELECT id,service_name,auth_required,permission_key FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
  if len(rows)!=1 or rows[0][1:]!=('client',1,'authenticated_client_profile_owner'):
   raise RuntimeError('Client owner count authority drift: '+route)
  schema=document['paths'][route]['get']['responses']['200']['content']['application/json']['schema']
  pagination=schema['properties']['pagination']['properties']
  if pagination['total']!={'type':'integer','minimum':0}:
   raise RuntimeError('Exact nonnegative count contract required: '+route)
  db.execute('UPDATE api_endpoints SET response_schema=? WHERE id=?',(json.dumps(schema),rows[0][0]))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,195,'authenticated_client_profile_owner','implemented','pending')",('GET '+route,sid))
  operation=document['paths'][route]['get']
  operation['description']='Active explicit bearer session, unique owned client profile and matching non-null tenant required. Booking-request queries bind client_id and tenant_id. Payments join their invoice and bind invoice ID, client ID and tenant ID. Runtime totals must be nonnegative safe integers without coercion; malformed driver values return a sanitized 503. Stored status groups retain null values. Read only; no processor identifiers, owner overrides, role grants, settlement, approval or completion claims.'
  paths[route]=operation
(ROOT/'docs/api/client-count-validation-batch-195.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Validated Owned Client Counts','version':'1.0.0'},'paths':paths,'components':document['components']},indent=2)+'\n')
print('Registered batch 195 non-coercive owned client counts; existing authority only.')
