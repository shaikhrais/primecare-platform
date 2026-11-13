"""Own temporary native QA actors; prove independent SQL and remove exact fixtures."""
import hashlib,json,os,pathlib,secrets,subprocess,urllib.request,uuid
import psycopg,bcrypt
GATEWAY='https://primecare-api-gateway.itpro-mohammed.workers.dev'
PORTAL='https://primecare-corporate.pages.dev'
out=pathlib.Path('test-results/pc10-native');out.mkdir(parents=True,exist_ok=True)
fixture=out/'fixture.json'
report={'scope':'owned-native-PC10-production','synthetic':True,'nativeRunner':'Flutter widget test with real production HTTP; not a device binary','checks':[],'physicalDeviceTested':False,'humanReviewApproved':False}
users=[];tenants=[];emails=[];sensitive=[];created=False;db=None
def must(value,label):
 if not value:raise AssertionError(label)
 report['checks'].append(label)
try:
 pin=json.loads(pathlib.Path('tools/governance-production/production-pin.json').read_text())
 db=psycopg.connect(os.environ['PRODUCTION_DATABASE_URL'],connect_timeout=15)
 table=lambda name:'"'+pin['schema']+'"."'+pin['tablePrefix']+name+'"'
 must(db.execute('SELECT manifest_sha256 FROM '+table('source_manifest')).fetchall()==[(pin['manifestSha256'],)],'Pinned production authority');db.commit()
 grants=db.execute('SELECT id,api_id,role_id,can_access,permission_key FROM '+table('api_permissions')+' WHERE api_id IN (777,16402) ORDER BY id').fetchall();db.commit()
 actors=[]
 with db.transaction():
  for locale,width in [('en',320),('fr',768),('es',1440)]:
   tid,uid=str(uuid.uuid4()),str(uuid.uuid4());tenants.append(tid);users.append(uid)
   email='pc10-native-'+uid+'@example.invalid';emails.append(email);password=secrets.token_urlsafe(24);sensitive.append(password)
   db.execute("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES(%s,'Temporary owned native PC10 QA',%s,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)",(tid,'pc10-native-'+tid))
   db.execute("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES(%s,%s,%s,'tenant_admin',%s,'active',NOW())",(uid,email,tid,bcrypt.hashpw(password.encode(),bcrypt.gensalt()).decode()))
   actors.append({'id':uid,'tenant':tid,'locale':locale,'width':width,'email':email,'password':password})
 created=True;report['fixtureIdentifiers']={'users':users,'tenants':tenants}
 for actor in actors:
  request=urllib.request.Request(GATEWAY+'/v1/auth/login',method='POST',data=json.dumps({'email':actor['email'],'password':actor['password']}).encode(),headers={'Origin':PORTAL,'User-Agent':'node','Content-Type':'application/json'})
  with urllib.request.urlopen(request,timeout=30) as response:login=json.loads(response.read())
  must(login.get('status')=='authenticated' and login.get('userId')==actor['id'] and login.get('role')=='tenant_admin' and login.get('tenantId')==actor['tenant'],actor['locale']+' real credential login and self scope')
  actor['token']=login['token'];sensitive.append(actor['token'])
  actor.pop('password');actor.pop('email')
 fixture.write_text(json.dumps(actors));fixture.chmod(0o600)
 temporary=pathlib.Path('packages/primecare_ui/test/owned_native_live_test.dart')
 if temporary.exists():raise RuntimeError('Owned native test destination already exists')
 temporary.write_text(pathlib.Path('tools/auth-verification/native-application-live.dart').read_text())
 try:
  result=subprocess.run(['flutter','test','test/owned_native_live_test.dart','--reporter','expanded'],cwd='packages/primecare_ui',env={**os.environ,'PC10_NATIVE_FIXTURE':str(fixture.resolve()),'PC10_OWNED_NATIVE_TEST':'1'},stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,timeout=300)
  safe=result.stdout
  for value in sensitive:safe=safe.replace(value,'[redacted]')
  print(safe[-18000:])
  must(result.returncode==0,'Actual native host completed live production API tests')
 finally:temporary.unlink(missing_ok=True)
 native=json.loads((out/'dart-owned.json').read_text())
 must(len(native['results'])==3 and all(r.get('passed') is True for r in native['results']),'All three locale/viewport native results present')
 for actor in actors:
  row=db.execute("SELECT revision,document FROM account_preference_documents WHERE user_id=%s AND tenant_id=%s AND actor_role='tenant_admin' AND dataset='live' AND kind='shortcuts' AND resource='navigation'",(actor['id'],actor['tenant'])).fetchone();db.commit()
  must(row==(1,{'version':1,'screenIds':['2534','1269']}),actor['locale']+' independent SQL matches native saved choice')
  count=db.execute('SELECT COUNT(*) FROM account_preference_audit WHERE user_id=%s AND tenant_id=%s',(actor['id'],actor['tenant'])).fetchone()[0];db.commit()
  must(count==1,actor['locale']+' native reload did not repeat a mutation')
 must(db.execute('SELECT id,api_id,role_id,can_access,permission_key FROM '+table('api_permissions')+' WHERE api_id IN (777,16402) ORDER BY id').fetchall()==grants,'Existing grants unchanged');db.commit()
 report['passed']=True
