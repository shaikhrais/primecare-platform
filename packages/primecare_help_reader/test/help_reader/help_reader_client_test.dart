import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:primecare_help_reader/primecare_help_reader.dart';
import 'package:primecare_preferences/preference_sync/preference_protocol.dart';

class _DeniedClient extends http.BaseClient {
  final void Function() retire;
  final Completer<void> cancellation = Completer<void>();
  int requests = 0;
  int cancellations = 0;
  int closes = 0;
  _DeniedClient(this.retire);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    requests++;
    if (requests == 1) {
      return http.StreamedResponse(Stream.value(utf8.encode(jsonEncode({
        'status': 'authenticated', 'userId': 'psw-a',
        'tenantId': 'tenant-a', 'roles': 'psw',
      }))), 200, headers: {'content-type': 'application/json'});
    }
    final body = StreamController<List<int>>(onCancel: () {
      cancellations++;
      retire();
      return cancellation.future;
    });
    return http.StreamedResponse(body.stream, 403,
      headers: {'content-type': 'application/json'});
  }

  @override
  void close() { closes++; }
}

void main() {
  for (final dispose in [false, true]) {
    test('denied-body cancellation retires read after ${dispose ? 'dispose' : 'cancelPending'}', () async {
      late HelpReaderClient reader;
      final transport = _DeniedClient(() {
        if (dispose) { reader.dispose(); } else { reader.cancelPending(); }
      });
      final scope = PreferenceScope('tenant-a', 'psw-a', 'psw', 'live');
      reader = HelpReaderClient(origin: Uri.parse('https://help.example'),
        token: List.filled(43, 't').join(), scope: scope,
        currentToken: () => List.filled(43, 't').join(),
        currentScope: () => scope, client: transport);
      try {
        await expectLater(reader.list(locale: 'en'), throwsA(
          isA<HelpReaderFailure>()
            .having((error) => error.code, 'code', 'conflict')
            .having((error) => error.status, 'status', 409)));
        expect(transport.requests, 2);
        expect(transport.cancellations, 1);
        expect(transport.cancellation.isCompleted, isFalse);
        expect(transport.closes, 0);
      } finally {
        transport.cancellation.complete();
        reader.dispose();
        expect(transport.closes, 0);
        transport.close();
      }
    });
  }
}
