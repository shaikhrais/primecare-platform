#!/usr/bin/env python3
"""Execute original and extracted gateway routing against identical upstream cases."""
import argparse
import subprocess
from refactor_gateway_layers import ROOT, PREFIX, CORE, HOST, original, verify_gateway


def main():
    parser = argparse.ArgumentParser(); parser.add_argument('--dart', default='dart'); args = parser.parse_args()
    verify_gateway()
    service = ROOT / 'services/api_gateway'
    baseline = ROOT / (PREFIX + 'gateway_parity_baseline.dart')
    baseline_routes = ROOT / (PREFIX + 'routes/gateway_parity_baseline_routes.dart')
    runner = service / 'test/gateway_parity_runner.dart'
    for path in [baseline, baseline_routes, runner]: assert not path.exists()
    host = original(HOST)
    start = host.index('    final router = Router();') + len('    final router = Router();\n')
    end = host.index('    return router.call;', start)
    body = host[start:end]
    try:
        baseline.write_text(original(CORE))
        baseline_routes.write_text("import 'dart:io';\nimport 'package:shelf_router/shelf_router.dart';\nimport '../gateway_parity_baseline.dart';\n\nRouter originalRouter(ServiceMesh mesh, GatewayController controller) {\n  final router = Router();\n" + body + '  return router;\n}\n')
        runner.write_text(r'''import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:database_client/database_client.dart';
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import '../lib/src/gateway_core.dart' as current;
import '../lib/src/gateway_parity_baseline.dart' as original;
import '../lib/src/routes/gateway_api_routes.dart';
import '../lib/src/routes/gateway_parity_baseline_routes.dart';

class IgnoredResult implements DatabaseResult {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
class RecordingDatabase implements PlatformDatabase {
  final calls = <Object>[];
  bool fail = false;
  @override
  Future<void> initialize() async {}
  @override
  Future<void> close() async {}
  @override
  Future<DatabaseResult> query(String sql, {Map<String, dynamic>? substitutionValues}) async {
    calls.add([sql, substitutionValues]);
    if (fail) throw StateError('database unavailable');
    return IgnoredResult();
  }
}
class RecordingClient extends http.BaseClient {
  final calls = <Object>[];
  String scenario = 'ok';
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final body = await request.finalize().bytesToString();
    final headers = request.headers.entries.toList()..sort((a,b) => a.key.compareTo(b.key));
    calls.add([request.method, request.url.toString(), Map.fromEntries(headers), body]);
    // Deliver transport errors after the outgoing body sink has closed.
    await Future<void>.delayed(const Duration(milliseconds: 1));
    if (scenario == 'timeout') throw TimeoutException('upstream timeout');
    if (scenario == 'failure') throw http.ClientException('upstream offline');
    return http.StreamedResponse(Stream.value(utf8.encode('upstream:$body')), scenario == 'denied' ? 401 : 201,
      headers: {'content-type':'text/plain', 'connection':'keep-alive', 'transfer-encoding':'chunked', 'content-length':'123', 'set-cookie':'session=upstream', 'x-upstream':'original'});
  }
}
Future<Object> probe(Handler handler, RecordingClient client, RecordingDatabase db, String method, String path, String body) async {
  client.calls.clear(); db.calls.clear();
  final response = await handler(Request(method, Uri.parse('https://gateway$path'), body: body,
    headers: {'authorization':'Bearer original-token', 'cookie':'session_token=original-cookie', 'content-type':'application/json', 'connection':'keep-alive', 'host':'gateway', 'x-tenant-id':'tenant-12'}));
  final headers = response.headers.entries.toList()..sort((a,b) => a.key.compareTo(b.key));
  return [[response.statusCode, Map.fromEntries(headers), await response.readAsString()], List.of(client.calls), List.of(db.calls)];
}
Future<void> main() async {
  final db = RecordingDatabase();
  final client = RecordingClient();
  final services = {'auth':'https://upstream.test/base', 'clients':'https://clients.test/root/'};
  final old = originalRouter(original.ServiceMesh(services, client: client), original.GatewayController(db)).call;
  final migrated = GatewayApiRoutes(current.ServiceMesh(services, client: client), current.GatewayController(db)).router.call;
  var cases = 0;
  for (final scenario in ['ok', 'denied', 'timeout', 'failure']) {
    client.scenario = scenario;
    for (final method in ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS']) {
      for (final path in ['/v1/auth/login?q=hello%20world&x=1', '/api/auth/me', '/v1/clients/profiles/client-12?include=roles', '/api/clients/', '/missing']) {
        for (final body in ['', '{"original":"body"}', 'multiline\nbody']) {
          final before = await probe(old, client, db, method, path, body);
          final after = await probe(migrated, client, db, method, path, body);
          if (jsonEncode(before) != jsonEncode(after)) throw StateError('Proxy parity: $scenario $method $path $before vs $after');
          cases++;
        }
      }
    }
  }
  // Both healthy and degraded responses retain their exact body, headers, and SQL.
  for (final fail in [false, true]) {
    db.fail = fail;
    final before = await probe(old, client, db, 'GET', '/health', '');
    final after = await probe(migrated, client, db, 'GET', '/health', '');
    if (jsonEncode(before) != jsonEncode(after)) throw StateError('Health parity: $before vs $after');
    cases++;
  }
  final mockEnabled = Platform.environment['ENABLE_MOCK_UI']?.toLowerCase() == 'true';
  final missing = await migrated(Request('GET', Uri.parse('https://gateway/dashboard/metrics')));
  if (!mockEnabled && missing.statusCode != 404) throw StateError('Mock route enabled in production');
  final originalMissing = await old(Request('GET', Uri.parse('https://gateway/dashboard/metrics')));
  if (originalMissing.statusCode != missing.statusCode || await originalMissing.readAsString() != await missing.readAsString()) throw StateError('Mock route parity changed');
  print('Gateway parity passed: $cases response/header/body/proxy/SQL cases; mock enabled=$mockEnabled');
}
''')
        for mock_enabled in ['false', 'true']:
            import os
            env = dict(os.environ, ENABLE_MOCK_UI=mock_enabled)
            subprocess.run([args.dart, 'run', str(runner.relative_to(service))], cwd=service, env=env, check=True)
    finally:
        for path in [baseline, baseline_routes, runner]: path.unlink(missing_ok=True)


if __name__ == '__main__': main()
