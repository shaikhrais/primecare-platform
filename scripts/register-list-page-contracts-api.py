"""Batches 951–1000: align existing list response pagination with runtime validation."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
cases=json.loads((ROOT/'docs/api/list-page-contract-batches-951-1000.json').read_text())['changes']
def align(schema):
 props=schema['properties'];arrays=[v for k,v in props.items() if k!='pagination' and v.get('type')=='array']
 if len(arrays)!=1:raise RuntimeError('Unique record collection required')
 arrays[0]['maxItems']=100
 paging=props['pagination']['properties']
 for name,minimum,maximum in [('limit',1,100),('offset',0,100000),('total',0,9007199254740991)]:
  if paging[name]['type']!='integer':raise RuntimeError('Pagination type drift')
  paging[name].update(minimum=minimum,maximum=maximum)
 if paging['hasMore']['type']!='boolean':raise RuntimeError('Pagination flag drift')
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 for case in cases:
  service=case['service'];route='/v1/'+service+case['path']
  permission={'client':'authenticated_client_profile_owner','provider':'authenticated_provider_profile_owner','auth':'authenticated_self_record_owner'}[service]
  rows=db.execute("SELECT id,service_name,auth_required,permission_key,response_schema FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
  if len(rows)!=1 or rows[0][1:4]!=(service,1,permission):raise RuntimeError('List authority drift: '+route)
  schema=json.loads(rows[0][4]);align(schema)
  db.execute('UPDATE api_endpoints SET response_schema=? WHERE id=?',(json.dumps(schema),rows[0][0]))
  for file in (ROOT/'docs/api').glob('*.openapi.json'):
   document=json.loads(file.read_text());op=document.get('paths',{}).get(route,{}).get('get')
   if op:
    schema=op['responses']['200']['content']['application/json']['schema'];before=json.dumps(schema);align(schema)
    if before!=json.dumps(schema):file.write_text(json.dumps(document,indent=2)+'\n')
print('Aligned fifty list page contracts; empty pages and zero totals preserved.')
