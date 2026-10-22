"""Register shared messaging controls/locales on existing screens before implementation."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('communication-ui-registration.json')
TABLES={'screen_components':'id','screen_required_elements':'id','language_resources':'resource_id','language_resource_values':'translation_id'}
def definition():return json.loads(FILE.read_text())
def expected_scope():
 d=definition()
 return dict(optInVariable='GOVERNANCE_COMMUNICATION_UI_REGISTRATION',tables=list(TABLES),screenIds=sorted(map(int,d['screens'])),apiIds=d['apiIds'],definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,permissionChanges=False,activation=False)
def validate(db):
 d=definition()
 for sid,code in d['screens'].items():
  if db.execute('SELECT screen_code,active FROM screens WHERE id=?',(int(sid),)).fetchall()!=[(code,1)]:raise GovernanceReadError('Existing communication screen required')
 catalog=json.loads((ROOT/'packages/shared/src/communications/registered-contracts.json').read_text())
 for api in [a for a in catalog['apis'] if a['id'] in d['apiIds']]:
  if db.execute('SELECT http_method,route_path,service_name,auth_required,permission_key FROM api_endpoints WHERE id=?',(api['id'],)).fetchall()!=[(api['method'],api['path'],'governance',1,'role_screen_permissions')]:raise GovernanceReadError('Existing communication API required')
  for sid in map(int,d['screens']):
   if len(db.execute('SELECT id FROM screen_api_links WHERE screen_id=? AND api_id=?',(sid,api['id'])).fetchall())!=1:raise GovernanceReadError('Existing communication API link required')
 if len([a for a in catalog['apis'] if a['id'] in d['apiIds']])!=len(d['apiIds']):raise GovernanceReadError('Unknown communication API')
 for c in d['controls'].values():
  if db.execute('SELECT component_code,active FROM primecare_ui_component_registry WHERE id=?',(c['componentId'],)).fetchall()!=[(c['component'],1)]:raise GovernanceReadError('Approved communication component required')
 langs=dict(db.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
 if set(langs)!=set(d['locales']) or any(set(labels)!=set(d['locales']['en']) for labels in d['locales'].values()):raise GovernanceReadError('Exact enabled communication locales required')
 return langs
def plans(db):
 d=definition();langs=validate(db);result=[]
 for sid in map(int,d['screens']):
  for key,c in d['controls'].items():
   code=d['namespace']+'.'+key
   result.append(('screen_components',{'screen_id':sid,'component_code':code},{'component_name':code,'component_type':c['component'],'data_cy':c['testId'],'file_path':d['panelFile'],'implementation_status':d['implementationStatus']}))
   result.append(('screen_required_elements',{'screen_id':sid,'element_key':code},{'element_type':c['component'],'label':code,'test_id':c['testId'],'required':1}))
 for key in d['locales']['en']:
  code=d['namespace']+'.'+key
  result.append(('language_resources',{'resource_key':code},{'resource_group':d['namespace'],'description':'Shared communication workspace text','context':d['namespace'],'active':1}))
 return result,langs
class CommunicationUiStore(ProductionWorkflowStore):
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get('communicationUiRegistrationWriter')!=expected_scope() or os.environ.get('GOVERNANCE_COMMUNICATION_UI_REGISTRATION')!='1':raise GovernanceReadError('Exact communication UI scope required')
   self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted(TABLES))+' IN SHARE ROW EXCLUSIVE MODE')
   for table in TABLES:
    meta=self.tables.get(table)
    if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Missing/mixed UI metadata')
    actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
    expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
    if actual!=expected:raise GovernanceReadError('UI physical metadata differs from manifest')
  except Exception:self.db.rollback();self.db.close();raise
 def ensure_exact(self,table,key,values,apply=True):
  if table not in TABLES:raise GovernanceReadError('Unrelated UI table refused')
  d=definition();namespace=d['namespace']+'.'
  if table in ['screen_components','screen_required_elements']:
   column='component_code' if table=='screen_components' else 'element_key'
   code=key.get(column,'');control=d['controls'].get(code.removeprefix(namespace)) if code.startswith(namespace) else None
   if set(key)!={'screen_id',column} or key['screen_id'] not in map(int,d['screens']) or not control:raise GovernanceReadError('Exact registered UI control required')
   expected={'component_name':code,'component_type':control['component'],'data_cy':control['testId'],'file_path':d['panelFile'],'implementation_status':d['implementationStatus']} if table=='screen_components' else {'element_type':control['component'],'label':code,'test_id':control['testId'],'required':1}
   if values!=expected:raise GovernanceReadError('Exact UI component values required')
  elif table=='language_resources':
   code=key.get('resource_key','')
   if set(key)!={'resource_key'} or not code.startswith(namespace) or code.removeprefix(namespace) not in d['locales']['en'] or values!={'resource_group':d['namespace'],'description':'Shared communication workspace text','context':d['namespace'],'active':1}:raise GovernanceReadError('Exact UI text namespace required')
  else:
   if set(key)!={'resource_id','language_id'}:raise GovernanceReadError('Exact translation identity required')
   resources=self.execute('SELECT resource_key FROM language_resources WHERE resource_id=? AND context=?',(key['resource_id'],d['namespace'])).fetchall()
   langs=dict(self.execute("SELECT language_id,language_code FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
   locale=langs.get(key['language_id']);code=resources[0][0].removeprefix(namespace) if len(resources)==1 and resources[0][0].startswith(namespace) else None
   if locale not in d['locales'] or code not in d['locales']['en'] or values!={'translated_text':d['locales'][locale][code],'reviewed':0,'approved':0,'version':'communication-workspace-v1'}:raise GovernanceReadError('Exact UI translation required')
  fields=[TABLES[table],*values]
  rows=self.execute('SELECT '+','.join(fields)+' FROM '+table+' WHERE '+' AND '.join(k+'=?' for k in key),tuple(key.values())).fetchall()
  if len(rows)>1 or rows and tuple(rows[0][1:])!=tuple(values.values()):raise GovernanceReadError('Edited or duplicate UI metadata preserved')
  if rows:return rows[0][0]
  if not apply:raise GovernanceReadError('Communication UI registration missing')
  data={**key,**values};data[TABLES[table]]=self.execute('SELECT COALESCE(MAX('+TABLES[table]+'),0)+1 FROM '+table).fetchone()[0]
  data['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0]
  if not set(data)<={'_primecare_import_row',*[c['name'] for c in self.tables[table]['columns']]}:raise GovernanceReadError('Unregistered UI field')
  cols=list(data);self.db.execute('INSERT INTO '+self.table(table)+'('+','.join(map(quote,cols))+') VALUES('+','.join(['%s']*len(cols))+')',[data[k] if k=='_primecare_import_row' else self._value(table,k,data[k]) for k in cols]);return data[TABLES[table]]
def register(db,apply=True):
 d=definition();rows,langs=plans(db)
 for table,key,values in rows:db.ensure_exact(table,key,values,apply)
 for key in d['locales']['en']:
  rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(d['namespace']+'.'+key,)).fetchall()
  if len(rid)!=1:raise GovernanceReadError('Exact UI resource required')
  for locale,labels in d['locales'].items():db.ensure_exact('language_resource_values',{'resource_id':rid[0][0],'language_id':langs[locale]},{'translated_text':labels[key],'reviewed':0,'approved':0,'version':'communication-workspace-v1'},apply)
 return dict(definitionSha256=expected_scope()['definitionSha256'],screens=len(d['screens']),controlsPerScreen=len(d['controls']),resources=len(d['locales']['en']),locales=sorted(langs),permissionGrants=0,activation=False,reviewApproved=False)
def readback(reader):
 d=definition();rows,langs=plans(reader)
 for table,key,values in rows:
  actual=reader.execute('SELECT '+','.join(values)+' FROM '+table+' WHERE '+' AND '.join(k+'=?' for k in key),tuple(key.values())).fetchall()
  if actual!=[tuple(values.values())]:raise GovernanceReadError('Independent UI readback differs')
 for key in d['locales']['en']:
  rid=reader.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(d['namespace']+'.'+key,)).fetchall()
  if len(rid)!=1:raise GovernanceReadError('Independent UI resource identity differs')
  for loc,labels in d['locales'].items():
   actual=reader.execute('SELECT translated_text,reviewed,approved,version FROM language_resource_values WHERE resource_id=? AND language_id=?',(rid[0][0],langs[loc])).fetchall()
   if actual!=[(labels[key],0,0,'communication-workspace-v1')]:raise GovernanceReadError('Independent UI text readback differs')
 return True
def main():
 if sys.argv[1:] not in [['--dry-run'],['--apply']]:raise SystemExit('Explicit mode required')
 with CommunicationUiStore() as db:
  result=register(db)
  if result!=register(db):raise GovernanceReadError('Non-idempotent UI registration')
  if sys.argv[1]=='--dry-run':db.db.rollback()
 if sys.argv[1]=='--apply':
  from production_reader import connect
  with connect() as reader:result['independentReadback']=readback(reader)
 print('COMMUNICATION_UI_REGISTRATION '+json.dumps(result))
if __name__=='__main__':main()
