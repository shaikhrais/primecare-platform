import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_preferences/preference_sync/preference_protocol.dart' show PreferenceScope;

class HelpReaderFailure implements Exception {
  final String code;
  final int status;
  const HelpReaderFailure(this.code, this.status);
  static HelpReaderFailure sanitize(Object? error) {
    const statuses = {'invalid_request': 400, 'unauthenticated': 401,
      'forbidden': 403, 'not_found': 404, 'conflict': 409,
      'rate_limited': 429, 'unavailable': 503};
    if (error is HelpReaderFailure) {
      try {
        final code = error.code, status = error.status;
        if (statuses[code] == status) return HelpReaderFailure(code, status);
      } catch (_) { /* A hostile subclass cannot supply safe public metadata. */ }
    }
    return const HelpReaderFailure('unavailable', 503);
  }
  @override
  String toString() => code;
}

/// Unmounted API794 reader. This client grants no screen or runtime authority.
/// Its registered host must cancel pending reads on navigation/session change.
class HelpReaderClient {
  final Uri _origin;
  final String _token;
  final PreferenceScope scope;
  final String? Function() currentToken;
  final PreferenceScope? Function() currentScope;
  final http.Client _client;
  final bool _owned;
  Completer<void>? _pending;
  bool _disposed = false;

  HelpReaderClient({required Uri origin, required String token,
    required this.scope, required this.currentToken, required this.currentScope,
    http.Client? client})
      : _origin = origin, _token = token,
        _client = client ?? http.Client(), _owned = client == null {
    if (origin.scheme != 'https' || origin.host.isEmpty ||
        origin.userInfo.isNotEmpty || origin.hasQuery || origin.hasFragment ||
        (origin.path.isNotEmpty && origin.path != '/') ||
        !RegExp(r'^[A-Za-z0-9_-]{43}$').hasMatch(token) ||
        scope.role != 'psw' || scope.dataset != 'live' ||
        !_id(scope.tenantId) || !_id(scope.userId)) {
      if (_owned) _client.close();
      throw const HelpReaderFailure('invalid_request', 400);
    }
  }

  Future<Map<String, Object?>> list({required String locale,
    String query = '', int offset = 0, int limit = 25}) {
    if (!_locale(locale) || !_text(query, 0, 100) ||
        offset < 0 || offset > 100000 || limit < 1 || limit > 100) {
      throw const HelpReaderFailure('invalid_request', 400);
    }
    return _read({'version': 1, 'action': 'list', 'locale': locale,
      'query': query, 'offset': offset, 'limit': limit});
  }

  Future<Map<String, Object?>> readArticle({required String locale,
    required String articleId}) {
    if (!_locale(locale) || !_id(articleId)) {
      throw const HelpReaderFailure('invalid_request', 400);
    }
    return _read({'version': 1, 'action': 'read', 'locale': locale,
      'articleId': articleId});
  }

  void _check(Completer<void> operation) {
    if (_disposed || operation.isCompleted || !identical(_pending, operation)) {
      throw const HelpReaderFailure('conflict', 409);
    }
    var matches = false;
    try {
      final active = currentScope();
      matches = currentToken() == _token && active != null && active.same(scope);
    } catch (_) { /* A failed host callback is never authority. */ }
    if (_disposed || operation.isCompleted || !identical(_pending, operation) || !matches) {
      throw const HelpReaderFailure('conflict', 409);
    }
  }

  Future<Map<String, Object?>> _read(Map<String, Object> request) async {
    if (_disposed) throw const HelpReaderFailure('conflict', 409);
    cancelPending();
    final operation = Completer<void>();
    _pending = operation;
    try {
      _check(operation);
      await _identity(operation);
      final raw = await _json('/v1/psw/help-support', operation,
        request: request, maxBytes: 1048576);
      _check(operation);
      final result = _reply(raw, request);
      await _identity(operation);
      _check(operation);
      return result;
    } on HelpReaderFailure catch (failure) {
      _check(operation);
      throw HelpReaderFailure.sanitize(failure);
    } catch (_) {
      _check(operation);
      throw const HelpReaderFailure('unavailable', 503);
    } finally {
      if (!operation.isCompleted) operation.complete();
      if (identical(_pending, operation)) _pending = null;
    }
  }

  Future<void> _identity(Completer<void> operation) async {
    final raw = await _json('/v1/auth/me', operation);
    _check(operation);
    if (raw is! Map || raw['status'] != 'authenticated' ||
        raw['userId'] != scope.userId || raw['tenantId'] != scope.tenantId ||
        raw['roles'] != scope.role) {
      throw const HelpReaderFailure('conflict', 409);
    }
  }

  void _discard(http.StreamedResponse response) {
    try { unawaited(response.stream.listen(null).cancel().catchError((Object _) {})); }
    catch (_) { /* A retired body cannot delay denial or expose diagnostics. */ }
  }

