"""Fail closed on production workspace text drift; isolated fixtures are explicit."""
import json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES')=='1':
    if os.environ.get('GOVERNANCE_DATABASE_URL') or os.environ.get('PRODUCTION_DATABASE_URL'):
        raise SystemExit('Fixture metadata cannot be used with production credentials')
    print(json.dumps({'authority':'explicit-isolated-fixture','live_verified':False}))
    raise SystemExit(0)
sys.path.insert(0,str(ROOT/'tools/governance-production'))
from production_reader import Connection
from workspace_resource_catalog import verify
with Connection() as db:result=verify(db)
print(json.dumps(result))
