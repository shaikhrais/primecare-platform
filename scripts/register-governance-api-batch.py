"""Batch 1: register seven authenticated, read-only governance APIs.

Catalog responses describe the deployed governance snapshot. They never claim
live probe results or permission inheritance from reporting relationships.
"""
import hashlib,json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
ENDPOINTS=[
 ('page-progress','screen_progress_dashboard','inventory','Group registered page completion by application.'),
 ('screen-health','admin_screen_health','inventory','List concrete screen binding and verification blockers.'),
 ('role-coverage','role_coverage_dashboard','inventory','List active roles, granted page counts and landing coverage.'),
 ('pending-tasks','pending_task_queue','inventory','List outstanding screen bindings, verification and business actions.'),
 ('api-contracts','api_health_dashboard','inventory','List registered API contracts and recorded health evidence.'),
 ('organization-map','ceo_organization_map','screen','Read approved administrative reporting and live tenant account counts.'),
 ('overview','ceo_dashboard','organization','Read live tenant-scoped account, session and domain counts.'),
]
query_schema={'type':'object','additionalProperties':False,'properties':{
 'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},
 'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0},
 'search':{'type':'string','maxLength':200},'app':{'type':'string','maxLength':40},'role':{'type':'string','maxLength':80}}}
response_schema={'type':'object','required':['data','pagination','source'],'properties':{
 'data':{'type':'array','items':{'type':'object'}},
 'pagination':{'type':'object','required':['limit','offset','total','hasMore'],'properties':{'limit':{'type':'integer'},'offset':{'type':'integer'},'total':{'type':'integer'},'hasMore':{'type':'boolean'}}},
 'source':{'type':'object','required':['catalogVersion','evidenceType'],'properties':{'catalogVersion':{'type':'string'},'evidenceType':{'enum':['registered_governance','live_tenant_data','approved_reporting_and_live_tenant_counts']}}}}}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 db.row_factory=sqlite3.Row
 db.execute('''CREATE TABLE IF NOT EXISTS governance_api_batches (
   route TEXT PRIMARY KEY,screen_id INTEGER NOT NULL REFERENCES screens(id),batch INTEGER NOT NULL,
   permission TEXT NOT NULL,implementation_status TEXT NOT NULL,test_status TEXT NOT NULL)''')
 apps=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()
 if not apps:raise RuntimeError('Governance service is not registered')
 bindings=[]
 for name,code,gate,purpose in ENDPOINTS:
  screen=db.execute('SELECT id FROM screens WHERE screen_code=? AND active=1',(code,)).fetchone()
  if not screen:raise RuntimeError('Missing governed screen '+code)
  route='/v1/governance/'+name
  permission={'inventory':'runtime_catalog_permissions.can_view_inventory','organization':'runtime_catalog_permissions.can_view_organization','screen':'role_screen_permissions.can_view'}[gate]
  db.execute('''INSERT INTO governance_api_batches VALUES(?,?,1,?,'implemented','pending')
    ON CONFLICT(route) DO UPDATE SET screen_id=excluded.screen_id,permission=excluded.permission,implementation_status='implemented',test_status='pending' ''',(route,screen['id'],permission))
  code_api='GOVERNANCE_BATCH1_'+name.replace('-','_').upper()
  db.execute('''INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination)
    SELECT ?,?,?,'GET','governance',1,'implemented',?,?,?,'workspace.source',1
    WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method='GET')''',
    (apps['id'],code_api,route,permission,json.dumps(query_schema),json.dumps(response_schema),apps['id'],route))
  aid=db.execute("SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method='GET'",(apps['id'],route)).fetchone()[0]
  db.execute("INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)",(screen['id'],aid,purpose))
  bindings.append({'path':'/'+name,'screen':code,'gate':gate,'purpose':purpose})
 roles=[dict(r) for r in db.execute('SELECT role_code code,role_name name,post_login_route landing FROM roles WHERE active=1 ORDER BY role_code')]
 hierarchy=[dict(r) for r in db.execute('''SELECT r.role_code role,r.role_name name,parent.role_code supervisor,parent.role_name supervisorName,p.scope
   FROM authority_hierarchy_proposals p JOIN roles r ON r.id=p.role_id
   LEFT JOIN roles parent ON parent.id=p.proposed_supervisor_role_id
   JOIN authority_hierarchy_approvals a ON a.proposal_code=p.proposal_code
   WHERE a.approved_scope='administrative_reporting_only' AND a.grants_permissions=0
   AND p.inherits_permissions=0 AND r.active=1 ORDER BY r.role_code''')]
 catalog={'bindings':bindings,'roles':roles,'hierarchy':hierarchy}
 catalog['version']=hashlib.sha256(json.dumps(catalog,sort_keys=True).encode()).hexdigest()[:16]
 (ROOT/'cloudflare/workers/src/governance-api-registry.json').write_text(json.dumps(catalog,separators=(',',':'))+'\n')
 paths={}
 for name,code,gate,purpose in ENDPOINTS:
  paths['/v1/governance/'+name]={'get':{'operationId':'governance_'+name.replace('-','_'),'summary':purpose,
   'description':'Active bearer session and tenant required. '+('Existing inventory authority required.' if gate=='inventory' else 'Existing organization authority required.' if gate=='organization' else 'Existing screen view grant required.')+' Catalog evidence is recorded evidence, never a live probe.',
   'security':[{'bearerAuth':[]}],
   'parameters':[{'name':k,'in':'query','required':False,'schema':v} for k,v in query_schema['properties'].items()],
   'responses':{'200':{'description':'Paginated result','content':{'application/json':{'schema':response_schema}}},**{str(n):{'description':d} for n,d in [(400,'Invalid query'),(401,'Missing or expired session'),(403,'Permission or tenant mismatch'),(405,'Read-only endpoint'),(429,'Rate limit'),(503,'Source unavailable')]}}}}
 spec={'openapi':'3.1.0','info':{'title':'PrimeCare Governance Batch 1','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}}
 target=ROOT/'docs/api/governance-batch-1.openapi.json';target.parent.mkdir(parents=True,exist_ok=True);target.write_text(json.dumps(spec,indent=2)+'\n')
print('Registered 7 read-only governance APIs; no UI files changed.')
