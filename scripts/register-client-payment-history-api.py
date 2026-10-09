"""Batches 209–211: owner-scoped payment history through the invoice relation."""
import copy,json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
source=json.loads((ROOT/'docs/api/booking-payment-batches-23-25.openapi.json').read_text())
base='/v1/client/invoices/{invoiceId}/payments'
definitions=[(209,'/v1/client/payments',base,'CLIENT_OWN_PAYMENT_HISTORY'),(210,'/v1/client/payments/{paymentId}',base+'/{paymentId}','CLIENT_OWN_PAYMENT_DETAIL'),(211,'/v1/client/payments/summary',base+'/summary','CLIENT_OWN_PAYMENT_STATUS_SUMMARY')]
paths={}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 for table,required in [('client_profiles',{'id','user_id','tenant_id'}),('invoices',{'id','client_id','tenant_id'}),('payments',{'id','invoice_id','amount','status','created_at','updated_at'})]:
  cols={r[0] for r in db.execute('SELECT c.column_name FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if not required<=cols:raise RuntimeError('Missing registered payment relationship: '+table)
 sid,app=db.execute("SELECT id,app_id FROM screens WHERE screen_code='client_profile' AND active=1").fetchone()
 for batch,route,canonical,code in definitions:
  existing=db.execute("SELECT permission_key,response_schema FROM api_endpoints WHERE route_path=? AND http_method='GET'",(canonical,)).fetchall()
  if len(existing)!=1 or existing[0][0]!='authenticated_client_profile_owner':raise RuntimeError('Canonical payment authority drift')
  operation=copy.deepcopy(source['paths'][canonical]['get'])
  response=operation['responses']['200']['content']['application/json']['schema']
  if json.loads(existing[0][1])!=response:raise RuntimeError('Canonical payment response drift')
  detail='{paymentId}' in route
  operation['parameters']=[p for p in operation['parameters'] if p['name']!='invoiceId']
  query={p['name']:p['schema'] for p in operation['parameters'] if p['in']=='query'}
  request={'type':'object','additionalProperties':False,'properties':query}
  operation['operationId']=code.lower()
  operation['summary']=code.replace('_',' ').lower()
  operation['description']='Active explicit bearer session, a unique owned client profile and matching tenant required. Every payment query joins invoices and restricts invoice.client_id and invoice.tenant_id to that profile and actor tenant. No invoice selection is required. Foreign/missing detail returns 404; an empty owned history returns 200 with zero results. Unknown fields, arbitrary owner/tenant/invoice/status filters, duplicate paging and all writes are denied. Exact decimal strings and nullable stored statuses are preserved; processor IDs, notes and invoice internals are excluded. Summary pagination counts stored status groups, null last, without settlement, currency or free-capacity inference. Existing authenticated_client_profile_owner authority only; no administrative or financial write grants.'
  operation['responses']['404']['description']='Owned client profile or payment absent'
  if detail:
   response['properties']['payment']['properties']['amount']['pattern']=r'^-?\d+(?:\.\d+)?$'
  elif route.endswith('/summary'):
   response['properties']['groups']['items']['properties']['count']['maximum']=9007199254740991
  else:
   response['properties']['payments']['items']['properties']['amount']['pattern']=r'^-?\d+(?:\.\d+)?$'
  if not detail:
   response['properties']['pagination']['properties'].update({'limit':{'type':'integer','minimum':1,'maximum':100},'offset':{'type':'integer','minimum':0,'maximum':100000},'total':{'type':'integer','minimum':0,'maximum':9007199254740991}})
  db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,'GET','client',1,'implemented','authenticated_client_profile_owner',?,?,'workspace.source',? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')",(app,code,route,json.dumps(request),json.dumps(response),int(not detail),route))
  aid=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchone()[0]
  db.execute("UPDATE api_endpoints SET request_schema=?,response_schema=? WHERE id=? AND permission_key='authenticated_client_profile_owner'",(json.dumps(request),json.dumps(response),aid))
  db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Own payment metadata through the registered invoices.client_id/tenant_id relation'))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,'authenticated_client_profile_owner','implemented','pending')",('GET '+route,sid,batch))
  paths[route]={'get':operation}
(ROOT/'docs/api/client-payment-history-batches-209-211.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Own Payment History','version':'1.0.0'},'paths':paths,'components':source['components']},indent=2)+'\n')
print('Registered batches 209–211 owned payment history; no new role or write grants.')
