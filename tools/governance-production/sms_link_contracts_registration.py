"""Register exact SMS link boundary metadata; never mount, grant or provision."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
from twilio_voice_registration import retry_transaction
FILE=Path(__file__).with_name('sms-link-contracts-registration.json')
FIELDS=['app_id','http_method','route_path','endpoint_code','api_version','health_status','uses_pagination','service_name','auth_required','permission_key','implementation_status','request_schema','response_schema']
IDENTITIES={'link.'+key:('POST','/v1/messaging/sms/link/'+key) for key in ['status','bind','revoke']}
def definition():
 d=json.loads(FILE.read_text())
 if (not isinstance(d,dict) or set(d)!={'version','requirement','implementationStatus','activation','service','anchorApiId','operations'}
     or type(d.get('version')) is not int or d.get('version')!=1 or d.get('activation') is not False or d.get('implementationStatus')!='registered-unimplemented'
     or d.get('service')!='governance' or type(d.get('anchorApiId')) is not int or d.get('anchorApiId')!=710
     or not isinstance(d.get('requirement'),str) or not d['requirement'].strip() or not isinstance(d.get('operations'),list) or len(d['operations'])!=3):
  raise GovernanceReadError('Nonactivating contact contract definition required')
 seen=set()
 for op in d['operations']:
  if not isinstance(op,dict) or set(op)!={'key','method','path','authentication','responseKind','permission','request','response'} or not isinstance(op.get('key'),str) or IDENTITIES.get(op.get('key'))!=(op.get('method'),op.get('path')) or op['key'] in seen or op.get('authentication')!='native-session-csrf' or op.get('permission')!='role_screen_permissions' or op.get('responseKind')!='json':raise GovernanceReadError('Exact native SMS link boundary required')
  seen.add(op['key'])
  if not isinstance(op.get('request'),dict) or not isinstance(op.get('response'),dict) or op['request'].get('additionalProperties') is not False:raise GovernanceReadError('Exact native schemas required')
 return d

def expected_scope():
 return dict(optInVariable='GOVERNANCE_SMS_LINK_REGISTRATION',tables=['api_endpoints'],anchorApiId=710,
  endpointIdentities=[{'key':k,'method':v[0],'path':v[1]} for k,v in sorted(IDENTITIES.items())],
  definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,
  permissionChanges=False,providerWrites=False,activation=False)

def values(d,op,app):
 return dict(app_id=app,http_method=op['method'],route_path=op['path'],endpoint_code='SMS_LINK_'+op['key'].split('.')[-1].upper(),api_version='v1',health_status='unknown',uses_pagination=0,service_name=d['service'],auth_required=1,permission_key=op['permission'],implementation_status=d['implementationStatus'],request_schema=json.dumps(op['request'],sort_keys=True),response_schema=json.dumps(op['response'],sort_keys=True))

def normalized(row):
 result=list(row)
 for index,key in enumerate(FIELDS):
  if key in ['request_schema','response_schema']:
   try:result[index]=json.dumps(json.loads(result[index]) if isinstance(result[index],str) else result[index],sort_keys=True)
   except (ValueError,TypeError):raise GovernanceReadError('Edited SMS link schema preserved')
 return result

from native_call_contracts import NativeCallContractRegistrationStore
class SmsLinkContractRegistrationStore(NativeCallContractRegistrationStore):
 definition_reader=staticmethod(lambda: definition())
 scope_reader=staticmethod(lambda: expected_scope())
 values_reader=staticmethod(lambda *args: values(*args))

def register(db):
 d=db.definition_reader() if hasattr(db,'definition_reader') else definition();anchor=db.execute('SELECT app_id FROM api_endpoints WHERE id=710').fetchall()
 if len(anchor)!=1 or anchor[0][0] is None:raise GovernanceReadError('Existing communication application required')
 receipt={}
 for op in d['operations']:
  expected=(db.values_reader if hasattr(db,'values_reader') else values)(d,op,anchor[0][0]);rows=db.execute('SELECT id,'+','.join(FIELDS)+' FROM api_endpoints WHERE http_method=? AND route_path=?',(op['method'],op['path'])).fetchall()
  if len(rows)>1:raise GovernanceReadError('Duplicate SMS link endpoint identity')
  if rows:
   if normalized(rows[0][1:])!=[expected[k] for k in FIELDS]:raise GovernanceReadError('Existing SMS link contract preserved; reconciliation required')
   aid=rows[0][0]
  else:aid=db.insert_exact(expected)
  if type(aid) is not int or aid<1 or aid in receipt.values() or db.execute('SELECT COUNT(*) FROM api_endpoints WHERE id=?',(aid,)).fetchone()[0]!=1:raise GovernanceReadError('SMS link contract identity collision')
  receipt[op['key']]=aid
 return dict(apiIds=receipt,registered=len(receipt),roleGrants=0,messagesSent=0,numbersPurchased=0,providerWrites=False,activation=False,definitionSha256=(db.scope_reader() if hasattr(db,'scope_reader') else expected_scope())['definitionSha256'])

def transaction(mode):
 with SmsLinkContractRegistrationStore() as db:
  result=register(db)
  if result!=register(db):raise GovernanceReadError('SMS link registration is not idempotent')
  if mode=='--dry-run':db.db.rollback()
 return result

def verify():
 # Independent read-only adapter, never a registration-store fallback.
 from production_reader import connect
 pin=json.loads((ROOT/'tools/governance-production/production-pin.json').read_text())
 if pin.get('smsLinkContractRegistrationWriter')!=expected_scope():raise GovernanceReadError('Pinned SMS link contract verification scope required')
 d=definition();ids={}
 with connect() as reader:
  anchor=reader.execute('SELECT app_id FROM api_endpoints WHERE id=710').fetchall()
  if len(anchor)!=1 or anchor[0][0] is None:raise GovernanceReadError('Voice verification anchor missing')
  for op in d['operations']:
   rows=reader.execute('SELECT id,'+','.join(FIELDS)+' FROM api_endpoints WHERE http_method=? AND route_path=?',(op['method'],op['path'])).fetchall()
   if len(rows)!=1 or normalized(rows[0][1:])!=[values(d,op,anchor[0][0])[k] for k in FIELDS]:raise GovernanceReadError('Independent SMS link contract readback failed')
   aid=rows[0][0]
   if type(aid) is not int or aid<1 or aid in ids.values() or reader.execute('SELECT COUNT(*) FROM api_endpoints WHERE id=?',(aid,)).fetchall()!=[(1,)]:raise GovernanceReadError('Independent SMS link identity collision')
   ids[op['key']]=aid
 return dict(apiIds=ids,registered=len(ids),independentReadback=True,writesAttempted=False,roleGrants=0,messagesSent=0,providerWrites=False,activation=False,definitionSha256=expected_scope()['definitionSha256'])

def main():
 if sys.argv[1:] not in [['--dry-run'],['--apply'],['--verify']]:raise SystemExit('Explicit mode required')
 if sys.argv[1]=='--verify':result=verify()
 else:
  result=retry_transaction(lambda:transaction(sys.argv[1]))
  if sys.argv[1]=='--apply':
   checked=verify()
   if checked['apiIds']!=result['apiIds']:raise GovernanceReadError('SMS link contract identity changed after registration')
   result['independentReadback']=True
 print('SMS_LINK_CONTRACT_REGISTRATION '+json.dumps(result))
if __name__=='__main__':main()
