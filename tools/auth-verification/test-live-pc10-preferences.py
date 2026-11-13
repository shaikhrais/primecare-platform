"""Owned synthetic deployed PC10 settings acceptance; no existing account is changed."""
import hashlib,json,os,pathlib,secrets,uuid,urllib.request,urllib.error
import psycopg,bcrypt
from playwright.sync_api import sync_playwright
GATEWAY='https://primecare-api-gateway.itpro-mohammed.workers.dev'
PORTAL='https://primecare-corporate.pages.dev'
report={'scope':'owned-production-PC10-shortcuts','synthetic':True,'checks':[],'humanReviewApproved':False,'deviceTested':False}
created=False;browser=pw=None;tenants=[];users=[];emails=[];passwords={}
db=psycopg.connect(os.environ['PRODUCTION_DATABASE_URL'],connect_timeout=15)
pin=json.loads(pathlib.Path('tools/governance-production/production-pin.json').read_text())
q=lambda name:'"'+pin['schema']+'"."'+pin['tablePrefix']+name+'"'
def must(value,label):
 if not value:raise AssertionError(label)
 report['checks'].append(label)
def call(body,token=None,headers=None):
 request=urllib.request.Request(GATEWAY+'/v1/user/preferences',method='POST',data=json.dumps(body).encode(),headers={'Origin':PORTAL,'User-Agent':'node','Content-Type':'application/json',**({'Authorization':'Bearer '+token} if token else {}),**(headers or {})})
 try:
  with urllib.request.urlopen(request,timeout=30) as response:return response.status,json.loads(response.read())
 except urllib.error.HTTPError as error:
  return error.code,json.loads(error.read())
def scoped(uid,tid):return {'version':1,'action':'read','expectedScope':{'tenantId':tid,'userId':uid,'role':'tenant_admin','dataset':'live'},'dataset':'live','kind':'shortcuts','resource':'navigation'}
def snapshot(uid,tid):
 value=db.execute("SELECT revision,document FROM account_preference_documents WHERE user_id=%s AND tenant_id=%s AND actor_role='tenant_admin' AND dataset='live' AND kind='shortcuts' AND resource='navigation'",(uid,tid)).fetchone();db.commit();return value
def audit_count(uid):
 n=db.execute('SELECT COUNT(*) FROM account_preference_audit WHERE user_id=%s',(uid,)).fetchone()[0];db.commit();return n
def login_api(page,email,password):
 response=page.request.post(GATEWAY+'/v1/auth/login',data={'email':email,'password':password},headers={'Origin':PORTAL})
 must(response.status==200,'Real API credential login for owned comparison actor')
 return response.json()['token']
