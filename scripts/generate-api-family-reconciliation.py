"""Reproducible family planning; route triage never earns API completion credit."""
import hashlib
import json
import sqlite3
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def classify(operation, probe):
    if operation['method']=='POST' and operation['route'].endswith('/compliance/scan'):
        return 'compliance_scan_requires_workflow_contract'
    if operation['area'] == 'premium':
        return 'legacy_model_collection_requires_contract_review'
    if operation['area'] == 'auth':
        return 'legacy_auth_method_or_workflow_reconciliation'
    return {
        'gateway_route_not_found': 'gateway_unmapped_requires_workflow_review',
        'worker_route_not_found': 'forwarded_operation_requires_handler_review',
        'declared_method_rejected': 'method_or_dynamic_capture_requires_caller_review',
        'credential_or_authority_required': 'protected_route_requires_authenticated_workflow_review',
        'service_status_only': 'service_status_is_not_business_workflow',
    }.get(probe['classification'], 'requires_further_review')


def build(checklist, audit, package):
    operations = checklist['operations']
    lookup = {o['api']: o for o in operations}
    if len(lookup) != len(operations):
        raise ValueError('Duplicate exact method/path in finite checklist')
    pending = [o for o in operations if o['stage'] in ['needs_contract_and_verification','needs_reconciliation']]
    probes = {o['api']: o for o in audit['operations']}
    if len(probes) != len(audit['operations']) or set(probes) != {o['api'] for o in pending}:
        raise ValueError('Routing audit must cover exactly the current pending operations; refresh it first')
    retired = {}
    for p in [package, *package.get('additionalWorkPackages', [])]:
        for api, evidence in p.get('retirements', {}).items():
            if (api not in lookup or lookup[api]['stage']=='retired_with_evidence') and evidence.get('reason') and evidence.get('evidence'):
                retired[api] = evidence
    rows = []
    for o in pending:
        missing = o['missingContractFields']
        rows.append({
            'api': o['api'], 'method': o['method'], 'route': o['route'],
            'area': o['area'], 'declarationIds': o['declarationIds'],
            'familyClassification': classify(o, probes[o['api']]),
            'routingClassification': probes[o['api']]['classification'],
            'authorizationContractStatus': 'requires_business_authorization_contract' if 'permission' in missing else 'registered_permission_requires_behavior_verification',
            'missingContractFields': missing,
            'businessOperationVerified': False,
        })
    families = dict(sorted(Counter(o['familyClassification'] for o in rows).items()))
    assert sum(families.values()) == len(pending)
    states = dict(sorted(Counter(o['stage'] for o in operations).items()))
    assert sum(states.values()) == checklist['summary']['uniqueOperations']
    return {
        'countingRule': checklist['countingRule'],
        'summary': {
            'baselineUniqueOperations':len(operations),
            'activeUniqueOperations': sum(o['stage']!='retired_with_evidence' for o in operations),
            'baselineStages':states,'activeStages':{k:v for k,v in states.items() if k!='retired_with_evidence'},
            'pendingOperations': len(pending), 'documentedRetiredOperations': len(retired),
            'pendingFamilyCounts': families,
            'pendingRoutingCounts': dict(sorted(Counter(o['routingClassification'] for o in rows).items())),
            'pendingMissingContractCounts': dict(sorted(Counter(f for o in rows for f in o['missingContractFields']).items())),
        },
        'retiredOperations': [{'api': api, **evidence} for api, evidence in sorted(retired.items())],
        'operations': rows,
        'limitations': 'Missing declaration authority can be reconciled with a reviewed existing canonical handler. Route responses and full-path literal absence do not prove business implementation, absence, or obsolescence. Generic role grants are not workflow authority. No new resolved API credit is awarded by this report.',
    }


def main():
    paths = ['docs/api/api-delivery-checklist.json', 'docs/api/api-reachability-audit.json', 'docs/api/api-delivery-work-package.json']
    checklist, audit, package = [json.loads((ROOT / p).read_text()) for p in paths]
    report = build(checklist, audit, package)
    db_path = ROOT / '.agents/governance/governance.db'
    examples = []
    with sqlite3.connect(db_path.as_uri() + '?mode=ro', uri=True) as db:
        # Actual records are evidence only, never interpreted as authorization.
        for op in report['operations'][:4]:
            api_id = op['declarationIds'][0]
            grants = db.execute('SELECT permission_key, COUNT(*), SUM(can_access) FROM api_permissions WHERE api_id=? GROUP BY permission_key ORDER BY permission_key', (api_id,)).fetchall()
            examples.append({'api': op['api'], 'apiId': api_id, 'grantGroups': [{'permissionKey': key, 'roleRows': count, 'enabledRoleRows': enabled} for key, count, enabled in grants]})
    report['catalogGrantExamplesNotAuthorizationEvidence'] = examples
    report['sourceHashes'] = {p: hashlib.sha256((ROOT / p).read_bytes()).hexdigest() for p in [*paths, '.agents/governance/governance.db']}
    (ROOT / 'docs/api/api-family-reconciliation.json').write_text(json.dumps(report, indent=2) + '\n')
    s = report['summary']
    lines = ['# API family reconciliation', '', report['countingRule'], '',
             f"**{s['pendingOperations']} active pending operations classified exactly once.**", '',
             '| Baseline evidence stage | Unique operations |', '| --- | ---: |']
    lines += [f'| {name} | {count} |' for name, count in s['baselineStages'].items()]
    lines += ['', f"Documented retirements outside the active denominator: **{s['documentedRetiredOperations']}**. Retirements are not implemented APIs.", '', '| Pending family | Operations |', '| --- | ---: |']
    lines += [f'| {name} | {count} |' for name, count in s['pendingFamilyCounts'].items()]
    lines += ['', '| Missing pending contract field | Operations |', '| --- | ---: |']
    lines += [f'| {name} | {count} |' for name, count in s['pendingMissingContractCounts'].items()]
    lines += ['', report['limitations'], '', '## Parallel work boundaries', '',
              'Choose families with reviewed canonical authority first. Resolve exact callers, methods and ownership before adding adapters. Review unreferenced declarations for evidence-backed retirement; never infer retirement from a failed probe. Keep premium model collections behind explicit entity scope. Run shared routing contract tests plus operation-specific negative authorization and PostgreSQL tests before claiming implementation.', '',
              '## Catalog grant examples', '', 'These existing records demonstrate why generic role-grant rows require scrutiny; their presence does not establish permission for the advertised operation.', '']
    for example in examples:
        for grant in example['grantGroups']:
            lines.append(f"- `{example['api']}` (ID {example['apiId']}): `{grant['permissionKey']}` across {grant['roleRows']} role rows ({grant['enabledRoleRows']} enabled).")
    (ROOT / 'docs/api/API_FAMILY_RECONCILIATION.md').write_text('\n'.join(lines) + '\n')
    print(json.dumps(s, sort_keys=True))


if __name__ == '__main__':
    main()
