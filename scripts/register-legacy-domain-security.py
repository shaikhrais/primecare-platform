"""Batch 17: inventory and disable unsafe legacy domain handlers."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
routes=[('client','/api/clients',['GET','POST'],'client_profile'),('provider','/api/providers',['GET'],'psw_profile'),('provider','/api/providers/{providerId}',['GET'],'psw_profile'),('visit','/api/visits',['GET','POST'],'client_profile'),('billing','/api/invoices',['GET'],'client_profile'),('scheduling','/api/schedules',['GET'],'client_profile'),('compliance','/api/compliance/audits',['GET'],'compliance_manager_dashboard'),('compliance','/api/compliance/findings',['POST'],'compliance_manager_dashboard')]
response={'type':'object','additionalProperties':False,'required':['error','status','code'],'properties':{'error':{'const':'Legacy domain operation is not implemented securely'},'status':{'const':'not_implemented'},'code':{'const':'legacy_domain_disabled'}}}
paths={}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 db.execute('CREATE TABLE IF NOT EXISTS legacy_domain_security_routes(service TEXT NOT NULL,path TEXT NOT NULL,methods_json TEXT NOT NULL,reason TEXT NOT NULL,PRIMARY KEY(service,path))')
 for service,path,methods,screen in routes:
  sid,app=db.execute('SELECT id,app_id FROM screens WHERE screen_code=?',(screen,)).fetchone()
  db.execute('INSERT OR REPLACE INTO legacy_domain_security_routes VALUES(?,?,?,?)',(service,path,json.dumps(methods),'Unscoped unauthenticated SQL; secured domain workflow remains pending'))
  for method in methods:
   code='LEGACY_DISABLED_'+service.upper()+'_'+path.replace('/','_').replace('{','').replace('}','').upper()+'_'+method
   db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema) SELECT ?,?,?,?,?,1,'blocked','legacy_domain_disabled',?,? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method=?)",(app,code,path,method,service,json.dumps({'type':'object','additionalProperties':False}),json.dumps(response),path,method))
   aid=db.execute('SELECT id FROM api_endpoints WHERE route_path=? AND http_method=?',(path,method)).fetchone()[0]
   db.execute("UPDATE api_endpoints SET implementation_status='blocked',permission_key='legacy_domain_disabled',health_status='not_implemented',response_schema=? WHERE id=?",(json.dumps(response),aid))
   db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Disabled legacy handler; secure business workflow and migration remain pending'))
   db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,17,'legacy_domain_disabled','blocked','pending')",(method+' '+path,sid))
   parameters=[{'in':'path','name':'providerId','required':True,'schema':{'type':'string'}}] if '{providerId}' in path else []
   paths.setdefault(path,{})[method.lower()]={'operationId':code.lower(),'deprecated':True,'summary':'Disabled legacy '+service+' operation','description':'Always fails closed without reading bodies, opening database connections or executing SQL. This is a migration boundary, not a functioning domain API. Unsupported methods return 405. OPTIONS is handled by service CORS. No role grants can enable this handler.','parameters':parameters,'responses':{'501':{'description':'Secure domain implementation pending','content':{'application/json':{'schema':response}}},'405':{'description':'Unsupported method'}}}
 catalog=[{'service':r[0],'path':r[1],'methods':json.loads(r[2])} for r in db.execute('SELECT service,path,methods_json FROM legacy_domain_security_routes ORDER BY service,path')]
 (ROOT/'cloudflare/workers/src/legacy-domain-registry.json').write_text(json.dumps(catalog,indent=2)+'\n')
 (ROOT/'docs/api/legacy-domain-batch-17.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Disabled Legacy Domain Operations','version':'1.0.0'},'paths':paths},indent=2)+'\n')
print('Registered 10 disabled legacy operations; business implementation stays blocked.')
