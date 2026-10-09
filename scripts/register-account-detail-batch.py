"""Batch 4: governed CEO account detail and creation-history contracts."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
id_schema={'type':'string','pattern':'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$','maxLength':200}
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer','minimum':1,'maximum':100},'offset':{'type':'integer','minimum':0,'maximum':100000},'total':{'type':'integer','minimum':0},'hasMore':{'type':'boolean'}}}
detail_response={'type':'object','additionalProperties':False,'required':['user','assignableRoles'],'properties':{'user':{'type':'object','additionalProperties':False,'required':['id','email','roles','status','updated_at','canModify'],'properties':{'id':id_schema,'email':{'type':'string','format':'email'},'roles':{'type':['string','null']},'status':{'type':['string','null']},'updated_at':{'type':['string','null'],'format':'date-time'},'canModify':{'type':'boolean'}}},'assignableRoles':{'type':'array','items':{'type':'string'}}}}
creation_response={'type':'object','required':['events','pagination'],'additionalProperties':False,'properties':{'events':{'type':'array','items':{'type':'object','additionalProperties':False,'required':['id','actorUserId','targetUserId','action','created_at'],'properties':{'id':{'type':'string'},'actorUserId':id_schema,'targetUserId':id_schema,'action':{'const':'account_created'},'created_at':{'type':'string','format':'date-time'}}}},'pagination':pagination}}
ops=[('GET','/v1/admin/users/{userId}','Read tenant account details','Only approved account fields are returned. Self accounts have canModify=false. No session or password data.',{},detail_response),
 ('GET','/v1/admin/users/creation-audit','Read tenant account creation history','Reads persisted account_created events only. Does not include password or management history.',{**paging,'userId':id_schema},creation_response)]
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 db.execute('''CREATE TABLE IF NOT EXISTS governance_api_batches(route TEXT PRIMARY KEY,screen_id INTEGER NOT NULL REFERENCES screens(id),batch INTEGER NOT NULL,permission TEXT NOT NULL,implementation_status TEXT NOT NULL,test_status TEXT NOT NULL)''')
 app=db.execute("SELECT id FROM apps WHERE app_code='at'").fetchone()[0]
 sid=db.execute("SELECT id FROM screens WHERE screen_code='ceo_dashboard' AND active=1").fetchone()[0]
 for method,path,title,description,query,response in ops:
  code='AUTH_ADMIN_'+('DETAIL' if '{userId}' in path else 'CREATION_AUDIT')
  db.execute('''INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination)
  SELECT ?,?,?,?,'auth',1,'implemented','auth_account_management_policy',?,?,?,?
  WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?)''',
  (app,code,path,method,json.dumps({'type':'object','properties':query,'additionalProperties':False}),json.dumps(response),'workspace.source',int(bool(query)),app,path,method))
  aid=db.execute('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?',(app,path,method)).fetchone()[0]
  db.execute("UPDATE api_endpoints SET request_schema=?,response_schema=?,permission_key='auth_account_management_policy',auth_required=1,implementation_status='implemented' WHERE id=?",
    (json.dumps({'type':'object','properties':query,'additionalProperties':False}),json.dumps(response),aid))
  for screen in db.execute("SELECT id FROM screens WHERE active=1 AND screen_code IN ('ceo_dashboard','admin_user_management','user_management')").fetchall():
   db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(screen[0],aid,title+'; existing CEO authority only'))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,4,'auth_account_management_policy','implemented','pending')",(method+' '+path,sid))
 paths={}
 for method,path,title,description,query,response in ops:
  params=[{'in':'query','name':k,'required':False,'schema':v} for k,v in query.items()]
  if '{userId}' in path:params.insert(0,{'in':'path','name':'userId','required':True,'schema':id_schema})
  params.append({'in':'header','name':'X-Tenant-Id','required':False,'description':'If present, must exactly match the authenticated tenant.','schema':{'type':'string'}})
  paths.setdefault(path,{})[method.lower()]={'operationId':'account_detail' if '{userId}' in path else 'account_creation_audit',
   'summary':title,'description':description+' Requires an active explicit bearer session, CEO authority and a matching tenant. No new role grants.',
   'security':[{'bearerAuth':[]}],'parameters':params,'responses':{'200':{'description':'Success','content':{'application/json':{'schema':response}}},**{str(n):{'description':d,'content':{'application/json':{'schema':{'type':'object','required':['error'],'properties':{'error':{'type':'string'}}}}}} for n,d in [(400,'Invalid fields or query'),(401,'Missing or expired session'),(403,'Permission or tenant mismatch'),(404,'Target absent in tenant'),(405,'Unsupported method'),(429,'Rate limit'),(503,'Database or audit failure')]}}}
 doc={'openapi':'3.1.0','info':{'title':'PrimeCare Account Administration Batch 4','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}}
 target=ROOT/'docs/api/account-batch-4.openapi.json';target.parent.mkdir(parents=True,exist_ok=True);target.write_text(json.dumps(doc,indent=2)+'\n')
print('Registered batch 4 account detail and creation audit APIs; existing permissions retained.')
