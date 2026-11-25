import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:primecare_help_reader/help_reader/help_reader_client.dart';
import 'package:primecare_help_reader/help_reader/help_reader_controller.dart';
import 'package:primecare_preferences/preference_sync/preference_protocol.dart';

final _scope = PreferenceScope('tenant-a', 'psw-a', 'psw', 'live');
final _token = List.filled(43, 'a').join();

class _PrivateFailure extends HelpReaderFailure {
  final String privateDetail = 'PRIVATE database credential';
  const _PrivateFailure() : super('unavailable', 503);
  @override
  String toString() => privateDetail;
}

class _ReentrantFailure extends HelpReaderFailure {
  final void Function() onRead;
  _ReentrantFailure(this.onRead) : super('unavailable', 503);
  @override
  String get code { onRead(); return 'unavailable'; }
}

/// Synthetic transport only: no grant, role, source or live activation evidence.
class _HelpWire extends http.BaseClient {
  final requests = <http.BaseRequest>[];
  final queries = <String>[];
  bool closed = false, failFirstHelp = false;
  int identities = 0;
  void Function()? onFinalIdentityDone, onHelpFailure;

  http.StreamedResponse _json(Object value, {void Function()? onDone}) {
    final bytes = utf8.encode(jsonEncode(value));
    final stream = Stream<List<int>>.value(bytes).transform(
      StreamTransformer<List<int>, List<int>>.fromHandlers(handleDone: (sink) {
        onDone?.call();
        sink.close();
      }));
    return http.StreamedResponse(stream, 200,
      headers: {'content-type': 'application/json'});
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    requests.add(request);
    if (request.url.path == '/v1/auth/me') {
      identities++;
      return _json({'status': 'authenticated', 'userId': _scope.userId,
        'tenantId': _scope.tenantId, 'roles': _scope.role},
        onDone: identities == 2 ? onFinalIdentityDone : null);
    }
    expect(request.url.path, '/v1/psw/help-support');
    final command = jsonDecode((request as http.Request).body) as Map;
    queries.add(command['query'] as String);
    if (failFirstHelp) {
      failFirstHelp = false;
      onHelpFailure?.call();
      throw StateError('PRIVATE transport failure');
    }
    return _json({'version': 1, 'action': 'list', 'locale': command['locale'],
      'scope': _scope.toJson(), 'offset': command['offset'],
      'limit': command['limit'], 'total': 1,
      'items': [{'id': 'guide', 'revision': 1, 'title': command['query'] == ''
        ? 'Published guide' : command['query'],
        'category': 'general', 'summary': 'Approved fixture guide'}]});
  }

  @override
  void close() { closed = true; }
}

HelpReaderController _controller(_HelpWire wire,
    {PreferenceScope? Function()? currentScope, String? Function()? currentToken}) =>
  HelpReaderController(origin: Uri.parse('https://help.example.test'),
    token: _token, scope: _scope, currentToken: currentToken ?? () => _token,
    currentScope: currentScope ?? () => _scope, client: wire);

Future<void> _settle(Future<void> operation) => operation.timeout(const Duration(seconds: 2));

void _expectReplacement(HelpReaderController controller, _HelpWire wire) {
  expect(controller.state.phase, 'list');
  expect(controller.state.query, 'replacement');
  expect(controller.state.items.single['title'], 'replacement');
  expect(controller.state.failure, isNull);
  expect(controller.canRetry, isFalse);
  controller.dispose();
  expect(controller.state.phase, 'disposed');
  expect(controller.state.items, isEmpty);
  expect(wire.closed, isFalse);
  wire.close();
}

void main() {
  test('sanitization returns a fresh base failure without subclass private state', () {
    const privateFailure = _PrivateFailure();
    final safe = HelpReaderFailure.sanitize(privateFailure);
    expect(identical(safe, privateFailure), isFalse);
    expect(safe.runtimeType, HelpReaderFailure);
    expect(safe.code, 'unavailable');
    expect(safe.status, 503);
    expect(safe.toString(), 'unavailable');
    expect(safe.toString(), isNot(contains('PRIVATE')));
    final base = HelpReaderFailure.sanitize(const HelpReaderFailure('forbidden', 403));
    expect(base.code, 'forbidden');
    expect(base.status, 403);
    final malformed = HelpReaderFailure.sanitize(const HelpReaderFailure('forbidden', 503));
    expect(malformed.code, 'unavailable');
    expect(malformed.status, 503);
  });

  test('initial scope callback replacement is not retired by the abandoned request', () async {
    final wire = _HelpWire();
    late HelpReaderController controller;
    Future<void>? replacement;
    var replace = true;
    controller = _controller(wire, currentScope: () {
      if (replace) {
        replace = false;
        replacement = controller.search('replacement');
        return null;
      }
      return _scope;
    });
    await _settle(controller.load());
    expect(replacement, isNotNull);
    await _settle(replacement!);
    expect(wire.queries, ['replacement']);
    _expectReplacement(controller, wire);
  });

  test('final session check cannot retire or overwrite a callback replacement', () async {
    final wire = _HelpWire();
    late HelpReaderController controller;
    Future<void>? replacement;
    var afterFinalBody = false, callbacksAfterBody = 0, replaced = false;
    wire.onFinalIdentityDone = () { afterFinalBody = true; };
    controller = _controller(wire, currentScope: () {
      // After the final identity body, the client checks ownership four times:
      // twice during JSON parsing, once in identity, once before returning.
      // The next public callback belongs to the controller's success check.
      if (afterFinalBody && !replaced && ++callbacksAfterBody == 5) {
        replaced = true;
        replacement = controller.search('replacement');
        return null;
      }
      return _scope;
    });
    await _settle(controller.load());
    expect(replaced, isTrue);
    await _settle(replacement!);
    expect(wire.queries, ['', 'replacement']);
    _expectReplacement(controller, wire);
  });

  test('error session check cannot retire or install retry state over a replacement', () async {
    final wire = _HelpWire()..failFirstHelp = true;
    late HelpReaderController controller;
    Future<void>? replacement;
    var failed = false, callbacksAfterFailure = 0, replaced = false;
    wire.onHelpFailure = () { failed = true; };
    controller = _controller(wire, currentScope: () {
      // The client checks ownership once while sanitizing the transport error;
      // the next callback belongs to the controller's error handler.
      if (failed && !replaced && ++callbacksAfterFailure == 2) {
        replaced = true;
        replacement = controller.search('replacement');
        return null;
      }
      return _scope;
    });
    await _settle(controller.load());
    expect(replaced, isTrue);
    await _settle(replacement!);
    expect(wire.queries, ['', 'replacement']);
    _expectReplacement(controller, wire);
  });

  test('session observer preserves a new request created by its scope callback', () async {
    final wire = _HelpWire();
    late HelpReaderController controller;
    Future<void>? replacement;
    var replace = false;
    controller = _controller(wire, currentScope: () {
      if (replace) {
        replace = false;
        replacement = controller.search('replacement');
        return null;
      }
      return _scope;
    });
    replace = true;
    controller.sessionChanged();
    expect(replacement, isNotNull);
    await _settle(replacement!);
    _expectReplacement(controller, wire);
  });

  test('retirement failure projection cannot overwrite a reentrant disposal', () {
    final wire = _HelpWire(), controller = _controller(wire);
    controller.retire(failure: _ReentrantFailure(controller.dispose));
    expect(controller.state.phase, 'disposed');
    expect(controller.state.failure, isNull);
    expect(controller.state.items, isEmpty);
    expect(controller.canRetry, isFalse);
    expect(wire.closed, isFalse);
    wire.close();
  });
}
