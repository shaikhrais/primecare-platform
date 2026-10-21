import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/auth/password_recovery_form.dart';
import 'package:primecare_ui/src/localization/auth_screen_text_generated.dart';
import 'auth_design_test.dart' show localized;

class RecoveryApi extends Fake implements ApiClient {
  dynamic payload;
  int status = 200;
  bool offline = false;
  final requests = <Map<String, dynamic>>[];
  @override
  Future<ApiResponse> post(String path, {dynamic body, Map<String, String>? headers}) async {
    requests.add({'path': path, 'body': body});
    if (offline) throw StateError('fixture transport failure');
    return ApiResponse(statusCode: status, data: payload);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  for (final language in ['en', 'fr', 'es']) {
    for (final reset in [false, true]) {
      testWidgets('recovery reset=$reset validates response and retries in $language', (tester) async {
        SharedPreferences.setMockInitialValues({});
        final api = RecoveryApi();
        final text = passwordRecoveryScreenCatalog[language]!;
        await tester.pumpWidget(ProviderScope(overrides: [
          apiClientProvider.overrideWithValue(api),
        ], child: localized(Scaffold(body: SingleChildScrollView(
          child: PasswordRecoveryForm(reset: reset),
        )), language: language)));
        await tester.pumpAndSettle();
        final fields = find.byType(TextField);
        await tester.enterText(fields.first, 'QA@example.test');
        if (reset) {
          await tester.enterText(fields.at(1), 'abcdef123456');
          await tester.enterText(fields.at(2), 'fixture-password-123');
          await tester.enterText(fields.at(3), 'fixture-password-123');
        }
        Future<void> submit() async {
          await tester.ensureVisible(find.byType(FilledButton));
          await tester.tap(find.byType(FilledButton));
          await tester.pumpAndSettle();
        }
        final success = text[reset ? 'reset_success' : 'forgot_success']!;
        for (final payload in <dynamic>[
          null, [], 'invalid', {}, {'message': 7},
          {'status': 'password_reset'},
          {'status': 'password_reset', 'reauthenticationRequired': 'true'},
          {'status': 'password_reset', 'reauthenticationRequired': false},
          reset
              ? {'message': 'If an active account matches, recovery instructions will be emailed. Check your inbox and spam folder.'}
              : {'status': 'password_reset', 'reauthenticationRequired': true},
        ]) {
          api.payload = payload;
          await submit();
          expect(find.text(success), findsNothing);
          expect(find.text(text['request_failed']!), findsOneWidget);
          if (reset) expect(tester.widget<TextField>(fields.at(2)).controller!.text, 'fixture-password-123');
        }
        api.offline = true;
        await submit();
        expect(find.text(text['connection_error']!), findsOneWidget);
        api.offline = false;
        api.payload = reset
            ? {'status': 'password_reset', 'reauthenticationRequired': true}
            : {'message': 'If an active account matches, recovery instructions will be emailed. Check your inbox and spam folder.'};
        api.status = 503;
        await submit();
        expect(find.text(success), findsNothing);
        api.status = 200;
        await submit();
        expect(find.text(success), findsOneWidget);
        expect(api.requests.last['path'], ApiConfig.endpoints[reset ? 'resetPassword' : 'forgotPassword']);
        final body = api.requests.last['body'] as Map<String, dynamic>;
        expect(body['email'], 'qa@example.test');
        if (reset) {
          expect(body['code'], 'ABCDEF123456');
          expect(body['newPassword'], 'fixture-password-123');
          for (var index = 1; index < 4; index++) {
            expect(tester.widget<TextField>(fields.at(index)).controller!.text, isEmpty);
          }
        }
        await tester.pump();
        expect(find.text(success), findsOneWidget);
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
      });
    }
  }
}
