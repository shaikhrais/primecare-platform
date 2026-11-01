import 'dart:convert';
import 'package:http/http.dart' as http;
import '../preference_sync/preference_protocol.dart' show PreferenceScope;
import '../work_modules/work_module_model.dart';
import '../work_modules/work_module_session.dart';

/// API16402 GET /v1/auth/me: authenticated self identity only.
/// The host supplies its captured session; this port neither logs in nor grants access.
class ApplicationProfilePort implements WorkPort {
  final PreferenceScope scope;
  final String _token, _identityLabel;
  final String? Function() currentToken;
  final PreferenceScope? Function() currentScope;
  final http.Client _client;
  final bool _owned;
  final Uri _url;
  final int maxBytes;
  bool _dead = false;

  ApplicationProfilePort({required Uri origin, required String token,
    required this.scope, required this.currentToken, required this.currentScope,
    required String identityLabel, this.maxBytes = 65536, http.Client? client})
      : _token = token, _identityLabel = identityLabel,
        _client = client ?? http.Client(), _owned = client == null,
        _url = origin.resolve('/v1/auth/me') {
    if (scope.dataset != 'live' || origin.host.isEmpty ||
        origin.userInfo.isNotEmpty || origin.hasQuery || origin.hasFragment ||
        (origin.path.isNotEmpty && origin.path != '/') ||
        !(origin.scheme == 'https' || origin.scheme == 'http' &&
          ['localhost', '127.0.0.1'].contains(origin.host)) ||
        token.trim().isEmpty || RegExp(r'[\x00-\x20\x7f]').hasMatch(token) ||
        identityLabel.trim().isEmpty || identityLabel.length > 500 ||
        RegExp(r'[\x00-\x1f\x7f]').hasMatch(identityLabel) ||
        maxBytes < 1 || maxBytes > 65536) {
      if (_owned) _client.close();
      throw const WorkFailure('invalid', 400);
    }
  }

  void _check() {
    if (_dead) throw const WorkFailure('unavailable');
    final now = currentScope();
    if (currentToken() != _token || now == null || !now.same(scope)) {
      throw const WorkFailure('denied', 403);
    }
  }

  @override
  Future<Object?> read(WorkQuery query) async {
    _check();
    if (query.offset != 0 || query.search.length > 100) {
      throw const WorkFailure('invalid', 400);
    }
    try {
      final request = http.Request('GET', _url)..followRedirects = false
        ..headers.addAll({'authorization': 'Bearer $_token', 'cache-control': 'no-store'});
      final response = await _client.send(request);
      try { _check(); } on WorkFailure { await response.stream.listen(null).cancel(); rethrow; }
      if (response.statusCode != 200) {
        await response.stream.listen(null).cancel();
        _check();
        throw WorkFailure([401, 403].contains(response.statusCode) ? 'denied' : 'error', response.statusCode);
      }
      if (response.contentLength != null && response.contentLength! > maxBytes) {
        await response.stream.listen(null).cancel();
        _check();
        throw const WorkFailure('invalid', 502);
      }
      final bytes = <int>[];
      await for (final chunk in response.stream) {
        _check();
        if (bytes.length + chunk.length > maxBytes) throw const WorkFailure('invalid', 502);
        bytes.addAll(chunk);
      }
      _check();
      final raw = object(jsonDecode(utf8.decode(bytes)), ['roles', 'status', 'tenantId', 'userId']);
      if (raw['status'] != 'authenticated' || raw['userId'] != scope.userId ||
          raw['tenantId'] != scope.tenantId || raw['roles'] != scope.role) {
        throw const WorkFailure('denied', 403);
      }
      _check();
      final item = {'id': scope.userId, 'version': 1, 'title': _identityLabel,
        'body': scope.userId, 'date': '', 'lane': '',
        'meta': '${scope.role} · ${scope.tenantId}', 'actions': <Object?>[]};
      final matches = query.search.isEmpty || '${item['body']} ${item['meta']}'
          .toLowerCase().contains(query.search.toLowerCase());
      return WorkSnapshot.fromJson({'scope': scope.toJson(), 'module': 'profile',
        'items': matches ? [item] : <Object?>[], 'lanes': <Object?>[], 'offset': 0,
        'total': matches ? 1 : 0, 'partial': false}, scope, 'profile').toJson();
    } on WorkFailure {
      rethrow;
    } catch (_) {
      _check();
      throw const WorkFailure('error', 502);
    }
  }

  @override
  Future<WorkReceipt> mutate(WorkCommand command, String requestId) async {
    throw const WorkFailure('denied', 403);
  }
  @override
  Future<Object?> readItem(String id) async { throw const WorkFailure('denied', 403); }
  @override
  void dispose() { if (_dead) return; _dead = true; if (_owned) _client.close(); }
}
