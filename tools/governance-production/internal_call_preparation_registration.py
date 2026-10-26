"""Exact native app-call contracts; registration never grants access or mounts."""
import hashlib,json,os,sys
from pathlib import Path
from native_call_contracts import NativeCallContractRegistrationStore
import sms_link_contracts_registration as shared
from production_reader import GovernanceReadError
from twilio_voice_registration import retry_transaction
FILE=Path(__file__).with_name('internal-call-preparation-registration.json')
FIELDS=shared.FIELDS
IDENTITIES={'call.prepare':('POST','/v1/calls/prepare'),'call.prepare.read':('POST','/v1/calls/prepare/read')}
def definition():
 d=json.loads(FILE.read_text())
 if d.get('version')!=1 or d.get('activation') is not False or d.get('implementationStatus')!='registered-unimplemented' or d.get('service')!='governance' or d.get('anchorApiId')!=710 or len(d.get('operations',[]))!=2:raise GovernanceReadError('Exact nonactivating app-call definition required')
 seen=set()
 for op in d['operations']:
  if set(op)!={'key','method','path','authentication','responseKind','permission','request','response'} or IDENTITIES.get(op['key'])!=(op['method'],op['path']) or op['key'] in seen or op['authentication']!='native-session-csrf' or op['permission']!='role_screen_permissions' or op['responseKind']!='json':raise GovernanceReadError('Exact app-call operation required')
  seen.add(op['key'])
 return d
def expected_scope():return dict(optInVariable='GOVERNANCE_INTERNAL_CALL_PREPARATION',tables=['api_endpoints'],anchorApiId=710,endpointIdentities=[dict(key=k,method=v[0],path=v[1]) for k,v in sorted(IDENTITIES.items())],definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,permissionChanges=False,providerWrites=False,activation=False)
def values(d,op,app):return {**shared.values(d,op,app),'endpoint_code':'INTERNAL_'+op['key'].replace('.','_').upper()}
class InternalCallPreparationStore(NativeCallContractRegistrationStore):
 pin_key='internalCallPreparationWriter';opt_in='GOVERNANCE_INTERNAL_CALL_PREPARATION'
 definition_reader=staticmethod(lambda:definition());scope_reader=staticmethod(lambda:expected_scope());values_reader=staticmethod(lambda *args:values(*args))
def register(db):return shared.register(db)
class ReadView:
 definition_reader=staticmethod(lambda:definition());scope_reader=staticmethod(lambda:expected_scope());values_reader=staticmethod(lambda *args:values(*args))
 def __init__(self,db):self.execute=db.execute
 def insert_exact(self,*args):raise GovernanceReadError('Missing exact app-call registration')
def verify():
 from production_reader import connect
 pin=json.loads((shared.ROOT/'tools/governance-production/production-pin.json').read_text())
 if pin.get('internalCallPreparationWriter')!=expected_scope():raise GovernanceReadError('Pinned app-call scope required')
 with connect() as reader:result=register(ReadView(reader))
 return dict(**result,independentReadback=True,writesAttempted=False)
def main():
 if sys.argv[1:] not in [['--dry-run'],['--apply'],['--verify']]:raise SystemExit('Explicit mode required')
 if sys.argv[1]=='--verify':result=verify()
 else:
  def transaction():
   with InternalCallPreparationStore() as db:
    result=register(db)
    if result!=register(db):raise GovernanceReadError('Non-idempotent app-call registration')
    if sys.argv[1]=='--dry-run':db.db.rollback()
   return result
  result=retry_transaction(transaction)
  if sys.argv[1]=='--apply':
   if verify()['apiIds']!=result['apiIds']:raise GovernanceReadError('Independent call contract identity changed')
   result['independentReadback']=True
 print('INTERNAL_CALL_PREPARATION '+json.dumps(result))
if __name__=='__main__':main()
