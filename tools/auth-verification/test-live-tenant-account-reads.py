"""Real deployed CEO read workflows against uniquely owned synthetic tenant records."""
import os,json,pathlib,uuid,secrets,hashlib,urllib.request,urllib.error
import psycopg,bcrypt
from playwright.sync_api import sync_playwright
GATEWAY='https://primecare-api-gateway.itpro-mohammed.workers.dev';PORTAL='https://primecare-corporate.pages.dev'
locale=os.environ['TEST_LOCALE'];width=int(os.environ['TEST_WIDTH']);nonce=uuid.uuid4().hex
report={'synthetic':True,'scope':'deployed-ceo-account-reads','locale':locale,'width':width,'checks':[],'wholeAuthVerified':False}
db=psycopg.connect(os.environ['PRODUCTION_DATABASE_URL'],connect_timeout=15)
tenants=[str(uuid.uuid4()),str(uuid.uuid4())];users=[str(uuid.uuid4()) for _ in range(28)];password=secrets.token_urlsafe(24);created=False;pw=browser=context=None
emails=['a-'+nonce+'@example.invalid']+['b-'+nonce+'-'+str(i).zfill(2)+'@example.invalid' for i in range(26)]+['foreign-'+nonce+'@example.invalid']
def must(value,label):
 assert value,label
 report['checks'].append(label)
def call(path,token=None,tenant=None):
 headers={'Origin':PORTAL,'User-Agent':'node'}
 if token:headers['Authorization']='Bearer '+token
 if tenant:headers['x-tenant-id']=tenant
 req=urllib.request.Request(GATEWAY+path,headers=headers)
 try:
  with urllib.request.urlopen(req,timeout=30) as r:return r.status,json.loads(r.read())
 except urllib.error.HTTPError as e:return e.code,json.loads(e.read())
def snapshot():
 values=[]
 for sql,args in [('SELECT id,email,roles,status FROM users WHERE tenant_id=ANY(%s::uuid[]) ORDER BY id',(tenants,)),('SELECT token_hash,user_id,expires_at FROM auth_sessions WHERE user_id=ANY(%s::uuid[]) ORDER BY token_hash',(users,)),('SELECT actor_user_id,target_user_id,previous_state,new_state FROM auth_management_audit WHERE tenant_id=ANY(%s::uuid[]) ORDER BY id',(tenants,)),('SELECT actor_user_id,target_user_id,action FROM auth_account_audit WHERE tenant_id=ANY(%s::uuid[]) ORDER BY id',(tenants,))]:values.append(db.execute(sql,args).fetchall())
 db.commit();return values
