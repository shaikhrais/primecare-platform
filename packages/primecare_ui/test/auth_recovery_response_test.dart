import 'dart:async';
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
  Completer<ApiResponse>? pending;
  final requests = <Map<String, dynamic>>[];
  @override
  Future<ApiResponse> post(String path, {dynamic body, Map<String, String>? headers}) async {
    requests.add({'path': path, 'body': body});
    if (offline) throw StateError('fixture transport failure');
    if (pending != null) return pending!.future;
    return ApiResponse(statusCode: status, data: payload);
  }
}

class RecoveryAuth extends AuthNotifier {
  int logoutCalls = 0;
  @override
  AuthState build() => AuthState(isInitialized: true, isAuthenticated: true,
      token: 'fixture-token', userId: 'fixture-user', role: 'rmt');
  void replaceSession() {
    state = AuthState(isInitialized: true, isAuthenticated: true,
        token: 'replacement-token', userId: 'replacement-user', role: 'rmt');
  }
  @override
  Future<void> logout() async {
    logoutCalls++;
    state = AuthState(isInitialized: true);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  testWidgets('confirmed reset preserves a newer browser session', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final api = RecoveryApi()..pending = Completer<ApiResponse>();
    final auth = RecoveryAuth();
    await tester.pumpWidget(ProviderScope(overrides: [
      apiClientProvider.overrideWithValue(api), authProvider.overrideWith(() => auth),
    ], child: localized(const Scaffold(body: SingleChildScrollView(
      child: PasswordRecoveryForm(reset: true),
    )))));
    await tester.pumpAndSettle();
    final fields = find.byType(TextField);
    for (final entry in <int, String>{0: 'qa@example.test', 1: 'ABCDEF123456',
      2: 'fixture-password-123', 3: 'fixture-password-123'}.entries) {
      await tester.enterText(fields.at(entry.key), entry.value);
    }
    await tester.ensureVisible(find.byType(FilledButton));
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    expect(api.requests.length, 1);
    auth.replaceSession();
    api.pending!.complete(ApiResponse(statusCode: 200, data: {
      'status': 'password_reset', 'reauthenticationRequired': true,
    }));
    await tester.pumpAndSettle();
    expect(auth.logoutCalls, 0);
    final current = ProviderScope.containerOf(tester.element(find.byType(PasswordRecoveryForm))).read(authProvider);
    expect(current.token, 'replacement-token');
    expect(current.userId, 'replacement-user');
    expect(tester.widget<TextField>(fields.at(2)).controller!.text, isEmpty);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  for (final language in ['en', 'fr', 'es']) {
    for (final reset in [false, true]) {
      testWidgets('recovery reset=$reset validates response and retries in $language', (tester) async {
        SharedPreferences.setMockInitialValues({});
        final api = RecoveryApi();
        final auth = RecoveryAuth();
        final text = passwordRecoveryScreenCatalog[language]!;
        await tester.pumpWidget(ProviderScope(overrides: [
          apiClientProvider.overrideWithValue(api),
          authProvider.overrideWith(() => auth),
        ], child: localized(Scaffold(body: SingleChildScrollView(
          child: PasswordRecoveryForm(reset: reset),
        )), language: language)));
        await tester.pumpAndSettle();
        final fields = find.byType(TextField);
        // Identifiers and recovery secrets must not be changed by keyboards.
        final inputs = tester.widgetList<TextField>(fields).toList();
        for (final field in inputs) {
          expect(field.autocorrect, isFalse);
          expect(field.enableSuggestions, isFalse);
        }
        if (reset) {
          for (final field in inputs.skip(1)) {
            expect(field.enableIMEPersonalizedLearning, isFalse);
          }
        }
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
          expect(auth.logoutCalls, 0);
          expect(find.text(text['request_failed']!), findsOneWidget);
          if (reset) {
            expect(tester.widget<TextField>(fields.at(2)).controller!.text, 'fixture-password-123');
            expect(find.byKey(const ValueKey('recovery-code-0')), findsOneWidget);
          }
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
        expect(auth.logoutCalls, reset ? 1 : 0);
        expect(ProviderScope.containerOf(tester.element(find.byType(PasswordRecoveryForm))).read(authProvider).isAuthenticated, !reset);
        expect(api.requests.last['path'], ApiConfig.endpoints[reset ? 'resetPassword' : 'forgotPassword']);
        final body = api.requests.last['body'] as Map<String, dynamic>;
        expect(body['email'], 'qa@example.test');
        if (reset) {
          expect(find.byKey(const ValueKey('recovery-code-0')), findsNothing);
          for (final id in ['recovery-code', 'recovery-password', 'recovery-confirm']) {
            expect(find.byKey(ValueKey('$id-1')), findsOneWidget);
          }
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
