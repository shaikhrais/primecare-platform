"""Candidate: bounded pinned metadata read; no assignments or business-row lookup.

Install under tools/governance-production only after review. Not locally executed.
Category names below are audit labels, never new governance status values.
"""
from collections import Counter
import json
import os
from pathlib import Path
import re

from production_reader import GovernanceReadError, connect

ROLE = 'tenant_admin'
EXPECTED = {'blocked': 2, 'missing': 1}
REQUIRED = {
    'virtual_workflow_definitions': {
        'flow_id', 'flow_kind', 'actor_roles_json', 'definition_status',
        'verification_status', 'blocker_json',
    },
    'virtual_workflow_source_links': {
        'flow_id', 'source_table', 'source_key', 'source_key_columns', 'reference_status',
    },
}
# Exact public strings reviewed at 09566e11088dc5ab4cb8e3e03138e397acd63fc3:
# docs/task-progress/workflow-execution-status.json. No fuzzy/prefix matching.
KNOWN_BLOCKERS = {
    'Approved multi-role assignments, tenant-bound switch/session semantics, allowed grants and audit acceptance are missing.': 'approved_role_switch_policy_missing',
    'Playwright executable absent; /tmp/chromium is a zero-byte file; browser installation returned invalid ZIP on every retry.': 'recorded_browser_environment_unavailable',
    'Failed governance registration: Canonical identity or owner authority changed: /v1/client/invoices/{invoiceId}. Partial generated changes reverted.': 'recorded_invoice_canonical_authority_conflict',
    'Required UI interaction is absent in current TypeScript/native presentation source.': 'recorded_required_ui_absent',
    'Draft auth-prefixed endpoint differs from canonical registered /v1/user/sessions or /v1/admin/users path; bind existing canonical contract.': 'recorded_canonical_auth_binding_mismatch',
    'General role-selection/account-provisioning UI is absent; maintenance-only form does not satisfy the defined multi-target creation flow.': 'recorded_account_provisioning_ui_absent',
}
QUERY = """
SELECT flow_id, actor_roles_json, definition_status, verification_status,
       CASE WHEN LENGTH(blocker_json)<=16384 THEN blocker_json ELSE NULL END
FROM virtual_workflow_definitions
WHERE flow_kind='business_process' AND verification_status IN ('blocked','missing')
ORDER BY flow_id LIMIT 1001
"""


def repository_catalog(root, commit):
    catalog = {}
    for name in ('care', 'enterprise'):
        path = 'tools/workflow-verification/virtual-processes/' + name + '.json'
        plans = json.loads((root / path).read_text())
        for plan in plans:
            if ROLE not in plan.get('actor_roles', []):
                continue
            flow = plan['id']
            if not re.fullmatch(r'[a-z0-9][a-z0-9_.-]{0,159}', flow) or flow in catalog:
                raise GovernanceReadError('Repository workflow identity mismatch')
            # Titles and paths come only from checked-out repository source, not DB.
            title = ' '.join(plan['title'].split())
            title = ''.join(c for c in title if 32 <= ord(c) < 127)[:120]
            paths = {path}
            for doc in plan.get('source_paths', []):
                if (isinstance(doc, str) and re.fullmatch(r'docs/[A-Za-z0-9_./-]+\.md', doc)
                        and '..' not in doc.split('/')
                        and (root / doc).resolve().is_relative_to(root.resolve())
                        and (root / doc).is_file()):
                    paths.add(doc)
            catalog[flow] = {'repositoryTitle': title, 'repositoryDocuments': [
                'https://github.com/shaikhrais/primecare-platform/blob/' + commit + '/' + p
                for p in sorted(paths)]}
    return catalog


