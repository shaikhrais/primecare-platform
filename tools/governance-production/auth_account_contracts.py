"""Reconcile APIs1/11 with existing runtime and policy; narrow legacy grants only."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('auth-account-contract-reconciliation.json')
def definition():return json.loads(FILE.read_text())
def expected_scope():return dict(optInVariable='GOVERNANCE_AUTH_CONTRACT_RECONCILIATION',apiIds=[1,11],tables=['api_endpoints','api_permissions'],definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,permissionDisposition='narrow-existing-to-approved-policy')
def target_permission(old,api):
 if old['api_id']!=api['id']:raise GovernanceReadError('Wrong permission/API binding')
 return {**old,'permission_key':api['target']['permission_key'],'can_access':old['can_access'] if old['role_id'] in api['allowedActorIds'] else 0}
class ContractStore(ProductionWorkflowStore):
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get('authAccountContractWriter')!=expected_scope() or os.environ.get('GOVERNANCE_AUTH_CONTRACT_RECONCILIATION')!='1':raise GovernanceReadError('Exact auth contract reconciliation scope required')
   self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in ['api_endpoints','api_permissions'])+' IN SHARE ROW EXCLUSIVE MODE')
   for table in ['api_endpoints','api_permissions']:
    m=self.tables.get(table)
    if not m or any(len(c['storage_types'])>1 for c in m['columns']):raise GovernanceReadError('Mixed/missing contract schema')
    actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
    expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in m['columns']}}
    if actual!=expected:raise GovernanceReadError('Contract physical schema drift')
  except Exception:self.db.rollback();self.db.close();raise

def reconcile(db,d):
 if d!=definition() or hashlib.sha256((ROOT/'cloudflare/workers/src/account-policy.json').read_bytes()).hexdigest()!=d['policyHash']:raise GovernanceReadError('Reviewed account policy source required')
 source=json.loads((ROOT/'cloudflare/workers/src/account-policy.json').read_text())
 if {actor:[x['code'] for x in value['targets']] for actor,value in d['actors'].items()}!=source:raise GovernanceReadError('Runtime role policy mismatch')
 registered=db.execute("SELECT a.role_code,t.role_code,p.scope FROM auth_account_creation_policy p JOIN roles a ON a.id=p.actor_role_id JOIN roles t ON t.id=p.target_role_id WHERE a.role_code IN ('ceo','hr_director')").fetchall()
 expected=sorted((actor,role,'same_tenant') for actor,roles in source.items() for role in roles)
 if sorted(registered)!=expected:raise GovernanceReadError('Registered creation authority drift')
 if db.execute("SELECT scope,permitted_fields,self_modification FROM auth_account_management_policy WHERE actor_role_code='ceo'").fetchall()!=[('same_tenant','roles,status',0)]:raise GovernanceReadError('Existing management authority changed')
 for actor,entry in d['actors'].items():
  if db.execute('SELECT role_code,active FROM roles WHERE id=?',(entry['id'],)).fetchall()!=[(actor,1)]:raise GovernanceReadError('Actor identity drift')
 for api in d['apis']:
  fields=list(api['reviewed']);row=db.execute('SELECT '+','.join(fields)+' FROM api_endpoints WHERE id=?',(api['id'],)).fetchall()
  target={**api['reviewed'],**api['target']}
  if len(row)!=1 or dict(zip(fields,row[0])) not in [api['reviewed'],target]:raise GovernanceReadError('API contract edited; preserve')
  old=sorted([p for p in d['reviewedPermissions'] if p['api_id']==api['id']],key=lambda p:p['id']);pfields=list(old[0]);current=db.execute('SELECT '+','.join(pfields)+' FROM api_permissions WHERE api_id=? ORDER BY id',(api['id'],)).fetchall()
  new=[target_permission(p,api) for p in old]
  actual=[dict(zip(pfields,r)) for r in current]
  if actual not in [old,new] or any(not any(p['role_id']==role and p['can_access']==1 for p in old) for role in api['allowedActorIds']):raise GovernanceReadError('Permission inventory drift; preserve')
  for p in new:
   if p['can_access']>next(o['can_access'] for o in old if o['id']==p['id']):raise GovernanceReadError('No grant expansion allowed')
  keys=list(api['target']);updated=db.db.execute('UPDATE '+db.table('api_endpoints')+' SET '+','.join(quote(k)+'=%s' for k in keys)+' WHERE id=%s',[*[db._value('api_endpoints',k,api['target'][k]) for k in keys],api['id']])
  if updated.rowcount!=1:raise GovernanceReadError('API update count mismatch')
  allowed=api['allowedActorIds'];updated=db.db.execute('UPDATE '+db.table('api_permissions')+' SET permission_key=%s,can_access=CASE WHEN role_id=ANY(%s::bigint[]) THEN can_access ELSE 0 END WHERE api_id=%s',[api['target']['permission_key'],allowed,api['id']])
  if updated.rowcount!=len(old):raise GovernanceReadError('Permission update count mismatch')
  checked=db.execute('SELECT '+','.join(pfields)+' FROM api_permissions WHERE api_id=? ORDER BY id',(api['id'],)).fetchall()
  if [dict(zip(pfields,r)) for r in checked]!=new:raise GovernanceReadError('Permission readback mismatch')
 return {'apis':[1,11],'source':'existing account-policy and same-tenant database policies','allowedActors':{'1':['ceo','hr_director'],'11':['ceo']},'newGrants':0,'runtimeChanged':False,'businessDataChanged':False,'reviewApprovals':False}
def main():
 if not any(x in sys.argv for x in ['--apply','--dry-run']):raise SystemExit('Explicit --apply or --dry-run required')
 with ContractStore() as db:
  result=reconcile(db,definition());assert result==reconcile(db,definition()),'Reconciliation not idempotent'
  if '--dry-run' in sys.argv:db.db.rollback()
 print('AUTH_ACCOUNT_CONTRACTS_RECONCILED '+json.dumps({**result,'dryRun':'--dry-run' in sys.argv}))
if __name__=='__main__':main()
