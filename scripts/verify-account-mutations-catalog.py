import json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'tools/governance-production'))
from account_mutations_registration import definition,read_catalog
current=json.loads((ROOT/'packages/shared/src/account-mutations.json').read_text())
if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES')=='1':
 if os.environ.get('GOVERNANCE_DATABASE_URL') or os.environ.get('PRODUCTION_DATABASE_URL'):raise SystemExit('Conflicting fixture mode')
 if {k:current[k] for k in definition()}!=definition():raise SystemExit('Mutation specification/catalog mismatch')
else:
 from production_reader import connect
 with connect() as db:
  if read_catalog(db,definition())!=current:raise SystemExit('Mutation catalog differs from pinned production')
print('Mutation catalog matched; independent review approval not inferred')
