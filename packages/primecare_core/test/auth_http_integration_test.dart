import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class IntegrationAuth extends BaseAuthWorkflow {
  IntegrationAuth(super.transport);
}

void main() {
  test(
    'real HTTP gateway login, session and server revocation',
    () async {
      final root = Directory('../..').absolute;
      final temporary = await Directory.systemTemp.createTemp(
        'primecare-auth-tls-',
      );
      Process? server;
      IOClient? client;
      try {
        final key = '${temporary.path}/key.pem',
            cert = '${temporary.path}/cert.pem';
        final generated = await Process.run('openssl', [
          'req',
          '-x509',
          '-newkey',
          'rsa:2048',
          '-nodes',
          '-keyout',
          key,
          '-out',
          cert,
          '-days',
          '1',
          '-subj',
          '/CN=localhost',
        ]);
        expect(
          generated.exitCode,
          0,
          reason: 'Generate disposable loopback certificate',
        );
        server = await Process.start('node', [
          'scripts/auth-http-integration-fixture.mjs',
          key,
          cert,
        ], workingDirectory: root.path);
        final errors = StringBuffer();
        server.stderr.transform(utf8.decoder).listen(errors.write);
        final line = await server.stdout
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .first
            .timeout(const Duration(seconds: 20));
        final port = (jsonDecode(line) as Map<String, dynamic>)['port'];
        final socket = HttpClient();
        // Trust only this disposable loopback server, never a production host.
        socket.badCertificateCallback = (certificate, host, requestPort) =>
            host == '127.0.0.1' && requestPort == port;
        client = IOClient(socket);
        final transport = HttpAuthTransport(
          'https://127.0.0.1:$port/v1/auth',
          client,
        );
        final auth = IntegrationAuth(transport);
        await expectLater(
          auth.login('integration@example.invalid', 'wrong-password'),
          throwsA(isA<AuthFailure>().having((e) => e.status, 'status', 401)),
        );
        await auth.login('integration@example.invalid', 'integration-password');
        expect(auth.session!.userId, 'integration-user');
        expect(auth.session!.role, 'client');
        await auth.refreshSession();
        expect(auth.session!.userId, 'integration-user');
        // Capture a second token to demonstrate revocation at the actual handler.
        final login = await transport.send(
          'POST',
          '/login',
          body: {
            'email': 'integration@example.invalid',
            'password': 'integration-password',
          },
        );
        final token = login['token'] as String;
        await transport.send('POST', '/logout', token: token);
        await expectLater(
          transport.send('GET', '/me', token: token),
          throwsA(isA<AuthFailure>().having((e) => e.status, 'status', 401)),
        );
        await auth.logout();
        expect(auth.session, isNull);
        await expectLater(
          transport.send('GET', '/me'),
          throwsA(isA<AuthFailure>().having((e) => e.status, 'status', 401)),
        );
      } finally {
        client?.close();
        if (server != null) {
          server.kill();
          await server.exitCode;
        }
        await temporary.delete(recursive: true);
      }
    },
    skip: Platform.environment['AUTH_HTTP_INTEGRATION'] != '1',
    timeout: const Timeout(Duration(seconds: 45)),
  );
}
