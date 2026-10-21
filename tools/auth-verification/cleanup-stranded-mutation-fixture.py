"""Recover only the exact synthetic dataset stranded during canceled job119295482070."""
import os,json,hashlib,sys,datetime
import psycopg
NONCE='439c778b507c416a9a2fecd0f88e10d6'
TENANT='4adb82b2-7ea0-4bcc-9c3e-7872aa984a6a'
EXPECTED={
 'e9bb40b9-d733-421d-8cf1-7895a1cdf939':('auth-test@15minutes-email.com','physio','active'),
 'b7d33ce4-fe9c-45ce-acc8-4a623561a937':('created-by-hr-'+NONCE+'@example.invalid','psw','active'),
 '5011f016-4a01-407d-bf9b-cc1de620937b':('mutation-'+NONCE+'-0@example.invalid','ceo','active'),
 '501cf888-dc81-470c-a23b-8cef42865436':('mutation-'+NONCE+'-1@example.invalid','hr_director','active')}
if len(sys.argv)!=2 or sys.argv[1] not in ['--dry-run','--apply']:raise SystemExit('Explicit mode required')
with psycopg.connect(os.environ['PRODUCTION_DATABASE_URL']) as db:
 with db.transaction():
  db.execute("SELECT pg_advisory_xact_lock(hashtext('recover-mutation-job119295482070'))")
  primary=db.execute('SELECT id::text,name,slug FROM tenants WHERE id::text=%s FOR UPDATE',(TENANT,)).fetchall()
  if not primary:
   if db.execute('SELECT COUNT(*) FROM users WHERE id::text=ANY(%s::text[])',(list(EXPECTED),)).fetchone()[0]:raise RuntimeError('Partial cleanup drift')
   print('STRANDED_MUTATION_RECOVERED '+json.dumps({'alreadyAbsent':True,'realAccountsTouched':False}));sys.exit(0)
  if primary!=[(TENANT,'Temporary account mutation QA','account-mutations-'+TENANT)]:raise RuntimeError('Tenant provenance mismatch')
  rows=db.execute('SELECT id::text,email,roles,status,updated_at FROM users WHERE tenant_id::text=%s FOR UPDATE',(TENANT,)).fetchall()
  if {r[0]:r[1:4] for r in rows}!=EXPECTED:raise RuntimeError('Exact synthetic identities changed; preserve')
  for r in rows:
   updated=r[4] if r[4].tzinfo else r[4].replace(tzinfo=datetime.timezone.utc)
   if not datetime.datetime(2026,10,21,14,50,tzinfo=datetime.timezone.utc)<=updated<datetime.datetime(2026,10,21,15,23,tzinfo=datetime.timezone.utc):raise RuntimeError('Fixture outside producer time window')
  foreign=db.execute('SELECT id::text,tenant_id::text,roles,status FROM users WHERE email=%s FOR UPDATE',('mutation-'+NONCE+'-2@example.invalid',)).fetchall()
  if len(foreign)!=1 or foreign[0][2:]!=('ceo','active') or foreign[0][1]==TENANT:raise RuntimeError('Paired synthetic actor changed')
  other=foreign[0][1]
  if db.execute('SELECT name,slug FROM tenants WHERE id::text=%s FOR UPDATE',(other,)).fetchall()!=[('Temporary account mutation QA','account-mutations-'+other)]:raise RuntimeError('Paired tenant provenance mismatch')
  if db.execute('SELECT COUNT(*) FROM users WHERE tenant_id::text=%s',(other,)).fetchone()[0]!=1:raise RuntimeError('Paired tenant population changed')
  ids=list(EXPECTED)+[foreign[0][0]];tids=[TENANT,other]
  if db.execute("SELECT COUNT(*) FROM auth_account_audit WHERE actor_user_id::text=%s AND target_user_id::text=%s AND tenant_id::text=%s AND action='account_created'",('5011f016-4a01-407d-bf9b-cc1de620937b','e9bb40b9-d733-421d-8cf1-7895a1cdf939',TENANT)).fetchone()[0]!=1:raise RuntimeError('Missing attributed synthetic creation audit')
  for table in ['auth_sessions','auth_password_resets','auth_password_audit']:db.execute('DELETE FROM '+table+' WHERE user_id::text=ANY(%s::text[])',(ids,))
  for table in ['auth_account_audit','auth_management_audit']:db.execute('DELETE FROM '+table+' WHERE tenant_id::text=ANY(%s::text[])',(tids,))
  for uid,email,*_ in rows+[(foreign[0][0],'mutation-'+NONCE+'-2@example.invalid')]:
   for operation,subject in [('login',email),('forgot',email),('reset',email),('createAccount',uid),('manageAccount',uid),('changePassword',uid)]:db.execute('DELETE FROM auth_rate_limits WHERE subject_hash=%s',(hashlib.sha256((operation+':'+subject).encode()).hexdigest(),))
  if db.execute('DELETE FROM users WHERE id::text=ANY(%s::text[]) AND tenant_id::text=ANY(%s::text[])',(ids,tids)).rowcount!=5:raise RuntimeError('Unexpected account cleanup count')
  if db.execute('DELETE FROM tenants WHERE id::text=ANY(%s::text[])',(tids,)).rowcount!=2:raise RuntimeError('Unexpected tenant cleanup count')
  print('STRANDED_MUTATION_RECOVERED '+json.dumps({'users':5,'tenants':2,'producerJob':119295482070,'realAccountsTouched':False,'dryRun':sys.argv[1]=='--dry-run'}))
  if sys.argv[1]=='--dry-run':raise psycopg.Rollback()
