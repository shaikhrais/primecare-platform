"""Register exact Messaging boundary metadata; never mount, grant or provision."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
from twilio_voice_registration import retry_transaction
FILE=Path(__file__).with_name('messaging-contracts-registration.json')
FIELDS=['app_id','http_method','route_path','endpoint_code','api_version','health_status','uses_pagination','service_name','auth_required','permission_key','implementation_status','request_schema','response_schema']
IDENTITIES={'sms.incoming':('POST','/v1/twilio/sms/incoming')}
def definition():
 d=json.loads(FILE.read_text())
 if (not isinstance(d,dict) or set(d)!={'version','requirement','implementationStatus','activation','service','anchorApiId','operations'}
     or type(d.get('version')) is not int or d.get('version')!=1 or d.get('activation') is not False or d.get('implementationStatus')!='registered-unimplemented'
     or d.get('service')!='governance' or type(d.get('anchorApiId')) is not int or d.get('anchorApiId')!=710
     or not isinstance(d.get('requirement'),str) or not d['requirement'].strip() or not isinstance(d.get('operations'),list) or len(d['operations'])!=1):
  raise GovernanceReadError('Nonactivating Messaging contract definition required')
 op=d['operations'][0]
 if not isinstance(op,dict) or set(op)!={'key','method','path','authentication','responseKind','permission','request','response'} or IDENTITIES.get(op.get('key'))!=(op.get('method'),op.get('path')) or op.get('authentication')!='twilio-signed-form' or op.get('permission')!='twilio.signature' or op.get('responseKind')!='twiml':
  raise GovernanceReadError('Exact Messaging endpoint and authentication required')
 if not isinstance(op.get('request'),dict) or not isinstance(op.get('response'),dict):raise GovernanceReadError('Messaging schemas required')
 return d

def expected_scope():
 return dict(optInVariable='GOVERNANCE_MESSAGING_CONTRACT_REGISTRATION',tables=['api_endpoints'],anchorApiId=710,
  endpointIdentities=[{'key':k,'method':v[0],'path':v[1]} for k,v in sorted(IDENTITIES.items())],
  definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,
  permissionChanges=False,providerWrites=False,activation=False)

def values(d,op,app):
 return dict(app_id=app,http_method=op['method'],route_path=op['path'],endpoint_code='TWILIO_SMS_INCOMING',api_version='v1',health_status='unknown',uses_pagination=0,service_name=d['service'],auth_required=1,permission_key=op['permission'],implementation_status=d['implementationStatus'],request_schema=json.dumps(op['request'],sort_keys=True),response_schema=json.dumps(op['response'],sort_keys=True))

def normalized(row):
 result=list(row)
 for index,key in enumerate(FIELDS):
  if key in ['request_schema','response_schema']:
   try:result[index]=json.dumps(json.loads(result[index]) if isinstance(result[index],str) else result[index],sort_keys=True)
   except (ValueError,TypeError):raise GovernanceReadError('Edited messaging schema preserved')
 return result

class MessagingContractRegistrationStore(ProductionWorkflowStore):
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get('messagingContractRegistrationWriter')!=expected_scope() or os.environ.get('GOVERNANCE_MESSAGING_CONTRACT_REGISTRATION')!='1':raise GovernanceReadError('Exact pinned Messaging contract scope and opt-in required')
   definition()
   self.db.execute('LOCK TABLE '+self.table('api_endpoints')+' IN SHARE ROW EXCLUSIVE MODE')
   meta=self.tables.get('api_endpoints')
   if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Messaging metadata schema required')
   actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_api_endpoints')).fetchall())
   expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
   if actual!=expected:raise GovernanceReadError('Physical Messaging metadata differs from manifest')
  except Exception:
   self.db.rollback();self.db.close();raise
 def insert_exact(self,entry):
  d=definition();op=next((o for o in d['operations'] if (o['method'],o['path'])==(entry.get('http_method'),entry.get('route_path'))),None)
  anchor=self.execute('SELECT app_id FROM api_endpoints WHERE id=710').fetchall()
  if not op or len(anchor)!=1 or entry!=values(d,op,anchor[0][0]):raise GovernanceReadError('Only exact Messaging contracts may be inserted')
  fields={c['name'] for c in self.tables['api_endpoints']['columns']}
  if not set(entry)<=fields:raise GovernanceReadError('Unregistered Messaging metadata column')
  entry=dict(entry);entry['id']=self.execute('SELECT COALESCE(MAX(id),0)+1 FROM api_endpoints').fetchone()[0]
  entry['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table('api_endpoints')).fetchone()[0]
  keys=list(entry)
  self.db.execute('INSERT INTO '+self.table('api_endpoints')+'('+','.join(map(quote,keys))+') VALUES('+','.join(['%s']*len(keys))+')',[entry[k] if k=='_primecare_import_row' else self._value('api_endpoints',k,entry[k]) for k in keys])
  return entry['id']

def register(db):
 d=definition();anchor=db.execute('SELECT app_id FROM api_endpoints WHERE id=710').fetchall()
 if len(anchor)!=1 or anchor[0][0] is None:raise GovernanceReadError('Existing communication application required')
 receipt={}
 for op in d['operations']:
  expected=values(d,op,anchor[0][0]);rows=db.execute('SELECT id,'+','.join(FIELDS)+' FROM api_endpoints WHERE http_method=? AND route_path=?',(op['method'],op['path'])).fetchall()
  if len(rows)>1:raise GovernanceReadError('Duplicate Messaging endpoint identity')
  if rows:
   if normalized(rows[0][1:])!=[expected[k] for k in FIELDS]:raise GovernanceReadError('Existing Messaging contract preserved; reconciliation required')
   aid=rows[0][0]
  else:aid=db.insert_exact(expected)
  if type(aid) is not int or aid<1 or aid in receipt.values() or db.execute('SELECT COUNT(*) FROM api_endpoints WHERE id=?',(aid,)).fetchone()[0]!=1:raise GovernanceReadError('Messaging contract identity collision')
  receipt[op['key']]=aid
 return dict(apiIds=receipt,registered=len(receipt),roleGrants=0,messagesSent=0,numbersPurchased=0,providerWrites=False,activation=False,definitionSha256=expected_scope()['definitionSha256'])

def transaction(mode):
 with MessagingContractRegistrationStore() as db:
  result=register(db)
  if result!=register(db):raise GovernanceReadError('Messaging registration is not idempotent')
  if mode=='--dry-run':db.db.rollback()
 return result

def verify():
 # Independent read-only adapter, never a registration-store fallback.
 from production_reader import connect
 pin=json.loads((ROOT/'tools/governance-production/production-pin.json').read_text())
 if pin.get('messagingContractRegistrationWriter')!=expected_scope():raise GovernanceReadError('Pinned Messaging contract verification scope required')
 d=definition();ids={}
 with connect() as reader:
  anchor=reader.execute('SELECT app_id FROM api_endpoints WHERE id=710').fetchall()
  if len(anchor)!=1 or anchor[0][0] is None:raise GovernanceReadError('Messaging verification anchor missing')
  for op in d['operations']:
   rows=reader.execute('SELECT id,'+','.join(FIELDS)+' FROM api_endpoints WHERE http_method=? AND route_path=?',(op['method'],op['path'])).fetchall()
   if len(rows)!=1 or normalized(rows[0][1:])!=[values(d,op,anchor[0][0])[k] for k in FIELDS]:raise GovernanceReadError('Independent Messaging contract readback failed')
   aid=rows[0][0]
   if type(aid) is not int or aid<1 or aid in ids.values() or reader.execute('SELECT COUNT(*) FROM api_endpoints WHERE id=?',(aid,)).fetchall()!=[(1,)]:raise GovernanceReadError('Independent Messaging identity collision')
   ids[op['key']]=aid
 return dict(apiIds=ids,registered=len(ids),independentReadback=True,writesAttempted=False,roleGrants=0,messagesSent=0,providerWrites=False,activation=False,definitionSha256=expected_scope()['definitionSha256'])

def main():
 if sys.argv[1:] not in [['--dry-run'],['--apply'],['--verify']]:raise SystemExit('Explicit mode required')
 if sys.argv[1]=='--verify':result=verify()
 else:
  result=retry_transaction(lambda:transaction(sys.argv[1]))
  if sys.argv[1]=='--apply':
   checked=verify()
   if checked['apiIds']!=result['apiIds']:raise GovernanceReadError('Messaging contract identity changed after registration')
   result['independentReadback']=True
 print('MESSAGING_CONTRACT_REGISTRATION '+json.dumps(result))
if __name__=='__main__':main()