  Future<Object?> _json(String path, Completer<void> operation,
      {Map<String, Object>? request, int maxBytes = 65536}) async {
    _check(operation);
    final outgoing = http.AbortableRequest(request == null ? 'GET' : 'POST',
      _origin.resolve(path), abortTrigger: operation.future)
      ..followRedirects = false
      ..headers.addAll({'authorization': 'Bearer $_token',
        'accept': 'application/json', 'cache-control': 'no-store'});
    if (request != null) {
      outgoing.headers['content-type'] = 'application/json';
      outgoing.body = jsonEncode(request);
    }
    final headers = Completer<http.StreamedResponse>();
    unawaited(operation.future.then((_) {
      if (!headers.isCompleted) headers.completeError(const HelpReaderFailure('conflict', 409));
    }));
    try {
      final pendingHeaders = _client.send(outgoing);
      unawaited(pendingHeaders.then((response) {
        if (headers.isCompleted) { _discard(response); return; }
        headers.complete(response);
      }, onError: (Object error, StackTrace stack) {
        if (!headers.isCompleted) headers.completeError(error, stack);
      }));
    } catch (error, stack) {
      if (!headers.isCompleted) headers.completeError(error, stack);
    }
    final response = await headers.future;
    StreamSubscription<List<int>>? subscription;
    try {
      _check(operation);
      if (response.statusCode != 200) {
        const failures = {401: 'unauthenticated', 403: 'forbidden',
          404: 'not_found', 409: 'conflict', 429: 'rate_limited'};
        throw HelpReaderFailure(failures[response.statusCode] ?? 'unavailable',
          failures.containsKey(response.statusCode) ? response.statusCode : 503);
      }
      if (response.headers['content-type']?.split(';').first.trim().toLowerCase() != 'application/json' ||
          response.contentLength != null && response.contentLength! > maxBytes) {
        throw const HelpReaderFailure('unavailable', 503);
      }
      final bytes = <int>[];
      final body = Completer<List<int>>();
      subscription = response.stream.listen((chunk) {
        if (body.isCompleted) return;
        try {
          _check(operation);
          if (bytes.length + chunk.length > maxBytes) {
            throw const HelpReaderFailure('unavailable', 503);
          }
          bytes.addAll(chunk);
        } catch (error, stack) { body.completeError(error, stack); }
      }, onError: (Object error, StackTrace stack) {
        if (!body.isCompleted) body.completeError(error, stack);
      }, onDone: () { if (!body.isCompleted) body.complete(bytes); });
      final payload = await Future.any<List<int>>([body.future,
        operation.future.then<List<int>>((_) => throw const HelpReaderFailure('conflict', 409))]);
      _check(operation);
      final raw = jsonDecode(utf8.decode(payload));
      _check(operation);
      return raw;
    } finally {
      final owned = subscription;
      if (owned == null) { _discard(response); }
      else { try { unawaited(owned.cancel().catchError((Object _) {})); } catch (_) {} }
    }
  }

  Map<String, Object?> _reply(Object? value, Map<String, Object> request) {
    final action = request['action'];
    final raw = _object(value, action == 'read'
      ? ['version', 'locale', 'action', 'scope', 'article']
      : ['version', 'locale', 'action', 'scope', 'items', 'offset', 'limit', 'total']);
    if (raw['version'] != 1 || raw['locale'] != request['locale'] || raw['action'] != action) {
      throw const HelpReaderFailure('unavailable', 503);
    }
    final actor = _object(raw['scope'], ['tenantId', 'userId', 'role', 'dataset']);
    if (actor['tenantId'] != scope.tenantId || actor['userId'] != scope.userId ||
        actor['role'] != scope.role || actor['dataset'] != scope.dataset) {
      throw const HelpReaderFailure('conflict', 409);
    }
    final result = <String, Object?>{...raw, 'scope': Map<String, Object?>.unmodifiable(actor)};
    if (action == 'read') {
      final article = _article(raw['article'], true);
      if (article['id'] != request['articleId']) throw const HelpReaderFailure('unavailable', 503);
      result['article'] = article;
    } else {
      final items = raw['items'], total = raw['total'];
      final offset = request['offset'] as int, limit = request['limit'] as int;
      if (raw['offset'] != offset || raw['limit'] != limit || !_integer(total, 0, 9007199254740991) ||
          items is! List || items.length > limit || items.length > (total as int) - offset && items.isNotEmpty) {
        throw const HelpReaderFailure('unavailable', 503);
      }
      final projected = items.map((item) => _article(item, false)).toList();
      if (projected.map((item) => item['id']).toSet().length != projected.length) {
        throw const HelpReaderFailure('unavailable', 503);
      }
      result['items'] = List<Map<String, Object?>>.unmodifiable(projected);
    }
    return Map<String, Object?>.unmodifiable(result);
  }

  static Map<String, Object?> _article(Object? value, bool detail) {
    final textField = detail ? 'body' : 'summary';
    final raw = _object(value, ['id', 'revision', 'title', 'category', textField]);
    if (!_id(raw['id']) || !_integer(raw['revision'], 1, 9007199254740991) ||
        !_text(raw['title'], 1, 500) || !_text(raw['category'], 1, 100) ||
        !_text(raw[textField], detail ? 1 : 0, detail ? 5000 : 1000)) {
      throw const HelpReaderFailure('unavailable', 503);
    }
    return Map<String, Object?>.unmodifiable(raw);
  }

  static Map<String, Object?> _object(Object? value, List<String> keys) {
    if (value is! Map || value.length != keys.length || keys.any((key) => !value.containsKey(key)) ||
        value.keys.any((key) => key is! String)) throw const HelpReaderFailure('unavailable', 503);
    return Map<String, Object?>.from(value);
  }
  static bool _id(Object? value) => value is String && RegExp(r'^[A-Za-z0-9][A-Za-z0-9._:-]{0,199}$').hasMatch(value);
  static bool _locale(String value) => const ['en', 'fr', 'es'].contains(value);
  static bool _integer(Object? value, int min, int max) => value is int && value >= min && value <= max;
  static bool _text(Object? value, int min, int max) => value is String && value.length >= min &&
    value.length <= max && (min == 0 || value.trim().isNotEmpty) &&
    !RegExp(r'[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]').hasMatch(value);

  void cancelPending() {
    final operation = _pending;
    _pending = null;
    if (operation != null && !operation.isCompleted) operation.complete();
  }
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    cancelPending();
    if (_owned) _client.close();
  }
}
