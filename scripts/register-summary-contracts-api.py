"""Batches 901–950: align existing grouped read contracts with runtime validation."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
cases=json.loads((ROOT/'docs/api/summary-contract-batches-901-950.json').read_text())['changes']
def align(schema):
 groups=schema['properties']['groups'];count=groups['items']['properties']['count']
 if groups['type']!='array' or count['type']!='integer':raise RuntimeError('Summary schema drift')
 total=schema['properties']['pagination']['properties']['total']
 if total['type']!='integer' or total.get('minimum',0)!=0:raise RuntimeError('Zero pagination total must remain valid')
 total.update(minimum=0,maximum=9007199254740991)
 count.update(minimum=1,maximum=9007199254740991);groups['maxItems']=100
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 for case in cases:
  service=case['service'];route='/v1/'+service+case['path']
  permission={'client':'authenticated_client_profile_owner','provider':'authenticated_provider_profile_owner','auth':'authenticated_self_record_owner'}[service]
  if route=='/v1/provider/visits/summary':permission='authenticated_assigned_provider_visit'
  rows=db.execute("SELECT id,service_name,auth_required,permission_key,response_schema FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
  if len(rows)!=1 or rows[0][1:4]!=(service,1,permission):raise RuntimeError('Summary authority drift: '+route)
  schema=json.loads(rows[0][4]);align(schema)
  db.execute('UPDATE api_endpoints SET response_schema=? WHERE id=?',(json.dumps(schema),rows[0][0]))
  for file in (ROOT/'docs/api').glob('*.openapi.json'):
   document=json.loads(file.read_text());op=document.get('paths',{}).get(route,{}).get('get')
   if op:
    schema=op['responses']['200']['content']['application/json']['schema'];before=json.dumps(schema);align(schema)
    if before!=json.dumps(schema):file.write_text(json.dumps(document,indent=2)+'\n')
print('Aligned fifty existing summary contracts; zero totals/empty groups preserved.')
