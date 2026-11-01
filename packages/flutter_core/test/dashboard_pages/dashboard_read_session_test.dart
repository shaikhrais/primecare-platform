import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_core/dashboard_pages.dart';
import 'package:flutter_core/preference_sync/preference_protocol.dart' show PreferenceScope;

void main() {
  final fixture = jsonDecode(File('test/dashboard_pages/parity-fixtures.json').readAsStringSync()) as Map<String, dynamic>;
  final scope = PreferenceScope.fromJson(fixture['scope']);
  const token = 'fixture-token';
  test('existing GET binding, bearer/no-cache/no-redirect, reload and context denial', () async {
    String? current = token;
    var calls = 0;
    final client = MockClient((request) async {
      calls++;
      expect(request.method, 'GET');
      expect(request.url.path, '/v1/governance/tenant-dashboard');
      expect(request.url.queryParameters, {'dataset': 'live'});
      expect(request.headers['authorization'], 'Bearer $token');
      expect(request.headers['cache-control'], 'no-store');
      expect(request.followRedirects, false);
      return http.Response(jsonEncode(fixture['raw']), 200);
    });
    final transport = DashboardPageTransport(origin: Uri.parse('https://fixture.test'), token: token, scope: scope,
      currentToken: () => current, currentScope: () => scope, maxBytes: 262144, client: client);
    final session = DashboardReadSession<DashboardPageProjection>(transport: transport,
      project: (raw) => DashboardPageProjection.fromResponse('project', raw, scope), projectionStatus: (p) => p.status);
    await session.load();
    expect(session.status, 'ready');
    expect(session.projection!.metrics.first.value, 5);
    await session.load();
    expect(calls, 2);
    current = 'changed';
    final read = session.load();
    expect(session.projection, null);
    await read;
    expect(session.status, 'denied');
    expect(calls, 2);
    session.dispose();client.close();
  });
  test('latest read wins; invalidation and disposal suppress late results', () async {
    final pending = <Completer<http.Response>>[];
    final client = MockClient((_) { final item = Completer<http.Response>(); pending.add(item); return item.future; });
    final transport = DashboardPageTransport(origin: Uri.parse('https://fixture.test'), token: token, scope: scope,
      currentToken: () => token, currentScope: () => scope, maxBytes: 262144, client: client);
    final session = DashboardReadSession<RecordPageProjection>(transport: transport,
      project: (raw) => RecordPageProjection.fromResponse('search', raw, scope), projectionStatus: (p) => p.status);
    final first = session.load(), second = session.load();
    await Future<void>.delayed(Duration.zero);
    pending[1].complete(http.Response(jsonEncode(fixture['raw']), 200));await second;
    expect(session.status, 'ready');
    pending[0].complete(http.Response('invalid JSON', 200));await first;
    expect(session.status, 'ready');
    final invalidated = session.load();session.invalidate();
    await Future<void>.delayed(Duration.zero);
    pending[2].complete(http.Response(jsonEncode(fixture['raw']), 200));await invalidated;
    expect(session.status, 'denied');expect(session.projection, null);
    final disposed = session.load();session.dispose();
    await Future<void>.delayed(Duration.zero);
    pending[3].complete(http.Response(jsonEncode(fixture['raw']), 200));await disposed;
    expect(session.status, 'disposed');expect(session.projection, null);client.close();
  });
  test('scope changes after response, denied replies, redirect, bounds and bad JSON fail closed', () async {
    for (final mode in ['scope', 'denied', 'redirect', 'large', 'json']) {
      var currentScope = scope;
      final client = MockClient((_) async {
        if (mode == 'scope') currentScope = PreferenceScope(scope.tenantId, scope.userId, 'client', scope.dataset);
        return http.Response(mode == 'json' ? 'invalid' : jsonEncode(fixture['raw']), mode == 'denied' ? 403 : mode == 'redirect' ? 302 : 200);
      });
      final transport = DashboardPageTransport(origin: Uri.parse('https://fixture.test'), token: token, scope: scope,
        currentToken: () => token, currentScope: () => currentScope, maxBytes: mode == 'large' ? 10 : 262144, client: client);
      final session = DashboardReadSession<DashboardPageProjection>(transport: transport,
        project: (raw) => DashboardPageProjection.fromResponse('project', raw, scope), projectionStatus: (p) => p.status);
      await session.load();expect(session.projection, null);
      expect(session.status, ['scope', 'denied'].contains(mode) ? 'denied' : mode == 'large' ? 'invalid' : 'error');
      session.dispose();client.close();
    }
  });
  test('invalid byte limits are rejected', () {
    for (final limit in [0, 1048577]) {
      expect(() => DashboardPageTransport(origin: Uri.parse('https://fixture.test'), token: token, scope: scope,
        currentToken: () => token, currentScope: () => scope, maxBytes: limit), throwsA(isA<DashboardReadFailure>()));
    }
  });
  test('unsafe origin and invalid limits are rejected before any request', () {
    for (final origin in ['http://public.test', 'https://u:p@fixture.test', 'https://fixture.test/path', 'https://fixture.test?token=x']) {
      expect(() => DashboardPageTransport(origin: Uri.parse(origin), token: token, scope: scope,
        currentToken: () => token, currentScope: () => scope, maxBytes: 262144), throwsA(isA<DashboardReadFailure>()));
    }
  });
}
