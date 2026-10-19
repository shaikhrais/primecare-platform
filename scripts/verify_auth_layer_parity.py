#!/usr/bin/env python3
"""Execute original and extracted auth handlers against identical database cases."""
import argparse
import subprocess
from refactor_auth_layers import ROOT, original, verify_auth


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dart', default='dart')
    args = parser.parse_args()
    verify_auth()
    service = ROOT / 'services/auth_api'
    baseline = service / 'lib/src/application/auth_parity_baseline.dart'
    runner = service / 'test/auth_parity_runner.dart'
    assert not baseline.exists() and not runner.exists()
    source = original().replace('class AuthApiHost extends BaseHttpServiceHost {', 'class AuthApiHost extends BaseHttpServiceHost {\n  final PlatformDatabase database;')
    source = source.replace('AuthApiHost() :', 'AuthApiHost(this.database) :').replace('final db = PlatformDatabase();', 'final db = database;')
    # Make token generation deterministic in both implementations for comparison.
    # The checked production source retains Random.secure and the original logic.
    start = source.index('String _newToken() {')
    end = source.index('\nResponse _json', start)
    source = source[:start] + "String _newToken() => 'parity-token';\n" + source[end:]
    controller_path = service / 'lib/src/controllers/auth_http_controller.dart'
    controller_copy = service / 'lib/src/controllers/auth_parity_controller.dart'
    controller = controller_path.read_text()
    start = controller.index('String _newToken() {')
    end = controller.index('\nResponse _json', start)
    controller = controller[:start] + "String _newToken() => 'parity-token';\n" + controller[end:]
    try:
        baseline.write_text(source)
        controller_copy.write_text(controller)
        runner.parent.mkdir(exist_ok=True)
        runner.write_text(r'''import 'dart:convert';
import 'package:bcrypt/bcrypt.dart';
import 'package:database_client/database_client.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../lib/src/application/auth_parity_baseline.dart' as baseline;
import '../lib/src/controllers/auth_parity_controller.dart';
import '../lib/src/repositories/auth_repository.dart';

class RecordingDatabase implements PlatformDatabase {
  final calls = <Object>[];
  String scenario = 'active';
  late final hash = BCrypt.hashpw('correct-password', BCrypt.gensalt());
  @override
  Future<void> initialize() async {}
  @override
  Future<void> close() async {}
  @override
  Future<Result> query(String sql, {Map<String, dynamic>? substitutionValues}) async {
    calls.add([sql, substitutionValues]);
    if (scenario == 'failure') throw StateError('database unavailable');
    final login = sql.startsWith('SELECT id, roles');
    final schema = ResultSchema(List.generate(login ? 4 : 2,
      (i) => ResultSchemaColumn(typeOid: 25, type: Type.text, columnName: 'column$i')));
    final values = login ? ['user-12', 'client', scenario == 'bad-hash' ? r'$2bad' : hash, scenario == 'inactive' ? 'inactive' : 'active'] : ['user-12', 'client'];
    final rows = scenario == 'missing' || !sql.startsWith('SELECT') ? <ResultRow>[] : [ResultRow(values: values, schema: schema)];
    return Result(rows: rows, schema: schema, affectedRows: rows.length);
  }
}

Future<Object> probe(Handler handler, RecordingDatabase db, String method, String path, String body, Map<String, String> headers) async {
  db.calls.clear();
  Object outcome;
  try {
    final response = await handler(Request(method, Uri.parse('https://api$path'), body: body, headers: headers));
    final entries = response.headers.entries.toList()..sort((a,b) => a.key.compareTo(b.key));
    outcome = [response.statusCode, Map.fromEntries(entries), await response.readAsString()];
  } catch (error) {
    outcome = ['error', error.runtimeType.toString(), error.toString()];
  }
  return [outcome, List.of(db.calls)];
}

Future<void> main() async {
  final db = RecordingDatabase();
  final old = await baseline.AuthApiHost(db).createRoutes();
  final router = Router();
  AuthHttpController(AuthRepository(db)).registerRoutes(router);
  var cases = 0;
  for (final scenario in ['active', 'missing', 'inactive', 'bad-hash', 'failure']) {
    db.scenario = scenario;
    for (final body in ['malformed', '[]', '{}', '{"email":3}', '{"email":" a@example.test ","password":"wrong"}', '{"email":" A@example.test ","password":"correct-password"}']) {
      final before = await probe(old, db, 'POST', '/login', body, {});
      final after = await probe(router.call, db, 'POST', '/login', body, {});
      if (jsonEncode(before) != jsonEncode(after)) throw StateError('Login parity: $scenario $body $before $after');
      cases++;
    }
    for (final headers in <Map<String, String>>[{}, {'authorization':'Bearer '}, {'authorization':'Bearer token'}, {'cookie':'x=1; session_token=cookie-token'}, {'authorization':'Bearer bearer-token', 'cookie':'session_token=cookie-token'}, {'cookie':'session_token=a=b'}]) {
      for (final binding in [['GET','/me'], ['POST','/logout'], ['GET','/health']]) {
        final before = await probe(old, db, binding[0], binding[1], '', headers);
        final after = await probe(router.call, db, binding[0], binding[1], '', headers);
        if (jsonEncode(before) != jsonEncode(after)) throw StateError('Session parity: $scenario $binding $headers $before $after');
        cases++;
      }
    }
  }
  print('Auth parity passed: $cases response/header/body/SQL/parameter/error cases');
}
''')
        subprocess.run([args.dart, 'run', str(runner.relative_to(service))], cwd=service, check=True)
    finally:
        for path in [baseline, runner, controller_copy]:
            path.unlink(missing_ok=True)


if __name__ == '__main__':
    main()
