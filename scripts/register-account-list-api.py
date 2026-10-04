"""Batch 2 registers the existing CEO account-management read contract."""
import json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
policy=json.loads((ROOT/'cloudflare/workers/src/account-policy.json').read_text())
query={'type':'object','additionalProperties':False,'properties':{
 'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0},
 'search':{'type':'string','maxLength':200},'role':{'type':'string','enum':policy['ceo']},'status':{'enum':['active','inactive']}}}
response={'type':'object','required':['users','assignableRoles','pagination'],'properties':{
 'users':{'type':'array','items':{'type':'object','additionalProperties':False,'required':['id','email','roles','status','canModify'],'properties':{
 'id':{'type':'string'},'email':{'type':'string'},'roles':{'type':'string'},'status':{'type':'string'},'updated_at':{'type':['string','null']},'canModify':{'type':'boolean'}}}},
 'assignableRoles':{'type':'array','items':{'type':'string'}},'pagination':{'type':'object','required':['limit','offset','total','hasMore'],'properties':{
 'limit':{'type':'integer'},'offset':{'type':'integer'},'total':{'type':'integer'},'hasMore':{'type':'boolean'}}}}}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 db.execute('''CREATE TABLE IF NOT EXISTS governance_api_batches (
   route TEXT PRIMARY KEY,screen_id INTEGER NOT NULL REFERENCES screens(id),batch INTEGER NOT NULL,
   permission TEXT NOT NULL,implementation_status TEXT NOT NULL,test_status TEXT NOT NULL)''')
 app=db.execute("SELECT id FROM apps WHERE app_code='at'").fetchone()[0]
 path='/v1/admin/users'
 db.execute('''INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination)
 SELECT ?,'AUTH_ACCOUNT_LIST',?,'GET','auth',1,'implemented','auth_account_management_policy',?,?,'workspace.source',1
 WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method='GET')''',(app,path,json.dumps(query),json.dumps(response),app,path))
 aid=db.execute("SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method='GET'",(app,path)).fetchone()[0]
 sid=db.execute("SELECT id FROM screens WHERE screen_code='ceo_dashboard' AND active=1").fetchone()[0]
 db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,2,'auth_account_management_policy','implemented','pending')",(path,sid))
 for code in ['ceo_dashboard','admin_user_management','user_management']:
  row=db.execute('SELECT id FROM screens WHERE screen_code=? AND active=1',(code,)).fetchone()
  if row:db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(row[0],aid,'CEO-only tenant account list; existing account management authority, no new grants'))
 operation={'operationId':'listTenantAccounts','summary':'List tenant accounts for the authorized CEO',
 'description':'Explicit bearer session; active CEO and matching tenant required. Passwords, tokens and configuration secrets are excluded. Search is literal. canModify is false for the actor. No new role grants.',
 'security':[{'bearerAuth':[]}],'parameters':[{'name':k,'in':'query','required':False,'schema':v} for k,v in query['properties'].items()],
 'responses':{'200':{'description':'Tenant account list','content':{'application/json':{'schema':response}}},**{str(n):{'description':d} for n,d in [(400,'Invalid query'),(401,'Missing or expired session'),(403,'Permission or tenant mismatch'),(405,'Unsupported method'),(429,'Rate limit'),(503,'Source unavailable')]}}}
 doc={'openapi':'3.1.0','info':{'title':'PrimeCare Account API Batch 2','version':'1.0.0'},'paths':{path:{'get':operation}},'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}}
 target=ROOT/'docs/api/account-batch-2.openapi.json';target.parent.mkdir(parents=True,exist_ok=True);target.write_text(json.dumps(doc,indent=2)+'\n')
print('Registered CEO tenant account-list API; no role grants changed.')