try:
 manifest=db.execute('SELECT manifest_sha256 FROM '+q('source_manifest')).fetchall();db.commit();must(manifest==[(pin['manifestSha256'],)],'Pinned production metadata authority')
 denied=db.execute('SELECT r.role_code FROM '+q('roles')+' r WHERE r.active=1 AND NOT EXISTS(SELECT 1 FROM '+q('api_permissions')+' p WHERE p.api_id=777 AND p.role_id=r.id AND p.can_access=1) ORDER BY CASE lower(r.role_code) WHEN \'ceo\' THEN 0 WHEN \'hr_director\' THEN 1 ELSE 2 END,r.id LIMIT 1').fetchone();db.commit();must(denied is not None,'Existing ungranted role available for denial fixture')
 fixtures=[];nonce=uuid.uuid4().hex
 with db.transaction():
  for locale,width in [('en',320),('fr',768),('es',1440)]:
   a,b=str(uuid.uuid4()),str(uuid.uuid4());tenants.extend([a,b])
   for tid in [a,b]:db.execute("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES(%s,'Temporary PC10 owned settings QA',%s,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)",(tid,'pc10-'+tid))
   actors=[]
   for index,(tid,role) in enumerate([(a,'tenant_admin'),(a,'tenant_admin'),(b,'tenant_admin'),(a,denied[0])]):
    uid=str(uuid.uuid4());email='pc10-'+nonce+'-'+locale+'-'+str(index)+'@example.invalid';password=secrets.token_urlsafe(24);users.append(uid);emails.append(email);passwords[uid]=password
    db.execute("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES(%s,%s,%s,%s,%s,'active',NOW())",(uid,email,tid,role,bcrypt.hashpw(password.encode(),bcrypt.gensalt()).decode()))
    actors.append({'id':uid,'tenant':tid,'email':email,'role':role})
   fixtures.append((locale,width,actors))
 created=True;report['fixtureIdentifiers']={'tenants':tenants,'users':users}
 pw=sync_playwright().start();browser=pw.chromium.launch()
 for locale,width,actors in fixtures:
  report['stage']=locale+'-owned-settings'
  owner,peer,foreign,ungranted=actors
  context=browser.new_context(viewport={'width':width,'height':1000},locale=locale);page=context.new_page()
  try:
   page.goto(PORTAL+'/login?locale='+locale+'&enable-semantics=true',wait_until='domcontentloaded',timeout=60000)
   page.locator('[data-cy=login-email]').fill(owner['email']);page.locator('[data-cy=login-password]').fill(passwords[owner['id']])
   with page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/auth/login') and r.request.method=='POST',timeout=30000) as login:page.locator('[data-cy=login-submit]').click()
   must(login.value.status==200,locale+' real browser credential login');token=login.value.json()['token'];page.wait_for_url(lambda url:'/login' not in url,timeout=30000)
   page.goto(PORTAL+'/tenant-dashboard?applicationModule=settings&locale='+locale+'#overview',wait_until='domcontentloaded',timeout=60000)
   host=page.locator('[data-pc-tenant-shortcut-host]');host.wait_for(timeout=30000)
   save=host.locator('[data-cy=shell-utilities-save]');toggle=host.locator('[data-cy=shell-utilities-favourite-toggle-1269]')
   page.wait_for_function("() => document.querySelector('[data-cy=shell-utilities-favourite-toggle-1269]')?.disabled===false",timeout=30000)
   initial=scoped(owner['id'],owner['tenant']);status,value=call(initial,token);must(status==200 and value['revision']==0 and value['document'] is None,locale+' new owned preference starts empty')
   must(snapshot(owner['id'],owner['tenant']) is None,locale+' initial load does not write a document')
   toggle.click();must(save.is_enabled(),locale+' actual picker retains dirty choice')
   with page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/user/preferences') and r.request.method=='POST' and (r.request.post_data_json or {}).get('action')=='write',timeout=30000) as acknowledgement:save.click()
   response=acknowledgement.value;request=response.request.post_data_json;reply=response.json();must(response.status==200 and reply['revision']==1,locale+' actual Save commits canonical API777')
   words=json.loads(pathlib.Path('packages/primecare_ui/catalogs/shell-utilities.registration.json').read_text())['locales'][locale]
   page.wait_for_function("message => document.querySelector('[data-cy=shell-utilities-status]')?.textContent===message",words['saved'],timeout=30000)
   expected={'version':1,'screenIds':['2534','1269']};must(reply['document']==expected and snapshot(owner['id'],owner['tenant'])==(1,expected),locale+' UI acknowledgement equals independent production SQL')
   before=audit_count(owner['id']);status,replay=call(request,token);must(status==200 and replay==reply and audit_count(owner['id'])==before,locale+' original receipt replay is idempotent')
   page.reload(wait_until='domcontentloaded');host.wait_for(timeout=30000);page.wait_for_function("() => document.querySelector('[data-cy=shell-utilities-favourite-toggle-1269]')?.getAttribute('aria-pressed')==='true'",timeout=30000)
   must(snapshot(owner['id'],owner['tenant'])==(1,expected) and audit_count(owner['id'])==before,locale+' fresh production reload restores saved choice without replay')
   for actor in [peer,foreign]:
    other=login_api(page,actor['email'],passwords[actor['id']]);status,empty=call(scoped(actor['id'],actor['tenant']),other)
    must(status==200 and empty['revision']==0 and empty['document'] is None,locale+' other owned actor/tenant cannot read owner preferences')
    must(call(initial,other)[0]==409,locale+' injected owner scope is denied')
   bad=login_api(page,ungranted['email'],passwords[ungranted['id']]);denied_body=scoped(ungranted['id'],ungranted['tenant']);denied_body['expectedScope']['role']=ungranted['role'];must(call(denied_body,bad)[0]==403,locale+' existing ungranted role denied without grant changes')
   must(call(initial)[0]==401 and call(initial,token,{'X-Tenant-Id':foreign['tenant']})[0]==400,locale+' missing authentication and tenant override denied')
   stale={**request,'requestId':str(uuid.uuid4()),'revision':0,'document':{'version':1,'screenIds':[]}}
   status,conflict=call(stale,token);must(status==409 and conflict['error']=='revision_conflict' and snapshot(owner['id'],owner['tenant'])==(1,expected),locale+' stale CAS cannot overwrite saved preferences')
   must(page.evaluate('document.documentElement.scrollWidth<=innerWidth+1'),locale+' registered host fits viewport')
   out=pathlib.Path('test-results/pc10-preferences');out.mkdir(parents=True,exist_ok=True);page.screenshot(path=str(out/('saved-'+locale+'.png')),full_page=True)
   page.evaluate("sessionStorage.setItem('primecare_session','changed')");page.locator('[data-cy=tenant-refresh]').click();page.locator('[data-cy=tenant-dashboard-error]').wait_for(timeout=30000);must(page.locator('[data-pc-tenant-shortcut-host]').count()==0,locale+' session change retires owned settings host')
  finally:context.close()
 report['passed']=True
