"""Read-only parity gate for the committed production-generated maintenance data."""
import json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools/governance-production'))
from production_reader import connect

from maintenance_catalog import verify

if __name__=='__main__':
    if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES')=='1':
        if os.environ.get('PRODUCTION_DATABASE_URL') or os.environ.get('GOVERNANCE_DATABASE_URL'):raise RuntimeError('Fixture mode forbidden with production credentials')
        print('Isolated historical build: no live maintenance parity claim')
    else:
        with connect() as db:result=verify(db,json.loads((ROOT/'packages/shared/src/maintenance.json').read_text()))
        print('MAINTENANCE_CATALOG_PARITY '+json.dumps(result))
