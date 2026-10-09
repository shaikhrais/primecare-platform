"""Reject new catalog identity violations; quarantine is not business authority."""
import argparse
import hashlib
import json
import sqlite3
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BASELINE = ROOT / 'docs/api/api-catalog-identity-quarantine.json'


def digest(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def violations(db):
    db.row_factory = sqlite3.Row
    endpoints = {r['id']: dict(r) for r in db.execute('SELECT id,http_method,route_path,permission_key FROM api_endpoints')}
    registries = [dict(r) for r in db.execute('SELECT id,api_id,endpoint_code,method,endpoint_path FROM api_endpoint_registry')]
    origins = defaultdict(list)
    for registry in registries:
        origins['api_permission_' + str(registry['endpoint_code'])].append(registry)
    role_ids = {r[0] for r in db.execute('SELECT id FROM roles')}
    artifact_ids = {r[0] for r in db.execute('SELECT id FROM runtime_artifacts')}
    groups = defaultdict(list)
    for row in db.execute('SELECT id,api_id,role_id,runtime_artifact_id,permission_key,can_access FROM api_permissions ORDER BY id'):
        groups[(row['api_id'], row['permission_key'])].append(dict(row))
    result = {}
    for (api_id, key), members in sorted(groups.items(), key=lambda x: (str(x[0][0]), str(x[0][1]))):
        endpoint = endpoints.get(api_id)
        sources = origins.get(key, [])
        reasons = []
        if endpoint is None:
            reasons.append('missing_endpoint_foreign_key')
        elif not key or key != endpoint['permission_key']:
            identities = {(r['method'], r['endpoint_path']) for r in sources}
            if not sources:
                reasons.append('unknown_permission_identity')
            elif identities != {(endpoint['http_method'], endpoint['route_path'])}:
                reasons.append('permission_key_targets_different_operation')
        if any(m['role_id'] not in role_ids for m in members):
            reasons.append('missing_role_foreign_key')
        if any(m['runtime_artifact_id'] is not None and m['runtime_artifact_id'] not in artifact_ids for m in members):
            reasons.append('missing_runtime_artifact_foreign_key')
        if reasons:
            identity = 'grant:' + json.dumps([api_id, key], separators=(',', ':'))
            result[identity] = {'reasons': reasons, 'rowCount': len(members), 'fingerprint': digest({'members': members, 'endpoint': endpoint, 'origins': sources})}
    for registry in registries:
        endpoint = endpoints.get(registry['api_id'])
        if endpoint is None or (registry['method'], registry['endpoint_path']) != (endpoint['http_method'], endpoint['route_path']):
            result['registry:' + str(registry['id'])] = {'reasons': ['missing_or_mismatched_endpoint_mapping'], 'rowCount': 1, 'fingerprint': digest({'registry': registry, 'endpoint': endpoint})}
    return dict(sorted(result.items()))


def unexpected(current, baseline):
    # Removed/repaired whole violations are allowed. Changing a still-invalid
    # group (including its role membership) requires explicit quarantine review.
    return {key: value for key, value in current.items() if baseline.get(key) != value}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--database', type=Path, default=ROOT / '.agents/governance/governance.db')
    parser.add_argument('--baseline', type=Path, default=BASELINE)
    parser.add_argument('--record-quarantine', action='store_true', help='Review-only baseline creation; never run in CI')
    args = parser.parse_args()
    with sqlite3.connect(args.database.resolve().as_uri() + '?mode=ro', uri=True) as db:
        current = violations(db)
    if args.record_quarantine:
        args.baseline.write_text(json.dumps({'policy': 'Legacy identity violations only. No grants accepted, reassigned, enabled or repaired by this baseline. New or changed violations fail CI. Remediation must validate business authority separately.', 'violations': current}, indent=2) + '\n')
        print(f'Recorded {len(current)} legacy violation groups for review; no database mutation')
        return
    baseline = json.loads(args.baseline.read_text())['violations']
    introduced = unexpected(current, baseline)
    if introduced:
        print(json.dumps({'newOrChangedIdentityViolations': introduced}, indent=2))
        raise SystemExit('API catalog identity guard rejected new or changed legacy violations')
    print(json.dumps({'currentQuarantinedGroups': len(current), 'removedOrRepairedGroups': len(set(baseline)-set(current)), 'newViolations': 0, 'authorityEstablished': False}))


if __name__ == '__main__':
    main()
