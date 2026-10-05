"""Batch 6: authenticated self-session controls, no role or screen grants."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
responses={
 'GET':{'type':'object','additionalProperties':False,'required':['sessions','pagination'],'properties':{'sessions':{'type':'array','items':{'type':'object','additionalProperties':False,'required':['created_at','expires_at','current'],'properties':{'created_at':{'type':'string','format':'date-time'},'expires_at':{'type':'string','format':'date-time'},'current':{'type':'boolean'}}}},'pagination':{'type':'object','required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer'},'offset':{'type':'integer'},'total':{'type':'integer'},'hasMore':{'type':'boolean'}}}}},
 'DELETE':{'type':'object','additionalProperties':False,'required':['revokedSessions','status'],'properties':{'revokedSessions':{'type':'integer','minimum':0},'status':{'const':'signed_out_all_devices'}}}}
path='/v1/user/sessions';paths={path:{}}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 db.execute('''CREATE TABLE IF NOT EXISTS governance_api_batches(route TEXT PRIMARY KEY,screen_id INTEGER NOT NULL REFERENCES screens(id),batch INTEGER NOT NULL,permission TEXT NOT NULL,implementation_status TEXT NOT NULL,test_status TEXT NOT NULL)''')
 app=db.execute("SELECT id FROM apps WHERE app_code='at'").fetchone()[0]
 sid=db.execute("SELECT id FROM screens WHERE screen_code='login'").fetchone()[0]
 for method in ['GET','DELETE']:
  request={'type':'object','properties':paging if method=='GET' else {},'additionalProperties':False}
  code='AUTH_SELF_SESSIONS_'+('LIST' if method=='GET' else 'REVOKE')
  db.execute('''INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination)
   SELECT ?,?,?,?,'auth',1,'implemented','authenticated_self_session',?,?,?,? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?)''',
   (app,code,path,method,json.dumps(request),json.dumps(responses[method]),'workspace.source' if method=='GET' else 'manageAccount',int(method=='GET'),app,path,method))
  db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,6,'authenticated_self_session','implemented','pending')",(method+' '+path,sid))
  aid=db.execute('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?',(app,path,method)).fetchone()[0]
  db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Authenticated personal session lifecycle; actor derived from bearer, no arbitrary user target or new grants'))
  paths[path][method.lower()]={'operationId':'listOwnSessions' if method=='GET' else 'signOutAllDevices','summary':'List active own sessions' if method=='GET' else 'Revoke all own sessions',
   'description':'Active explicit bearer session and matching tenant required. User identity is derived from the session for every role. No userId/body accepted. DELETE atomically revokes active and expired sessions plus audit, and clears the session cookie. Concurrent later logins may create new sessions. No passwords, hashes or tokens returned.',
   'security':[{'bearerAuth':[]}],'parameters':[{'in':'query','name':k,'schema':v} for k,v in (paging if method=='GET' else {}).items()],
   'responses':{'200':{'description':'Success','content':{'application/json':{'schema':responses[method]}}},**{str(n):{'description':d} for n,d in [(400,'Invalid query/body'),(401,'Invalid or expired session'),(403,'Tenant mismatch'),(405,'Unsupported method'),(429,'Source or mutation budget exceeded'),(503,'Database or audit failure')]}}}
 target=ROOT/'docs/api/self-sessions-batch-6.openapi.json';target.write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Self Sessions Batch 6','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered self-session contracts; no role grants added.')
