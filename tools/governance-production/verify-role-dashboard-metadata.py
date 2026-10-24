"""Read back dashboard identities only; never creates screens, grants or records."""
import json
import runpy
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def verify_identities(expected, rows):
    actual = {}
    for identity, code, route in rows:
        if code in actual:
            raise ValueError('Duplicate active screen code')
        actual[code] = (identity, route)
    for screen in expected:
        if actual.get(screen['code']) != (screen['id'], screen['route']):
            raise ValueError('Registered dashboard identity drift: ' + screen['code'])
    return {'registeredIdentitiesVerified': len(expected), 'writesAttempted': False,
            'grantsChanged': False, 'businessRecordsRead': False,
            'domainWorkflowsVerified': False}


if __name__ == '__main__':
    from production_reader import connect
    generator = runpy.run_path(str(ROOT / 'tools/integrate-role-dashboards.py'))
    registry = json.loads((ROOT / 'cloudflare/workers/src/workspace-registry.json').read_text())
    sources = {screen['code']: path.read_text() if path.is_file() else None
               for screen in registry['screens'] if screen['renderer'] == 'dashboard'
               for path in [ROOT / generator['DIRECTORY'] / (screen['code'] + '.dart')]}
    plan = generator['make_plan'](registry, sources)
    expected = [screen for screen in plan if screen['status'] == 'shared']
    if not expected:
        raise ValueError('No integrated dashboard identities')
    with connect() as db:
        report = verify_identities(expected, db.execute(
            'SELECT id,screen_code,route_path FROM screens WHERE active=1 ORDER BY id').fetchall())
    target = ROOT / 'test-results/role-dashboard-registry'
    target.mkdir(parents=True, exist_ok=True)
    (target / 'identities.json').write_text(json.dumps(report, indent=2) + '\n')
    print('ROLE_DASHBOARD_IDENTITIES ' + json.dumps(report))
