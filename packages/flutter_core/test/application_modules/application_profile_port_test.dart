import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_core/application_modules.dart';
import 'package:flutter_core/preference_sync/preference_protocol.dart';

class TrackedClient extends MockClient {
  bool closed = false;
  TrackedClient(Future<http.Response> Function(http.Request) handler) : super(handler);
  @override void close() { closed = true; super.close(); }
}
void main() {
  final scope = PreferenceScope('tenant1', 'user1', 'psw', 'live');
  final identity = {'status': 'authenticated', 'userId': 'user1', 'tenantId': 'tenant1', 'roles': 'psw'};
  ApplicationProfilePort port(http.Client client, {String? Function()? token, PreferenceScope? Function()? current, int maxBytes = 65536}) =>
    ApplicationProfilePort(origin: Uri.parse('https://fixture.test'), token: 'captured-token', scope: scope,
      identityLabel: 'Identity', currentToken: token ?? () => 'captured-token', currentScope: current ?? () => scope,
      client: client, maxBytes: maxBytes);
  final denied = throwsA(isA<WorkFailure>().having((e) => e.code, 'code', 'denied'));
  test('registered self identity becomes a read-only profile snapshot', () async {
    final requests = <http.Request>[];
    final p = port(MockClient((r) async { requests.add(r); return http.Response(jsonEncode(identity), 200); }));
    final raw = await p.read(const WorkQuery()), snapshot = WorkSnapshot.fromJson(raw, scope, 'profile');
    expect(snapshot.items.single.id, 'user1'); expect(snapshot.items.single.actions, isEmpty);
    expect(snapshot.items.single.meta, 'psw · tenant1');
    expect(WorkSnapshot.fromJson(await p.read(const WorkQuery('no match')), scope, 'profile').items, isEmpty);
    for (final r in requests) { expect(r.method, 'GET'); expect(r.url.toString(), 'https://fixture.test/v1/auth/me');
      expect(r.followRedirects, false); expect(r.headers['authorization'], 'Bearer captured-token');
      expect(r.headers['cache-control'], 'no-store'); expect(r.body, isEmpty); }
    await expectLater(p.mutate(WorkCommand('user1', 1, 'edit', {}), 'key'), denied);
    await expectLater(p.readItem('user1'), denied); expect(requests.length, 2); p.dispose();
  });
  test('identity mismatch, unknown fields and denied status never publish profile', () async {
    for (final change in [{'tenantId': 'other'}, {'userId': 'other'}, {'roles': 'admin'}, {'status': 'anonymous'}]) {
      final p = port(MockClient((_) async => http.Response(jsonEncode({...identity, ...change}), 200)));
      await expectLater(p.read(const WorkQuery()), denied); p.dispose();
    }
    final extra = port(MockClient((_) async => http.Response(jsonEncode({...identity, 'extra': true}), 200)));
    await expectLater(extra.read(const WorkQuery()), throwsA(isA<WorkFailure>())); extra.dispose();
    for (final status in [401, 403]) { final p = port(MockClient((_) async => http.Response('{}', status)));
      await expectLater(p.read(const WorkQuery()), denied); p.dispose(); }
  });
  test('session changes before dispatch and during response decoding fail closed', () async {
    var calls = 0, currentToken = 'other';
    final p = port(MockClient((_) async { calls++; return http.Response(jsonEncode(identity), 200); }), token: () => currentToken);
    await expectLater(p.read(const WorkQuery()), denied); expect(calls, 0);
    currentToken = 'captured-token';
    final changed = port(MockClient((_) async { currentToken = 'other'; return http.Response(jsonEncode(identity), 200); }), token: () => currentToken);
    await expectLater(changed.read(const WorkQuery()), denied); p.dispose(); changed.dispose();
    final scoped = port(MockClient((_) async => http.Response(jsonEncode(identity), 200)), current: () => PreferenceScope('other', 'user1', 'psw', 'live'));
    await expectLater(scoped.read(const WorkQuery()), denied); scoped.dispose();
  });
  test('stream size, malformed JSON and redirects fail without extra requests', () async {
    for (final response in [http.Response('x' * 65, 200), http.Response('{bad', 200), http.Response('', 302, headers: {'location': 'https://other.test'})]) {
      var calls = 0; final p = port(MockClient((_) async { calls++; return response; }), maxBytes: 64);
      await expectLater(p.read(const WorkQuery()), throwsA(isA<WorkFailure>())); expect(calls, 1); p.dispose();
    }
  });
  test('disposal suppresses late replies and does not close injected clients', () async {
    final response = Completer<http.Response>(), client = TrackedClient((_) => response.future), p = port(client);
    final pending = p.read(const WorkQuery()); p.dispose(); response.complete(http.Response(jsonEncode(identity), 200));
    await expectLater(pending, throwsA(isA<WorkFailure>().having((e) => e.code, 'code', 'unavailable')));
    expect(client.closed, false); client.close();
  });
  test('scope changes and byte overflow during streaming fail closed', () async {
    var currentToken = 'captured-token';
    Stream<List<int>> changed() async* { yield utf8.encode('{'); currentToken = 'other'; yield utf8.encode('}'); }
    final changedPort = port(MockClient.streaming((_, __) async => http.StreamedResponse(changed(), 200)), token: () => currentToken);
    await expectLater(changedPort.read(const WorkQuery()), denied); changedPort.dispose();
    Stream<List<int>> oversized() async* { yield List.filled(32, 65); yield List.filled(33, 65); }
    final large = port(MockClient.streaming((_, __) async => http.StreamedResponse(oversized(), 200)), maxBytes: 64);
    await expectLater(large.read(const WorkQuery()), throwsA(isA<WorkFailure>().having((e) => e.code, 'code', 'invalid'))); large.dispose();
  });
  test('invalid origins, demo scope, empty labels and invalid byte limits reject construction', () {
    for (final origin in ['http://remote.test', 'https://user:secret@fixture.test', 'https://fixture.test/path', 'https://fixture.test/?q=x']) {
      expect(() => ApplicationProfilePort(origin: Uri.parse(origin), token: 'token', scope: scope,
        identityLabel: 'Identity', currentToken: () => 'token', currentScope: () => scope), throwsA(isA<WorkFailure>()));
    }
    expect(() => ApplicationProfilePort(origin: Uri.parse('https://fixture.test'), token: 'token', scope: scope, identityLabel: '', currentToken: () => 'token', currentScope: () => scope), throwsA(isA<WorkFailure>()));
    for (final maxBytes in [0, 65537]) { expect(() => port(MockClient((_) async => http.Response('{}', 200)), maxBytes: maxBytes), throwsA(isA<WorkFailure>())); }
    expect(() => ApplicationProfilePort(origin: Uri.parse('https://fixture.test'), token: 'token',
      scope: PreferenceScope('tenant1', 'user1', 'psw', 'demo'), identityLabel: 'Identity',
      currentToken: () => 'token', currentScope: () => scope), throwsA(isA<WorkFailure>()));
  });
}
