"""Read bounded workflow tracking metadata only; not acceptance or authorization."""
import json
import os
import re
from collections import Counter
from production_reader import GovernanceReadError, connect

ROLE = 'tenant_admin'
STATUSES = ('scoped_pass', 'stale')
REQUIRED = {
    'virtual_workflow_definitions': {
        'flow_id', 'flow_kind', 'actor_roles_json', 'definition_sha256',
        'definition_status', 'verification_status', 'test_status',
    },
    'virtual_workflow_attempts': {
        'attempt_id', 'flow_id', 'definition_sha256', 'requested_status', 'test_status',
        'scope', 'created_at', 'gate_result_json', 'result_json',
    },
    'virtual_workflow_evidence': {'attempt_id', 'path'},
}
DEFINITIONS = """
SELECT flow_id,actor_roles_json,definition_sha256,definition_status,verification_status,test_status
FROM virtual_workflow_definitions
WHERE flow_kind='business_process' AND definition_status='source_mapped'
AND verification_status='implemented-unverified' AND test_status IN ('scoped_pass','stale')
ORDER BY flow_id LIMIT 10001
"""
ATTEMPT = """
SELECT attempt_id,definition_sha256,requested_status,test_status,scope,created_at,
       CASE WHEN gate_result_json IS NULL THEN 0 ELSE 1 END,
       CASE WHEN LENGTH(result_json)<=262144 THEN result_json ELSE NULL END
FROM virtual_workflow_attempts WHERE flow_id=?
"""
LATEST = ' ORDER BY created_at DESC,attempt_id DESC LIMIT 1'
EVIDENCE = """
SELECT COUNT(*),SUM(CASE WHEN path=? THEN 1 ELSE 0 END)
FROM virtual_workflow_evidence WHERE attempt_id=?
"""
SHA = r'[0-9a-f]{64}'
FLOW_ID = r'[a-z][a-z0-9_.-]{0,199}'
STAMP = r'\d{4}-\d{2}-\d{2}[T ]\d{2}:\d{2}:\d{2}(?:\.\d{1,6})?(?:Z|[+-]\d{2}:\d{2})?'

def matches(pattern, value):
    return isinstance(value, str) and re.fullmatch(pattern, value) is not None

def attempt_metadata(db, row, definition_sha):
    if row is None:
        return None
    attempt_id, digest, status, test_status, scope, date, gate, result_raw = row
    if (type(attempt_id) is not int or attempt_id < 1 or not matches(SHA, digest)
            or status not in ('missing', 'implemented-unverified', 'verified', 'blocked')
            or test_status not in ('not_run', 'scoped_pass', 'passed', 'failed', 'blocked', 'stale')
            or scope not in ('scoped', 'workflow') or not matches(STAMP, date)
            or gate not in (0, 1)):
        raise GovernanceReadError('Unexpected workflow attempt metadata')
    # Free text, review paths and reviewer identity must never reach the artifact.
    declared_review = None
    if result_raw is not None:
        try:
            data = json.loads(result_raw)
        except (TypeError, ValueError):
            raise GovernanceReadError('Malformed workflow attempt metadata') from None
        if not isinstance(data, dict):
            raise GovernanceReadError('Malformed workflow attempt metadata')
        value = data.get('acceptance_review_path')
        if isinstance(value, str) and 0 < len(value) <= 1024:
            declared_review = value
    count, linked = db.execute(EVIDENCE, (declared_review or '', attempt_id)).fetchone()
    return {
        'attemptId': attempt_id, 'definitionMatches': digest == definition_sha,
        'requestedStatus': status, 'testStatus': test_status, 'scope': scope, 'recordedAt': date,
        'evidenceCount': int(count), 'gateEnvelopePresent': bool(gate),
        'reviewArtifactRecorded': None if result_raw is None else bool(declared_review and linked),
    }

def audit(db):
    for table, expected in REQUIRED.items():
        entry = db.tables.get(table)
        if entry is None or not expected <= {column['name'] for column in entry['columns']}:
            raise GovernanceReadError('Required workflow tracking schema mismatch')
    candidates = db.execute(DEFINITIONS).fetchall()
    if len(candidates) == 10001:
        raise GovernanceReadError('Global candidate bound exceeded')
    selected = []
    seen = set()
    for flow_id, raw_roles, digest, definition, status, test_status in candidates:
        try:
            roles = json.loads(raw_roles)
        except (TypeError, ValueError):
            raise GovernanceReadError('Malformed workflow actor metadata') from None
        if not isinstance(roles, list) or any(not isinstance(role, str) for role in roles):
            raise GovernanceReadError('Malformed workflow actor metadata')
        if ROLE not in roles:
            continue
        if (not matches(FLOW_ID, flow_id) or flow_id in seen or not matches(SHA, digest)
                or definition != 'source_mapped' or status != 'implemented-unverified'
                or test_status not in STATUSES):
            raise GovernanceReadError('Unexpected candidate metadata')
        seen.add(flow_id)
        selected.append((flow_id, digest, definition, status, test_status))
    if len(selected) > 32:
        raise GovernanceReadError('Tenant Admin evidence shortlist exceeds its 32-row bound')
    buckets = Counter(row[-1] for row in selected)
    workflows = []
    for flow_id, digest, definition, status, test_status in selected:
        latest = db.execute(ATTEMPT + LATEST, (flow_id,)).fetchone()
        eligible = db.execute(
            ATTEMPT + " AND definition_sha256=? AND test_status IN ('scoped_pass','passed')" + LATEST,
            (flow_id, digest),
        ).fetchone()
        current = attempt_metadata(db, latest, digest)
        passing = current if latest is not None and eligible is not None and eligible[0] == latest[0] else attempt_metadata(db, eligible, digest)
        workflows.append({
            'flowId': flow_id, 'definitionStatus': definition,
            'verificationStatus': status, 'testStatus': test_status,
            'latestAttempt': current, 'latestMatchingPassingAttempt': passing,
        })
    return {
        'commit': os.environ.get('GITHUB_SHA'), 'run': os.environ.get('GITHUB_RUN_ID'),
        'roleCode': ROLE, 'metadataOnly': True, 'writesAttempted': False,
        'expectedPriorCohort': {'scoped_pass': 7, 'stale': 9},
        'currentCohort': {status: buckets[status] for status in STATUSES},
        'workflows': workflows,
        'limits': 'Tracking metadata only. Digest match, pass, evidence or review presence do not prove current acceptance, approval or Tenant Admin coverage.',
    }

if __name__ == '__main__':
    with connect() as database:
        print(json.dumps(audit(database), indent=2, sort_keys=True))