except Exception as error:
 report['errorType']=type(error).__name__
 if isinstance(error,AssertionError):report['failedCheck']=str(error)
 raise RuntimeError('Owned native production proof failed: '+type(error).__name__) from None
finally:
 fixture.unlink(missing_ok=True)
 if db:
  try:
   db.rollback()
   if created:
    with db.transaction():
     for name in ['account_preference_documents','account_preference_requests','account_preference_audit']:
      db.execute('DELETE FROM '+name+' WHERE user_id=ANY(%s) AND tenant_id=ANY(%s)',(users,tenants))
     db.execute('DELETE FROM tenant_dashboard_preferences WHERE user_id::text=ANY(%s::text[]) AND tenant_id::text=ANY(%s::text[])',(users,tenants))
     for uid in users:db.execute('DELETE FROM account_preference_rate WHERE key=%s',(hashlib.sha256(('preferences:account:'+uid).encode()).hexdigest(),))
     for name in ['auth_sessions','auth_password_resets','auth_password_audit']:db.execute('DELETE FROM '+name+' WHERE user_id::text=ANY(%s::text[])',(users,))
     for name in ['auth_account_audit','auth_management_audit']:db.execute('DELETE FROM '+name+' WHERE tenant_id::text=ANY(%s::text[])',(tenants,))
     for email in emails:db.execute('DELETE FROM auth_rate_limits WHERE subject_hash=%s',(hashlib.sha256(('login:'+email).encode()).hexdigest(),))
     db.execute('DELETE FROM users WHERE id::text=ANY(%s::text[]) AND tenant_id::text=ANY(%s::text[])',(users,tenants));db.execute('DELETE FROM tenants WHERE id::text=ANY(%s::text[])',(tenants,))
    must(db.execute('SELECT COUNT(*) FROM users WHERE id::text=ANY(%s::text[])',(users,)).fetchone()[0]==0 and db.execute('SELECT COUNT(*) FROM tenants WHERE id::text=ANY(%s::text[])',(tenants,)).fetchone()[0]==0,'Exact native fixture users and tenants removed');db.commit()
    report['cleanup']='Exact owned users/tenants/preferences/sessions/audits/account quotas removed; shared source counters preserved'
  except Exception as error:report['cleanupErrorType']=type(error).__name__
  finally:db.close()
 (out/'owned-native.json').write_text(json.dumps(report,indent=2));print('PC10_OWNED_NATIVE_PRODUCTION '+json.dumps(report))
 if report.get('cleanupErrorType'):raise RuntimeError('Native fixture cleanup failed; inspect exact fixture ownership')
