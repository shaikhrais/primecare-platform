"""One bounded recovery of synthetic read fixtures from failed run39471170775.
Only paired 27+1 datasets with exact generated email/tenant invariants qualify.
"""
import os,re,json,hashlib
import psycopg
from collections import defaultdict
with psycopg.connect(os.environ['PRODUCTION_DATABASE_URL'],connect_timeout=15) as db:
 with db.transaction():
  db.execute("SELECT pg_advisory_xact_lock(hashtext('recover-account-read-fixtures-39471170775'))")
  tenants=db.execute("SELECT id::text,name,slug FROM tenants WHERE name='Temporary account read QA' AND slug LIKE 'account-reads-%' AND updated_at >= TIMESTAMPTZ '2026-10-20 18:05:00+00' AND updated_at < TIMESTAMPTZ '2026-10-20 18:15:00+00' FOR UPDATE").fetchall()
  groups=defaultdict(list)
  for tid,name,slug in tenants:
   if slug!='account-reads-'+tid:raise RuntimeError('Synthetic tenant slug drift; preserve')
   rows=db.execute('SELECT id::text,email,roles,status FROM users WHERE tenant_id::text=%s ORDER BY email FOR UPDATE',(tid,)).fetchall()
   if len(rows) not in [1,27]:raise RuntimeError('Unexpected fixture population; preserve')
   nonces=set()
   for uid,email,role,status in rows:
    m=re.fullmatch(r'(?:a-|b-|foreign-)([0-9a-f]{32})(?:-\d{2})?@example\.invalid',email)
    if not m or status!='active' or role not in ['ceo','rmt']:raise RuntimeError('Unrecognized fixture account; preserve')
    nonces.add(m.group(1))
   if len(nonces)!=1:raise RuntimeError('Mixed fixture nonce; preserve')
   nonce=next(iter(nonces))
   expected=sorted(['a-'+nonce+'@example.invalid']+['b-'+nonce+'-'+str(n).zfill(2)+'@example.invalid' for n in range(26)]) if len(rows)==27 else ['foreign-'+nonce+'@example.invalid']
   if [r[1] for r in rows]!=expected or sum(r[2]=='ceo' for r in rows)!=1:raise RuntimeError('Exact fixture shape mismatch; preserve')
   groups[nonce].append((tid,rows))
  recovered=0
  for nonce,items in groups.items():
   if sorted(len(r) for _,r in items)!=[1,27]:raise RuntimeError('Unpaired synthetic tenants; preserve')
   ids=[uid for _,rows in items for uid,*_ in rows];tids=[tid for tid,_ in items]
   for table in ['auth_sessions','auth_password_resets','auth_password_audit']:db.execute('DELETE FROM '+table+' WHERE user_id::text=ANY(%s::text[])',(ids,))
   for table in ['auth_account_audit','auth_management_audit']:db.execute('DELETE FROM '+table+' WHERE tenant_id::text=ANY(%s::text[])',(tids,))
   for _,rows in items:
    for _,email,*_ in rows:db.execute('DELETE FROM auth_rate_limits WHERE subject_hash=%s',(hashlib.sha256(('login:'+email).encode()).hexdigest(),))
   db.execute('DELETE FROM users WHERE id::text=ANY(%s::text[]) AND tenant_id::text=ANY(%s::text[])',(ids,tids));db.execute('DELETE FROM tenants WHERE id::text=ANY(%s::text[])',(tids,));recovered+=len(ids)
  print('STRANDED_ACCOUNT_READ_FIXTURE_CLEANUP '+json.dumps({'recoveredUsers':recovered,'pairedDatasets':len(groups),'realAccountsTouched':False,'run':39471170775}))
