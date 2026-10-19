#!/usr/bin/env python3
"""Verify current skeleton structure without replacing historical parity checks."""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def read(path):
    target = ROOT / path
    assert target.resolve().is_relative_to(ROOT) and target.is_file(), path
    return target.read_text()


def manifest(path):
    return json.loads(read(path))


def inherits(source, name, parent, path):
    assert re.search(r"\bclass\s+" + re.escape(name) + r"\s+extends\s+"
                     + re.escape(parent) + r"\b", source), path + ': missing ' + parent


controllers = manifest('docs/architecture/controller-migration.json')['migrated']
assert len({r['path'] for r in controllers}) == len(controllers)
for record in controllers:
    path = record['path']
    source = read(path)
    parent = 'BaseDashboardController' if record['kind'] == 'dashboard' else 'BaseScaffoldController'
    inherits(source, record['controller'], parent, path)
    assert re.search(r'final\s+' + re.escape(record['provider']) + r'\s*=', source), path
    assert not re.search(r'\b(?:loadDashboardData|syncData|performAction|build)\s*\(', source), path
    if record['kind'] == 'dashboard':
        assert re.search(r"endpoint:\s*'" + re.escape(record['endpoint']) + "'", source), path
        inherits(source, record['state'], 'DashboardState', path)
    else:
        assert 'action_completed' not in source, path

apps = manifest('docs/architecture/app-shell-migration.json')['apps']
for app in apps:
    source = read(app['path'])
    inherits(source, app['class'], app['parent'], app['path'])
    assert "applicationTitle => '" + app['title'] + "'" in source, app['path']
    assert 'ref.watch(appRouterProvider)' in source, app['path']
    assert 'Widget build(' not in source and 'MaterialApp.router(' not in source, app['path']

parents = {r['path']: r['parent'] for r in manifest('docs/architecture/http-host-migration.json')['hosts']}
services = manifest('docs/refactoring/service-entrypoint-migration.json')['services']
for service in services:
    path = service['application']
    source = read(path)
    inherits(source, service['class'], parents[service['entrypoint']], path)
    assert not re.search(r'\b(?:run|serve)\s*\([^;]*\)\s*(?:async\s*)?\{', source), path
    assert '.addMiddleware(' not in source and 'createHandler(' not in source, path
    entry = read(service['entrypoint'])
    assert 'class ' not in entry, service['entrypoint']
    assert '/src/application/' in entry and "export 'package:" in entry, service['entrypoint']

for path, name, parent in [
    ('cloudflare/workers/src/service.ts', 'ServiceWorker', 'ServiceApplication'),
    ('cloudflare/workers/src/service-application.ts', 'ServiceApplication', 'WorkerApplication'),
    ('cloudflare/workers/src/runtime/worker-application.ts', 'WorkerApplication', 'BaseWorker'),
    ('cloudflare/workers/src/gateway.ts', 'GatewayWorker', 'BaseWorker'),
    ('websites/typescript/src/care/client.ts', 'CareClient', 'BaseSessionClient'),
    ('websites/typescript/src/growth/client.ts', 'GrowthClient', 'BaseSessionClient'),
]:
    inherits(read(path), name, parent, path)

print(json.dumps({'controllers': len(controllers), 'applicationRoots': len(apps),
                  'organizedServiceHosts': len(services), 'workerSubclasses': 2,
                  'webSessionSubclasses': 2, 'historicalParityChecked': False,
                  'scope': 'registered current skeleton; not all repository code'}))
