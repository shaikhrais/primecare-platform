"""Register pending MFA requirements only; no API grants, users or business DDL."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('mfa-registration.json')
def expected_scope():
 return dict(optInVariable='GOVERNANCE_MFA_POLICY_WRITES',tables=['platform_hierarchy_policy'],policyId='mfa-auth-policy-v1',definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,permissionChanges=False,activation=False)
def register(store):
 if store.pin.get('mfaPolicyWriter')!=expected_scope() or os.environ.get('GOVERNANCE_MFA_POLICY_WRITES')!='1':raise GovernanceReadError('Exact pending MFA policy scope required')
 definition=json.loads(FILE.read_text())
 if definition['activationApproved'] or definition['status']!='registered-unimplemented' or any(v!='pending' for v in definition['approvals'].values()):raise GovernanceReadError('No activation or review approvals may be inferred')
 if store.execute('SELECT route_code,route_path,flow_type FROM auth_route_registry WHERE id=5').fetchall()!=[('mfa','/mfa','challenge_contract_pending')]:raise GovernanceReadError('Existing pending MFA route changed; preserve')
 if store.execute("SELECT active FROM roles WHERE role_code='code_admin'").fetchall()!=[(1,)]:raise GovernanceReadError('Registered Code Admin required')
 table=store.table('platform_hierarchy_policy')
 store.db.execute('LOCK TABLE '+table+' IN SHARE ROW EXCLUSIVE MODE')
 rows=store.execute('SELECT definition,requirement FROM platform_hierarchy_policy WHERE id=?',(definition['id'],)).fetchall()
 if rows:
  if len(rows)!=1 or json.loads(rows[0][0])!=definition or rows[0][1]!=definition['requirement']:raise GovernanceReadError('MFA policy drift; preserve existing record')
 else:
  ordinal=store.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+table).fetchone()[0]
  store.db.execute('INSERT INTO '+table+' (_primecare_import_row,id,definition,requirement) VALUES (%s,%s,%s,%s)',(ordinal,definition['id'],json.dumps(definition,sort_keys=True),definition['requirement']))
 readback=store.execute('SELECT definition FROM platform_hierarchy_policy WHERE id=?',(definition['id'],)).fetchall()
 if len(readback)!=1 or json.loads(readback[0][0])!=definition:raise GovernanceReadError('MFA policy readback mismatch')
 return dict(registered=True,status=definition['status'],accountChanges=0,activation=False,reviewApprovals=False)
def main():
 if len(sys.argv)!=2 or sys.argv[1] not in ['--apply','--dry-run']:raise SystemExit('Explicit mode required')
 with ProductionWorkflowStore() as store:
  result=register(store)
  if result!=register(store):raise GovernanceReadError('MFA registration not idempotent')
  if sys.argv[1]=='--dry-run':store.db.rollback()
 print('MFA_POLICY_REGISTERED '+json.dumps(result))
if __name__=='__main__':main()