def blocker_categories(raw):
    try:
        values = json.loads(raw) if raw is not None else None
    except (TypeError, ValueError):
        values = None
    if not isinstance(values, list) or any(not isinstance(x, str) for x in values):
        return {'state': 'malformed_or_oversized_redacted'}
    counts = Counter(KNOWN_BLOCKERS[x] for x in values if x in KNOWN_BLOCKERS)
    return {'state': 'empty_recorded_list' if not values else 'recorded_list',
            'exactMatchCategories': dict(sorted(counts.items())),
            'unclassifiedRedactedCount': sum(x not in KNOWN_BLOCKERS for x in values)}


def audit(db, root, commit):
    if not re.fullmatch(r'[0-9a-f]{40}', commit or ''):
        raise GovernanceReadError('An exact source commit is required')
    for table, columns in REQUIRED.items():
        entry = db.tables.get(table)
        if entry is None or not columns <= {c['name'] for c in entry['columns']}:
            raise GovernanceReadError('Required workflow metadata schema mismatch')
    catalog = repository_catalog(root, commit)
    rows = db.execute(QUERY).fetchall()
    if len(rows) > 1000:
        raise GovernanceReadError('Workflow metadata bound exceeded')
    selected = []
    for row in rows:
        try:
            actors = json.loads(row[1])
        except (TypeError, ValueError):
            raise GovernanceReadError('Malformed workflow actor metadata') from None
        if not isinstance(actors, list) or any(not isinstance(x, str) for x in actors):
            raise GovernanceReadError('Malformed workflow actor metadata')
        if ROLE in actors:
            selected.append(row)
    counts = dict(Counter(row[3] for row in selected))
    result = {'commit': commit, 'run': os.environ.get('GITHUB_RUN_ID'),
              'manifestSha256': db.pin['manifestSha256'], 'writesAttempted': False,
              'metadataOnly': True, 'roleCode': ROLE, 'cohort': counts,
              'matchesReviewedCohort': counts == EXPECTED, 'workflows': []}
    # Do not expand the reviewed three-workflow disclosure scope if production moved.
    if counts != EXPECTED:
        result['reason'] = 'cohort_changed_re_review_required'
        return result
    for flow, _actors, definition, status, raw in selected:
        if flow not in catalog:
            raise GovernanceReadError('Target workflow lacks reviewed repository crosswalk')
        if definition not in ('virtual_draft', 'source_mapped'):
            raise GovernanceReadError('Unexpected workflow definition status')
        links = db.execute(
            'SELECT COUNT(*), SUM(CASE WHEN reference_status=? THEN 1 ELSE 0 END), '
            'SUM(CASE WHEN reference_status=? THEN 1 ELSE 0 END), '
            'COUNT(DISTINCT source_table) FROM virtual_workflow_source_links WHERE flow_id=?',
            ('row', 'table_snapshot', flow),
        ).fetchone()
        total, row_links, snapshots, tables = (int(x or 0) for x in links)
        result['workflows'].append({
            'flowId': flow, **catalog[flow], 'definitionStatus': definition,
            'verificationStatus': status, 'recordedBlockers': blocker_categories(raw),
            'sourceLinks': {'total': total, 'rowReferences': row_links,
                            'tableSnapshots': snapshots, 'distinctSourceTables': tables,
                            'otherReferenceStatuses': total - row_links - snapshots},
        })
    result['limits'] = [
        'Category labels describe exact recorded text, not current reproduction.',
        'Empty blockers are not proof that a missing workflow has no issues.',
        'Unknown blocker text, source keys and operational records are never exported.',
        'Source links are counted only; no linked records are dereferenced.',
        'Repository documents are source-controlled crosswalks, not proof of live definition equality.',
        'No approval, grants, assignment, enrollment or full workflow acceptance inferred.',
    ]
    return result


if __name__ == '__main__':
    commit = os.environ.get('GITHUB_SHA')
    if not re.fullmatch(r'[0-9a-f]{40}', commit or ''):
        raise GovernanceReadError('An exact source commit is required')
    with connect() as database:
        print(json.dumps(audit(database, Path(__file__).resolve().parents[2],
                               commit), indent=2, sort_keys=True))
