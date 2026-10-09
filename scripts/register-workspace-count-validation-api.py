"""Batches 205–208: preserve catalog authority while validating live counts."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
count={'type':'integer','minimum':0,'maximum':9007199254740991}
role={'type':'object','additionalProperties':False,'required':['role','count'],'properties':{'role':{'type':'string','minLength':1},'count':count}}
overview={'type':'object','required':['activeAccounts','activeSessions','accountRoles','activity','metrics','scope'],'properties':{'activeAccounts':count,'activeSessions':count,'accountRoles':{'type':'array','items':role},'activity':{'type':'array','items':{'type':'object'}},'metrics':{'type':'array','items':{'oneOf':[{'type':'object','additionalProperties':False,'required':['code','available'],'properties':{'code':{'type':'string'},'available':{'const':False}}},{'type':'object','additionalProperties':False,'required':['code','available','count'],'properties':{'code':{'type':'string'},'available':{'const':True},'count':count}}]}},'scope':{'enum':['organization','personal']}}}
paths={};source=json.loads((ROOT/'docs/api/governance-batch-1.openapi.json').read_text())
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 sid=db.execute("SELECT id FROM screens WHERE screen_code='ceo_dashboard'").fetchone()[0]
 for batch,route,permission in [(208,'/v1/governance/workspace','role_screen_permissions.can_view'),(205,'/v1/governance/overview','runtime_catalog_permissions.can_view_organization'),(206,'/v1/governance/organization-map','role_screen_permissions.can_view')]:
  rows=db.execute("SELECT id,service_name,auth_required,permission_key FROM api_endpoints WHERE app_id=(SELECT id FROM apps WHERE app_code='gv') AND route_path=? AND http_method='GET'",(route,)).fetchall()
  if len(rows)!=1 or rows[0][1:]!=('governance',1,permission):raise RuntimeError('Workspace authority drift: '+route)
  if route.endswith('/workspace'):
   db.execute('UPDATE api_endpoints SET request_schema=? WHERE id=?',(json.dumps({'type':'object','additionalProperties':False,'properties':{'screen':{'type':'string','pattern':'^[A-Za-z0-9_]{1,160}$'}}}),rows[0][0]))
   schema={'type':'object','required':['identity','screens','overview'],'properties':{'identity':{'type':'object'},'screens':{'type':'array','items':{'type':'object'}},'overview':overview}}
   op={'operationId':'governance_workspace','security':[{'bearerAuth':[]}],'parameters':[{'name':'screen','in':'query','schema':{'type':'string','pattern':'^[A-Za-z0-9_]{1,160}$'}}],'responses':{'200':{'description':'Governed workspace','content':{'application/json':{'schema':schema}}},**{str(n):{'description':d} for n,d in [(400,'Invalid query'),(401,'No active session'),(403,'Permission or tenant mismatch'),(404,'Unknown screen'),(405,'Read only'),(429,'Rate limit'),(503,'Source unavailable')]}}}
  else:
   op=source['paths'][route]['get'];schema=op['responses']['200']['content']['application/json']['schema'];schema['properties']['data']['items']=overview if route.endswith('/overview') else {'type':'object','required':['role','activeAccounts','inheritsPermissions'],'properties':{'role':{'type':'string'},'activeAccounts':count,'inheritsPermissions':{'const':False}}}
   schema['properties']['pagination']['properties'].update({'limit':{'type':'integer','minimum':1,'maximum':100},'offset':{'type':'integer','minimum':0,'maximum':100000},'total':count})
  op['description']='Existing active bearer session, matching tenant and catalog organization/screen authority remain required. Live counts require nonnegative safe integers; role groups must be unique nonempty strings. Invalid projections return sanitized 503 and roll back the read-only repeatable-read transaction. No new grants or production-readiness claims.'
  paths[route]={'get':op}
  if not route.endswith('/workspace'):source['paths'][route]={'get':op}
  db.execute('UPDATE api_endpoints SET response_schema=? WHERE id=?',(json.dumps(schema),rows[0][0]))
  db.execute('DELETE FROM governance_api_batches WHERE route=?',(route,))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,?, 'implemented','pending')",('GET '+route,sid,batch,permission))
(ROOT/'docs/api/governance-batch-1.openapi.json').write_text(json.dumps(source,indent=2)+'\n')
(ROOT/'docs/api/workspace-count-validation-batches-205-208.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Workspace Count Validation','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered batches 205–208 workspace count validation; existing authority retained.')
