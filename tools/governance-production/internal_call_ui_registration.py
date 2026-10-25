"""Inherit existing exact UI metadata writer for the shared native call panel."""
import hashlib,json,sys
from pathlib import Path
import communication_ui_registration as base
import internal_call_access_registration as access
from production_reader import GovernanceReadError,connect
FILE=Path(__file__).with_name('internal-call-ui-registration.json')
def definition():
 d=json.loads(FILE.read_text())
 if d.get('version')!=1 or d.get('namespace')!='internal_calls' or d.get('screens')!=json.loads(access.FILE.read_text())['screens'] or d.get('panelFile')!='websites/typescript/src/internal-calls.ts' or d.get('productionReady') is not False or d.get('reviewApproved') is not False or set(d.get('locales',{}))!={'en','fr','es'}:raise GovernanceReadError('Exact shared call UI scope required')
 return d
def expected_scope():
 d=definition();return dict(optInVariable='GOVERNANCE_INTERNAL_CALL_UI',tables=list(base.TABLES),screenIds=sorted(map(int,d['screens'])),namespace=d['namespace'],paths=d['paths'],definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,permissionChanges=False,activation=False)
def validate(db):
 d=definition();ids=access.contracts.register(access.contracts.ReadView(db))['apiIds']
 for sid,code in d['screens'].items():
  if db.execute('SELECT screen_code,active FROM screens WHERE id=?',(int(sid),)).fetchall()!=[(code,1)]:raise GovernanceReadError('Existing call host screen required')
  for aid in ids.values():
   if len(db.execute('SELECT id FROM screen_api_links WHERE screen_id=? AND api_id=?',(int(sid),aid)).fetchall())!=1:raise GovernanceReadError('Exact call API screen link required')
 for cid,code in {(c['componentId'],c['component']) for c in d['controls'].values()}:
  if db.execute('SELECT component_code,active FROM primecare_ui_component_registry WHERE id=?',(cid,)).fetchall()!=[(code,1)]:raise GovernanceReadError('Approved call component required')
 langs=dict(db.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
 if set(langs)!=set(d['locales']) or any(set(v)!=set(d['locales']['en']) for v in d['locales'].values()):raise GovernanceReadError('Exact enabled call locales required')
 return langs
class InternalCallUiStore(base.CommunicationUiStore):
 pin_key='internalCallUiWriter';opt_in='GOVERNANCE_INTERNAL_CALL_UI'
 def definition_for(self):return definition()
 def scope_for(self):return expected_scope()
 def validate_for(self):return validate(self)
class ReadView:
 def __init__(self,db):self.execute=db.execute
 def definition_for(self):return definition()
 def validate_for(self):return validate(self)
def main():
 if sys.argv[1:] not in [['--dry-run'],['--apply'],['--verify']]:raise SystemExit('Explicit mode required')
 if sys.argv[1]=='--verify':
  with connect() as reader:base.readback(ReadView(reader))
  result=dict(independentReadback=True,writesAttempted=False,definitionSha256=expected_scope()['definitionSha256'])
 else:
  with InternalCallUiStore() as db:
   result=base.register(db)
   if result!=base.register(db):raise GovernanceReadError('Non-idempotent call UI')
   if sys.argv[1]=='--dry-run':db.db.rollback()
  if sys.argv[1]=='--apply':
   with connect() as reader:base.readback(ReadView(reader))
   result['independentReadback']=True
 print('INTERNAL_CALL_UI '+json.dumps(result))
if __name__=='__main__':main()