try:
 hashed=bcrypt.hashpw(password.encode(),bcrypt.gensalt(12)).decode()
 with db.transaction():
  for tid in tenants:db.execute("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES(%s,'Temporary account read QA',%s,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)",(tid,'account-reads-'+tid))
  for i,uid in enumerate(users):db.execute("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES(%s,%s,%s,%s,%s,'active',NOW())",(uid,emails[i],tenants[1 if i==27 else 0],'ceo' if i in [0,27] else 'rmt',hashed))
  db.execute("INSERT INTO auth_account_audit(actor_user_id,target_user_id,tenant_id,action) VALUES(%s,%s,%s,'account_created'),(%s,%s,%s,'account_created')",(users[0],users[1],tenants[0],users[27],users[27],tenants[1]))
  db.execute('INSERT INTO auth_management_audit(actor_user_id,target_user_id,tenant_id,previous_state,new_state) VALUES(%s,%s,%s,%s::jsonb,%s::jsonb)',(users[0],users[1],tenants[0],json.dumps({'role':'rmt','status':'active'}),json.dumps({'role':'rmt','status':'active'})))
  for uid in [users[1],users[27]]:db.execute("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES(%s,%s,NOW()+INTERVAL '1 hour')",(hashlib.sha256(secrets.token_urlsafe(32).encode()).hexdigest(),uid))
 created=True
 pw=sync_playwright().start();browser=pw.chromium.launch();context=browser.new_context(viewport={'width':width,'height':1000},locale=locale);page=context.new_page()
 def el(name):return page.locator('[data-cy="'+name+'"]')
 page.goto(PORTAL+'/login?locale='+locale+'&enable-semantics=true',wait_until='domcontentloaded',timeout=60000);el('login-email').fill(emails[0]);el('login-password').fill(password)
 with page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/auth/login') and r.request.method=='POST',timeout=30000) as login:el('login-submit').click()
 must(login.value.status==200,'Real CEO browser credential login');token=login.value.json()['token']
 page.wait_for_url(lambda u:'/login' not in u,timeout=30000)
 el('tenant-accounts-table-row-'+users[1]).wait_for(timeout=30000)
 staffLogin=page.request.post(GATEWAY+'/v1/auth/login',data={'email':emails[2],'password':password},headers={'Origin':PORTAL})
 must(staffLogin.status==200,'Real staff session prepared for denied-role checks');staffToken=staffLogin.json()['token']
 before=snapshot();must(el('tenant-accounts-pagination').inner_text().endswith('27'),'UI account total matches native fixture tenant')
 must(page.locator('[data-cy^="tenant-accounts-table-row-"]').count()==25,'First account page has exact registered page size')
 must(not page.locator('body').inner_text().find(emails[27])>=0,'Foreign tenant email never rendered')
 el('tenant-accounts-next').click();el('tenant-accounts-table-row-'+users[26]).wait_for(timeout=30000)
 must(page.locator('[data-cy^="tenant-accounts-table-row-"]').count()==2,'Next page renders remaining two records')
 el('tenant-accounts-previous').click();el('tenant-accounts-table-row-'+users[1]).wait_for(timeout=30000)
 el('tenant-accounts-search').fill(emails[1]);el('tenant-accounts-searchSubmit'.replace('Submit','-submit')).click()
 page.wait_for_function("document.querySelector('[data-cy=tenant-accounts-pagination]').textContent.endsWith('1')",timeout=30000)
 must(page.locator('[data-cy^="tenant-accounts-table-row-"]').count()==1,'Literal search renders exactly one native account')
 for mode,path in [('details','/v1/admin/users/'+users[1]),('sessions','/v1/admin/users/'+users[1]+'/sessions'),('managementAudit','/v1/admin/users/audit'),('creationAudit','/v1/admin/users/creation-audit')]:
  key={'managementAudit':'management-audit','creationAudit':'creation-audit'}.get(mode,mode)
  with page.expect_response(lambda r:r.url.split('?')[0].endswith(path) and r.request.method=='GET',timeout=30000) as result:el('tenant-accounts-'+key+'-'+users[1]).click()
  response=result.value;must(response.status==200,'Browser '+mode+' reaches canonical API');data=response.json()
  el('tenant-accounts-detailTable'.replace('Table','-table')+'-row-0').wait_for(timeout=30000)
  rendered=el('tenant-accounts-detail-panel').inner_text()
  if mode=='details':
   row=db.execute('SELECT email,roles,status FROM users WHERE id=%s AND tenant_id=%s',(users[1],tenants[0])).fetchone();db.commit()
   must(data['user']['id']==users[1] and [data['user'][k] for k in ['email','roles','status']]==list(row),'Account details match native record');must(all(str(x) in rendered for x in row),'Account fields rendered exactly')
  elif mode=='sessions':
   rows=db.execute('SELECT created_at,expires_at FROM auth_sessions WHERE user_id=%s AND expires_at>NOW() ORDER BY created_at DESC,expires_at DESC,token_hash',(users[1],)).fetchall();db.commit()
   stamp=lambda v:v.isoformat(timespec='milliseconds').replace('+00:00','Z')
   must(data['userId']==users[1] and [(v['created_at'],v['expires_at']) for v in data['sessions']]==[(stamp(a),stamp(b)) for a,b in rows],'Session timestamps match native records');must(all(v in rendered for r in data['sessions'] for v in r.values()),'Session timestamps rendered without token hashes')
  else:
   table='auth_management_audit' if mode=='managementAudit' else 'auth_account_audit';count=db.execute('SELECT COUNT(*) FROM '+table+' WHERE target_user_id=%s AND tenant_id=%s',(users[1],tenants[0])).fetchone()[0];db.commit()
   must(data['pagination']['total']==count and all(e['targetUserId']==users[1] for e in data['events']),mode+' matches native target/tenant records');must(all(e['action'] in rendered and e['targetUserId'] in rendered for e in data['events']),mode+' rendered from persisted records')
  must(call(path,token,tenants[1])[0]==403,mode+' denies foreign tenant header')
  must(call(path,staffToken)[0]==403,mode+' denies staff role')
 must(call('/v1/admin/users')[0]==401,'Account list denies missing session')
 must(call('/v1/admin/users',staffToken)[0]==403,'Account list denies staff role')
 must(call('/v1/admin/users/'+users[27],token)[0]==404,'Foreign account detail concealed')
 must(call('/v1/admin/users/'+users[27]+'/sessions',token)[0]==404,'Foreign account sessions concealed')
 must(snapshot()==before,'All read workflows preserve account/session/audit records')
 page.reload(wait_until='domcontentloaded');el('tenant-accounts-table-row-'+users[1]).wait_for(timeout=30000)
 must(el('tenant-accounts-pagination').inner_text().endswith('27'),'Reload rereads authoritative account list')
 context.set_offline(True);el('tenant-accounts-refresh').click();page.wait_for_function("document.querySelector('[data-cy=tenant-accounts-status]').textContent.length>0 && document.querySelector('[data-cy=tenant-accounts-root]').getAttribute('aria-busy')==='false'",timeout=30000)
 must(page.locator('[data-cy^="tenant-accounts-table-row-"]').count()==0,'Offline failure clears stale account data')
 context.set_offline(False);el('tenant-accounts-refresh').click();el('tenant-accounts-table-row-'+users[1]).wait_for(timeout=30000)
 must(el('tenant-accounts-pagination').inner_text().endswith('27'),'Refresh recovers after offline failure')
 must(page.evaluate('document.documentElement.scrollWidth<=innerWidth'),'Registered viewport has no page overflow')
 out=pathlib.Path('test-results/tenant-account-reads');out.mkdir(parents=True,exist_ok=True);page.screenshot(path=str(out/('accounts-'+locale+'-'+str(width)+'.png')),full_page=True)
 report['passed']=True
