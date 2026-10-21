"""Register one challenge API and localized controls on existing MFA screen949."""
import json,hashlib,os,sys,datetime
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('mfa-surface.json')
TABLES={'api_endpoints':'id','screen_components':'id','screen_required_elements':'id','screen_api_links':'id','language_resources':'resource_id','language_resource_values':'translation_id'}
def expected_scope():return dict(optInVariable='GOVERNANCE_MFA_SURFACE_WRITES',tables=list(TABLES),screenId=949,endpoint='/v1/auth/mfa',definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,roleGrants=False)
class Store(ProductionWorkflowStore):
 def ensure(self,table,key,values):
  pk=TABLES[table];fields=list(values)
  rows=self.execute('SELECT '+pk+','+','.join(fields)+' FROM '+table+' WHERE '+' AND '.join(k+'=?' for k in key),tuple(key.values())).fetchall()
  if rows:
   if len(rows)!=1 or tuple(rows[0][1:])!=tuple(values.values()):raise GovernanceReadError('MFA metadata drift; preserve existing rows')
   return rows[0][0]
  values={**key,**values};values[pk]=self.execute('SELECT COALESCE(MAX('+pk+'),0)+1 FROM '+table).fetchone()[0]
  cols={c['name'] for c in self.tables[table]['columns']}
  if not set(values)<=cols:raise GovernanceReadError('Unknown MFA metadata fields')
  if 'created_at' in cols:values.setdefault('created_at',datetime.datetime.now(datetime.timezone.utc).isoformat())
  values['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0]
  self.db.execute('INSERT INTO '+self.table(table)+' ('+','.join(map(quote,values))+') VALUES ('+','.join('%s' for _ in values)+')',[v if k=='_primecare_import_row' else self._value(table,k,v) for k,v in values.items()])
  return values[pk]
def register(db):
 if db.pin.get('mfaSurfaceWriter')!=expected_scope() or os.environ.get('GOVERNANCE_MFA_SURFACE_WRITES')!='1':raise GovernanceReadError('Exact MFA surface scope required')
 d=json.loads(FILE.read_text())
 if db.execute("SELECT screen_code,active FROM screens WHERE id=949").fetchall()!=[('mfa',1)]:raise GovernanceReadError('Existing native MFA screen required')
 policy=db.execute("SELECT definition FROM platform_hierarchy_policy WHERE id='mfa-auth-policy-v1'").fetchall()
 if len(policy)!=1 or json.loads(policy[0][0])!=json.loads(FILE.with_name('mfa-registration.json').read_text()):raise GovernanceReadError('Registered MFA policy required')
 db.db.execute('LOCK TABLE '+','.join(db.table(t) for t in TABLES)+' IN SHARE ROW EXCLUSIVE MODE')
 aid=db.ensure('api_endpoints',{'endpoint_code':d['endpointCode']},dict(app_id=1,route_path=d['endpoint'],http_method='POST',controller_name='mfa',service_name='auth',auth_required=0,implementation_status='registered-unimplemented',request_schema=json.dumps(d['requestSchema'],sort_keys=True),response_schema=json.dumps(d['responseSchema'],sort_keys=True),permission_key=d['permission'],rate_limit_key='mfa_challenge',api_version='v1',is_backend_only=0))
 languages=dict(db.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
 if set(languages)!=set(d['locales']):raise GovernanceReadError('Registered MFA languages required')
 for locale,strings in d['locales'].items():
  for key,text in strings.items():
   rid=db.ensure('language_resources',{'resource_key':'authMfa.'+key},dict(resource_group='authMfa',description='Password-verified MFA challenge',context='authMfa',active=1))
   db.ensure('language_resource_values',dict(resource_id=rid,language_id=languages[locale]),dict(translated_text=text,reviewed=0,approved=0,version='mfa-v1'))
 for name,component in d['controls'].items():
  if db.execute('SELECT active FROM primecare_ui_component_registry WHERE component_code=?',(component,)).fetchall()!=[(1,)]:raise GovernanceReadError('Registered MFA component required')
  key='authMfa.'+name;label=d['locales']['en'].get(name,d['locales']['en']['title'])
  db.ensure('screen_components',dict(screen_id=949,component_code=key),dict(component_name=label,component_type=component,data_cy='mfa-'+name,file_path=d['file'],implementation_status='registered-unimplemented'))
  db.ensure('screen_required_elements',dict(screen_id=949,element_key=key),dict(element_type=component,label=label,test_id='mfa-'+name,required=1))
 db.ensure('screen_api_links',dict(screen_id=949,api_id=aid),dict(purpose='Password-verified challenge; no session authority before MFA'))
 return dict(apiId=aid,screenId=949,activation=False,roleGrants=0)
def main():
 if len(sys.argv)!=2 or sys.argv[1] not in ['--apply','--dry-run']:raise SystemExit('Explicit mode required')
 with Store() as db:
  r=register(db)
  if register(db)!=r:raise GovernanceReadError('Non-idempotent MFA surface')
  if sys.argv[1]=='--dry-run':db.db.rollback()
 print('MFA_SURFACE_REGISTERED '+json.dumps(r))
if __name__=='__main__':main()
