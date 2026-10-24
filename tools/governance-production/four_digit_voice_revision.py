"""Exact six-to-four-digit metadata revision; no user assignment or provider write."""
import copy,hashlib,json,os,sys
from pathlib import Path
import twilio_contracts_registration as contracts
from twilio_contracts_registration import TwilioContractRegistrationStore,GovernanceReadError,normalized,FIELDS,values
from twilio_voice_registration import retry_transaction
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).parent
FILE=HERE/'four-digit-voice-revision.json'
OLD_POLICY=HERE/'history/twilio-six-digit-requirement.json'
OLD_CONTRACTS=HERE/'history/twilio-six-digit-contracts.json'

def documents():
 oldp=json.loads(OLD_POLICY.read_text());oldc=json.loads(OLD_CONTRACTS.read_text());new=json.loads(FILE.read_text())
 expectedp=copy.deepcopy(oldp);expectedp['version']=2;expectedp['requirement']=oldp['requirement'].replace('six-digit','four-digit')
 expectedp['requirement']+=' Use menu 0 for configured reception and menu 1 for the configured verified AI pairing flow; missing AI configuration falls back to reception or unavailable. Account tasks require current policy and exact independent confirmation.'
 expectedp['rules']['extensionDigits']=4;expectedp['rules']['extensionRange']='1000-9999'
 expectedp['rules'].update(receptionMenuDigit='0',aiMenuDigit='1',aiEntry='configured-verified-app-pairing-otherwise-reception',unknownAmbiguousOrRevokedDestination='configured-reception-otherwise-generic-unavailable-no-dial')
 expectedc=copy.deepcopy(oldc)
 def adjust(node):
  if isinstance(node,dict):
   if node.get('pattern')=='^[1-9][0-9]{5}$':node['pattern']='^[1-9][0-9]{3}$';node['maxLength']=4
   for key,value in node.items():
    if key=='Digits' and isinstance(value,dict):value['maxLength']=4
    adjust(value)
  elif isinstance(node,list):
   for value in node:adjust(value)
 adjust(expectedc)
 if new!={'version':1,'policy':expectedp,'contracts':expectedc}:raise GovernanceReadError('Only exact four-digit voice revision allowed')
 return oldp,oldc,new['policy'],new['contracts']

def expected_scope():
 return dict(optInVariable='GOVERNANCE_FOUR_DIGIT_VOICE_REVISION',tables=['api_endpoints','platform_hierarchy_policy'],policyIds=['communication-twilio-voice-v1'],
  baselineRequirementSha256=hashlib.sha256(OLD_POLICY.read_bytes()).hexdigest(),baselineContractsSha256=hashlib.sha256(OLD_CONTRACTS.read_bytes()).hexdigest(),revisionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),
  schemaChanges=False,businessDataWrites=False,permissionChanges=False,providerWrites=False,activation=False)

def checked_rows(reader):
 oldp,oldc,newp,newc=documents()
 anchor=reader.execute('SELECT app_id FROM api_endpoints WHERE id=710').fetchall()
 if len(anchor)!=1 or anchor[0][0] is None:raise GovernanceReadError('Communication anchor required')
 policies=reader.execute('SELECT definition,requirement FROM platform_hierarchy_policy WHERE id=?',(oldp['id'],)).fetchall()
 if len(policies)!=1:raise GovernanceReadError('One existing voice requirement required')
 policy=(json.loads(policies[0][0]),policies[0][1])
 if policy not in [(oldp,oldp['requirement']),(newp,newp['requirement'])]:raise GovernanceReadError('Edited voice policy preserved')
 rows=[];ids=set()
 for old,new in zip(oldc['operations'],newc['operations']):
  found=reader.execute('SELECT id,'+','.join(FIELDS)+' FROM api_endpoints WHERE http_method=? AND route_path=?',(old['method'],old['path'])).fetchall()
  before=values(oldc,old,anchor[0][0]);after=values(newc,new,anchor[0][0])
  if len(found)!=1 or normalized(found[0][1:]) not in [[before[k] for k in FIELDS],[after[k] for k in FIELDS]]:raise GovernanceReadError('Edited or missing voice contract preserved')
  aid=found[0][0]
  if type(aid) is not int or aid<1 or aid in ids or reader.execute('SELECT COUNT(*) FROM api_endpoints WHERE id=?',(aid,)).fetchall()!=[(1,)]:raise GovernanceReadError('Voice identity collision')
  ids.add(aid);rows.append((aid,normalized(found[0][1:]),after))
 return policy,newp,rows

