"""Inherited exact metadata writer; native DDL has a separate tested gate."""
import hashlib,json,os,sys
from pathlib import Path
from communication_storage import CommunicationStorageStore,register,GovernanceReadError,TABLES
ROOT=Path(__file__).resolve().parents[2]
FILE=Path(__file__).with_name('call-audit-storage-registration.json')
FILES=['20261022_business_communications.sql','20261023_business_sms.sql','20261024_communication_sms_inbox.sql','20261024_communication_ai_turns.sql','20261024_communication_sms_links.sql']
def definition():
 d=json.loads(FILE.read_text())
 if d.get('version')!=1 or d.get('sourceApiId')!=710 or d.get('baseline')!='communication-call-audit-v1' or list(d.get('tables',{}))!=['communication_call_audit']:raise GovernanceReadError('Exact audit design required')
 return d
def migration_sql():
 d=definition();raw=(ROOT/d['migrationPath']).read_bytes()
 if hashlib.sha256(raw).hexdigest()!=d['migrationSha256']:raise GovernanceReadError('Audit migration differs')
 return raw.decode()
def expected_scope():
 d=definition()
 return dict(optInVariable='GOVERNANCE_CALL_AUDIT_STORAGE_WRITES',tables=sorted(TABLES),definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),migrationSha256=d['migrationSha256'],businessTables=sorted(d['tables']),schemaChanges=False,businessDataWrites=False,roleGrants=False,activation=False)
class CallAuditStorageStore(CommunicationStorageStore):
 definition_reader=staticmethod(definition)
 migration_reader=staticmethod(migration_sql)
 scope_reader=staticmethod(expected_scope)
 pin_key='callAuditStorageWriter'
 opt_in='GOVERNANCE_CALL_AUDIT_STORAGE_WRITES'
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
 if pin.get('callAuditStorageWriter')!=expected_scope():raise GovernanceReadError('Pinned messaging storage verification required')
 migration_sql()
 with connect() as reader:result=register(ReadOnlyStorageView(reader),False)
 return {**result,'independentReadback':True,'writesAttempted':False}
def main():
 if sys.argv[1:] not in [['--register-dry-run'],['--register'],['--verify']]:raise SystemExit('Explicit registration or read-only verification required')
 if sys.argv[1]=='--verify':result=verify()
 else:
  from twilio_voice_registration import retry_transaction
  def run():
   with CallAuditStorageStore() as db:
    result=register(db)
    if result!=register(db):raise GovernanceReadError('Non-idempotent messaging storage registration')
    if sys.argv[1]=='--register-dry-run':db.db.rollback()
   return result
  result=retry_transaction(run)
  if sys.argv[1]=='--register':
   checked=verify()
   if result['tableIds']!=checked['tableIds']:raise GovernanceReadError('Storage identities changed after commit')
   result['independentReadback']=True
 print('CALL_AUDIT_STORAGE_REGISTRATION '+json.dumps(result))
if __name__=='__main__':main()
