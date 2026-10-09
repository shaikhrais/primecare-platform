#!/usr/bin/env python3
"""Compare governance responses and database calls with pinned pre-extraction code."""
import argparse
import re
import subprocess
from pathlib import Path
from refactor_governance_layers import ROOT, SOURCE, PREFIX


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--dart',default='dart');parser.add_argument('--offline',action='store_true');args=parser.parse_args()
    service=ROOT/'services/governance_api'
    source=subprocess.check_output(['git','show',SOURCE+':'+PREFIX+'controllers/governance_controller.dart'],cwd=ROOT,text=True)
    names=re.findall(r'static Future<Response> (\w+)\(',source)
    assert len(names)==20
    # The only baseline change is injecting a recording connection rather than
    # opening a real database. Handler logic is kept verbatim.
    source=source.replace("import '../database/database_controller.dart';\n",'').replace('static final db = DatabaseController.connection;','static late Connection db;')
    baseline=service/'lib/src/controllers/governance_parity_baseline.dart'
    baseline_routes=service/'lib/src/routes/governance_parity_baseline_routes.dart'
    runner=service/'test/governance_parity_runner.dart'
    assert not baseline.exists() and not runner.exists() and not baseline_routes.exists()
    try:
        baseline.write_text(source)
        route_source=subprocess.check_output(['git','show',SOURCE+':'+PREFIX+'routes/governance_routes.dart'],cwd=ROOT,text=True)
        baseline_routes.write_text(route_source.replace("../controllers/governance_controller.dart", "../controllers/governance_parity_baseline.dart"))
        routes=re.findall(r"router\.(get|post)\('([^']+)'",route_source)
        route_pairs='\n'.join(f"    ['{method.upper()}', '{path}']," for method,path in routes if '<' not in path)
        pairs='\n'.join(f"    '{name}': [baseline.GovernanceController.{name}, controller.{name}]," for name in names)
        runner.write_text(r"""import 'dart:convert';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import '../lib/src/controllers/governance_parity_baseline.dart' as baseline;
import '../lib/src/controllers/governance_http_controller.dart';
import '../lib/src/repositories/governance_repository.dart';
import '../lib/src/routes/governance_api_routes.dart';
import '../lib/src/routes/governance_routes.dart' as compatibility;
import '../lib/src/routes/governance_parity_baseline_routes.dart' as original_routes;

class RecordingConnection implements Connection {
  final calls = <Map<String, Object?>>[];
  bool fail = false;
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #execute) {
      final dynamic query = invocation.positionalArguments.first;
      calls.add({'sql': query is String ? query : query.sql, 'parameters': invocation.namedArguments[#parameters]});
      if (fail) return Future<Result>.error(StateError('database unavailable'));
      final schema = ResultSchema([
        ResultSchemaColumn(typeOid: 23, type: Type.integer, columnName: 'id'),
        ResultSchemaColumn(typeOid: 25, type: Type.text, columnName: 'name'),
      ]);
      return Future.value(Result(rows: [ResultRow(values: [12, 'original data'], schema: schema)], affectedRows: 1, schema: schema));
    }
    return super.noSuchMethod(invocation);
  }
}

Future<Object> probe(Future<Response> Function(Request) handler, RecordingConnection db, String body, bool fail, {String method = 'POST', String path = '/governance'}) async {
  db.calls.clear(); db.fail = fail;
  Object outcome;
  try {
    final response = await handler(Request(method, Uri.parse('https://api$path'), body: body));
    final headers = response.headers.entries.toList()..sort((a,b) => a.key.compareTo(b.key));
    outcome = [response.statusCode, Map.fromEntries(headers), await response.readAsString()];
  } catch (error) {
    outcome = ['error', error.runtimeType.toString()];
  }
  return {'outcome': outcome, 'calls': List.of(db.calls)};
}

Future<void> main() async {
  final db = RecordingConnection();
  baseline.GovernanceController.db = db;
  final controller = GovernanceHttpController(GovernanceRepository(db));
  final handlers = <String, List<Future<Response> Function(Request)>>{
PAIRS
  };
  final valid = jsonEncode({'name': 'Name', 'type': 'clinical', 'status': 'active', 'code': 'code', 'app_id': 'app', 'priority': 'high', 'requested_by': 'actor', 'feature_name': 'Feature', 'intent': 'intent', 'app_name': 'App', 'screens': 'screens', 'apis': 'apis', 'roles': 'roles', 'path': '/existing', 'endpoint': '/existing'});
  var scenarios = 0;
  for (final entry in handlers.entries) {
    for (final body in [valid, '{}', '[]', '7', 'malformed']) {
      for (final fail in [false, true]) {
        final before = await probe(entry.value[0], db, body, fail);
        final after = await probe(entry.value[1], db, body, fail);
        if (jsonEncode(before) != jsonEncode(after)) throw StateError('Changed ${entry.key}: $before vs $after');
        scenarios++;
      }
    }
  }
  // The compatibility entrypoint must build a router before the database has
  // initialized; controller construction stays lazy for actual API requests.
  final sanity = await compatibility.GovernanceRoutes.router(Request('GET', Uri.parse('https://api/')));
  if (await sanity.readAsString() != 'Hello, World!\n') throw StateError('Eager database initialization');
  final original = original_routes.GovernanceRoutes.router;
  final migrated = GovernanceApiRoutes(() => controller).router;
  final routeBindings = <List<String>>[
ROUTES
    ['GET', '/echo/original'],
    ['DELETE', '/api/apps'],
    ['GET', '/unknown'],
  ];
  for (final binding in routeBindings) {
    for (final fail in [false, true]) {
      final before = await probe(original.call, db, valid, fail, method: binding[0], path: binding[1]);
      final after = await probe(migrated.call, db, valid, fail, method: binding[0], path: binding[1]);
      if (jsonEncode(before) != jsonEncode(after)) throw StateError('Route changed: $binding');
    }
  }
  print('${handlers.length} handlers preserve responses, SQL, parameters and errors across $scenarios scenarios');
  print('${routeBindings.length} route/method cases preserve dispatch and errors');
}
""".replace('PAIRS',pairs).replace('ROUTES',route_pairs))
        subprocess.run([args.dart,'pub','get']+(['--offline'] if args.offline else []),cwd=service,check=True,stdout=subprocess.DEVNULL)
        subprocess.run([args.dart,'run',str(runner.relative_to(service))],cwd=service,check=True)
    finally:
        baseline.unlink(missing_ok=True);baseline_routes.unlink(missing_ok=True);runner.unlink(missing_ok=True)


if __name__=='__main__':
    main()
