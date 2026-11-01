"""Capture metadata for blocked theme grants; never infer or mutate authority."""
import argparse
import hashlib
import json
from datetime import datetime, timezone
from pathlib import Path

API_IDS = (710, 857, 777)


def capture(reader, *, scope_details=False):
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
    endpoints_by_id = {row['id']: row for row in endpoints}
    result['rowReconciliation'] = []
    for grant in grants:
        endpoint = endpoints_by_id.get(grant['api_id'])
        origins = [row for row in registry_matches if 'api_permission_' + str(row['endpoint_code']) == grant['permission_key']]
        blocked = []
        if endpoint is None:
            blocked.append('endpoint_missing')
        elif grant['permission_key'] != endpoint['permission_key']:
            blocked.append('permission_operation_authority_required')
        if grant['runtime_artifact_id'] is not None and grant['runtime_artifact_id'] not in artifact_ids:
            blocked.append('runtime_artifact_provenance_required')
        if grant['role_id'] not in role_ids:
            blocked.append('role_missing')
        result['rowReconciliation'].append({
            'rowId': grant['id'], 'before': grant, 'endpoint': endpoint,
            'labelOrigins': origins, 'blockedBy': blocked,
            'proposedChange': None, 'safeToApply': False,
        })
    if scope_details:
        result['roles'] = rows('SELECT id,role_code,active FROM roles ORDER BY id')
        result['linkedScreens'] = rows('SELECT id,screen_code,route_path,actual_file_path,active FROM screens WHERE id IN (SELECT screen_id FROM screen_api_links WHERE api_id IN (?,?,?)) ORDER BY id', API_IDS)
        result['screenPermissions'] = rows('SELECT role_id,screen_id,can_view FROM role_screen_permissions WHERE screen_id IN (SELECT screen_id FROM screen_api_links WHERE api_id IN (?,?,?)) ORDER BY screen_id,role_id', API_IDS)
        columns = rows('PRAGMA table_info(runtime_artifacts)')
        safe_columns = ['id', 'artifact_key', 'artifact_type', 'artifact_code', 'source_path', 'file_path', 'source_file', 'source_type', 'app_id', 'api_id', 'screen_id', 'status', 'implementation_status', 'version']
        selected = [name for name in safe_columns if name in {column['name'] for column in columns}]
        if 'id' not in selected:
            raise ValueError('Runtime artifact identity schema unavailable')
        result['runtimeArtifactColumns'] = [{'name': column['name'], 'type': column['type'], 'notnull': column['notnull']} for column in columns]
        candidates = rows('SELECT ' + ','.join(selected) + ' FROM runtime_artifacts ORDER BY id LIMIT 1001')
        result['runtimeArtifactCandidates'] = candidates[:1000]
        result['runtimeArtifactCandidatesTruncated'] = len(candidates) > 1000
        result['runtimeArtifactIdUpperBound'] = max(artifact_ids, default=0)
        result['referencedArtifactIdUpperBound'] = rows('SELECT max(runtime_artifact_id) AS upper_bound FROM api_permissions')[0]['upper_bound']
        result['grantIdUpperBound'] = rows('SELECT max(id) AS upper_bound FROM api_permissions')[0]['upper_bound']
        result['registrationIdAllocationAuthority'] = False
        result['artifactIdColumnShape'] = [{key: column.get(key) for key in ('name', 'type', 'notnull', 'pk', 'dflt_value')} for column in columns if column['name'] == 'id']
        grant_columns = rows('PRAGMA table_info(api_permissions)')
        result['grantIdColumnShape'] = [{key: column.get(key) for key in ('name', 'type', 'notnull', 'pk', 'dflt_value')} for column in grant_columns if column['name'] == 'id']
        result['roleAndScreenReadbackEstablishesNewGrants'] = False
    result['snapshotSha256'] = hashlib.sha256(json.dumps(result, sort_keys=True, separators=(',', ':')).encode()).hexdigest()
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--scope-details', action='store_true')
    args = parser.parse_args()
    from production_reader import connect
    with connect() as reader:
        result = capture(reader, scope_details=args.scope_details)
        result['manifestSha256'] = reader.pin['manifestSha256']
        result['capturedAt'] = datetime.now(timezone.utc).isoformat()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + '\n')
    print('THEME_RELEASE_IDENTITIES ' + json.dumps(result, sort_keys=True))


if __name__ == '__main__':
    main()
