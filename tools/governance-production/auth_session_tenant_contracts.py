"""Extend existing authenticated response schemas only; preserve all authority."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore
from production_reader import GovernanceReadError,connect
FILE=Path(__file__).with_name('auth-session-tenant-contracts.json')
def definition():return json.loads(FILE.read_text())
def scope():return dict(optInVariable='GOVERNANCE_AUTH_SESSION_TENANT_WRITES',tables=['api_endpoints'],apiIds=[2,779,16402,16496,16500],fields=['response_schema'],definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,permissionChanges=False,activation=False)
def target(entry):
 old=entry['reviewed'];result={**old,'response_schema':json.dumps(entry['response'],sort_keys=True)}
 before=json.loads(old['response_schema']);after=json.loads(result['response_schema']);branches=after.get('oneOf',[after]);count=0
 for branch in branches:
  if branch.get('properties',{}).get('status',{}).get('const')=='authenticated':
   prop=branch['properties'].pop('tenantId',None)
   if prop is None or prop.get('type')!='string' or prop.get('maxLength')!=200 or 'tenantId' in branch.get('required',[]):raise GovernanceReadError('Exact optional tenant extension required')
   count+=1
 if after!=before or count!=1:raise GovernanceReadError('Unrelated contract change refused')
 return result
def validate(db,entry,accept_old=True):
 fields=list(entry['reviewed']);rows=db.execute('SELECT '+','.join(fields)+' FROM api_endpoints WHERE id=?',(entry['reviewed']['id'],)).fetchall()
 if len(rows)!=1:raise GovernanceReadError('Existing exact auth API required')
 actual=dict(zip(fields,rows[0]));expected=target(entry)
 for candidate in [expected,*([entry['reviewed']] if accept_old else [])]:
  if all(json.loads(actual[k])==json.loads(candidate[k]) if k=='response_schema' and isinstance(actual[k],str) else actual[k]==candidate[k] for k in fields):return expected
 raise GovernanceReadError('Edited auth contract preserved')
class TenantContractStore(ProductionWorkflowStore):
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get('authSessionTenantWriter')!=scope() or os.environ.get('GOVERNANCE_AUTH_SESSION_TENANT_WRITES')!='1':raise GovernanceReadError('Exact auth session tenant scope required')
   self.db.execute('LOCK TABLE '+self.table('api_endpoints')+' IN SHARE ROW EXCLUSIVE MODE')
   meta={c['name']:c for c in self.tables['api_endpoints']['columns']}
   if meta['id']['storage_types']!=['integer'] or len(meta['response_schema']['storage_types'])>1:raise GovernanceReadError('Auth API storage metadata drift')
  except Exception:self.db.rollback();self.db.close();raise
 def write_response(self,entry,expected):
  result=self.db.execute('UPDATE '+self.table('api_endpoints')+' SET response_schema=%s WHERE id=%s',[self._value('api_endpoints','response_schema',expected['response_schema']),entry['reviewed']['id']])
  if result.rowcount!=1:raise GovernanceReadError('Auth API update count mismatch')
def register(db):
 entries=definition()['contracts']
 if [e['reviewed']['id'] for e in entries]!=scope()['apiIds']:raise GovernanceReadError('Exact auth API identities required')
 plans=[(entry,validate(db,entry)) for entry in entries]
 for entry,expected in plans:db.write_response(entry,expected)
 for entry in entries:validate(db,entry,False)
 return dict(apiIds=scope()['apiIds'],fields=['response_schema'],permissionChanges=False,accountChanges=False,activation=False,definitionSha256=scope()['definitionSha256'])
def main():
 if sys.argv[1:] not in [['--dry-run'],['--apply']]:raise SystemExit('Explicit mode required')
 with TenantContractStore() as db:
  result=register(db);assert result==register(db)
  if sys.argv[1]=='--dry-run':db.db.rollback()
 if sys.argv[1]=='--apply':
  with connect() as db:
   for entry in definition()['contracts']:validate(db,entry,False)
  result['independentReadback']=True
 print('AUTH_SESSION_TENANT_REGISTRATION '+json.dumps(result))
if __name__=='__main__':main()
