"""Inherit current screen-eligible access writer; preserve every explicit deny."""
import hashlib,json,sys
from pathlib import Path
import voice_contact_access_registration as base
import external_call_registration as contracts
import internal_call_contracts_registration as calls
from production_reader import GovernanceReadError,connect
FILE=Path(__file__).with_name('external-call-access-registration.json')
def definition(db):
 d=json.loads(FILE.read_text());ops=contracts.definition()['operations'][:3]
 if d.get('version')!=1 or d.get('screens')!={'234':'psw_messages','331':'patient_messages','559':'communication','578':'messaging','1269':'PLATFORM_ADMINISTRATION'} or d.get('paths')!=[o['path'] for o in ops] or d.get('roleScreenChanges') is not False or d.get('activation') is not False or d.get('existingDenials')!='preserve':raise GovernanceReadError('Exact existing communication access required')
 d['apiIds']={k:v for k,v in contracts.register(contracts.ReadView(db))['apiIds'].items() if k in ('external.prepare','external.state','external.end')};return d
def expected_scope():
 d=json.loads(FILE.read_text());return dict(optInVariable='GOVERNANCE_EXTERNAL_CALL_ACCESS',tables=sorted(base.TABLES),screenIds=sorted(map(int,d['screens'])),paths=d['paths'],contractSha256=contracts.expected_scope()['definitionSha256'],definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,roleScreenChanges=False,existingDenials='preserve',providerWrites=False,activation=False)
def validate(db):
 d=definition(db)
 for sid,code in d['screens'].items():
  if db.execute('SELECT screen_code,active FROM screens WHERE id=?',(int(sid),)).fetchall()!=[(code,1)]:raise GovernanceReadError('Existing active communication screen required')
 roles=dict(db.execute('SELECT id,role_code FROM roles').fetchall());return [role for role in base.eligible(db,d) if roles.get(role) in d['staffRoleCodes']]

class InternalCallPreparationAccessStore(base.VoiceContactAccessStore):
 pin_key='externalCallAccessWriter';opt_in='GOVERNANCE_EXTERNAL_CALL_ACCESS'
 def definition_for(self):return definition(self)
 def validate_for(self):return validate(self)
 def scope_for(self):return expected_scope()
 def purpose_for(self):return json.loads(FILE.read_text())['purpose']
class ReadView:
 def __init__(self,db):self.execute=db.execute
 def definition_for(self):return definition(self)
 def validate_for(self):return validate(self)
 def scope_for(self):return expected_scope()
 def purpose_for(self):return json.loads(FILE.read_text())['purpose']
def register(db,apply=True):return base.register(db,apply)
def verify():
 with connect() as reader:return dict(**register(ReadView(reader),False),independentReadback=True,writesAttempted=False)
def main():
 if sys.argv[1:] not in [['--dry-run'],['--apply'],['--verify']]:raise SystemExit('Explicit mode required')
 if sys.argv[1]=='--verify':result=verify()
 else:
  def transaction():
   with InternalCallPreparationAccessStore() as db:
    result=register(db)
    if result!=register(db):raise GovernanceReadError('Non-idempotent internal call access')
    if sys.argv[1]=='--dry-run':db.db.rollback()
   return result
  result=contracts.retry_transaction(transaction)
  if sys.argv[1]=='--apply':
   checked=verify()
   if any(checked[k]!=v for k,v in result.items()):raise GovernanceReadError('Independent access readback differs')
   result['independentReadback']=True
 print('EXTERNAL_CALL_ACCESS '+json.dumps(result))
if __name__=='__main__':main()
