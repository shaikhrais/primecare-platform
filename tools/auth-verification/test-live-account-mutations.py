"""Owned synthetic UI creation/edit/revocation plus real email recovery; no existing accounts."""
import os,json,pathlib,uuid,secrets,hashlib,urllib.request,urllib.error
import psycopg,bcrypt
from playwright.sync_api import sync_playwright
from owned_inbox import OwnedInbox,RECIPIENT
GATEWAY='https://primecare-api-gateway.itpro-mohammed.workers.dev';CORPORATE='https://primecare-corporate.pages.dev';CLINIC='https://primecare-clinic.pages.dev'
locale=os.environ['TEST_LOCALE'];width=int(os.environ['TEST_WIDTH']);nonce=uuid.uuid4().hex
report={'synthetic':True,'scope':'deployed-account-mutations-owned-inbox','locale':locale,'width':width,'checks':[],'wholeAuthVerified':False}
tenants=[str(uuid.uuid4()),str(uuid.uuid4())];actors=[str(uuid.uuid4()) for _ in range(3)];passwords=[secrets.token_urlsafe(24) for _ in range(3)];emails=['mutation-'+nonce+'-'+str(n)+'@example.invalid' for n in range(3)];target_password=secrets.token_urlsafe(24);new_password=secrets.token_urlsafe(24);target_id=None;created=False;inbox=None;pw=browser=ceo=hr=client=None
report['fixtureIdentifiers']={'tenants':tenants,'actors':actors,'nonce':nonce}
db=psycopg.connect(os.environ['PRODUCTION_DATABASE_URL'],connect_timeout=15)
def must(value,label):
 assert value,label
 report['checks'].append(label)
def call(path,method='GET',body=None,token=None,tenant=None):
 headers={'Origin':CORPORATE,'User-Agent':'node','Content-Type':'application/json'}
 if token:headers['Authorization']='Bearer '+token
 if tenant:headers['X-Tenant-Id']=tenant
 request=urllib.request.Request(GATEWAY+path,headers=headers,method=method,data=None if body is None else json.dumps(body).encode())
 try:
  with urllib.request.urlopen(request,timeout=30) as r:return r.status,json.loads(r.read())
 except urllib.error.HTTPError as e:
  raw=e.read()
  try:value=json.loads(raw)
  except ValueError:value={'non_json':True}
  report.setdefault('denials',[]).append({'path':path,'method':method,'status':e.code});return e.code,value
def count_sessions(uid):
 n=db.execute('SELECT COUNT(*) FROM auth_sessions WHERE user_id::text=%s',(uid,)).fetchone()[0];db.commit();return n
def read_user(uid):
 row=db.execute('SELECT email,roles,status,password_hash,tenant_id::text FROM users WHERE id::text=%s',(uid,)).fetchone();db.commit();return row
def el(page,key):return page.locator('[data-cy="'+key+'"]')
def login(context,portal,email,password):
 page=context.new_page();page.goto(portal+'/login?locale='+locale+'&enable-semantics=true',wait_until='domcontentloaded',timeout=60000);el(page,'login-email').fill(email);el(page,'login-password').fill(password)
 with page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/auth/login') and r.request.method=='POST',timeout=30000) as response:el(page,'login-submit').click()
 must(response.value.status==200,'Real browser credential login '+email.split('@')[0].split('-')[0]);token=response.value.json()['token'];page.wait_for_url(lambda u:'/login' not in u,timeout=30000);return page,token
