#!/usr/bin/env python3
"""Compare extracted service responses and SQL with their pinned host handlers."""
import argparse
import re
import subprocess
import tempfile
from pathlib import Path
from refactor_domain_hosts import ROOT, SERVICES, QUERIES, host_path, original, verify_domain


def main():
    parser = argparse.ArgumentParser(); parser.add_argument('--dart', default='dart'); parser.add_argument('--offline', action='store_true'); args = parser.parse_args()
    baselines = []
    imports = []; constructors = []; bindings = []
    try:
        for i, service in enumerate(SERVICES):
            verify_domain(service)
            source = original(service)
            host = re.search(r'class (\w+) extends', source)[1]
            prefix = ''.join(word.title() for word in service.split('_')[:-1])
            baseline = ROOT / Path(host_path(service)).with_name('domain_parity_baseline.dart')
            assert not baseline.exists()
            if service in QUERIES:
                source = source.replace(f'class {host} extends', f'class {host} extends', 1).replace(f'class {host} extends BaseCorsServiceHost {{', f'class {host} extends BaseCorsServiceHost {{\n  final PlatformDatabase database;')
                source = source.replace(f'{host}() :', f'{host}(this.database) :').replace('final db = PlatformDatabase();', 'final db = database;')
            baseline.write_text(source); baselines.append(baseline)
            imports.append(f"import '{baseline.as_uri()}' as old{i};")
            root = ROOT / f'services/{service}/lib/src'
            imports.append(f"import '{(root / 'routes' / (service + '_service_routes.dart')).as_uri()}' as route{i};")
            if service in QUERIES:
                imports.append(f"import '{(root / 'controllers' / (service + '_http_controller.dart')).as_uri()}' as controller{i};")
                imports.append(f"import '{(root / 'repositories' / (service + '_repository.dart')).as_uri()}' as repository{i};")
                constructor = f'route{i}.{prefix}ServiceRoutes(controller{i}.{prefix}HttpController(repository{i}.{prefix}Repository(db)))'
                old_constructor = f'old{i}.{host}(db)'
            else:
                constructor = f'route{i}.{prefix}ServiceRoutes()'
                old_constructor = f'old{i}.{host}()'
            constructors.append(f"    '{service}': [await {old_constructor}.createRoutes(), {constructor}.router.call],")
            pairs = re.findall(r"router\.(get|post)\(\s*'([^']+)'", source)
            paths = [(method.upper(), path.replace('<id>', 'provider-12')) for method, path in pairs]
            if service == 'verification_api':
                paths = [('GET', '/v4/health')] + [('POST', '/v4/' + domain + '/existing') for domain in ['identity','finance','audit','admin','clinical','compliance','user','auth','system','dashboard']]
            paths += [('DELETE', '/missing'), ('GET', '/missing'), ('POST', '/')]
            bindings.append(f"    '{service}': {paths!r},".replace('(', '[').replace(')', ']'))
        with tempfile.TemporaryDirectory(prefix='primecare-domain-parity-') as temp:
            harness = Path(temp)
            deps = '\n'.join(f'  {service}:\n    path: {ROOT / "services" / service}' for service in SERVICES)
            (harness / 'pubspec.yaml').write_text("name: domain_parity\nenvironment:\n  sdk: '^3.11.3'\ndependencies:\n  database_client:\n    path: " + str(ROOT / 'packages/database_client') + '\n  postgres: ^3.5.9\n  shelf: ^1.4.2\n' + deps + '\n')
            runner = r'''import 'dart:convert';
import 'package:database_client/database_client.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
IMPORTS
class RecordingDatabase implements PlatformDatabase {
  final calls = <Object>[];
  String scenario = 'rows';
  @override
  Future<void> initialize() async {}
  @override
  Future<void> close() async {}
  @override
  Future<Result> query(String sql, {Map<String, dynamic>? substitutionValues}) async {
    calls.add([sql, substitutionValues]);
    if (scenario == 'failure') throw StateError('database unavailable');
    final schema = ResultSchema([ResultSchemaColumn(typeOid: 25, type: Type.text, columnName: 'id')]);
    final rows = scenario == 'empty' ? <ResultRow>[] : [ResultRow(values: ['record-12'], schema: schema)];
    return Result(rows: rows, schema: schema, affectedRows: rows.length);
  }
}
Future<Object> probe(Handler handler, RecordingDatabase db, List<String> binding, String body) async {
  db.calls.clear();
  Object outcome;
  try {
    final response = await handler(Request(binding[0], Uri.parse('https://api${binding[1]}'), body: body));
    final headers = response.headers.entries.toList()..sort((a,b) => a.key.compareTo(b.key));
    outcome = [response.statusCode, Map.fromEntries(headers), await response.readAsString()];
  } catch (error) { outcome = ['error', error.runtimeType.toString(), error.toString()]; }
  return [outcome, List.of(db.calls)];
}
Future<void> main() async {
  final db = RecordingDatabase();
  final services = <String, List<Handler>>{
CONSTRUCTORS
  };
  final bindings = <String, List<List<String>>>{
BINDINGS
  };
  var cases = 0;
  for (final service in services.entries) {
    for (final scenario in ['rows', 'empty', 'failure']) {
      db.scenario = scenario;
      for (final binding in bindings[service.key]!) {
        for (final body in ['malformed', '[]', '{}', '{"first_name":"A","last_name":"B","email":"a@test","client_id":"client-12","provider_id":"provider-12","category":"clinical","severity":"high","message":"original","metadata":{"source":"original"}}']) {
          final before = await probe(service.value[0], db, binding, body);
          final after = await probe(service.value[1], db, binding, body);
          if (jsonEncode(before) != jsonEncode(after)) throw StateError('Changed ${service.key} $binding $scenario $body: $before vs $after');
          cases++;
        }
      }
    }
  }
  print('Domain host parity passed: ${services.length} services, $cases response/header/body/SQL/parameter/error cases');
}
'''.replace('IMPORTS', '\n'.join(imports)).replace('CONSTRUCTORS', '\n'.join(constructors)).replace('BINDINGS', '\n'.join(bindings))
            (harness / 'runner.dart').write_text(runner)
            subprocess.run([args.dart, 'pub', 'get'] + (['--offline'] if args.offline else []), cwd=harness, check=True, stdout=subprocess.DEVNULL)
            subprocess.run([args.dart, 'run', 'runner.dart'], cwd=harness, check=True)
    finally:
        for baseline in baselines: baseline.unlink(missing_ok=True)


if __name__ == '__main__': main()
