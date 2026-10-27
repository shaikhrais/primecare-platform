"""Narrow inherited access writer: existing own-contact roles, two existing APIs."""
import hashlib,json,sys
from pathlib import Path
import voice_contact_access_registration as base
import twilio_contracts_registration as contracts
from production_reader import GovernanceReadError,connect
FILE=Path(__file__).with_name('callback-approval-access-registration.json')
def source():
 d=json.loads(FILE.read_text())
 if d.get('version')!=1 or d.get('screens')!={'234':'psw_messages','331':'patient_messages','559':'communication','578':'messaging'} or d.get('paths')!=['/v1/voice/tasks/preview','/v1/voice/tasks/approve'] or d.get('eligibility')!='active-communication-screen-and-all-own-phone-enrollment-api-grants' or d.get('permission')!='role_screen_permissions' or d.get('roleScreenChanges') is not False or d.get('activation') is not False or d.get('existingDenials')!='preserve':raise GovernanceReadError('Exact own-callback approval access required')
 return d
def definition(db):
 d=source();doc=contracts.definition();anchor=db.execute('SELECT app_id FROM api_endpoints WHERE id=710').fetchall()
 if len(anchor)!=1:raise GovernanceReadError('Existing communication application required')
 ids={}
 for key,path in zip(['task.preview','task.approve'],d['paths']):
  op=next((o for o in doc['operations'] if o['key']==key),None)
  if not op or op['path']!=path or op['authentication']!='native-session-csrf' or op['permission']!=d['permission']:raise GovernanceReadError('Existing native approval contract required')
  rows=db.execute('SELECT id,'+','.join(contracts.FIELDS)+' FROM api_endpoints WHERE http_method=? AND route_path=?',(op['method'],path)).fetchall()
  if len(rows)!=1 or type(rows[0][0])is not int or rows[0][0]<1 or contracts.normalized(rows[0][1:])!=[contracts.values(doc,op,anchor[0][0])[f] for f in contracts.FIELDS]:raise GovernanceReadError('Exact registered approval API required')
  aid=rows[0][0]
  if aid in ids.values() or db.execute('SELECT COUNT(*) FROM api_endpoints WHERE id=?',(aid,)).fetchall()!=[(1,)]:raise GovernanceReadError('Approval API identity collision')
  ids[key]=aid
 d['apiIds']=ids;return d
def expected_scope():
 d=source();return dict(optInVariable='GOVERNANCE_CALLBACK_APPROVAL_ACCESS',tables=sorted(base.TABLES),screenIds=sorted(map(int,d['screens'])),paths=d['paths'],contractSha256=contracts.expected_scope()['definitionSha256'],definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,roleScreenChanges=False,existingDenials='preserve',providerWrites=False,activation=False)
def validate(db):
 definition(db);eligible=[]
 for role in base.validate(db):
  allow=True
  for aid in base.definition()['apiIds'].values():
   rows=db.execute('SELECT permission_key,can_access FROM api_permissions WHERE role_id=? AND api_id=?',(role,aid)).fetchall()
   if len(rows)>1 or rows and (rows[0][0]!='role_screen_permissions' or type(rows[0][1])is not int or rows[0][1]not in (0,1)):raise GovernanceReadError('Ambiguous own-phone enrollment permission')
   if rows!=[('role_screen_permissions',1)]:allow=False
  if allow:eligible.append(role)
 return eligible
class CallbackApprovalAccessStore(base.VoiceContactAccessStore):
 pin_key='callbackApprovalAccessWriter';opt_in='GOVERNANCE_CALLBACK_APPROVAL_ACCESS'
 def definition_for(self):return definition(self)
 def validate_for(self):return validate(self)
 def scope_for(self):return expected_scope()
 def purpose_for(self):return source()['purpose']
class ReadView:
 def __init__(self,db):self.execute=db.execute
 def definition_for(self):return definition(self)
 def validate_for(self):return validate(self)
 def scope_for(self):return expected_scope()
 def purpose_for(self):return source()['purpose']
def register(db,apply=True):return base.register(db,apply)
def verify():
 with connect() as reader:return dict(**register(ReadView(reader),False),independentReadback=True,writesAttempted=False)
def main():
 if sys.argv[1:]not in [['--dry-run'],['--apply'],['--verify']]:raise SystemExit('Explicit mode required')
 if sys.argv[1]=='--verify':result=verify()
 else:
  def transaction():
   with CallbackApprovalAccessStore() as db:
    result=register(db)
    if result!=register(db):raise GovernanceReadError('Non-idempotent callback approval access')
    if sys.argv[1]=='--dry-run':db.db.rollback()
   return result
  result=contracts.retry_transaction(transaction)
  if sys.argv[1]=='--apply':
   checked=verify()
   if any(checked[k]!=v for k,v in result.items()):raise GovernanceReadError('Independent callback access readback differs')
   result['independentReadback']=True
 print('CALLBACK_APPROVAL_ACCESS '+json.dumps(result))
if __name__=='__main__':main()
