"""Owned synthetic deployed session proof; never reads or changes existing user sessions."""
import os,json,pathlib,uuid,secrets,hashlib,urllib.request,urllib.error,urllib.parse
import psycopg,bcrypt
from playwright.sync_api import sync_playwright
gateway='https://primecare-api-gateway.itpro-mohammed.workers.dev'
portal='https://primecare-clinic.pages.dev'
locale=os.environ['TEST_LOCALE'];width=int(os.environ['TEST_WIDTH'])
db=psycopg.connect(os.environ['PRODUCTION_DATABASE_URL'],connect_timeout=15)
nonce=uuid.uuid4().hex
fixtures=[{'tenant':str(uuid.uuid4()),'user':str(uuid.uuid4()),'email':'sessions-'+nonce+'-'+str(n)+'@15minutes-email.com','password':secrets.token_urlsafe(24)} for n in range(2)]
created=[];report={'scope':'deployed-own-session-browser-api-database','synthetic':True,'locale':locale,'viewport':width,'checks':[],'whole_workflow_verified':False}
def must(value,label):
    assert value,label
    report['checks'].append(label)
def call(path,method='GET',body=None,bearer=None,tenant=None):
    headers={'Content-Type':'application/json','User-Agent':'node','Origin':portal}
    if method!='GET':headers['Idempotency-Key']=str(uuid.uuid4())
    if bearer:headers['Authorization']='Bearer '+bearer
    if tenant:headers['x-tenant-id']=tenant
    request=urllib.request.Request(gateway+path,headers=headers,data=None if body is None else json.dumps(body).encode(),method=method)
    try:
        with urllib.request.urlopen(request,timeout=30) as response:return response.status,json.loads(response.read())
    except urllib.error.HTTPError as error:
        value=json.loads(error.read());report.setdefault('http_denials',[]).append({'method':method,'path':path.split('?')[0],'status':error.code,'response_keys':list(value) if isinstance(value,dict) else []});return error.code,value
def count(user):
    value=db.execute('SELECT COUNT(*) FROM auth_sessions WHERE user_id=%s AND expires_at>NOW()',(user,)).fetchone()[0];db.commit();return value