except Exception as e:report['error']=str(e);raise
finally:
 if context:context.close()
 if browser:browser.close()
 if pw:pw.stop()
 try:
  db.rollback()
  if created:
   with db.transaction():
    for table in ['auth_sessions','auth_password_resets','auth_password_audit']:db.execute('DELETE FROM '+table+' WHERE user_id=ANY(%s::uuid[])',(users,))
    for table in ['auth_account_audit','auth_management_audit']:db.execute('DELETE FROM '+table+' WHERE tenant_id=ANY(%s::uuid[])',(tenants,))
    for email in emails:db.execute('DELETE FROM auth_rate_limits WHERE subject_hash=%s',(hashlib.sha256(('login:'+email).encode()).hexdigest(),))
    db.execute('DELETE FROM users WHERE id=ANY(%s::uuid[]) AND tenant_id=ANY(%s::uuid[])',(users,tenants));db.execute('DELETE FROM tenants WHERE id=ANY(%s::uuid[])',(tenants,))
   report['cleanup']='Exact synthetic account-read tenants, users, sessions, audits and login counters removed'
 finally:db.close()
 out=pathlib.Path('test-results/tenant-account-reads');out.mkdir(parents=True,exist_ok=True);(out/('results-'+locale+'.json')).write_text(json.dumps(report,indent=2));print('TENANT_ACCOUNT_READS_PROOF '+json.dumps(report))