try:
 inbox=OwnedInbox()
 with db.transaction():
  must(db.execute('SELECT COUNT(*) FROM users WHERE LOWER(email)=%s',(RECIPIENT,)).fetchone()[0]==0,'Owned inbox has no existing account; preserve existing users')
  for tid in tenants:db.execute("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES(%s,'Temporary account mutation QA',%s,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)",(tid,'account-mutations-'+tid))
  for n,(uid,role) in enumerate(zip(actors,['ceo','hr_director','ceo'])):db.execute("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES(%s,%s,%s,%s,%s,'active',NOW())",(uid,emails[n],tenants[1 if n==2 else 0],role,bcrypt.hashpw(passwords[n].encode(),bcrypt.gensalt(12)).decode()))
 created=True;pw=sync_playwright().start();browser=pw.chromium.launch();ceo=browser.new_context(viewport={'width':width,'height':1000},locale=locale);page,ceo_token=login(ceo,CORPORATE,emails[0],passwords[0]);el(page,'account-mutations-create-form').wait_for(timeout=30000)
 # Malformed success must never claim that a user was created.
 def malformed(route):
  if route.request.method!='POST':route.continue_();return
  route.fulfill(status=200,content_type='application/json',headers={'access-control-allow-origin':CORPORATE},body='{}')
 page.route('**/v1/auth/register',malformed);el(page,'account-mutations-email').fill('not-created-'+nonce+'@example.invalid');el(page,'account-mutations-password').fill(target_password);el(page,'account-mutations-create-role').select_option('rmt');el(page,'account-mutations-create-submit').click();page.wait_for_function("document.querySelector('[data-cy=account-mutations-password]').value===''",timeout=30000)
 must(not el(page,'account-mutations-create-status').inner_text().endswith('not-created-'+nonce+'@example.invalid'),'Malformed success acknowledgement does not claim creation');must(db.execute('SELECT COUNT(*) FROM users WHERE email=%s',('not-created-'+nonce+'@example.invalid',)).fetchone()[0]==0,'Malformed intercepted response made no native account');db.commit();page.unroute('**/v1/auth/register',malformed)
 el(page,'account-mutations-email').fill(RECIPIENT);el(page,'account-mutations-password').fill(target_password);el(page,'account-mutations-create-role').select_option('rmt')
 with page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/auth/register') and r.request.method=='POST',timeout=30000) as response:el(page,'account-mutations-create-submit').click()
 must(response.value.status==201,'CEO creates account through registered browser form');target=response.value.json()['user'];target_id=target['id'];report['fixtureIdentifiers']['createdAccount']=target_id
 must(target['email']==RECIPIENT and target['roles']=='rmt' and target['tenant_id']==tenants[0],'Creation acknowledgement bound to owned tenant and requested role');row=read_user(target_id);must(row[:3]==(RECIPIENT,'rmt','active') and row[4]==tenants[0] and bcrypt.checkpw(target_password.encode(),row[3].encode()),'Created account and credential hash match native records')
 count=db.execute("SELECT COUNT(*) FROM auth_account_audit WHERE actor_user_id::text=%s AND target_user_id::text=%s AND tenant_id::text=%s AND action='account_created'",(actors[0],target_id,tenants[0])).fetchone()[0];db.commit();must(count==1,'Exactly one attributed native creation audit')
 el(page,'tenant-accounts-table-row-'+target_id).wait_for(timeout=30000);client=browser.new_context(viewport={'width':width,'height':1000},locale=locale);user_page,user_token=login(client,CLINIC,RECIPIENT,target_password);must(count_sessions(target_id)==1,'Newly created account authenticates with a real session')
 el(page,'tenant-accounts-details-'+target_id).click();el(page,'account-mutations-revoke').wait_for(timeout=30000);el(page,'account-mutations-revoke').click();el(page,'account-mutations-cancel').click();must(count_sessions(target_id)==1,'Revoke cancellation preserves target session')
 el(page,'account-mutations-revoke').click()
 with page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/admin/users/'+target_id+'/sessions') and r.request.method=='DELETE',timeout=30000) as response:el(page,'account-mutations-confirm').click()
 must(response.value.status==200 and response.value.json()=={'userId':target_id,'revokedSessions':1},'Confirmed browser revocation acknowledges exact target session count');must(count_sessions(target_id)==0 and call('/v1/auth/me',token=user_token)[0]==401,'Revocation removes database session and rejects old bearer');el(page,'tenant-accounts-table-row-'+target_id).wait_for(timeout=30000)
 status,new_login=call('/v1/auth/login','POST',{'email':RECIPIENT,'password':target_password});must(status==200,'Target reauthenticates before management check');second_token=new_login['token']
 el(page,'tenant-accounts-details-'+target_id).click();el(page,'account-mutations-manage-status').wait_for(timeout=30000);el(page,'account-mutations-manage-status').select_option('inactive')
 with page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/admin/users') and r.request.method=='POST',timeout=30000) as response:el(page,'account-mutations-save').click()
 must(response.value.status==200 and response.value.json()['user']['status']=='inactive','Browser deactivation acknowledged');must(read_user(target_id)[2]=='inactive' and count_sessions(target_id)==0 and call('/v1/auth/me',token=second_token)[0]==401,'Deactivation persisted and revoked target session');must(call('/v1/auth/login','POST',{'email':RECIPIENT,'password':target_password})[0]==401,'Inactive account cannot log in')
 el(page,'tenant-accounts-table-row-'+target_id).wait_for(timeout=30000);el(page,'tenant-accounts-details-'+target_id).click();el(page,'account-mutations-manage-status').wait_for(timeout=30000);el(page,'account-mutations-manage-status').select_option('active');el(page,'account-mutations-manage-role').select_option('physio')
 with page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/admin/users') and r.request.method=='POST',timeout=30000) as response:el(page,'account-mutations-save').click()
 must(response.value.status==200 and response.value.json()['user']['roles']=='physio','Browser reactivation and allowed role change acknowledged');must(read_user(target_id)[1:3]==('physio','active'),'Role and status change persisted in native account');el(page,'tenant-accounts-table-row-'+target_id).wait_for(timeout=30000);page.reload(wait_until='domcontentloaded');el(page,'tenant-accounts-table-row-'+target_id).wait_for(timeout=30000);must('physio' in el(page,'tenant-accounts-table-row-'+target_id).inner_text(),'Reload rereads changed account role')
 audit=db.execute('SELECT previous_state,new_state FROM auth_management_audit WHERE target_user_id::text=%s AND tenant_id::text=%s ORDER BY created_at,id',(target_id,tenants[0])).fetchall();db.commit();report['managementAuditStates']=[{'previous':p,'current':n} for p,n in audit];must(audit==[({'sessionCount':1},{'sessionCount':0,'action':'sessions_revoked'}),({'role':'rmt','status':'active'},{'role':'rmt','status':'inactive'}),({'role':'rmt','status':'inactive'},{'role':'physio','status':'active'})],'Native audit records exact chronological revocation, deactivation and role transition')
 must(call('/v1/admin/users','POST',{'id':actors[0],'role':'ceo','status':'inactive'},ceo_token)[0]==403,'Self modification denied');must(call('/v1/admin/users/'+actors[0]+'/sessions','DELETE',token=ceo_token)[0]==403,'Self administrator revocation denied');must(call('/v1/admin/users','POST',{'id':target_id,'role':'rmt','status':'active'},ceo_token,tenants[1])[0]==403,'Cross-tenant mutation header denied');must(call('/v1/admin/users/'+actors[2]+'/sessions','DELETE',token=ceo_token)[0]==404,'Foreign target session revocation concealed')
 hr=browser.new_context(viewport={'width':width,'height':1000},locale=locale);hr_page,hr_token=login(hr,CORPORATE,emails[1],passwords[1]);el(hr_page,'account-mutations-create-form').wait_for(timeout=30000);must(el(hr_page,'account-mutations-create-role').locator('option[value="ceo"]').count()==0,'HR target choices exclude CEO escalation');must(el(hr_page,'tenant-accounts-root').count()==0,'HR does not receive CEO account read or management controls')
 hr_email='created-by-hr-'+nonce+'@example.invalid';el(hr_page,'account-mutations-email').fill(hr_email);el(hr_page,'account-mutations-password').fill(secrets.token_urlsafe(24));el(hr_page,'account-mutations-create-role').select_option('psw')
 with hr_page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/auth/register') and r.request.method=='POST',timeout=30000) as response:el(hr_page,'account-mutations-create-submit').click()
 must(response.value.status==201,'HR creates its approved PSW role through browser');hr_user=response.value.json()['user'];must(read_user(hr_user['id'])[:3]==(hr_email,'psw','active') and read_user(hr_user['id'])[4]==tenants[0],'HR-created account persists in same tenant');must(call('/v1/auth/register','POST',{'email':'denied-'+nonce+'@example.invalid','password':target_password,'role':'ceo'},hr_token)[0]==403,'Forged HR CEO creation denied by server');must(call('/v1/admin/users','POST',{'id':target_id,'role':'rmt','status':'inactive'},hr_token)[0]==403,'HR management bypass denied')
 # Complete the newly created account lifecycle with real receiving-Worker mail.
 user_page,user_token=login(client,CLINIC,RECIPIENT,target_password);user_page.goto(CLINIC+'/forgot-password?locale='+locale+'&enable-semantics=true',wait_until='domcontentloaded');el(user_page,'recovery-email').fill(RECIPIENT)
 with user_page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/auth/forgot-password') and r.request.method=='POST',timeout=30000) as response:el(user_page,'recovery-submit').click()
 payload=response.value.json();must(response.value.status==200 and 'message' in payload and 'code' not in payload and 'token' not in payload,'Created-account recovery has generic response without code disclosure');code=inbox.wait_code(db,target_id);must(inbox.received,'Real recovery email received and hash matched to newly created account')
 el(user_page,'recovery-reset-link').click();el(user_page,'recovery-email').fill(RECIPIENT);el(user_page,'recovery-code').fill(code);el(user_page,'recovery-password').fill(new_password);el(user_page,'recovery-confirm').fill(new_password)
 with user_page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/auth/reset-password') and r.request.method=='POST',timeout=30000) as response:el(user_page,'recovery-submit').click()
 must(response.value.status==200 and response.value.json().get('status')=='password_reset','Created-account browser password reset succeeds');must(call('/v1/auth/me',token=user_token)[0]==401,'Reset invalidates created-account old session');must(call('/v1/auth/login','POST',{'email':RECIPIENT,'password':target_password})[0]==401,'Reset rejects old created-account password');must(call('/v1/auth/reset-password','POST',{'email':RECIPIENT,'code':code,'newPassword':secrets.token_urlsafe(24)})[0]==400,'Consumed recovery code cannot be reused')
 new_page,new_token=login(client,CLINIC,RECIPIENT,new_password);must(call('/v1/auth/me',token=new_token)[1].get('roles')=='physio','Reset preserves assigned role and new credential session');
 # The same created account now changes its own password through the real shared account form.
 final_password=secrets.token_urlsafe(24);el(new_page,'workspace-account').click();el(new_page,'change-password-form').wait_for(timeout=30000);el(new_page,'current-password').fill(new_password);el(new_page,'new-password').fill(final_password)
 with new_page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/user/change-password') and r.request.method=='POST',timeout=30000) as changed_response:el(new_page,'change-password-submit').click()
 must(changed_response.value.status==200 and changed_response.value.json()=={'status':'password_changed','reauthenticationRequired':True},'Created-account browser password change succeeds with mandatory reauthentication')
 must(bcrypt.checkpw(final_password.encode(),read_user(target_id)[3].encode()) and count_sessions(target_id)==0,'Browser password change persists hash and removes every prior session')
 must(call('/v1/auth/me',token=new_token)[0]==401 and call('/v1/auth/login','POST',{'email':RECIPIENT,'password':new_password})[0]==401,'Browser password change rejects its old bearer and old password')
 n=db.execute('SELECT COUNT(*) FROM auth_password_audit WHERE user_id::text=%s',(target_id,)).fetchone()[0];remaining=db.execute('SELECT COUNT(*) FROM auth_password_resets WHERE user_id::text=%s',(target_id,)).fetchone()[0];db.commit();must(n==2 and remaining==0,'Reset and current-password change both persist audit with no usable reset records');el(new_page,'login-form').wait_for(timeout=30000)
 new_page,new_token=login(client,CLINIC,RECIPIENT,final_password)

 with new_page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/auth/logout') and r.request.method=='POST',timeout=30000) as logout_response:el(new_page,'workspace-logout').click()
 must(logout_response.value.status==200 and logout_response.value.json().get('status')=='signed_out' and count_sessions(target_id)==0 and call('/v1/auth/me',token=new_token)[0]==401,'Created-account browser logout removes its database session and remains denied');el(new_page,'login-form').wait_for(timeout=30000);new_page.reload(wait_until='domcontentloaded');el(new_page,'login-form').wait_for(timeout=30000);must(new_page.evaluate("sessionStorage.getItem('primecare_session')") is None,'Created-account reload clears logged-out session')
 must(page.evaluate('document.documentElement.scrollWidth<=innerWidth') and hr_page.evaluate('document.documentElement.scrollWidth<=innerWidth'),'CEO and HR forms fit registered viewport')
 out=pathlib.Path('test-results/account-mutations');out.mkdir(parents=True,exist_ok=True);page.screenshot(path=str(out/('ceo-'+locale+'-'+str(width)+'.png')),full_page=True);hr_page.screenshot(path=str(out/('hr-'+locale+'-'+str(width)+'.png')),full_page=True);report['received']=inbox.received;report['received_record_sha256']=inbox.digest;report['passed']=True
