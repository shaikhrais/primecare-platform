#!/usr/bin/env python3
"""Separate existing ordinary service routing, HTTP logic, and database queries."""
import argparse
import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = 'e0709f8b832ad21b574295e1b5975674a0694057'
SERVICES = ['billing_api', 'client_api', 'compliance_api', 'franchise_reporting_api', 'notes_api', 'notification_api', 'provider_api', 'scheduling_api', 'verification_api', 'visit_api']
QUERIES = {
    'billing_api': [('listInvoices', '', '')],
    'client_api': [('listClients', '', ''), ('createClient', 'Map<String, dynamic> payload', 'payload')],
    'compliance_api': [('listAudits', '', ''), ('createFinding', 'Map<String, dynamic> payload', 'payload')],
    'provider_api': [('listProviders', '', ''), ('findProvider', 'String id', 'id')],
    'scheduling_api': [('listSchedules', '', '')],
    'visit_api': [('listVisits', '', ''), ('createVisit', 'Map<String, dynamic> payload', 'payload')],
}
MANIFEST = ROOT / 'docs/refactoring/domain-host-migration.json'


def host_path(service):
    return f'services/{service}/lib/src/application/{service}_host.dart'


def original(service):
    return subprocess.check_output(['git', 'show', SOURCE + ':' + host_path(service)], cwd=ROOT, text=True)


def render(service, source):
    prefix = ''.join(word.title() for word in service.split('_')[:-1])
    root = f'services/{service}/lib/src'
    start = source.index('    final router = Router();')
    end = source.index('    return router.call;', start)
    body = source[start + len('    final router = Router();'):end]
    imports = source[:source.index('class ')].strip() + '\n'
    imports = re.sub(r"import '(?:dart:io|package:database_client/database_client.dart)';\n", '', imports)
    imports = re.sub(r'//[^\n]*\n', '', imports)
    files = {}
    route_class = prefix + 'ServiceRoutes'
    if service in QUERIES:
        repository_class = prefix + 'Repository'
        controller_class = prefix + 'HttpController'
        methods = []
        matches = list(re.finditer(r'await db\.query\([\s\S]*?\);', body))
        assert len(matches) == len(QUERIES[service]), service
        query_decl = ''
        if service == 'scheduling_api':
            declaration = re.search(r"        final query = '''[\s\S]*?''';\n", body)
            assert declaration
            query_decl = declaration[0]
            # Keep SQL bytes, including original spaces, without trailing source whitespace.
            sql_literal = query_decl.split("'''")[1].removeprefix('\n')
            query_decl = '        final query = ' + json.dumps(sql_literal) + ';\n'
        for match, (name, parameters, arguments) in reversed(list(zip(matches, QUERIES[service]))):
            expression = match[0].removeprefix('await ').removesuffix(';').replace('db.query(', 'database.query(', 1)
            if query_decl:
                method = f'  Future<DatabaseResult> {name}({parameters}) {{\n' + query_decl + f'    return {expression};\n  }}'
            else:
                method = f'  Future<DatabaseResult> {name}({parameters}) => {expression};'
            methods.insert(0, method)
            body = body[:match.start()] + f'await repository.{name}({arguments});' + body[match.end():]
        if query_decl:
            body = body.replace(declaration[0], '')
        repository_imports = "import 'package:database_client/database_client.dart';\n"
        if 'jsonEncode(' in '\n'.join(methods):
            repository_imports = "import 'dart:convert';\n" + repository_imports
        files[f'{root}/repositories/{service}_repository.dart'] = repository_imports + f'\nclass {repository_class} extends BasePlatformRepository {{\n  {repository_class}(super.database);\n\n' + '\n\n'.join(methods) + '\n}\n'
        files[f'{root}/controllers/{service}_http_controller.dart'] = imports + f"import '../repositories/{service}_repository.dart';\n\nclass {controller_class} extends BaseController {{\n  final {repository_class} repository;\n  {controller_class}(this.repository);\n\n  void registerRoutes(Router router) {{" + body + '\n  }\n}\n'
        route = "import 'package:server_core/server_core.dart';\nimport 'package:shelf_router/shelf_router.dart';\n" + f"import '../controllers/{service}_http_controller.dart';\n\nclass {route_class} extends BaseApiRoutes {{\n  final {controller_class} controller;\n  {route_class}(this.controller);\n\n  @override\n  void registerRoutes(Router router) {{\n    controller.registerRoutes(router);\n  }}\n}}\n"
        constructor = f'{route_class}({controller_class}({repository_class}(db)))'
        host_imports = f"import '../controllers/{service}_http_controller.dart';\nimport '../repositories/{service}_repository.dart';\n"
    else:
        route = imports + f'\nclass {route_class} extends BaseApiRoutes {{\n  @override\n  void registerRoutes(Router router) {{' + body + '\n  }\n}\n'
        constructor = route_class + '()'
        host_imports = ''
    files[f'{root}/routes/{service}_service_routes.dart'] = route
    host = source[:start] + f'    return {constructor}.router.call;\n' + source[end + len('    return router.call;\n'):]
    for uri in ['dart:convert', 'package:shelf_router/shelf_router.dart', f'package:{service}/routes.dart']:
        host = host.replace(f"import '{uri}';\n", '')
    host = host.replace("import 'package:server_core/server_core.dart';", "import 'package:server_core/server_core.dart';\n" + host_imports + f"import '../routes/{service}_service_routes.dart';")
    files[host_path(service)] = host
    return files


def verify_domain(service):
    for path, content in render(service, original(service)).items():
        assert (ROOT / path).read_text() == content, 'Domain extraction changed: ' + path


def main():
    parser = argparse.ArgumentParser(); parser.add_argument('--check', action='store_true'); args = parser.parse_args()
    outputs = {}; entries = []
    for service in SERVICES:
        outputs.update(render(service, original(service)))
        entries.append({'service': service, 'application': host_path(service), 'queries': len(QUERIES.get(service, []))})
    manifest = {'sourceCommit': SOURCE, 'services': entries, 'completedWorkflows': 0}
    if args.check:
        for service in SERVICES: verify_domain(service)
        assert json.loads(MANIFEST.read_text()) == manifest
        print(json.dumps({'serviceRoutes': len(SERVICES), 'controllers': len(QUERIES), 'repositories': len(QUERIES), 'existingQueries': sum(len(q) for q in QUERIES.values()), 'completedWorkflows': 0}))
    else:
        assert not MANIFEST.exists()
        for service in SERVICES: assert (ROOT / host_path(service)).read_text() == original(service)
        for path, content in outputs.items():
            target = ROOT / path; target.parent.mkdir(parents=True, exist_ok=True); target.write_text(content)
        MANIFEST.write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__': main()