class FourDigitVoiceRevisionStore(TwilioContractRegistrationStore):
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get('fourDigitVoiceRevisionWriter')!=expected_scope() or os.environ.get('GOVERNANCE_FOUR_DIGIT_VOICE_REVISION')!='1':raise GovernanceReadError('Exact four-digit revision scope and opt-in required')
   documents();self.db.execute('LOCK TABLE '+self.table('platform_hierarchy_policy')+' IN SHARE ROW EXCLUSIVE MODE')
  except Exception:self.db.rollback();self.db.close();raise

def revise(store):
 if store.pin.get('fourDigitVoiceRevisionWriter')!=expected_scope() or os.environ.get('GOVERNANCE_FOUR_DIGIT_VOICE_REVISION')!='1':raise GovernanceReadError('Exact revision capability required')
 policy,newp,rows=checked_rows(store)
 # Validate every row before the first update. Never alter a differing human edit.
 for aid,current,after in rows:
  if current!=[after[k] for k in FIELDS]:
   changed=[k for k in FIELDS if current[FIELDS.index(k)]!=after[k]]
   if not set(changed)<={'request_schema','response_schema'}:raise GovernanceReadError('Only extension schema fields may change')
   store.db.execute('UPDATE '+store.table('api_endpoints')+' SET request_schema=%s,response_schema=%s WHERE id=%s',
    [store._value('api_endpoints','request_schema',after['request_schema']),store._value('api_endpoints','response_schema',after['response_schema']),store._value('api_endpoints','id',aid)])
 if policy!=(newp,newp['requirement']):
  store.db.execute('UPDATE '+store.table('platform_hierarchy_policy')+' SET definition=%s,requirement=%s WHERE id=%s',
   [store._value('platform_hierarchy_policy','definition',json.dumps(newp,sort_keys=True)),store._value('platform_hierarchy_policy','requirement',newp['requirement']),store._value('platform_hierarchy_policy','id',newp['id'])])
 verify_reader(store)
 return dict(extensionDigits=4,contracts=21,policyVersion=2,grantsChanged=False,assignmentsChanged=False,providerWrites=False,activation=False)

def verify_reader(reader):
 policy,newp,rows=checked_rows(reader)
 if policy!=(newp,newp['requirement']) or any(current!=[after[k] for k in FIELDS] for _,current,after in rows):raise GovernanceReadError('Four-digit metadata readback incomplete')

def verify():
 from production_reader import connect
 pin=json.loads((HERE/'production-pin.json').read_text())
 if pin.get('fourDigitVoiceRevisionWriter')!=expected_scope():raise GovernanceReadError('Pinned revision scope required')
 with connect() as reader:verify_reader(reader)
 return dict(extensionDigits=4,contracts=21,independentReadback=True,writesAttempted=False,activation=False)

def main():
 if sys.argv[1:] not in [['--dry-run'],['--apply'],['--verify']]:raise SystemExit('Explicit revision mode required')
 mode=sys.argv[1]
 if mode=='--verify':receipt=verify()
 else:
  def transaction():
   with FourDigitVoiceRevisionStore() as db:
    receipt=revise(db)
    if receipt!=revise(db):raise GovernanceReadError('Revision idempotence failed')
    if mode=='--dry-run':db.db.rollback()
    return receipt
  receipt=retry_transaction(transaction)
  if mode=='--apply':verify();receipt['independentReadback']=True
 print('FOUR_DIGIT_VOICE_REVISION '+json.dumps(receipt))
if __name__=='__main__':main()
