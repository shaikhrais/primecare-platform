"""Batches 23–25: client-owned booking and invoice payment metadata reads."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','additionalProperties':False,'required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer'},'offset':{'type':'integer'},'total':{'type':'integer','minimum':0},'hasMore':{'type':'boolean'}}}
group={'type':'object','additionalProperties':False,'required':['status','count'],'properties':{'status':{'type':['string','null']},'count':{'type':'integer','minimum':0}}}
payment={'type':'object','additionalProperties':False,'required':['id','amount','status','created_at','updated_at'],'properties':{'id':{'type':'string'},'amount':{'type':['string','null'],'description':'Exact recorded decimal; no currency or settlement inference.'},'status':{'type':['string','null']},'created_at':{'type':'string','format':'date-time'},'updated_at':{'type':'string','format':'date-time'}}}
summary={'type':'object','additionalProperties':False,'required':['groups','pagination'],'properties':{'groups':{'type':'array','items':group},'pagination':pagination}}
base='/v1/client/invoices/{invoiceId}/payments'
definitions=[(23,'/v1/client/booking-requests/summary','CLIENT_OWN_BOOKING_REQUEST_STATUS_SUMMARY',summary,True),(24,base,'CLIENT_OWN_INVOICE_PAYMENTS',{'type':'object','required':['payments','pagination'],'properties':{'payments':{'type':'array','items':payment},'pagination':pagination}},True),(24,base+'/{paymentId}','CLIENT_OWN_INVOICE_PAYMENT_DETAIL',{'type':'object','required':['payment'],'properties':{'payment':payment}},False),(25,base+'/summary','CLIENT_OWN_INVOICE_PAYMENT_STATUS_SUMMARY',summary,True)]
paths={}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 for table,required in [('booking_requests',{'status','client_id','tenant_id'}),('invoices',{'id','client_id','tenant_id'}),('payments',{'invoice_id',*payment['required']})]:
  cols={r[0] for r in db.execute('SELECT c.column_name FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if not required <= cols:raise RuntimeError('Missing registered columns: '+table)
 sid,app=db.execute("SELECT id,app_id FROM screens WHERE screen_code='client_profile'").fetchone()
 for batch,route,code,response,paged in definitions:
  request={'type':'object','additionalProperties':False,'properties':paging if paged else {}}
  db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,'GET','client',1,'implemented','authenticated_client_profile_owner',?,?,'workspace.source',? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')",(app,code,route,json.dumps(request),json.dumps(response),int(paged),route))
  aid=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchone()[0]
  db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Owned metadata and recorded status counts; no financial mutations or processor identifiers'))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,'authenticated_client_profile_owner','implemented','pending')",('GET '+route,sid,batch))
  params=[{'in':'query','name':k,'schema':v} for k,v in (paging if paged else {}).items()]
  for name in ['invoiceId','paymentId']:
   if '{'+name+'}' in route:params.append({'in':'path','name':name,'required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$'}})
  paths[route]={'get':{'operationId':code.lower(),'summary':code.replace('_',' ').lower(),'description':'Active explicit bearer session, unique owned client profile and matching tenant required. Booking requests restrict client_id and tenant_id. Payments join their invoice and bind invoice ID, client ID and tenant ID; detail also binds payment ID. Missing or foreign invoice/payment returns 404. Only projected metadata is returned; no processor identifiers, notes, new role grants or mutations. Summary pagination totals count stored status groups (null last), not records. Recorded statuses do not prove booking approval, payment settlement, refunds or currency.','security':[{'bearerAuth':[]}],'parameters':params,'responses':{'200':{'description':'Owned metadata or status groups','content':{'application/json':{'schema':response}}},**{str(n):{'description':d} for n,d in [(400,'Invalid ID/query/body'),(401,'No active bearer session'),(403,'Tenant mismatch'),(404,'Owned profile/invoice/payment absent'),(405,'Read only'),(429,'Source limit'),(503,'Data unavailable')]}}}}
 (ROOT/'docs/api/booking-payment-batches-23-25.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Booking and Payment Reads','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered batches 23–25 owned reads; no new role grants.')
