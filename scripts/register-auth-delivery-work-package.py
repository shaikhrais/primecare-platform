"""Reconcile four existing auth handlers; unsupported workflows stay pending."""
import copy,json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
body=json.loads((ROOT/'docs/api/auth-body-bounds-batches-254-258.openapi.json').read_text())['paths']
results=json.loads((ROOT/'docs/api/auth-result-validation-batches-259-263.openapi.json').read_text())['paths']
policies={'login':'credential_login','logout':'optional_self_session_logout','forgot-password':'public_password_recovery','reset-password':'secret_code_password_reset'}
paths={}
for name in policies:
 route='/v1/auth/'+name
 if name=='logout':
  op={'operationId':'authDeliveryLogout','security':[],'description':'Idempotent logout. Bearer or cookie is optional; only the supplied session hash is deleted. Body/query are ignored.','responses':{'200':{'description':'Signed out','content':{'application/json':{'schema':{'type':'object','additionalProperties':False,'required':['status'],'properties':{'status':{'const':'signed_out'}}}}}}}}
 else:
  op=copy.deepcopy(body[route]['post'])
  if route in results:op['responses']['200']=copy.deepcopy(results[route]['post']['responses']['200'])
  op['operationId']='authDelivery'+name.replace('-','_');op['security']=[]
 op['x-governance-permission']=policies[name];paths[route]={'post':op}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 selected=[];screens=db.execute("SELECT id FROM screens WHERE screen_code='login'").fetchall()
 if len(screens)!=1:raise RuntimeError('Unique existing login screen required')
 sid=screens[0][0]
 for name,permission in policies.items():
  route='/v1/auth/'+name
  rows=db.execute("SELECT id,service_name,auth_required,permission_key FROM api_endpoints WHERE http_method='POST' AND route_path=?",(route,)).fetchall()
  if len(rows)!=1 or rows[0][1:] not in [('PRISMA',1,None),('auth',0,permission)]:raise RuntimeError('Auth delivery authority drift: '+route)
  selected.append((rows[0][0],route,permission))
 for aid,route,permission in selected:
  op=paths[route]['post'];request=op.get('requestBody',{}).get('content',{}).get('application/json',{}).get('schema',{'type':'object','description':'Body/query ignored; optional own session token determines deletion'})
  response=op['responses']['200']['content']['application/json']['schema']
  db.execute("UPDATE api_endpoints SET service_name='auth',auth_required=0,implementation_status='implemented',permission_key=?,request_schema=?,response_schema=?,health_status='unverified' WHERE id=?",(permission,json.dumps(request),json.dumps(response),aid))
  db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Existing auth workflow reconciliation; no new grants'))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,0,?,'implemented','pending')",('POST '+route,sid,permission))
(ROOT/'docs/api/auth-delivery-work-package.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Existing Auth Delivery Reconciliation','version':'1.0.0'},'paths':paths},indent=2)+'\n')
print('Reconciled four existing auth operations; ten reviewed declarations remain unresolved.')
