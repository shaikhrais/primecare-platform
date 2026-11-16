"""Count registered Tenant Admin workflow metadata only. Never read assignment data."""
from collections import Counter
import json
import os
from production_reader import GovernanceReadError, connect

REQUIRED = {
    'virtual_workflow_definitions': {'flow_id', 'actor_roles_json', 'flow_kind', 'definition_status', 'verification_status', 'test_status'},
    'virtual_workflow_steps': {'flow_id', 'step_order'},
    'virtual_workflow_source_links': {'flow_id'},
}
QUERY = """
SELECT d.actor_roles_json,d.flow_kind,d.definition_status,d.verification_status,d.test_status,
       COUNT(*) AS registrations,
       SUM(CASE WHEN NOT EXISTS (SELECT 1 FROM virtual_workflow_steps s
         WHERE s.flow_id=d.flow_id AND s.step_order>=1) THEN 1 ELSE 0 END) AS without_steps,
       SUM(CASE WHEN NOT EXISTS (SELECT 1 FROM virtual_workflow_source_links l
         WHERE l.flow_id=d.flow_id) THEN 1 ELSE 0 END) AS without_sources
FROM virtual_workflow_definitions d
GROUP BY d.actor_roles_json,d.flow_kind,d.definition_status,d.verification_status,d.test_status
LIMIT 10001
"""

def audit(db):
    for table, columns in REQUIRED.items():
        entry = db.tables.get(table)
        if entry is None or not columns <= {c['name'] for c in entry['columns']}:
            raise GovernanceReadError('Required workflow metadata schema mismatch')
    rows = db.execute(QUERY).fetchall()
    if len(rows) > 10000:
        raise GovernanceReadError('Workflow metadata group bound exceeded')
    scope = ('business_process', 'supporting_registration')
    totals = {kind: Counter() for kind in scope}
    malformed = 0
    counts = Counter()
    for raw, kind, definition, status, test, count, no_steps, no_sources in rows:
        try:
            actors = json.loads(raw) if raw is not None else []
        except (TypeError, ValueError):
            actors = None
        if not isinstance(actors, list) or any(not isinstance(x, str) for x in actors):
            malformed += int(count)
            continue
        if 'tenant_admin' not in actors:
            continue
        category = 'business_process' if kind == 'business_process' else 'supporting_registration'
        totals[category].update(registrations=int(count), missingNumberedSteps=int(no_steps),
                                missingSourceLinks=int(no_sources))
        counts[(category, kind, definition, status, test)] += int(count)
    return {
        'commit': os.environ.get('GITHUB_SHA'), 'run': os.environ.get('GITHUB_RUN_ID'),
        'writesAttempted': False, 'roleCode': 'tenant_admin', 'aggregateOnly': True,
        'malformedActorsGlobal': malformed,
        'totals': {k: {v: totals[k][v] for v in ('registrations','missingNumberedSteps','missingSourceLinks')} for k in scope},
        'statusBreakdown': [
            {'category': k[0], 'kind': k[1], 'definitionStatus': k[2],
             'verificationStatus': k[3], 'testStatus': k[4], 'registrations': n}
            for k, n in sorted(counts.items(), key=lambda item: tuple(str(x) for x in item[0]))
        ],
        'limits': 'Actor linkage and row-presence checks only; no business records, operational assignments, approval, or acceptance examined.',
    }

if __name__ == '__main__':
    with connect() as db:
        print(json.dumps(audit(db), indent=2, sort_keys=True))
