"""Register exact recovery/replacement API contracts and native MFA controls."""
import hashlib
import json
import os
from pathlib import Path
import sys
from mfa_surface import Store, TABLES
from production_reader import GovernanceReadError

FILE = Path(__file__).with_name('auth-lifecycle-surface.json')


def scope():
    return dict(optInVariable='GOVERNANCE_AUTH_LIFECYCLE_SURFACE_WRITES', tables=list(TABLES),
        screenId=949, endpointPrefix='/v1/auth/mfa/', definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),
        schemaChanges=False, businessDataWrites=False, roleGrants=False,
        additionalScreenCode='AUTHENTICATED_ACCOUNT')


def register(db):
    if db.pin.get('authLifecycleSurfaceWriter') != scope() or os.environ.get('GOVERNANCE_AUTH_LIFECYCLE_SURFACE_WRITES') != '1':
        raise GovernanceReadError('Exact lifecycle surface registration scope required')
    d = json.loads(FILE.read_text())
    policy = db.execute('SELECT definition FROM platform_hierarchy_policy WHERE id=?', (d['policyId'],)).fetchall()
    if len(policy) != 1 or json.loads(policy[0][0]) != json.loads(FILE.with_name('auth-lifecycle-policy.json').read_text()):
        raise GovernanceReadError('Registered lifecycle requirements required')
    if db.execute('SELECT screen_code,active FROM screens WHERE id=949').fetchall() != [('mfa', 1)]:
        raise GovernanceReadError('Existing MFA screen required')
    db.db.execute('LOCK TABLE ' + ','.join(db.table(t) for t in TABLES) + ' IN SHARE ROW EXCLUSIVE MODE')
    ids = []
    for endpoint in d['endpoints']:
        aid = db.ensure('api_endpoints', {'endpoint_code': endpoint['code']}, dict(app_id=1,
            route_path=endpoint['route'], http_method='POST', controller_name='mfa_lifecycle', service_name='auth',
            auth_required=endpoint['authenticated'], implementation_status='registered-unimplemented',
            request_schema=json.dumps(endpoint['request'], sort_keys=True), response_schema=json.dumps(endpoint['response'], sort_keys=True),
            permission_key=endpoint['permission'], rate_limit_key='mfa_lifecycle', api_version='v1', is_backend_only=0))
        db.ensure('screen_api_links', dict(screen_id=949, api_id=aid), dict(purpose='Self-only MFA lifecycle; no administrator bypass or cross-tenant access'))
        ids.append(aid)
    languages = dict(db.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
    if set(languages) != set(d['locales']):
        raise GovernanceReadError('Existing locales required')
    for locale, strings in d['locales'].items():
        for key, text in strings.items():
            rid = db.ensure('language_resources', {'resource_key': 'authLifecycle.' + key},
                dict(resource_group='authLifecycle', description='Self-only authenticator recovery and replacement', context='authLifecycle', active=1))
            db.ensure('language_resource_values', dict(resource_id=rid, language_id=languages[locale]),
                dict(translated_text=text, reviewed=0, approved=0, version='auth-lifecycle-v1'))
    for key, component in d['controls'].items():
        if db.execute('SELECT active FROM primecare_ui_component_registry WHERE component_code=?', (component,)).fetchall() != [(1,)]:
            raise GovernanceReadError('Existing PrimeCare component required')
        identifier = 'mfa-lifecycle-' + key.lower()
        db.ensure('screen_components', dict(screen_id=949, component_code='authLifecycle.' + key),
            dict(component_name='authLifecycle.' + key, component_type=component, data_cy=identifier,
                file_path=d['file'], implementation_status='registered-unimplemented'))
        db.ensure('screen_required_elements', dict(screen_id=949, element_key='authLifecycle.' + key),
            dict(element_type=component, label='authLifecycle.' + key, test_id=identifier, required=1))
    entry = d['managementEntry']
    account = db.execute('SELECT id,route_path,active FROM screens WHERE screen_code=?', (entry['screenCode'],)).fetchall()
    if len(account) != 1 or account[0][1:] != (entry['route'], 1) or entry['role'] != 'code_admin' or entry['destination'] != '/mfa':
        raise GovernanceReadError('Existing account entry and self-only MFA destination required')
    if db.execute('SELECT active FROM primecare_ui_component_registry WHERE component_code=?', (entry['componentType'],)).fetchall() != [(1,)]:
        raise GovernanceReadError('Existing PrimeCare entry component required')
    db.ensure('screen_components', dict(screen_id=account[0][0], component_code=entry['componentCode']),
        dict(component_name=entry['resourceKey'], component_type=entry['componentType'], data_cy=entry['dataCy'],
            file_path=entry['file'], implementation_status='registered-unimplemented'))
    db.ensure('screen_required_elements', dict(screen_id=account[0][0], element_key=entry['componentCode']),
        dict(element_type=entry['componentType'], label=entry['resourceKey'], test_id=entry['dataCy'], required=1))
    return dict(apiIds=ids, controls=len(d['controls']) + 1, roleGrants=0, accountChanges=0, activation=False)


if __name__ == '__main__':
    if sys.argv[1:] not in [['--dry-run'], ['--apply']]:
        raise SystemExit('Explicit mode required')
    with Store() as db:
        result = register(db)
        if result != register(db):
            raise GovernanceReadError('Non-idempotent lifecycle surface')
        if sys.argv[1] == '--dry-run':
            db.db.rollback()
    print('AUTH_LIFECYCLE_SURFACE ' + json.dumps(result))
