"""Record a truthful execution-status contract; declarations are not probes."""
import hashlib,json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
route='/v1/governance/api-execution-status'
query={'type':'object','additionalProperties':False,'properties':{'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0},'search':{'type':'string','maxLength':200},'app':{'type':'string','maxLength':40},'role':{'type':'string','maxLength':80},'screen':{'type':'string','maxLength':200}}}
response={'type':'object','required':['data','pagination','source'],'properties':{'data':{'type':'array','items':{'type':'object','required':['api','declaredImplementation','verificationState','missingContractFields','recordedUnitStatus','productionVerified','postgresVerified']}},'pagination':{'type':'object'},'source':{'type':'object'}}}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 sid,app=db.execute("SELECT s.id,a.id FROM screens s JOIN apps a ON a.app_code='gv' WHERE s.screen_code='api_health_dashboard'").fetchone()
 db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,'GOVERNANCE_API_EXECUTION_STATUS',?,'GET','governance',1,'implemented','runtime_catalog_permissions.can_view_inventory',?,?,'workspace.source',1 WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE route_path=? AND http_method='GET')",(app,route,json.dumps(query),json.dumps(response),route))
 aid=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchone()[0]
 db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Distinguish recorded fixture evidence, blocked contracts and verification gaps; not live probes'))
 db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,20,'runtime_catalog_permissions.can_view_inventory','implemented','pending')",('GET '+route,sid))
catalog_path=ROOT/'cloudflare/workers/src/governance-api-registry.json'
catalog=json.loads(catalog_path.read_text());catalog['bindings']=[b for b in catalog['bindings'] if b['path']!='/api-execution-status']+[{'path':'/api-execution-status','screen':'api_health_dashboard','gate':'inventory','purpose':'Read recorded API execution gaps without readiness inference'}]
catalog['version']=hashlib.sha256(json.dumps({k:v for k,v in catalog.items() if k!='version'},sort_keys=True).encode()).hexdigest()[:16]
catalog_path.write_text(json.dumps(catalog,separators=(',',':'))+'\n')
spec={'openapi':'3.1.0','info':{'title':'PrimeCare API Execution Status','version':'1.0.0'},'paths':{route:{'get':{'operationId':'governance_api_execution_status','summary':'Read API verification and contract gaps','description':'Existing inventory authority, active explicit bearer session and tenant match required. Recorded governance evidence only. Active/healthy declarations do not prove executable APIs. Unit-tested records do not imply PostgreSQL or production verification. Filters and paging share governance API conventions.','security':[{'bearerAuth':[]}],'parameters':[{'in':'query','name':k,'schema':v} for k,v in query['properties'].items()],'responses':{'200':{'description':'Recorded API execution status','content':{'application/json':{'schema':response}}},**{str(n):{'description':d} for n,d in [(400,'Invalid query'),(401,'No active session'),(403,'Inventory authority or tenant mismatch'),(405,'Read only'),(429,'Source limit'),(503,'Backend unavailable')]}}}}},'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}}
(ROOT/'docs/api/api-execution-status-batch-20.openapi.json').write_text(json.dumps(spec,indent=2)+'\n')
print('Registered API execution status; no readiness or role grants inferred.')