browser=context=pw=None
try:
    for f in fixtures:
        with db.transaction():
            must(db.execute('SELECT COUNT(*) FROM users WHERE LOWER(email)=%s',(f['email'],)).fetchone()[0]==0,'Preserve any existing synthetic-address account')
            db.execute("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES(%s,'Temporary session QA',%s,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)",(f['tenant'],'sessions-'+f['user']))
            db.execute("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES(%s,%s,%s,'rmt',%s,'active',NOW())",(f['user'],f['email'],f['tenant'],bcrypt.hashpw(f['password'].encode(),bcrypt.gensalt(12)).decode()))
        created.append(f)
    own,other=fixtures
    status,value=call('/v1/auth/login','POST',{'email':other['email'],'password':other['password']});must(status==200 and bool(value.get('token')),'Other-tenant synthetic control session created');other_token=value['token']
    pw=sync_playwright().start();browser=pw.chromium.launch();context=browser.new_context(viewport={'width':width,'height':1000},locale=locale,record_video_dir='test-results/live-sessions/videos',record_video_size={'width':width,'height':1000});page=context.new_page()
    def el(name):return page.locator('[data-cy="'+name+'"]')
    def visit(path):page.goto(portal+path+'?locale='+locale+'&enable-semantics=true',wait_until='domcontentloaded',timeout=60000)
    visit('/login');el('login-email').fill(own['email']);el('login-password').fill(own['password'])
    with page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/auth/login') and r.request.method=='POST',timeout=30000) as result:el('login-submit').click()
    must(result.value.status==200,'Deployed credential login succeeds')
    first=result.value.json().get('token');must(isinstance(first,str) and bool(first),'Browser issued a session')
    page.wait_for_url(lambda u:urllib.parse.urlsplit(u).path!='/login',timeout=30000)
    page.wait_for_function('(token)=>sessionStorage.getItem("primecare_session")===token',arg=first,timeout=30000)
    status,value=call('/v1/auth/login','POST',{'email':own['email'],'password':own['password']});must(status==200 and bool(value.get('token')),'Second own-device session created');second=value['token']
    must(count(own['user'])==2 and count(other['user'])==1,'Database has two own sessions and one tenant-isolation control')
    with page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/user/sessions') and r.request.method=='GET',timeout=30000) as listing:visit('/success')
    must(listing.value.status==200,'Deployed account page loads real own-session API')
    payload=listing.value.json()
    must(set(payload)=={'sessions','pagination'} and payload['pagination']['total']==2 and len(payload['sessions'])==2,'API projection matches exact own database total')
    must(all(set(row)=={'created_at','expires_at','current'} for row in payload['sessions']) and sum(row['current'] for row in payload['sessions'])==1,'Session projection exposes timestamps and current flag only')
    rows=db.execute('SELECT created_at,expires_at FROM auth_sessions WHERE user_id=%s AND expires_at>NOW() ORDER BY created_at DESC,expires_at DESC,token_hash',(own['user'],)).fetchall();db.commit()
    def stamp(value):return value.isoformat(timespec='milliseconds').replace('+00:00','Z')
    must([(x['created_at'],x['expires_at']) for x in payload['sessions']]==[(stamp(a),stamp(b)) for a,b in rows],'API timestamps match native database records')
    el('own-sessions-table-row-1').wait_for(timeout=30000)
    must(el('own-sessions-table-row-0').count()==1 and el('own-sessions-table-row-2').count()==0,'Browser renders exactly the two own sessions')
    must(call('/v1/user/sessions')[0]==401,'Missing bearer denied')
    must(call('/v1/user/sessions',bearer=first,tenant=other['tenant'])[0]==403,'Forged cross-tenant list denied')
    must(call('/v1/user/sessions?userId='+other['user'],bearer=first)[0]==400,'Caller-selected user rejected')
    denied=page.evaluate("""async ({url,token,tenant,key})=>{const response=await fetch(url,{method:'DELETE',headers:{authorization:'Bearer '+token,'x-tenant-id':tenant,'content-type':'application/json','idempotency-key':key}});return response.status;}""",{'url':gateway+'/v1/user/sessions','token':first,'tenant':other['tenant'],'key':str(uuid.uuid4())})
    must(denied==403,'Browser transport forged cross-tenant revocation denied (status '+str(denied)+')')
    must(count(own['user'])==2 and count(other['user'])==1,'Denied actions preserve both accounts')
    with page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/user/sessions') and r.request.method=='GET',timeout=30000) as reloaded:page.reload(wait_until='domcontentloaded')
    must(reloaded.value.status==200 and reloaded.value.json()['pagination']['total']==2,'Authenticated reload rereads real sessions')
    el('own-sessions-table-row-1').wait_for(timeout=30000);el('own-sessions-revoke').click();el('own-sessions-cancel-revoke').click()
    must(count(own['user'])==2,'Cancel leaves own sessions unchanged')
    el('own-sessions-revoke').click()
    must(page.evaluate('document.documentElement.scrollWidth<=innerWidth'),'Registered viewport fits without page overflow')
    path=pathlib.Path('test-results/live-sessions');path.mkdir(parents=True,exist_ok=True)
    page.screenshot(path=str(path/('confirmation-'+locale+'-'+str(width)+'.png')),full_page=True)
    with page.expect_response(lambda r:r.url.split('?')[0].endswith('/v1/user/sessions') and r.request.method=='DELETE',timeout=30000) as revoked:el('own-sessions-confirm-revoke').click()
    must(revoked.value.status==200 and revoked.value.json()=={'revokedSessions':2,'status':'signed_out_all_devices'},'Confirmed browser revocation acknowledges both own sessions')
    page.wait_for_url(lambda u:urllib.parse.urlsplit(u).path=='/login',timeout=30000)
    must(page.evaluate('sessionStorage.getItem("primecare_session")') is None,'Browser token cleared after confirmed revocation')
    must(count(own['user'])==0,'Native database confirms zero remaining own sessions')
    must(call('/v1/auth/me',bearer=first)[0]==401 and call('/v1/auth/me',bearer=second)[0]==401,'Both revoked device tokens rejected')
    must(count(other['user'])==1 and call('/v1/auth/me',bearer=other_token)[0]==200,'Other tenant session survives own revocation')
    audit=db.execute("SELECT previous_state,new_state FROM auth_management_audit WHERE actor_user_id=%s AND target_user_id=%s AND tenant_id=%s",(own['user'],own['user'],own['tenant'])).fetchall();db.commit()
    must(len(audit)==1 and audit[0][0]=={'sessionCount':2} and audit[0][1]=={'sessionCount':0,'action':'sessions_revoked','initiatedBy':'self'},'Exactly one matching committed management audit')
    page.reload(wait_until='domcontentloaded');el('login-form').wait_for(timeout=30000)
    must(page.evaluate('sessionStorage.getItem("primecare_session")') is None,'Reload remains signed out')
    report['passed']=True
except Exception as error:
    report['error']=str(error);raise
finally:
    if context:context.close()
    if browser:browser.close()
    if pw:pw.stop()
    db.rollback()
    try:
        for f in created:
            with db.transaction():
                for table in ['auth_password_resets','auth_sessions','auth_password_audit']:db.execute('DELETE FROM '+table+' WHERE user_id=%s',(f['user'],))
                for table in ['auth_account_audit','auth_management_audit']:db.execute('DELETE FROM '+table+' WHERE tenant_id=%s',(f['tenant'],))
                for operation,subject in [('login',f['email']),('manageAccount',f['user'])]:db.execute('DELETE FROM auth_rate_limits WHERE subject_hash=%s',(hashlib.sha256((operation+':'+subject).encode()).hexdigest(),))
                db.execute('DELETE FROM users WHERE id=%s AND tenant_id=%s',(f['user'],f['tenant']))
                db.execute('DELETE FROM tenants WHERE id=%s',(f['tenant'],))
        report['cleanup']='Exact synthetic users, tenants, sessions, audits and rate counters removed'
    finally:
        db.close();path=pathlib.Path('test-results/live-sessions');path.mkdir(parents=True,exist_ok=True);(path/'receipt.json').write_text(json.dumps(report,indent=2));print('LIVE_OWN_SESSIONS '+json.dumps(report))
