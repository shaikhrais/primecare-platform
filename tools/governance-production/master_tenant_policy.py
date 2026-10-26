"""Register only the user-directed master-tenant relationship requirement."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('master-tenant-hierarchy.json')
def scope():
 return dict(optInVariable='GOVERNANCE_MASTER_TENANT_POLICY',tables=['platform_hierarchy_policy'],policyId='primecare-master-tenant-hierarchy-v1',definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),businessDataWrites=False,accountChanges=False)
class MasterTenantPolicyStore(ProductionWorkflowStore):
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get('masterTenantHierarchyPolicyWriter')!=scope() or os.environ.get('GOVERNANCE_MASTER_TENANT_POLICY')!='1':raise GovernanceReadError('Exact master policy scope required')
   self.db.execute('LOCK TABLE '+self.table('platform_hierarchy_policy')+' IN SHARE ROW EXCLUSIVE MODE')
  except Exception:self.db.rollback();self.db.close();raise
 def register(self):
  d=json.loads(FILE.read_text());table=self.table('platform_hierarchy_policy')
  if self.execute("SELECT active FROM roles WHERE role_code='code_admin'").fetchall()!=[(1,)]:raise GovernanceReadError('Active governed Code Admin required')
  for key in (d['rootPolicy'],d['ownerPolicy']):
   if len(self.execute('SELECT definition FROM platform_hierarchy_policy WHERE id=?',(key,)).fetchall())!=1:raise GovernanceReadError('Existing registered owner and root required')
  rows=self.execute('SELECT definition FROM platform_hierarchy_policy WHERE id=?',(d['id'],)).fetchall()
  if rows:
   if len(rows)!=1 or json.loads(rows[0][0])!=d:raise GovernanceReadError('Edited master requirement preserved')
  else:
   ordinal=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+table).fetchone()[0]
   self.db.execute('INSERT INTO '+table+' (_primecare_import_row,id,definition,requirement) VALUES(%s,%s,%s,%s)',(ordinal,d['id'],json.dumps(d),'User requested master parent tenant linked to Code Admin and staff-only calling on 2026-10-26.'))
  return dict(masterRequirementRegistered=True,businessDataWrites=False,accountChanges=False)
if __name__=='__main__':
 if sys.argv[1:] not in [['--dry-run'],['--apply']]:raise SystemExit('Explicit mode required')
 with MasterTenantPolicyStore() as db:
  result=db.register()
  if result!=db.register():raise GovernanceReadError('Non-idempotent master policy')
  if sys.argv[1]=='--dry-run':db.db.rollback()
 print('MASTER_TENANT_POLICY '+json.dumps(result))
