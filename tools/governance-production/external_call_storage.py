"""Register a hashed upgrade baseline, then extend exactly the existing kind check."""
import hashlib,json,os,sys
from pathlib import Path
import communication_storage as shared
from production_reader import GovernanceReadError,connect
from twilio_voice_registration import retry_transaction
FILE=Path(__file__).with_name('external-call-storage-registration.json')
def definition():return json.loads(FILE.read_text())
def migration_sql():
 d=definition();raw=(shared.ROOT/d['migrationPath']).read_bytes()
 if hashlib.sha256(raw).hexdigest()!=d['migrationSha256']:raise GovernanceReadError('Exact call storage SQL required')
 return raw.decode()
def scope():
 d=definition()
 return dict(optInVariable='GOVERNANCE_EXTERNAL_CALL_STORAGE',tables=sorted(shared.TABLES),definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),migrationSha256=d['migrationSha256'],businessTables=['business_work_aggregates'],schemaChanges=False,businessDataWrites=False,roleGrants=False,activation=False)
def migration_scope():
 d=definition();return dict(optInVariable='GOVERNANCE_EXTERNAL_CALL_STORAGE_MIGRATION',migrationPath=d['migrationPath'],migrationSha256=d['migrationSha256'],businessTables=['business_work_aggregates'],governanceSchemaChanges=False,businessSchemaChanges=True,businessDataWrites=False,roleGrants=False,activation=False,temporaryValidationTables=True)
class ExternalCallStorageStore(shared.CommunicationStorageStore):
 definition_reader=staticmethod(definition);migration_reader=staticmethod(migration_sql);scope_reader=staticmethod(scope)
 pin_key='externalCallStorageWriter';opt_in='GOVERNANCE_EXTERNAL_CALL_STORAGE'
def apply(db):
 if db.pin.get('externalCallStorageMigration')!=migration_scope() or os.environ.get('GOVERNANCE_EXTERNAL_CALL_STORAGE_MIGRATION')!='1':raise GovernanceReadError('Exact call storage migration scope required')
 result=shared.register(db)
 if result!=shared.register(db):raise GovernanceReadError('Non-idempotent call storage registration')
 db.db.execute(migration_sql());db.db.execute(migration_sql())
 return dict(**result,nativeSchemaVerified=True,onlyKnownKindCheckExtended=True)
if __name__=='__main__':
 if sys.argv[1:] not in [['--dry-run'],['--apply']]:raise SystemExit('Explicit mode required')
 def transaction():
  with ExternalCallStorageStore() as db:
   result=apply(db)
   if sys.argv[1]=='--dry-run':db.db.rollback()
  return result
 result=retry_transaction(transaction)
 if sys.argv[1]=='--apply':
  with ExternalCallStorageStore() as db:
   if shared.register(db,False)['baseline']!=result['baseline']:raise GovernanceReadError('Baseline readback mismatch')
   constraints=db.db.execute("SELECT pg_get_expr(conbin,conrelid) FROM pg_constraint WHERE conrelid='public.business_work_aggregates'::regclass AND contype='c' AND convalidated").fetchall()
   if sum("'external_call'::text" in row[0] for row in constraints)!=1:raise GovernanceReadError('Native call kind missing')
  result['independentReadback']=True
 print('EXTERNAL_CALL_STORAGE '+json.dumps(result))
