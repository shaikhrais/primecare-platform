"""Inherited exact metadata writer; native DDL has a separate tested gate."""
import hashlib,json,os,sys
from pathlib import Path
from communication_storage import CommunicationStorageStore,register,GovernanceReadError,TABLES
ROOT=Path(__file__).resolve().parents[2]
FILE=Path(__file__).with_name('messaging-storage-registration.json')
FILES=['20261022_business_communications.sql','20261023_business_sms.sql','20261024_communication_sms_inbox.sql','20261024_communication_ai_turns.sql','20261024_communication_sms_links.sql']
def definition():
 d=json.loads(FILE.read_text())
 if d.get('version')!=1 or d.get('sourceApiId')!=710 or d.get('baseline')!='communication-messaging-storage-v1' or d.get('migrationPath')!='packages/database/migrations/20261025_communication_messaging_storage.sql' or list(d.get('sourceHashes',{}))!=FILES or len(d.get('tables',{}))!=13:raise GovernanceReadError('Exact messaging storage definition required')
 return d
def migration_sql():
 d=definition();parts=[]
 for name in FILES:
  raw=(ROOT/'packages/database/migrations'/name).read_text()
  if hashlib.sha256(raw.encode()).hexdigest()!=d['sourceHashes'][name]:raise GovernanceReadError('Messaging source hash changed')
  parts.append('-- Reviewed source: '+name+'\n'+raw.replace('CREATE TABLE public.','CREATE TABLE IF NOT EXISTS public.').replace('CREATE UNIQUE INDEX communication_','CREATE UNIQUE INDEX IF NOT EXISTS communication_'))
 expected='-- Generated additive messaging storage bundle. Do not edit; regenerate from reviewed sources.\n\n'+'\n'.join(parts)
 actual=(ROOT/d['migrationPath']).read_text()
 if expected!=actual or hashlib.sha256(actual.encode()).hexdigest()!=d['migrationSha256']:raise GovernanceReadError('Registered messaging bundle differs')
 return actual
def expected_scope():
 d=definition()
 return dict(optInVariable='GOVERNANCE_MESSAGING_STORAGE_WRITES',tables=sorted(TABLES),definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),migrationSha256=d['migrationSha256'],businessTables=sorted(d['tables']),schemaChanges=False,businessDataWrites=False,roleGrants=False,activation=False)
class MessagingStorageStore(CommunicationStorageStore):
 definition_reader=staticmethod(definition)
 migration_reader=staticmethod(migration_sql)
 scope_reader=staticmethod(expected_scope)
 pin_key='messagingStorageWriter'
 opt_in='GOVERNANCE_MESSAGING_STORAGE_WRITES'
class ReadOnlyStorageView:
 definition_reader=staticmethod(definition)
 migration_reader=staticmethod(migration_sql)
 app_id=CommunicationStorageStore.app_id
 baseline_values=CommunicationStorageStore.baseline_values
 def __init__(self,reader):self.reader=reader
 def execute(self,*args):return self.reader.execute(*args)
 def ensure_exact(self,table,key,values,apply):
  if apply or table not in TABLES:raise GovernanceReadError('Read-only storage verification required')
  identity=TABLES[table] or 'name';fields=list(values)
  rows=self.execute('SELECT '+identity+','+','.join(fields)+' FROM '+table+' WHERE '+' AND '.join(k+'=?' for k in key),tuple(key.values())).fetchall()
  if len(rows)!=1 or tuple(rows[0][1:])!=tuple(values.values()):raise GovernanceReadError('Independent messaging metadata readback failed')
  return rows[0][0]
def verify():
 from production_reader import connect
 pin=json.loads((ROOT/'tools/governance-production/production-pin.json').read_text())
 if pin.get('messagingStorageWriter')!=expected_scope():raise GovernanceReadError('Pinned messaging storage verification required')
 migration_sql()
 with connect() as reader:result=register(ReadOnlyStorageView(reader),False)
 return {**result,'independentReadback':True,'writesAttempted':False}
def main():
 if sys.argv[1:] not in [['--register-dry-run'],['--register'],['--verify']]:raise SystemExit('Explicit registration or read-only verification required')
 if sys.argv[1]=='--verify':result=verify()
 else:
  from twilio_voice_registration import retry_transaction
  def run():
   with MessagingStorageStore() as db:
    result=register(db)
    if result!=register(db):raise GovernanceReadError('Non-idempotent messaging storage registration')
    if sys.argv[1]=='--register-dry-run':db.db.rollback()
   return result
  result=retry_transaction(run)
  if sys.argv[1]=='--register':
   checked=verify()
   if result['tableIds']!=checked['tableIds']:raise GovernanceReadError('Storage identities changed after commit')
   result['independentReadback']=True
 print('MESSAGING_STORAGE_REGISTRATION '+json.dumps(result))
if __name__=='__main__':main()
