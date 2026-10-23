"""Register only the user-requested Twilio requirement; never provision telephony."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('twilio-voice-requirement.json')
def definition():return json.loads(FILE.read_text())
def expected_scope():
 return dict(optInVariable='GOVERNANCE_TWILIO_REQUIREMENT_REGISTRATION',tables=['platform_hierarchy_policy'],policyIds=['communication-twilio-voice-v1'],definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,permissionChanges=False,providerWrites=False,activation=False)
def register(store):
 if store.pin.get('twilioVoiceRequirementWriter')!=expected_scope() or os.environ.get('GOVERNANCE_TWILIO_REQUIREMENT_REGISTRATION')!='1':raise GovernanceReadError('Exact Twilio requirement scope and opt-in required')
 doc=definition()
 if doc['id']!='communication-twilio-voice-v1' or doc['status']!='registered-unimplemented' or doc['activationApproved'] is not False or doc['sharedNumber'] is not None or doc['extensions']!=[]:raise GovernanceReadError('Requirement registration cannot activate or provision telephony')
 table=store.table('platform_hierarchy_policy');store.db.execute('LOCK TABLE '+table+' IN SHARE ROW EXCLUSIVE MODE')
 rows=store.execute('SELECT definition,requirement FROM platform_hierarchy_policy WHERE id=?',(doc['id'],)).fetchall()
 if rows:
  if len(rows)!=1 or json.loads(rows[0][0])!=doc or rows[0][1]!=doc['requirement']:raise GovernanceReadError('Existing Twilio requirement preserved; reconciliation required')
 else:
  ordinal=store.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+table).fetchone()[0]
  values={'id':doc['id'],'definition':json.dumps(doc,sort_keys=True),'requirement':doc['requirement']}
  store.db.execute('INSERT INTO '+table+' (_primecare_import_row,id,definition,requirement) VALUES (%s,%s,%s,%s)',[ordinal,*[store._value('platform_hierarchy_policy',k,v) for k,v in values.items()]])
 return dict(policyId=doc['id'],registered=True,permissionGrants=0,extensionsAssigned=0,numbersPurchased=0,providerWrites=False,activation=False)
def main():
 if sys.argv[1:] not in [['--dry-run'],['--apply']]:raise SystemExit('Explicit mode required')
 with ProductionWorkflowStore() as store:
  result=register(store)
  if result!=register(store):raise GovernanceReadError('Non-idempotent Twilio requirement registration')
  if sys.argv[1]=='--dry-run':store.db.rollback()
 if sys.argv[1]=='--apply':
  from production_reader import connect
  with connect() as reader:
   doc=definition();rows=reader.execute('SELECT definition,requirement FROM platform_hierarchy_policy WHERE id=?',(doc['id'],)).fetchall()
   if len(rows)!=1 or json.loads(rows[0][0])!=doc or rows[0][1]!=doc['requirement']:raise GovernanceReadError('Independent Twilio requirement readback failed')
  result['independentReadback']=True
 print('TWILIO_REQUIREMENT_REGISTRATION '+json.dumps(result))
if __name__=='__main__':main()
