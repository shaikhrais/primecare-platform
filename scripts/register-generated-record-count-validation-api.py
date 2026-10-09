"""Batches 199–200: non-coercive totals for generated owner-scoped reads."""
import json,sqlite3
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
families=[
 ('provider',ROOT/'cloudflare/workers/src/provider-records-registry.json','/v1/provider','authenticated_provider_profile_owner','psw_profile',199,'ProviderProfile owner'),
 ('auth',ROOT/'cloudflare/workers/src/self-records-registry.json','/v1/auth','authenticated_self_record_owner','login',200,'active bearer User owner'),
]
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
paths={}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 for service,registry_file,prefix,permission,screen_code,batch,owner in families:
  source=(ROOT/'cloudflare/workers/src'/('provider-records.ts' if service=='provider' else 'self-records.ts')).read_text()
  if 'const exactCount=' not in source or 'const total=Number((await db.query' in source:
   raise RuntimeError('Exact count runtime guard missing: '+service)
  sid=db.execute('SELECT id FROM screens WHERE screen_code=?',(screen_code,)).fetchone()[0]
  records=json.loads(registry_file.read_text())
  for record in records:
   if record.get('singleton'):continue
   suffixes=['']+(['/summary'] if record.get('summaryField') else [])
   for suffix in suffixes:
    route=prefix+record['path']+suffix
    rows=db.execute("SELECT id,service_name,auth_required,permission_key,response_schema FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
    if len(rows)!=1 or rows[0][1:4]!=(service,1,permission):
     raise RuntimeError('Generated owner count authority drift: '+route)
    schema=json.loads(rows[0][4]);total=schema['properties']['pagination']['properties']['total']
    total.clear();total.update(type='integer',minimum=0)
    db.execute('UPDATE api_endpoints SET response_schema=? WHERE id=?',(json.dumps(schema),rows[0][0]))
    db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,?, 'implemented','pending')",('GET '+route,sid,batch,permission))
    summary=suffix=='/summary'
    paths[route]={'get':{
     'operationId':('validate_'+service+'_'+record['table']+('_summary' if summary else '_list')).lower(),
     'summary':'Read validated owner-scoped '+record['table'].replace('_',' ')+' '+('groups' if summary else 'records'),
     'description':'Active explicit bearer session, matching non-null tenant and '+owner+' required. Every query retains the registered owner and tenant bindings. Pagination totals must be nonnegative safe integers returned by the database driver without coercion; malformed totals return a sanitized 503. Summary totals count stored groups, not records. Existing projections, no-store, bounded paging, read-only repeatable-read isolation and source limits remain unchanged. No owner overrides, role grants, business mutations, clinical interpretation, approval or completion claims.',
     'security':[{'bearerAuth':[]}],
     'parameters':[{'in':'query','name':name,'schema':definition} for name,definition in paging.items()],
     'responses':{'200':{'description':'Validated scoped records or stored groups','content':{'application/json':{'schema':schema}}},**{str(code):{'description':description} for code,description in [(400,'Invalid query or body'),(401,'No active bearer session'),(403,'Tenant mismatch'),(404,'Owned profile absent'),(405,'Read only'),(429,'Source limit'),(503,'Data unavailable')]}}
    }}
(ROOT/'docs/api/generated-record-count-validation-batches-199-200.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Generated Owner Record Count Validation','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered batches 199–200 exact generated owner-record counts; existing authority only.')
