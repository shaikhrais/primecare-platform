"""Register communication access requirements before implementation; no grants or accounts."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('communication-access-policy.json')
def definition():return json.loads(FILE.read_text())
def expected_scope():
 return dict(optInVariable='GOVERNANCE_COMMUNICATION_ACCESS_REGISTRATION',tables=['platform_hierarchy_policy'],policyIds=sorted(d['id'] for d in definition().values()),definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,permissionChanges=False,activation=False)
def register(store):
 if store.pin.get('communicationAccessRegistrationWriter')!=expected_scope() or os.environ.get('GOVERNANCE_COMMUNICATION_ACCESS_REGISTRATION')!='1':raise GovernanceReadError('Exact communication access scope and opt-in required')
 d=definition()
 if d['policy']['activationApproved'] is not False or d['policy']['status']!='registered-unimplemented' or d['directory']['mailboxes']!=[]:raise GovernanceReadError('Access registration cannot provision mailboxes or activate access')
 for sid,code in {234:'psw_messages',331:'patient_messages',559:'communication',578:'messaging'}.items():
  if store.execute('SELECT screen_code,active FROM screens WHERE id=?',(sid,)).fetchall()!=[(code,1)]:raise GovernanceReadError('Registered communication screens required')
 table=store.table('platform_hierarchy_policy')
 store.db.execute('LOCK TABLE '+table+' IN SHARE ROW EXCLUSIVE MODE')
 for doc in d.values():
  rows=store.execute('SELECT definition,requirement FROM platform_hierarchy_policy WHERE id=?',(doc['id'],)).fetchall()
  if rows:
   if len(rows)!=1 or json.loads(rows[0][0])!=doc or rows[0][1]!=doc['requirement']:raise GovernanceReadError('Existing communication access data preserved; reconciliation required')
  else:
   ordinal=store.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+table).fetchone()[0]
   values={'id':doc['id'],'definition':json.dumps(doc,sort_keys=True),'requirement':doc['requirement']}
   store.db.execute('INSERT INTO '+table+' (_primecare_import_row,id,definition,requirement) VALUES (%s,%s,%s,%s)',[ordinal,*[store._value('platform_hierarchy_policy',k,v) for k,v in values.items()]])
 return dict(policyIds=expected_scope()['policyIds'],registered=True,mailboxesProvisioned=0,permissionGrants=0,businessDataWrites=False,activation=False)
def main():
 if sys.argv[1:] not in [['--dry-run'],['--apply']]:raise SystemExit('Explicit mode required')
 with ProductionWorkflowStore() as store:
  result=register(store)
  if result!=register(store):raise GovernanceReadError('Non-idempotent access registration')
  if sys.argv[1]=='--dry-run':store.db.rollback()
 # Independent read-only connection after transaction close; no credential/content output.
 if sys.argv[1]=='--apply':
  from production_reader import connect
  with connect() as reader:
   for doc in definition().values():
    rows=reader.execute('SELECT definition,requirement FROM platform_hierarchy_policy WHERE id=?',(doc['id'],)).fetchall()
    if len(rows)!=1 or json.loads(rows[0][0])!=doc or rows[0][1]!=doc['requirement']:raise GovernanceReadError('Independent access policy readback failed')
  result['independentReadback']=True
 print('COMMUNICATION_ACCESS_REGISTRATION '+json.dumps(result))
if __name__=='__main__':main()
