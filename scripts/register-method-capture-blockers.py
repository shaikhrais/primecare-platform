"""Register four exact unsupported method-capture workflows as blocked.

Only implementation_status and health_status change. No methods, permissions,
contracts, callers, findings, handlers or replacement workflows are invented.
"""
import argparse,hashlib,json,re,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
EXPECTED = {12: {'id': 12,
      'app_id': 1,
      'runtime_artifact_id': None,
      'controller_id': None,
      'service_id': None,
      'request_schema_id': None,
      'response_schema_id': None,
      'endpoint_code': 'API__V1_ADMIN_USERS_CHURN-HEATMAP',
      'route_path': '/v1/admin/users/churn-heatmap',
      'http_method': 'POST',
      'controller_name': '',
      'service_name': 'PRISMA',
      'auth_required': 1,
      'implementation_status': 'active',
      'gateway_url': 'https://api.primecare.io/v1/admin/users/churn-heatmap',
      'icon_key': 'post',
      'request_schema': None,
      'response_schema': None,
      'permission_key': None,
      'rate_limit_key': None,
      'api_version': 'v1',
      'deprecated_at': None,
      'is_backend_only': 0,
      'last_tested_at': None,
      'health_status': 'healthy',
      'created_at': '2026-06-19 00:15:57',
      'avg_latency_ms': None,
      'prisma_model_names': None,
      'query_pattern': None,
      'uses_pagination': 0,
      'uses_select': 0,
      'uses_include': 0,
      'possible_n_plus_one': 0,
      'recommended_indexes_json': None,
      'db_query_time_ms': 0,
      'optimization_status': 'pending'},
 251: {'id': 251,
       'app_id': 1,
       'runtime_artifact_id': None,
       'controller_id': None,
       'service_id': None,
       'request_schema_id': None,
       'response_schema_id': None,
       'endpoint_code': 'API__V1_CLIENT_FEEDBACK',
       'route_path': '/v1/client/feedback',
       'http_method': 'POST',
       'controller_name': '',
       'service_name': 'PRISMA',
       'auth_required': 1,
       'implementation_status': 'active',
       'gateway_url': 'https://api.primecare.io/v1/client/feedback',
       'icon_key': 'post',
       'request_schema': None,
       'response_schema': None,
       'permission_key': None,
       'rate_limit_key': None,
       'api_version': 'v1',
       'deprecated_at': None,
       'is_backend_only': 0,
       'last_tested_at': None,
       'health_status': 'healthy',
       'created_at': '2026-06-19 00:15:58',
       'avg_latency_ms': None,
       'prisma_model_names': None,
       'query_pattern': None,
       'uses_pagination': 0,
       'uses_select': 0,
       'uses_include': 0,
       'possible_n_plus_one': 0,
       'recommended_indexes_json': None,
       'db_query_time_ms': 0,
       'optimization_status': 'pending'},
 252: {'id': 252,
       'app_id': 1,
       'runtime_artifact_id': None,
       'controller_id': None,
       'service_id': None,
       'request_schema_id': None,
       'response_schema_id': None,
       'endpoint_code': 'API__V1_CLIENT_FEEDBACK_SURVEYS',
       'route_path': '/v1/client/feedback/surveys',
       'http_method': 'POST',
       'controller_name': '',
       'service_name': 'PRISMA',
       'auth_required': 1,
       'implementation_status': 'active',
       'gateway_url': 'https://api.primecare.io/v1/client/feedback/surveys',
       'icon_key': 'post',
       'request_schema': None,
       'response_schema': None,
       'permission_key': None,
       'rate_limit_key': None,
       'api_version': 'v1',
       'deprecated_at': None,
       'is_backend_only': 0,
       'last_tested_at': None,
       'health_status': 'healthy',
       'created_at': '2026-06-19 00:15:58',
       'avg_latency_ms': None,
       'prisma_model_names': None,
       'query_pattern': None,
       'uses_pagination': 0,
       'uses_select': 0,
       'uses_include': 0,
       'possible_n_plus_one': 0,
       'recommended_indexes_json': None,
       'db_query_time_ms': 0,
       'optimization_status': 'pending'},
 253: {'id': 253,
       'app_id': 1,
       'runtime_artifact_id': None,
       'controller_id': None,
       'service_id': None,
       'request_schema_id': None,
       'response_schema_id': None,
       'endpoint_code': 'API__V1_CLIENT_FEEDBACK_ANALYTICS',
       'route_path': '/v1/client/feedback/analytics',
       'http_method': 'POST',
       'controller_name': '',
       'service_name': 'PRISMA',
       'auth_required': 1,
       'implementation_status': 'active',
       'gateway_url': 'https://api.primecare.io/v1/client/feedback/analytics',
       'icon_key': 'post',
       'request_schema': None,
       'response_schema': None,
       'permission_key': None,
       'rate_limit_key': None,
       'api_version': 'v1',
       'deprecated_at': None,
       'is_backend_only': 0,
       'last_tested_at': None,
       'health_status': 'healthy',
       'created_at': '2026-06-19 00:15:58',
       'avg_latency_ms': None,
       'prisma_model_names': None,
       'query_pattern': None,
       'uses_pagination': 0,
       'uses_select': 0,
       'uses_include': 0,
       'possible_n_plus_one': 0,
       'recommended_indexes_json': None,
       'db_query_time_ms': 0,
       'optimization_status': 'pending'}}
