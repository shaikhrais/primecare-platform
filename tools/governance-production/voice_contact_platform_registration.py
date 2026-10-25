"""Exact existing Code Admin screen -> own phone APIs; never clinical access."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
import voice_contact_contracts_registration as contracts
import communication_ui_registration as ui
FILE=Path(__file__).with_name('voice-contact-platform-registration.json')
TABLES={'screen_api_links':'id','api_permissions':'id','screen_components':'id','screen_required_elements':'id'}
PURPOSE='Code Administrator own-phone verification only; no clinical messaging or AI access'
def definition():
 d=json.loads(FILE.read_text())
 if d.get('version')!=1 or d.get('roleCode')!='code_admin' or d.get('screenId')!=1269 or d.get('screenCode')!='PLATFORM_ADMINISTRATION' or d.get('apiIds')!=[16535,16536,16537] or d.get('controls')!=['phoneVerification','phoneStatus','phoneNumber','phoneSend','phoneCode','phoneCheck','phoneRefresh'] or d.get('existingDenials')!='preserve' or d.get('roleScreenChanges') is not False or d.get('activation') is not False:raise GovernanceReadError('Exact own-phone platform scope required')
 return d
def scope():
 d=definition()
 return dict(optInVariable='GOVERNANCE_VOICE_CONTACT_PLATFORM',tables=sorted(TABLES),screenId=d['screenId'],roleCode=d['roleCode'],apiIds=d['apiIds'],definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),uiDefinitionSha256=hashlib.sha256(ui.FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,roleScreenChanges=False,existingDenials='preserve',activation=False)
def plan(db):
 d=definition();sid=d['screenId'];u=ui.definition()
 if db.execute('SELECT screen_code,active FROM screens WHERE id=?',(sid,)).fetchall()!=[(d['screenCode'],1)]:raise GovernanceReadError('Existing platform screen required')
 roles=db.execute('SELECT id,active FROM roles WHERE role_code=?',(d['roleCode'],)).fetchall()
 if len(roles)!=1 or type(roles[0][0])is not int or roles[0][1]!=1:raise GovernanceReadError('Unique active Code Administrator required')
 rid=roles[0][0]
 if db.execute('SELECT can_view FROM role_screen_permissions WHERE role_id=? AND screen_id=?',(rid,sid)).fetchall()!=[(1,)]:raise GovernanceReadError('Existing explicit platform screen view required')
 anchor=db.execute('SELECT app_id FROM api_endpoints WHERE id=710').fetchall()
 if len(anchor)!=1:raise GovernanceReadError('Existing communication application required')
 for op,aid in zip(contracts.definition()['operations'],d['apiIds']):
  actual=db.execute('SELECT '+','.join(contracts.FIELDS)+' FROM api_endpoints WHERE id=?',(aid,)).fetchall()
  expected=contracts.values(contracts.definition(),op,anchor[0][0])
  if len(actual)!=1 or contracts.normalized(actual[0])!=[expected[k] for k in contracts.FIELDS]:raise GovernanceReadError('Exact own-phone API contract required')
 rows=[]
 for aid in d['apiIds']:
  rows.append(('screen_api_links',dict(screen_id=sid,api_id=aid),dict(purpose=PURPOSE)))
  rows.append(('api_permissions',dict(role_id=rid,api_id=aid),dict(permission_key='role_screen_permissions',can_access=1)))
 for key in d['controls']:
  c=u['controls'][key];code=u['namespace']+'.'+key
  if db.execute('SELECT component_code,active FROM primecare_ui_component_registry WHERE id=?',(c['componentId'],)).fetchall()!=[(c['component'],1)]:raise GovernanceReadError('Approved shared component required')
  rows.append(('screen_components',dict(screen_id=sid,component_code=code),dict(component_name=code,component_type=c['component'],data_cy=c['testId'],file_path=u['panelFile'],implementation_status=u['implementationStatus'])))
  rows.append(('screen_required_elements',dict(screen_id=sid,element_key=code),dict(element_type=c['component'],label=code,test_id=c['testId'],required=1)))
 # Reuse already registered text, including statuses/errors. Do not duplicate or
 # overwrite translations and reviewer edits when adding a host screen.
 for key in (k for k in u['locales']['en'] if k.startswith('phone')):
  resources=db.execute('SELECT resource_id,active FROM language_resources WHERE resource_key=?',(u['namespace']+'.'+key,)).fetchall()
  if len(resources)!=1 or resources[0][1]!=1:raise GovernanceReadError('Existing own-phone text required')
  for lang in ['en','fr','es']:
   langs=db.execute('SELECT language_id FROM languages WHERE language_code=? AND enabled=1',(lang,)).fetchall()
   if len(langs)!=1:raise GovernanceReadError('Existing language required')
   if db.execute('SELECT translated_text FROM language_resource_values WHERE resource_id=? AND language_id=?',(resources[0][0],langs[0][0])).fetchall()!=[(u['locales'][lang][key],)]:raise GovernanceReadError('Existing own-phone translation changed; preserve it')
 return rows
def reconcile(db,apply=True):
 denied=0
 for table,key,values in plan(db):
  fields=list(values)
  found=db.execute('SELECT '+','.join(fields)+' FROM '+table+' WHERE '+' AND '.join(k+'=?' for k in key),tuple(key.values())).fetchall()
  if table=='api_permissions' and found==[('role_screen_permissions',0)]:denied+=1;continue
  if found:
   if found!=[tuple(values.values())]:raise GovernanceReadError('Existing platform metadata differs; preserve it')
  elif not apply:raise GovernanceReadError('Platform own-phone metadata missing')
  else:db.insert_planned(table,key,values)
 return dict(definitionSha256=scope()['definitionSha256'],screenId=1269,screenLinks=3,controls=7,apiGrants=3-denied,explicitDenialsPreserved=denied,roleScreenChanges=False,businessDataWrites=False,providerWrites=False,activation=False)
class PlatformContactStore(ProductionWorkflowStore):
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get('voiceContactPlatformWriter')!=scope() or os.environ.get('GOVERNANCE_VOICE_CONTACT_PLATFORM')!='1':raise GovernanceReadError('Exact pinned platform opt-in required')
   sources=['api_endpoints','screens','roles','role_screen_permissions','primecare_ui_component_registry','language_resources','language_resource_values','languages']
   self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted([*TABLES,*sources]))+' IN SHARE ROW EXCLUSIVE MODE')
   for name in TABLES:
    meta=self.tables.get(name)
    if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Exact metadata manifest required')
    actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+name)).fetchall())
    expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
    if actual!=expected:raise GovernanceReadError('Physical metadata differs from manifest')
   self._plan=plan(self)
  except Exception:self.db.rollback();self.db.close();raise
 def insert_planned(self,table,key,values):
  if (table,key,values) not in self._plan:raise GovernanceReadError('Unrelated metadata mutation refused')
  data={**key,**values};data[TABLES[table]]=self.execute('SELECT COALESCE(MAX(id),0)+1 FROM '+table).fetchone()[0]
  data['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0]
  if not set(data)<={'_primecare_import_row',*[c['name'] for c in self.tables[table]['columns']]}:raise GovernanceReadError('Unknown metadata field')
  self.db.execute('INSERT INTO '+self.table(table)+'('+','.join(map(quote,data))+') VALUES('+','.join(['%s']*len(data))+')',[v if k=='_primecare_import_row' else self._value(table,k,v) for k,v in data.items()])
def main():
 if sys.argv[1:] not in [['--dry-run'],['--apply']]:raise SystemExit('Explicit mode required')
 with PlatformContactStore() as db:
  result=reconcile(db)
  if result!=reconcile(db):raise GovernanceReadError('Registration not idempotent')
  if sys.argv[1]=='--dry-run':db.db.rollback()
 if sys.argv[1]=='--apply':
  from production_reader import connect
  with connect() as reader:
   if result!=reconcile(reader,False):raise GovernanceReadError('Independent readback differs')
  result['independentReadback']=True
 print('VOICE_CONTACT_PLATFORM_REGISTRATION '+json.dumps(result))
if __name__=='__main__':main()
