"""Register exact SMS link boundary metadata; never mount, grant or provision."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
from twilio_voice_registration import retry_transaction
class NativeCallContractRegistrationStore(ProductionWorkflowStore):
 pin_key="smsLinkContractRegistrationWriter"
 opt_in="GOVERNANCE_SMS_LINK_REGISTRATION"
 definition_reader=None
 scope_reader=None
 values_reader=None
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get(self.pin_key)!=self.scope_reader() or os.environ.get(self.opt_in)!='1':raise GovernanceReadError('Exact pinned SMS link contract scope and opt-in required')
   self.definition_reader()
   self.db.execute('LOCK TABLE '+self.table('api_endpoints')+' IN SHARE ROW EXCLUSIVE MODE')
   meta=self.tables.get('api_endpoints')
   if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('SMS link metadata schema required')
   actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_api_endpoints')).fetchall())
   expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
   if actual!=expected:raise GovernanceReadError('Physical SMS link metadata differs from manifest')
  except Exception:
   self.db.rollback();self.db.close();raise
 def insert_exact(self,entry):
  d=self.definition_reader();op=next((o for o in d['operations'] if (o['method'],o['path'])==(entry.get('http_method'),entry.get('route_path'))),None)
  anchor=self.execute('SELECT app_id FROM api_endpoints WHERE id=710').fetchall()
  if not op or len(anchor)!=1 or entry!=self.values_reader(d,op,anchor[0][0]):raise GovernanceReadError('Only exact SMS link contracts may be inserted')
  fields={c['name'] for c in self.tables['api_endpoints']['columns']}
  if not set(entry)<=fields:raise GovernanceReadError('Unregistered SMS link metadata column')
  entry=dict(entry);entry['id']=self.execute('SELECT COALESCE(MAX(id),0)+1 FROM api_endpoints').fetchone()[0]
  entry['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table('api_endpoints')).fetchone()[0]
  keys=list(entry)
  self.db.execute('INSERT INTO '+self.table('api_endpoints')+'('+','.join(map(quote,keys))+') VALUES('+','.join(['%s']*len(keys))+')',[entry[k] if k=='_primecare_import_row' else self._value('api_endpoints',k,entry[k]) for k in keys])
  return entry['id']