SOURCE_HASHES = {'cloudflare/workers/src/gateway.ts': '8ec518ef8d8bf5577da2f049abd02c089e4d4405060adf71655487ee12851fb9',
 'cloudflare/workers/src/account-admin.ts': 'b93b16c000f0c02e387fef5b3566b79f2c786f8b62fb23176471b506390d9b92',
 'cloudflare/workers/src/client-self.ts': '61f8bb9dd63b7d99f0760f9364c4bef709e73a451db8c68f526e82f39d69f9a5',
 'cloudflare/workers/src/client-records-registry.json': '376620e3a45a9276bd751e79e000b223ac8dd280395b13ac46773bbb618738f5',
 'packages/domain/src/registries/FormRegistry/client-forms.ts': 'f05ee6ccd060907a6672b869434782508ac7f65a1d2cfaacf3391e0953799516'}

def verify_sources(root=ROOT):
    for path,expected in SOURCE_HASHES.items():
        actual=root/path
        if not actual.is_file() or hashlib.sha256(actual.read_bytes()).hexdigest()!=expected:
            raise ValueError('Reviewed method/caller evidence changed: '+path)
    form=(root/'packages/domain/src/registries/FormRegistry/client-forms.ts').read_text()
    if not re.search(r"id:\s*'client\.feedback'[\s\S]*?apiEndpoint:\s*'/v1/client/feedback',[\s\S]*?method:\s*'POST'",form):
        raise ValueError('Feedback submission caller contract changed')
    package_path=root/'docs/api/method-capture-blocker-package.json'
    if not package_path.is_file():raise ValueError('Reviewed blocker manifest missing')
    package=json.loads(package_path.read_text())
    operations={row['http_method']+' '+row['route_path']:aid for aid,row in EXPECTED.items()}
    if package.get('sourceHashes')!=SOURCE_HASHES or set(package.get('operations',[]))!=set(operations) or len(package.get('operations',[]))!=4 or (package.get('implementedOperations'),package.get('resolvedOperations'),package.get('newBlockedOperations'))!=(0,0,4):
        raise ValueError('Blocker manifest source/counting provenance changed')
    for api,aid in operations.items():
        review=package.get('reviews',{}).get(api,{})
        expected_reason='feedback_submission_authority_and_write_handler_missing' if aid==251 else 'generic_owned_detail_capture_not_workflow'
        if (review.get('declarationIds'),review.get('method'),review.get('path'),review.get('disposition'),review.get('verificationState'),review.get('blockerReason'))!=([aid],'POST',EXPECTED[aid]['route_path'],'requires_workflow_contract','blocked',expected_reason):
            raise ValueError('Blocker manifest exact disposition changed: '+api)

def reconcile(db,root=ROOT):
    verify_sources(root)
    db.execute('SAVEPOINT register_method_capture_blockers')
    try:
        for name,sql in db.execute("SELECT name,sql FROM sqlite_master WHERE type='trigger'"):
            if re.search(r'\bapi_endpoints\b',sql or '',re.I):
                raise ValueError('Unreviewed API mutation trigger: '+name)
        columns=[r[1] for r in db.execute('PRAGMA table_info(api_endpoints)')]
        if set(columns)!=set(next(iter(EXPECTED.values()))):
            raise ValueError('API declaration schema changed')
        before={r[0]:dict(zip(columns,r)) for r in db.execute('SELECT * FROM api_endpoints ORDER BY id')}
        for aid,expected in EXPECTED.items():
            row=before.get(aid)
            if row is None:raise ValueError('Missing reviewed declaration: '+str(aid))
            if (row['implementation_status'],row['health_status']) not in [('active','healthy'),('blocked','unverified')]:
                raise ValueError('Unexpected declaration status: '+str(aid))
            if any(row[k]!=v for k,v in expected.items() if k not in ('implementation_status','health_status')):
                raise ValueError('Reviewed identity/authority/query metadata changed: '+str(aid))
        for aid in EXPECTED:
            db.execute("UPDATE api_endpoints SET implementation_status='blocked',health_status='unverified' WHERE id=?",(aid,))
        after={r[0]:dict(zip(columns,r)) for r in db.execute('SELECT * FROM api_endpoints ORDER BY id')}
        expected_after={aid:dict(row,implementation_status='blocked',health_status='unverified') if aid in EXPECTED else row for aid,row in before.items()}
        if after!=expected_after:raise ValueError('Unreviewed source data changed')
        db.execute('RELEASE register_method_capture_blockers')
        return {'registeredBlockedOperations':4,'resolvedOperations':0,'runtimeChanges':0}
    except BaseException:
        db.execute('ROLLBACK TO register_method_capture_blockers')
        db.execute('RELEASE register_method_capture_blockers')
        raise

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--db',type=Path,required=True);args=parser.parse_args()
    path=args.db.resolve()
    if not path.is_file() or path==(ROOT/'.agents/governance/governance.db').resolve():
        parser.error('Explicit existing disposable derived database required; tracked seed unchanged')
    with sqlite3.connect(path) as db:print(json.dumps(reconcile(db)))
