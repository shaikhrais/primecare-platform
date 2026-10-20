"""Verify recovery presentation against its live production metadata, or an explicit isolated fixture."""
import json,os,sys,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
catalog=json.loads((ROOT/'packages/shared/src/auth-recovery.json').read_text())
if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES')=='1':
    if os.environ.get('GOVERNANCE_DATABASE_URL') or os.environ.get('PRODUCTION_DATABASE_URL'):
        raise SystemExit('Production credentials forbidden in recovery fixtures')
    fixture=ROOT/'.agents/governance/governance.db'
    if not fixture.is_file():raise SystemExit('Explicit isolated recovery fixture missing')
    with sqlite3.connect('file:'+str(fixture)+'?mode=ro',uri=True) as db:
        rows=db.execute("SELECT definition FROM auth_recovery_web_policy WHERE id='recovery-web-v1'").fetchall()
        if len(rows)!=1 or json.loads(rows[0][0])!=catalog:raise SystemExit('Isolated recovery fixture/catalog mismatch')
else:
    sys.path.insert(0,str(ROOT/'tools/governance-production'))
    from production_reader import connect
    from recovery_registration import load_definition,read_catalog
    with connect() as db:
        if read_catalog(db,load_definition())!=catalog:
            raise SystemExit('Recovery catalog differs from pinned production; regeneration required')
print('Recovery catalog matches its explicit authority; independent reviews remain separate')
