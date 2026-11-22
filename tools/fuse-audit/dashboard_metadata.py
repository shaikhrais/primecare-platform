"""Read current dashboard governance metadata through the pinned read-only adapter.

This report contains registrations only, never patient/business rows or credentials.
No write adapter, mutation flag or SQL supplied by a caller is accepted.
"""
import argparse
import datetime
import json
import re
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools/governance-production'))
from production_reader import connect, GovernanceReadError


class TracedMetadata:
    def __init__(self, db, report):
        self.db, self.report = db, report
        self.count = 0
    def execute(self, sql, parameters=()):
        self.count += 1
        match = re.search(r'FROM ([a-z_]+)', sql)
        table = match[1] if match else 'unknown'
        self.report['lastMetadataRead'] = dict(table=table, queryIndex=self.count)
        return self.db.execute(sql, parameters)


def rows(db, sql, parameters=()):
    cursor = db.execute(sql, parameters)
    keys = [column[0] for column in cursor.description]
    return [dict(zip(keys, row)) for row in cursor.fetchall()]


def kind_declarations(schema):
    if isinstance(schema, str):
        try:
            schema = json.loads(schema)
        except (ValueError, TypeError):
            return [], False
    if not isinstance(schema, dict):
        return [], False
    kinds = set()
    def visit(node):
        if not isinstance(node, dict):
            return
        field = node.get('properties', {}).get('kind', {})
        if isinstance(field, dict):
            for value in [field.get('const'), *field.get('enum', [])]:
                if isinstance(value, str):
                    kinds.add(value)
        for key in ['oneOf', 'anyOf', 'allOf']:
            for branch in node.get(key, []):
                visit(branch)
    visit(schema)
    return sorted(kinds), True


def inspect(db):
    contracts = {}
    for family in ['dashboard-pages', 'dashboard-widgets']:
        contract = json.loads((ROOT / 'tools/governance-production' / (family + '-contract.json')).read_text())
        host = contract['registrationTarget']
        screens = rows(db, 'SELECT id,screen_code,route_path,actual_file_path,active FROM screens WHERE route_path=?', (host['route'],))
        hosts = []
        for screen in screens:
            hosts.append(dict(screen=screen,
                matchesContract=screen['screen_code'] == host['screenCode'] and screen['actual_file_path'] == host['sourceFile'],
                roleGrantCount=len(rows(db, 'SELECT role_id FROM role_screen_permissions WHERE screen_id=?', (screen['id'],))),
                controls=rows(db, 'SELECT component_code,implementation_status FROM screen_components WHERE screen_id=? ORDER BY component_code', (screen['id'],))))
        contracts[family] = dict(expectedHost=host, registeredHosts=hosts,
            businessBindings=contract.get('businessBindings'), runtimeActivationContract=contract.get('runtimeActivation'))
    preference = json.loads((ROOT / 'tools/governance-production/preference-sync-contract.json').read_text())
    apis = rows(db, 'SELECT id,route_path AS path,http_method AS method,service_name,auth_required,permission_key,request_schema FROM api_endpoints WHERE id=?', (preference['apiId'],))
    registered_kinds = []
    for api in apis:
        kinds, readable = kind_declarations(api.pop('request_schema', None))
        registered_kinds.append(dict(apiId=api['id'], requestSchemaReadable=readable, declaredKinds=kinds))
    api_matches = len(apis) == 1 and all(apis[0][key] == preference[expected] for key, expected in [('path','path'),('method','method'),('service_name','service'),('permission_key','permissionKey')]) and apis[0]['auth_required'] == 1
    candidates = rows(db, 'SELECT id,screen_code,route_path,actual_file_path,active FROM screens WHERE LOWER(screen_code) LIKE ? OR LOWER(screen_code) LIKE ? OR LOWER(screen_code) LIKE ? OR LOWER(screen_code) LIKE ? ORDER BY id LIMIT 200', ('%analytics%', '%project%', '%finance%', '%crypto%'))
    return dict(contracts=contracts, preferenceApi=dict(expectedId=preference['apiId'], registrations=apis, matchesSourceContract=api_matches, registeredRequestKindDeclarations=registered_kinds),
        dashboardScreenCandidates=candidates, candidateLimit=200, candidateListMayBeTruncated=len(candidates) == 200,
        sourcePersistenceAdapter=dict(path='packages/shared/src/dashboard-widgets/session.ts', contract='Host-provided port required; this audit does not test an HTTP adapter.'), sourcePreferenceKinds=sorted({kind for branch in preference['requestSchema'].get('oneOf', []) for kind in ([branch.get('properties', {}).get('kind', {}).get('const')] + branch.get('properties', {}).get('kind', {}).get('enum', [])) if isinstance(kind, str)}),
        limitations=['Registration is not proof of deployment, authorization enforcement, business data binding or visual acceptance.',
                     'Name-matched screen candidates are discovery results, not approved full-dashboard bindings.',
                     'This snapshot reads governance metadata only; no signed-in business workflow was exercised.'])


def safe_diagnostic(error):
    if isinstance(error, GovernanceReadError):
        message = str(error)
        match = re.fullmatch(r'Production governance connection failed: ([a-z-]+) / ([A-Za-z0-9_]+)', message)
        if match:
            return dict(phase=match[1], code=match[2])
        match = re.fullmatch(r'Production governance query failed: ([A-Za-z0-9_]+)', message)
        if match:
            return dict(phase='query', code=match[1])
    return dict(phase='adapter', code='unavailable')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--source-commit', required=True)
    args = parser.parse_args()
    report = dict(sourceCommit=args.source_commit, observedAtUtc=datetime.datetime.now(datetime.timezone.utc).isoformat(), readOnly=True)
    try:
        with connect() as db:
            report['logicalSchemaColumns'] = {name:[column['name'] for column in db.tables[name]['columns']] for name in ['screens','role_screen_permissions','screen_components','api_endpoints']}
            report.update(inspect(TracedMetadata(db, report)))
            report['manifestSha256'] = db.pin['manifestSha256']
        report['status'] = 'metadata_readback_complete'
        result = 0
    except Exception as error:
        # Never serialize a driver exception, environment or connection URL.
        report.update(status='metadata_readback_failed', errorType=type(error).__name__, diagnostic=safe_diagnostic(error))
        result = 1
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(dict(status=report['status'], readOnly=True, output=str(args.output))))
    return result


if __name__ == '__main__':
    raise SystemExit(main())
