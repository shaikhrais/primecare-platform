"""Capture metadata for blocked theme grants; never infer or mutate authority."""
import argparse
import hashlib
import json
from pathlib import Path

API_IDS = (710, 857, 777)


def capture(reader):
    def rows(query, parameters=()):
        cursor = reader.execute(query, parameters)
        names = [column[0] for column in cursor.description]
        return [dict(zip(names, row)) for row in cursor.fetchall()]

    endpoints = rows('SELECT id,http_method,route_path,permission_key FROM api_endpoints ORDER BY id')
    registries = rows('SELECT id,api_id,endpoint_code,method,endpoint_path FROM api_endpoint_registry ORDER BY id')
    grants = rows('SELECT id,api_id,role_id,runtime_artifact_id,permission_key,can_access FROM api_permissions WHERE api_id IN (?,?,?) ORDER BY id', API_IDS)
    keys = {grant['permission_key'] for grant in grants}
    registry_matches = [row for row in registries if row['api_id'] in API_IDS or 'api_permission_' + str(row['endpoint_code']) in keys]
    endpoint_ids = set(API_IDS) | {row['api_id'] for row in registry_matches}
    role_ids = {row['id'] for row in rows('SELECT id FROM roles ORDER BY id')}
    artifact_ids = {row['id'] for row in rows('SELECT id FROM runtime_artifacts ORDER BY id')}
    result = {
        'format': 1, 'readOnly': True, 'businessDataRead': False, 'writes': 0,
        'authorityEstablished': False, 'apiIds': list(API_IDS),
        'endpoints': [row for row in endpoints if row['id'] in endpoint_ids],
        'registries': registry_matches, 'grants': grants,
        'missingRoleIds': sorted({row['role_id'] for row in grants if row['role_id'] not in role_ids}),
        'missingRuntimeArtifactIds': sorted({row['runtime_artifact_id'] for row in grants if row['runtime_artifact_id'] is not None and row['runtime_artifact_id'] not in artifact_ids}),
        'limits': ['Metadata identity is not business authority', 'No repair target or grant change is inferred', 'Independent authority reconciliation and readback are still required'],
    }
    result['snapshotSha256'] = hashlib.sha256(json.dumps(result, sort_keys=True, separators=(',', ':')).encode()).hexdigest()
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    from production_reader import connect
    with connect() as reader:
        result = capture(reader)
        result['manifestSha256'] = reader.pin['manifestSha256']
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + '\n')
    print('THEME_RELEASE_IDENTITIES ' + json.dumps(result, sort_keys=True))


if __name__ == '__main__':
    main()
