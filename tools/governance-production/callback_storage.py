"""Inherited exact nine-column metadata registration. Native DDL is separate."""
import hashlib,json,os,sys
from pathlib import Path
from communication_storage import CommunicationStorageStore,register,TABLES,GovernanceReadError,ROOT
from messaging_storage import ReadOnlyStorageView
from twilio_voice_registration import retry_transaction
FILE=Path(__file__).with_name('callback-storage-registration.json')
def definition():
 d=json.loads(FILE.read_text())
 if d.get('version')!=1 or d.get('baseline')!='communication-callback-storage-v1' or d.get('sourceApiId')!=710 or d.get('taskApiId')!=16534 or d.get('taskId')!='reception.callback.request' or list(d.get('tables',{}))!=['communication_callback_requests'] or len(d['tables']['communication_callback_requests'])!=9:raise GovernanceReadError('Exact callback storage definition required')
 return d
def migration_sql():
 from importlib.util import spec_from_file_location,module_from_spec
 spec=spec_from_file_location('generate_callback',Path(__file__).with_name('generate-callback-storage.py'));module=module_from_spec(spec);spec.loader.exec_module(module)
 sql,design=module.generated()
 if design!=FILE.read_text() or (ROOT/definition()['migrationPath']).read_text()!=sql:raise GovernanceReadError('Generated callback source differs')
 return sql
def expected_scope():
 d=definition();return dict(optInVariable='GOVERNANCE_CALLBACK_STORAGE_WRITES',tables=sorted(TABLES),definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),migrationSha256=d['migrationSha256'],businessTables=sorted(d['tables']),schemaChanges=False,businessDataWrites=False,roleGrants=False,activation=False)
class CallbackStorageStore(CommunicationStorageStore):
 definition_reader=staticmethod(definition);migration_reader=staticmethod(migration_sql);scope_reader=staticmethod(expected_scope)
 pin_key='callbackStorageWriter';opt_in='GOVERNANCE_CALLBACK_STORAGE_WRITES'
class ReadOnlyCallbackStorageView(ReadOnlyStorageView):
 definition_reader=staticmethod(definition);migration_reader=staticmethod(migration_sql)
def verify():
 from production_reader import connect
 pin=json.loads((ROOT/'tools/governance-production/production-pin.json').read_text())
 if pin.get('callbackStorageWriter')!=expected_scope():raise GovernanceReadError('Pinned callback metadata required')
 migration_sql()
 with connect() as reader:result=register(ReadOnlyCallbackStorageView(reader),False)
 return {**result,'independentReadback':True,'writesAttempted':False}
def main():
 if sys.argv[1:] not in [['--register-dry-run'],['--register'],['--verify']]:raise SystemExit('Explicit registration mode required')
 if sys.argv[1]=='--verify':result=verify()
 else:
  def run():
   with CallbackStorageStore() as db:
    result=register(db)
    if result!=register(db):raise GovernanceReadError('Non-idempotent callback metadata')
    if sys.argv[1]=='--register-dry-run':db.db.rollback()
   return result
  result=retry_transaction(run)
  if sys.argv[1]=='--register':
   checked=verify()
   if result['tableIds']!=checked['tableIds']:raise GovernanceReadError('Callback metadata readback differs')
   result['independentReadback']=True
 print('CALLBACK_STORAGE_REGISTRATION '+json.dumps(result))
if __name__=='__main__':main()