except Exception as e:report['error']=str(e);raise
finally:
 for context in [ceo,hr,client]:
  if context:context.close()
 if browser:browser.close()
 if pw:pw.stop()
 try:
  if inbox:report['inboxCleanup']=inbox.cleanup()
 except Exception as e:report['inboxCleanupError']=str(e)
 try:
  db.rollback()
  if created:
   with db.transaction():
    owned=db.execute('SELECT id::text,email FROM users WHERE tenant_id::text=ANY(%s::text[])',(tenants,)).fetchall();ids=[r[0] for r in owned]
    for table in ['auth_sessions','auth_password_resets','auth_password_audit']:db.execute('DELETE FROM '+table+' WHERE user_id::text=ANY(%s::text[])',(ids,))
    for table in ['auth_account_audit','auth_management_audit']:db.execute('DELETE FROM '+table+' WHERE tenant_id::text=ANY(%s::text[])',(tenants,))
    for uid,email in owned:
     for operation,subject in [('login',email),('forgot',email),('reset',email),('createAccount',uid),('manageAccount',uid),('changePassword',uid)]:db.execute('DELETE FROM auth_rate_limits WHERE subject_hash=%s',(hashlib.sha256((operation+':'+subject).encode()).hexdigest(),))
    db.execute('DELETE FROM users WHERE tenant_id::text=ANY(%s::text[])',(tenants,));db.execute('DELETE FROM tenants WHERE id::text=ANY(%s::text[])',(tenants,))
   report['cleanup']='Exact owned synthetic mutation tenants, accounts, sessions, reset codes, audits and counters removed'
 except Exception as e:report['cleanupError']=str(e)
 finally:db.close()
 out=pathlib.Path('test-results/account-mutations');out.mkdir(parents=True,exist_ok=True);(out/('results-'+locale+'.json')).write_text(json.dumps(report,indent=2));print('ACCOUNT_MUTATIONS_OWNED_INBOX_PROOF '+json.dumps(report))
 if report.get('cleanupError') or report.get('inboxCleanupError'):raise RuntimeError('Synthetic cleanup failed; exact fixture identifiers preserved')
