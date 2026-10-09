#!/usr/bin/env python3
"""Read-only provider family triage; never changes operation delivery evidence."""
import argparse
import collections
import json
import re
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
AREAS = {'provider', 'providers', 'psw', 'rn', 'staff', 'caregiver'}


def audit(root=ROOT):
    checklist = json.loads((root / 'docs/api/api-delivery-checklist.json').read_text())
    types = (root / 'packages/domain/src/openapi_types.d.ts').read_text()
    audit_rows = {o['api']: o for o in json.loads((root / 'docs/api/api-reachability-audit.json').read_text())['operations']}
    db = sqlite3.connect(f"file:{root / '.agents/governance/governance.db'}?mode=ro", uri=True)
    db.row_factory = sqlite3.Row
    operations = []
    for operation in checklist['operations']:
        if operation['area'] not in AREAS or operation['stage'] != 'needs_contract_and_verification':
            continue
        match = re.search(r'^    "' + re.escape(operation['route']) + r'": \{(.*?)(?=^    "|^\})', types, re.M | re.S)
        historical_methods = re.findall(r'^        (get|post|put|patch|delete|head|options):', match[1], re.M) if match else []
        rows = [dict(r) for r in db.execute('SELECT id,http_method,permission_key,request_schema,response_schema,rate_limit_key FROM api_endpoints WHERE route_path=?', (operation['route'],))]
        blockers = ['no_verified_runtime_handler_for_declared_workflow']
        if historical_methods and operation['method'].lower() not in historical_methods:
            blockers.append('declared_method_conflicts_with_historical_contract')
        if not rows or any(not row['permission_key'] for row in rows):
            blockers.append('missing_endpoint_specific_authorization')
        if not rows or any(not row['request_schema'] or not row['response_schema'] for row in rows):
            blockers.append('missing_governance_request_or_response_schema')
        operations.append({'api': operation['api'], 'declarationIds': operation['declarationIds'],
                           'historicalMethods': [m.upper() for m in historical_methods],
                           'governance': rows, 'blockers': blockers,
                           'reachability': audit_rows.get(operation['api']),
                           'disposition': 'review_required_no_delivery_credit'})
    db.close()
    return {'scope': 'provider_psw_rn_staff_caregiver_pending_operations',
            'countingRule': 'No operation is resolved by this audit. Historical type declarations are method evidence, not runtime or authorization evidence.',
            'summary': {'reviewedUniqueOperations': len(operations), 'resolved': 0,
                        'methodConflicts': sum('declared_method_conflicts_with_historical_contract' in o['blockers'] for o in operations),
                        'missingEndpointAuthorization': sum('missing_endpoint_specific_authorization' in o['blockers'] for o in operations),
                        'pendingByFamily': dict(collections.Counter(o['api'].split('/')[2] for o in operations))},
            'operations': operations}


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    output = json.dumps(audit(), indent=2) + '\n'
    if args.output:
        args.output.write_text(output)
    else:
        print(output, end='')
