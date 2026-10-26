"""Inherit current screen-eligible access writer; preserve every explicit deny."""
import hashlib,json,sys
from pathlib import Path
import voice_contact_access_registration as base
import internal_call_preparation_registration as contracts
import internal_call_contracts_registration as calls
from production_reader import GovernanceReadError,connect
FILE=Path(__file__).with_name('internal-call-preparation-access-registration.json')
def definition(db):
 d=json.loads(FILE.read_text());ops=contracts.definition()['operations']
 if d.get('version')!=1 or d.get('screens')!={'234':'psw_messages','331':'patient_messages','559':'communication','578':'messaging'} or d.get('paths')!=[o['path'] for o in ops] or d.get('roleScreenChanges') is not False or d.get('activation') is not False or d.get('existingDenials')!='preserve':raise GovernanceReadError('Exact existing communication access required')
 d['apiIds']=contracts.register(contracts.ReadView(db))['apiIds'];return d
def expected_scope():
 d=json.loads(FILE.read_text());return dict(optInVariable='GOVERNANCE_INTERNAL_CALL_PREPARATION_ACCESS',tables=sorted(base.TABLES),screenIds=sorted(map(int,d['screens'])),paths=d['paths'],contractSha256=contracts.expected_scope()['definitionSha256'],definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,roleScreenChanges=False,existingDenials='preserve',providerWrites=False,activation=False)
def validate(db):
 d=definition(db)
 for sid,code in d['screens'].items():
  if db.execute('SELECT screen_code,active FROM screens WHERE id=?',(int(sid),)).fetchall()!=[(code,1)]:raise GovernanceReadError('Existing active communication screen required')
 original=calls.register(calls.ReadView(db))['apiIds'];command=original['call.command'];media=original['call.media']
 allowed=[]
 for role in base.eligible(db,d):
  rows=db.execute('SELECT permission_key,can_access FROM api_permissions WHERE role_id=? AND api_id=?',(role,command)).fetchall()
  if len(rows)>1:raise GovernanceReadError('Ambiguous existing command permission')
  if rows==[('role_screen_permissions',1)] and db.execute('SELECT permission_key,can_access FROM api_permissions WHERE role_id=? AND api_id=?',(role,media)).fetchall()==[('role_screen_permissions',1)]:allowed.append(role)
 return allowed
class InternalCallPreparationAccessStore(base.VoiceContactAccessStore):
 pin_key='internalCallPreparationAccessWriter';opt_in='GOVERNANCE_INTERNAL_CALL_PREPARATION_ACCESS'
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
  with InternalCallPreparationAccessStore() as db:
   result=register(db)
   if result!=register(db):raise GovernanceReadError('Non-idempotent internal call access')
   if sys.argv[1]=='--dry-run':db.db.rollback()
  if sys.argv[1]=='--apply':
   checked=verify()
   if any(checked[k]!=v for k,v in result.items()):raise GovernanceReadError('Independent access readback differs')
   result['independentReadback']=True
 print('INTERNAL_CALL_PREPARATION_ACCESS '+json.dumps(result))
if __name__=='__main__':main()
