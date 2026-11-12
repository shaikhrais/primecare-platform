import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../preference_sync/preference_protocol.dart' show PreferenceScope;

class DashboardReadFailure implements Exception {
  final String code;
  const DashboardReadFailure(this.code);
}

/// Optional API16578 reader. Reuses the host's captured token/context, never login or grants.
class DashboardPageTransport {
  final PreferenceScope scope;
  final String _token;
  final String? Function() currentToken;
  final PreferenceScope? Function() currentScope;
  final http.Client _client;
  final bool _owned;
  final Uri _url;
  final int maxBytes;
  bool _dead = false;
  DashboardPageTransport({required Uri origin, required String token, required this.scope,
    required this.currentToken, required this.currentScope, required this.maxBytes, http.Client? client})
      : _token = token, _client = client ?? http.Client(), _owned = client == null,
        _url = origin.resolve('/v1/governance/tenant-dashboard').replace(queryParameters: {'dataset': scope.dataset}) {
    if (origin.host.isEmpty || origin.userInfo.isNotEmpty || origin.hasQuery || origin.hasFragment ||
        (origin.path.isNotEmpty && origin.path != '/') ||
        !(origin.scheme == 'https' || origin.scheme == 'http' && ['localhost', '127.0.0.1'].contains(origin.host)) ||
        token.trim().isEmpty || RegExp(r'[\r\n]').hasMatch(token) || maxBytes < 1 || maxBytes > 1048576) {
      if (_owned) _client.close();
      throw const DashboardReadFailure('invalid');
    }
  }
  void _guard() {
    if (_dead) throw const DashboardReadFailure('unavailable');
    final now = currentScope();
    if (currentToken() != _token || now == null || !now.same(scope)) throw const DashboardReadFailure('denied');
  }
  Future<Object?> read() async {
    _guard();
    final request = http.Request('GET', _url)..followRedirects = false
      ..headers.addAll({'authorization': 'Bearer $_token', 'cache-control': 'no-store'});
    final response = await _client.send(request);
    _guard();
    if (response.statusCode == 401 || response.statusCode == 403) throw const DashboardReadFailure('denied');
    if (response.statusCode != 200) throw const DashboardReadFailure('error');
    final bytes = <int>[];
    await for (final chunk in response.stream) {
      _guard();
      if (bytes.length + chunk.length > maxBytes) throw const DashboardReadFailure('invalid');
      bytes.addAll(chunk);
    }
    _guard();
    final Object? raw = jsonDecode(utf8.decode(bytes));
    _guard();
    return raw;
  }
  void dispose() {
    if (_dead) return;
    _dead = true;
    if (_owned) _client.close();
  }
}

/// Shared lifecycle for metric and record projections. Hosts explicitly invalidate on context change.
class DashboardReadSession<P> extends ChangeNotifier {
  final DashboardPageTransport transport;
  final P Function(Object?) project;
  final String Function(P) projectionStatus;
  P? _projection;
  String _status = 'idle';
  int _generation = 0;
  bool _dead = false;
  DashboardReadSession({required this.transport, required this.project, required this.projectionStatus});
  P? get projection => _projection;
  String get status => _status;
  void invalidate() {
    if (_dead) return;
    _generation++;
    _projection = null;
    _status = 'denied';
    notifyListeners();
  }
  Future<void> load() async {
    if (_dead) return;
    final generation = ++_generation;
    _projection = null;
    _status = 'loading';
    notifyListeners();
    try {
      if (_dead || generation != _generation) return;
      final raw = await transport.read();
      if (_dead || generation != _generation) return;
      transport._guard();
      if (_dead || generation != _generation) return;
      final next = project(raw);
      if (_dead || generation != _generation) return;
      final nextStatus = projectionStatus(next);
      if (_dead || generation != _generation) return;
      transport._guard();
      if (_dead || generation != _generation) return;
      _projection = next;
      _status = nextStatus;
    } catch (error) {
      if (_dead || generation != _generation) return;
      Object failure = error;
      try { transport._guard(); } catch (contextError) { failure = contextError; }
      if (_dead || generation != _generation) return;
      _projection = null;
      _status = failure is DashboardReadFailure ? failure.code : 'error';
    }
    notifyListeners();
  }
  @override void dispose() {
    if (_dead) return;
    _dead = true;
    _generation++;
    _projection = null;
    _status = 'disposed';
    transport.dispose();
    super.dispose();
  }
}