except Exception as error:
 report['errorType']=type(error).__name__
 if isinstance(error,AssertionError):report['failedCheck']=str(error)
 raise RuntimeError('Owned PC10 proof failed: '+report.get('stage','setup')+' / '+type(error).__name__) from None
finally:
 if browser:browser.close()
 if pw:pw.stop()
 try:
  db.rollback()
  if created:
   with db.transaction():
    for table in ['account_preference_documents','account_preference_requests','account_preference_audit']:db.execute('DELETE FROM '+table+' WHERE user_id=ANY(%s) AND tenant_id=ANY(%s)',(users,tenants))
    for uid in users:db.execute('DELETE FROM account_preference_rate WHERE key=%s',(hashlib.sha256(('preferences:account:'+uid).encode()).hexdigest(),))
    for table in ['auth_sessions','auth_password_resets','auth_password_audit']:db.execute('DELETE FROM '+table+' WHERE user_id::text=ANY(%s::text[])',(users,))
    for table in ['auth_account_audit','auth_management_audit']:db.execute('DELETE FROM '+table+' WHERE tenant_id::text=ANY(%s::text[])',(tenants,))
    for email in emails:db.execute('DELETE FROM auth_rate_limits WHERE subject_hash=%s',(hashlib.sha256(('login:'+email).encode()).hexdigest(),))
    db.execute('DELETE FROM users WHERE id::text=ANY(%s::text[]) AND tenant_id::text=ANY(%s::text[])',(users,tenants));db.execute('DELETE FROM tenants WHERE id::text=ANY(%s::text[])',(tenants,))
   must(db.execute('SELECT COUNT(*) FROM users WHERE id::text=ANY(%s::text[])',(users,)).fetchone()[0]==0,'Exact synthetic users removed');db.commit();report['cleanup']='Exact fixture users/tenants/preferences/sessions/audits/account counters removed; shared source counters preserved'
 except Exception as error:report['cleanupErrorType']=type(error).__name__
 finally:db.close()
 out=pathlib.Path('test-results/pc10-preferences');out.mkdir(parents=True,exist_ok=True);(out/'owned-production.json').write_text(json.dumps(report,indent=2));print('PC10_OWNED_PRODUCTION '+json.dumps(report))
 if report.get('cleanupErrorType'):raise RuntimeError('Exact synthetic cleanup failed; identifiers retained in report')
