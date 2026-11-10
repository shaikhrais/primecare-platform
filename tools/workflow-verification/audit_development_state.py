"""Read-only aggregate development audit; no account or permission rows exported."""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def audit(db, registry):
    def count(sql):
        return int(db.execute(sql).fetchone()[0])
    states = dict(db.execute("SELECT verification_status,COUNT(*) FROM virtual_workflow_definitions WHERE flow_kind='business_process' GROUP BY verification_status").fetchall())
    reports = []
    expected = {
        'organization_summary': {r[0] for r in db.execute('SELECT r.role_code FROM roles r JOIN runtime_catalog_permissions p ON p.role_id=r.id WHERE r.active=1 AND p.can_view_organization=1')},
        'page_readiness': {r[0] for r in db.execute('SELECT r.role_code FROM roles r WHERE r.active=1 AND EXISTS(SELECT 1 FROM role_screen_permissions p WHERE p.role_id=r.id AND p.can_view=1)')},
        # Mirrors the existing reconciler; this is a comparison, not a grant.
        'platform_administration': {'platform_admin'} | {r[0] for r in db.execute("SELECT r.role_code FROM roles r JOIN role_screen_permissions p ON p.role_id=r.id JOIN screens s ON s.id=p.screen_id WHERE r.role_code='code_admin' AND r.active=1 AND s.screen_code='PLATFORM_ADMINISTRATION' AND p.can_view=1")},
    }
    for definition in registry['definitions']:
        name = definition['report_id']
        if name not in expected:
            raise ValueError('Unknown report contract requires review')
        actual = [g['role'] for g in definition['grants']]
        roles = set(actual)
        reports.append({'reportId':name, 'sourceRoleCount':len(roles),
            'reconcilerExpectedRoleCount':len(expected[name]),
            'sourceOnlyRoleCount':len(roles-expected[name]),
            'expectedOnlyRoleCount':len(expected[name]-roles),
            'duplicateSourceRoles':len(actual)-len(roles),
            'matchesReconciler':roles == expected[name] and len(actual) == len(roles)})
    return {'writesAttempted':False,'aggregateOnly':True,
        'registeredScreens':count('SELECT COUNT(*) FROM screens'),
        'activeRegisteredScreens':count('SELECT COUNT(*) FROM screens WHERE active=1'),
        'distinctRegisteredRoutes':count("SELECT COUNT(DISTINCT route_path) FROM screens WHERE route_path IS NOT NULL AND route_path<>''"),
        'businessProcesses':sum(states.values()),'verificationStatuses':states,
        'businessProcessesWithoutSavedAttempt':count("SELECT COUNT(*) FROM virtual_workflow_definitions d WHERE flow_kind='business_process' AND NOT EXISTS(SELECT 1 FROM virtual_workflow_attempts a WHERE a.flow_id=d.flow_id)"),
        'savedBusinessProcessAttempts':count("SELECT COUNT(*) FROM virtual_workflow_attempts a JOIN virtual_workflow_definitions d ON d.flow_id=a.flow_id WHERE d.flow_kind='business_process'"),
        'savedBusinessProcessCheckpoints':count("SELECT COUNT(*) FROM virtual_workflow_checkpoints c JOIN virtual_workflow_definitions d ON d.flow_id=c.flow_id WHERE d.flow_kind='business_process'"),
        'reportAuthorityComparison':reports,
        'limitations':['Counts do not prove catalog completeness or end-to-end acceptance.',
            'Without a saved attempt does not mean never tested elsewhere.',
            'Report comparisons reproduce existing reconciler expectations; they do not authorize any role.']}


def main():
    sys.path.insert(0,str(ROOT/'tools/governance-production'))
    from production_reader import connect
    registry=json.loads((ROOT/'cloudflare/workers/src/report-registry.json').read_text())
    with connect() as db:
        result=audit(db,registry)
    print(json.dumps(result,sort_keys=True))


if __name__ == '__main__': main()
