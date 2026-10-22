"""Deployed API → native PostgreSQL → owned inbox; no browser/device credit."""
import hashlib
import json
import os
from pathlib import Path
import secrets
import time
import urllib.error
import urllib.request
import uuid
import bcrypt
import psycopg
from test_live_security_totp import totp
from owned_inbox import RECIPIENT
from security_notice_inbox import SecurityNoticeInbox

GATEWAY='https://primecare-api-gateway.itpro-mohammed.workers.dev'
OUT=Path('test-results/security-notice-inbox')

def main():
    OUT.mkdir(parents=True,exist_ok=True)
    report={'source':os.environ['GITHUB_SHA'],'scope':'deployed-api-database-owned-inbox',
            'browserVerified':False,'physicalDevicesVerified':False,'independentApprovals':False,'results':[]}
    db=psycopg.connect(os.environ['PRODUCTION_DATABASE_URL'],autocommit=True,connect_timeout=15)
    try:
        for locale in ['en','fr','es']:
            user,tenant=str(uuid.uuid4()),str(uuid.uuid4())
            slug='notice-qa-'+tenant;password=secrets.token_urlsafe(30)
            result={'locale':locale,'cleanup':False,'passed':False};report['results'].append(result)
            inbox=SecurityNoticeInbox(locale);created=False
            def call(path,body,token=None):
                result['stage']=path
                headers={'Content-Type':'application/json','Accept-Language':locale,'Origin':'https://primecare-clinic.pages.dev','User-Agent':'PrimeCareDeploymentVerifier/1.0 (+https://github.com/shaikhrais/primecare-platform)'}
                if token:headers['Authorization']='Bearer '+token
                req=urllib.request.Request(GATEWAY+'/v1/auth/'+path,headers=headers,data=json.dumps(body).encode(),method='POST')
                try:
                    with urllib.request.urlopen(req,timeout=30) as response:status,data=response.status,json.loads(response.read())
                except urllib.error.HTTPError as error:
                    status=error.code;result['httpStatus']=status;error.close();raise RuntimeError('Notice journey HTTP failure: '+str(status)) from None
                if status!=200 or not isinstance(data,dict):raise RuntimeError('Unexpected notice journey response')
                return data
            def fresh(seed):
                accepted=int(db.execute('SELECT last_counter FROM auth_mfa_credentials WHERE user_id=%s',(user,)).fetchone()[0])
                deadline=time.monotonic()+40
                while int(time.time())//30<=accepted:
                    if time.monotonic()>deadline:raise RuntimeError('Fresh factor deadline exceeded')
                    time.sleep(.5)
                return totp(seed,int(time.time())//30)
            def login():
                d=call('login',{'email':RECIPIENT,'password':password})
                if d.get('status')!='mfa_required' or 'token' in d:raise RuntimeError('Password exchange must remain limited')
                return d
            def confirm(challenge,seed):
                d=call('mfa/replacement/confirm',{'challenge':challenge,'code':totp(seed,int(time.time())//30)})
                if d.get('status')!='authenticated' or d.get('userId')!=user:raise RuntimeError('Replacement identity mismatch')
                return d['token']
            try:
                with db.transaction():
                    if db.execute('SELECT COUNT(*) FROM users WHERE LOWER(email)=%s',(RECIPIENT,)).fetchone()[0]!=0:raise RuntimeError('QA inbox belongs to an existing account; preserve it')
                    db.execute("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES(%s,'Temporary notice QA',%s,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)",(tenant,slug))
                    db.execute("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES(%s,%s,%s,'code_admin',%s,'mfa_pending',NOW())",(user,RECIPIENT,tenant,bcrypt.hashpw(password.encode(),bcrypt.gensalt(12)).decode()))
                created=True
                d=login();seed=d['setupKey'];d=call('mfa',{'challenge':d['challenge'],'code':totp(seed,int(time.time())//30)})
                if d.get('status')!='authenticated' or d.get('userId')!=user:raise RuntimeError('Enrollment identity mismatch')
                token=d['token']
                codes=call('mfa/recovery-codes',{'password':password,'code':fresh(seed)},token)
                if codes.get('status')!='recovery_codes_issued' or len(codes.get('recoveryCodes',[]))!=10:raise RuntimeError('Saved-code issue failed')
                d=call('mfa/replacement',{'password':password,'code':fresh(seed)},token)
                if d.get('status')!='mfa_replacement_required' or 'token' in d:raise RuntimeError('Replacement must remain limited')
                seed=d['setupKey'];token=confirm(d['challenge'],seed)
                codes=call('mfa/recovery-codes',{'password':password,'code':fresh(seed)},token)['recoveryCodes']
                call('logout',{},token);d=login()
                d=call('mfa/recovery',{'challenge':d['challenge'],'recoveryCode':codes[0]})
                if d.get('status')!='mfa_replacement_required' or 'token' in d:raise RuntimeError('Recovery must remain limited')
                token=confirm(d['challenge'],d['setupKey'])
                result['stage']='receiving-inbox'
                result['inbox']=inbox.verify(db,user,lambda ms:time.sleep(ms/1000))
                call('logout',{},token);result['passed']=True
            except Exception:
                result['failure']='Synthetic API/notice verification failed; no raw credentials or mail emitted'
                raise RuntimeError('Security notice acceptance failed for '+locale) from None
            finally:
                if created:
                    with db.transaction():
                        if db.execute('SELECT email,tenant_id::text FROM users WHERE id::text=%s',(user,)).fetchall()!=[(RECIPIENT,tenant)]:raise RuntimeError('QA identity cleanup guard failed')
                        if db.execute('SELECT slug FROM tenants WHERE id::text=%s',(tenant,)).fetchall()!=[(slug,)]:raise RuntimeError('QA tenant cleanup guard failed')
                        for table in ['auth_mfa_notification_outbox','auth_mfa_lifecycle_audit','auth_mfa_recovery_codes','auth_mfa_replacement_challenges','auth_sessions','auth_mfa_challenges','auth_mfa_credentials','auth_mfa_audit']:
                            db.execute('DELETE FROM '+table+' WHERE user_id::text=%s',(user,))
                        db.execute('DELETE FROM auth_rate_limits WHERE subject_hash IN (%s,%s)',(hashlib.sha256(('login:'+RECIPIENT).encode()).hexdigest(),hashlib.sha256(('mfa-lifecycle:'+user).encode()).hexdigest()))
                        db.execute('DELETE FROM users WHERE id::text=%s AND email=%s AND tenant_id::text=%s',(user,RECIPIENT,tenant))
                        db.execute('DELETE FROM tenants WHERE id::text=%s AND slug=%s',(tenant,slug))
                    result['cleanup']=True
                result['inboxCleanup']=inbox.cleanup()
                (OUT/'receipt.json').write_text(json.dumps(report,indent=2))
        report['passed']=len(report['results'])==3 and all(r['passed'] and r['cleanup'] for r in report['results'])
        print('SECURITY_NOTICE_INBOX '+json.dumps(report))
    finally:
        db.close();(OUT/'receipt.json').write_text(json.dumps(report,indent=2))

if __name__=='__main__':main()
