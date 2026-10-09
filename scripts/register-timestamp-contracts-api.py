"""Batches 1101–1150: align existing timestamp syntax contracts with runtime validation."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
cases=json.loads((ROOT/'docs/api/timestamp-contract-batches-1101-1150.json').read_text())['changes']
TIMESTAMP_PATTERN=r'^\d{4}-\d{2}-\d{2}T(?:[01]\d|2[0-3]):[0-5]\d:[0-5]\d(?:\.\d+)?(?:Z|[+-](?:[01]\d|2[0-3]):[0-5]\d)$'
def align(schema,field):
 count=0
 if not isinstance(schema,dict):return count
 if field in schema.get('properties',{}):
  prop=schema['properties'][field]
  types=prop['type'] if isinstance(prop['type'],list) else [prop['type']]
  if 'string' not in types or prop.get('format')!='date-time':raise RuntimeError('Timestamp contract drift')
  prop.update(minLength=20,pattern=TIMESTAMP_PATTERN);count+=1
 for value in schema.values():
  if isinstance(value,dict):count+=align(value,field)
  elif isinstance(value,list):
   for item in value:count+=align(item,field)
 return count
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 for case in cases:
  service=case['service'];name='self' if service=='auth' else service
  record=next(r for r in json.loads((ROOT/f'cloudflare/workers/src/{name}-records-registry.json').read_text()) if r['path']==case['path'])
  if case['field'] not in record['dateFields']:raise RuntimeError('Registered timestamp required')
  prefix='/v1/'+service+case['path'];permission={'client':'authenticated_client_profile_owner','provider':'authenticated_provider_profile_owner','auth':'authenticated_self_record_owner'}[service]
  routes=[prefix]+([] if record.get('singleton') else [prefix+'/{recordId}'])
  for route in routes:
   rows=db.execute("SELECT id,service_name,auth_required,permission_key,response_schema FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
   if len(rows)!=1 or rows[0][1:4]!=(service,1,permission):raise RuntimeError('Timestamp contract authority drift: '+route)
   schema=json.loads(rows[0][4]);assert align(schema,case['field'])>0
   db.execute('UPDATE api_endpoints SET response_schema=? WHERE id=?',(json.dumps(schema),rows[0][0]))
  for file in (ROOT/'docs/api').glob('*.openapi.json'):
   document=json.loads(file.read_text());changed=False
   for route in routes:
    op=document.get('paths',{}).get(route,{}).get('get')
    if op:
     schema=op['responses']['200']['content']['application/json']['schema']
     before=json.dumps(schema);align(schema,case['field']);changed|=before!=json.dumps(schema)
   if changed:file.write_text(json.dumps(document,indent=2)+'\n')
print('Aligned fifty existing timestamp fields; no new endpoints or authority.')
