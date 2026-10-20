import json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools/governance-production'))
from tenant_accounts_registration import definition,catalog
current=json.loads((ROOT/'packages/shared/src/tenant-account-reads.json').read_text())
if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES')=='1':
 if os.environ.get('GOVERNANCE_DATABASE_URL') or os.environ.get('PRODUCTION_DATABASE_URL'):raise SystemExit('Conflicting fixture mode')
 if {k:current[k] for k in definition()}!=definition():raise SystemExit('Account read specification mismatch')
else:
 from production_reader import connect
 with connect() as db:
  if catalog(db,definition())!=current:raise SystemExit('Account read catalog differs from pinned production')
print('Account read catalog matched; review approval not inferred')
