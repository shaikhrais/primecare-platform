"""Validate the shared account catalog against pinned production or an explicit isolated specification."""
import json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools/governance-production'))
from account_sessions_registration import definition,read_catalog
catalog=json.loads((ROOT/'packages/shared/src/account-sessions.json').read_text())
if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES')=='1':
    if os.environ.get('GOVERNANCE_DATABASE_URL') or os.environ.get('PRODUCTION_DATABASE_URL'):
        raise SystemExit('Production credentials forbidden in isolated account build')
    expected=definition()
    if {k:catalog[k] for k in expected}!=expected:
        raise SystemExit('Isolated account specification/catalog mismatch')
    print('Isolated account specification matches; this is not production parity evidence')
else:
    from production_reader import connect
    with connect() as db:
        if read_catalog(db,definition())!=catalog:
            raise SystemExit('Account session catalog differs from pinned production; regeneration required')
    print('Account session catalog matches pinned production; independent reviews remain pending')
