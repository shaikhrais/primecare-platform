"""Register exact bounded elevation/support contracts; never grant or activate access."""
import hashlib,json,os,sys
from pathlib import Path
from mfa_surface import Store,TABLES
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('auth-elevation-surface.json')
def scope():
 return dict(optInVariable='GOVERNANCE_AUTH_ELEVATION_SURFACE_WRITES',tables=list(TABLES),screenIds=[949],accountScreenCode='AUTHENTICATED_ACCOUNT',endpointPrefix='/v1/auth/mfa/',definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,roleGrants=False)
def register(db):
 if db.pin.get('authElevationSurfaceWriter')!=scope() or os.environ.get(scope()['optInVariable'])!='1':raise GovernanceReadError('Exact elevation registration scope required')
 d=json.loads(FILE.read_text());policy=db.execute('SELECT definition FROM platform_hierarchy_policy WHERE id=?',(d['policyId'],)).fetchall()
 if len(policy)!=1 or json.loads(policy[0][0])!=json.loads(FILE.with_name('auth-lifecycle-policy.json').read_text()):raise GovernanceReadError('Registered lifecycle requirement required')
 roles={r[0] for r in db.execute('SELECT role_code FROM roles WHERE active=1')}
 if not {'code_admin','tenant_admin'}<=roles:raise GovernanceReadError('Existing administrator roles required')
 if db.execute('SELECT screen_code,active FROM screens WHERE id=949').fetchall()!=[('mfa',1)]:raise GovernanceReadError('Existing MFA screen required')
 account=db.execute("SELECT id,route_path,active FROM screens WHERE screen_code='AUTHENTICATED_ACCOUNT'").fetchall()
 if len(account)!=1 or account[0][1:]!=('/success',1):raise GovernanceReadError('Existing account approval surface required')
 screens={'mfa':949,'AUTHENTICATED_ACCOUNT':account[0][0]}
 db.db.execute('LOCK TABLE '+','.join(db.table(t) for t in TABLES)+' IN SHARE ROW EXCLUSIVE MODE')
 ids=[]
 for e in d['endpoints']:
  aid=db.ensure('api_endpoints',{'endpoint_code':e['code']},dict(app_id=1,route_path=e['route'],http_method=e['method'],controller_name='auth_elevation',service_name='auth',auth_required=1,implementation_status='registered-unimplemented',request_schema=json.dumps(e['request'],sort_keys=True),response_schema=json.dumps(e['response'],sort_keys=True),permission_key=e['permission'],rate_limit_key='mfa_elevation',api_version='v1',is_backend_only=0))
  sid=screens['AUTHENTICATED_ACCOUNT'] if e['code'] in ['auth_support_requests','auth_support_approve','auth_support_revoke'] else 949
  db.ensure('screen_api_links',dict(screen_id=sid,api_id=aid),dict(purpose='Session-bound 900-second support; tenant approval; aggregate security counts only; no clinical access or impersonation'))
  ids.append(aid)
 languages=dict(db.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
 if set(languages)!=set(d['locales']):raise GovernanceReadError('Existing locales required')
 for locale,strings in d['locales'].items():
  for key,text in strings.items():
   rid=db.ensure('language_resources',{'resource_key':'authElevation.'+key},dict(resource_group='authElevation',description='Bounded support access and explicit tenant approval',context='authElevation',active=1))
   db.ensure('language_resource_values',dict(resource_id=rid,language_id=languages[locale]),dict(translated_text=text,reviewed=0,approved=0,version='auth-elevation-v1'))
 for name,c in d['controls'].items():
  if db.execute('SELECT active FROM primecare_ui_component_registry WHERE component_code=?',(c['component'],)).fetchall()!=[(1,)]:raise GovernanceReadError('Registered PrimeCare component required')
  sid=screens[c['screen']];key='authElevation.'+name;identifier='mfa-elevation-'+name.lower()
  db.ensure('screen_components',dict(screen_id=sid,component_code=key),dict(component_name=key,component_type=c['component'],data_cy=identifier,file_path=c['file'],implementation_status='registered-unimplemented'))
  db.ensure('screen_required_elements',dict(screen_id=sid,element_key=key),dict(element_type=c['component'],label=key,test_id=identifier,required=1))
 return dict(apiIds=ids,controls=len(d['controls']),roleGrants=0,accountChanges=0,activation=False,approvals=False)
if __name__=='__main__':
 if sys.argv[1:] not in [['--dry-run'],['--apply']]:raise SystemExit('Explicit mode required')
 with Store() as db:
  result=register(db)
  if result!=register(db):raise GovernanceReadError('Non-idempotent elevation metadata')
  if sys.argv[1]=='--dry-run':db.db.rollback()
 print('AUTH_ELEVATION_SURFACE '+json.dumps(result))
