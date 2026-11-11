import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/auth/auth_experience.dart';
import 'auth_design_test.dart' show TestTranslations;

// Real app resources, real LoginController, and real AuthNotifier. Only transport
// and platform persistence are isolated. No copied translation map is a fixture.
const apps = ['clinic', 'governance', 'business_development', 'marketing',
  'corporate', 'client', 'support', 'franchise'];
const locales = ['en', 'fr', 'es'];
const oldEmpty = 'Please enter both credentials.';
const oldFailure = 'Authentication failed. Please verify your credentials.';

String resource(String app, String locale, String key) {
  final document = jsonDecode(File(
    '../../apps/primecare_$app/assets/translations/$locale.json',
  ).readAsStringSync()) as Map<String, dynamic>;
  return (document['auth'] as Map<String, dynamic>)[key] as String;
}

class LoginApi extends Fake implements ApiClient {
  ApiResponse response = ApiResponse(statusCode: 401, data: {'error': 'fixture rejection'});
  bool offline = false;
  Completer<ApiResponse>? pending;
  final requests = <Map<String, dynamic>>[];
  final revoked = <String>[];

  @override
  Future<ApiResponse> post(String path, {dynamic body, Map<String, String>? headers}) async {
    requests.add({'path': path, 'body': body});
    if (offline) throw StateError('fixture transport exception');
    return pending == null ? response : await pending!.future;
  }

  @override
  Future<ApiResponse> revokeSession(String token) async {
    revoked.add(token);
    return ApiResponse(statusCode: 200, data: <String, dynamic>{});
  }
}

// This deliberately throwing notifier exercises only the controller catch path.
// Real transport exceptions are tested above through the unmodified notifier.
class ThrowingLoginAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true);

  @override
  Future<bool> login(String email, String password, {MfaPrompt? completeMfa}) async {
    throw StateError('synthetic notifier throw');
  }
}

class LoginFixture {
  LoginFixture(this.container, this.api, this.prefs);
  final ProviderContainer container;
  final LoginApi api;
  final SharedPreferences prefs;
  LoginController get controller => container.read(loginControllerProvider.notifier);
  LoginState get state => container.read(loginControllerProvider);
}

Future<LoginFixture> mountLogin(WidgetTester tester, {
  String app = 'clinic', String locale = 'en', LoginApi? api, AuthNotifier? auth,
}) async {
  SharedPreferences.setMockInitialValues({'auth_preferred_language': locale});
  authListenable.value = false;
  final prefs = await SharedPreferences.getInstance();
  final transport = api ?? LoginApi();
  final container = ProviderContainer(overrides: [
    apiClientProvider.overrideWithValue(transport),
    if (auth != null) authProvider.overrideWith(() => auth),
    sharedPreferencesProvider.overrideWithValue(prefs),
  ]);
  addTearDown(container.dispose);
  // Initialize the actual notifier; empty storage must not contact the server.
  container.read(authProvider);
  await tester.pumpWidget(UncontrolledProviderScope(container: container,
    child: EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
      path: '../../apps/primecare_$app/assets/translations',
      assetLoader: const TestTranslations(),
      fallbackLocale: const Locale('en'), startLocale: Locale(locale),
      useOnlyLangCode: true, useFallbackTranslations: true,
      child: Builder(builder: (context) => MaterialApp(
        locale: context.locale, supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        home: LocaleRebuildWrapper(child: PrimeTheme(
          data: const PrimeThemeData(), bootstrap: false,
          child: AppShellBoundary(child: SharedAuthRoutes.managedPage(
            '/login', (_) => const LoginView(),
          )),
        )),
      )),
    ),
  ));
  await tester.pumpAndSettle();
  expect(find.byType(LoginView), findsOneWidget);
  expect(find.byType(PrimeAuthExperience), findsOneWidget);
  expect(container.read(authProvider).isInitialized, isTrue);
  expect(transport.requests, isEmpty);
  expect(tester.takeException(), isNull);
  return LoginFixture(container, transport, prefs);
}

Finder input(String id) => find.descendant(
  of: find.byWidgetPredicate((widget) => widget is PrimeAuthTextField && widget.id == id),
  matching: find.byType(TextFormField),
);
Finder get submitButton => find.byWidgetPredicate(
  (widget) => widget is PrimeButton && widget.dataCy == 'login-submit',
);

Future<void> enterCredentials(WidgetTester tester) async {
  await tester.enterText(input('login-email'), '  fixture@example.test  ');
  await tester.enterText(input('login-password'), 'fixture-password');
}

Future<void> submit(WidgetTester tester) async {
  await tester.ensureVisible(submitButton);
  await tester.tap(submitButton);
  await tester.pumpAndSettle();
}

void expectNotice(WidgetTester tester, String message) {
  expect(find.text(message), findsOneWidget);
  final live = find.ancestor(of: find.text(message), matching:
    find.byWidgetPredicate((widget) => widget is Semantics && widget.properties.liveRegion == true));
  expect(live, findsOneWidget);
  expect(tester.getSemantics(live).getSemanticsData().label, contains(message));
  for (final raw in ['auth.enter_credentials_to_continue', 'auth.authentication_failed', oldEmpty, oldFailure]) {
    expect(find.text(raw), findsNothing);
  }
  expect(tester.takeException(), isNull);
}

void expectGuest(LoginFixture fixture) {
  final auth = fixture.container.read(authProvider);
  expect(auth.isAuthenticated, isFalse);
  expect(auth.token, isNull);
  expect(fixture.prefs.getString('auth_token'), isNull);
  expect(authListenable.value, isFalse);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  for (final app in apps) {
    for (final locale in locales) {
      testWidgets('$app login validates and localizes real bool failures in $locale', (tester) async {
        final semantics = tester.ensureSemantics();
        try {
          final fixture = await mountLogin(tester, app: app, locale: locale);
          final emptyText = resource(app, locale, 'enter_credentials_to_continue');
          final failedText = resource(app, locale, 'authentication_failed');
          expect(emptyText.trim(), isNotEmpty);
          expect(failedText.trim(), isNotEmpty);
          for (final values in [('', ''), ('   ', 'fixture-password'), ('fixture@example.test', '')]) {
            await tester.enterText(input('login-email'), values.$1);
            await tester.enterText(input('login-password'), values.$2);
            await submit(tester);
            expectNotice(tester, emptyText);
            expect(fixture.state.errorReason, LoginErrorReason.missingCredentials);
            expect(fixture.state.errorMessage, oldEmpty);
            expect(fixture.state.isLoading, isFalse);
            expect(fixture.api.requests, isEmpty);
            expectGuest(fixture);
          }
          // Both rejected HTTP and thrown transport become false in AuthNotifier.
          // Neither runs LoginController's separate catch-only branch.
          for (final offline in [false, true]) {
            fixture.api.offline = offline;
            await enterCredentials(tester);
            expect(fixture.state.errorReason, isNull);
            await submit(tester);
            expectNotice(tester, failedText);
            expect(fixture.state.errorReason, LoginErrorReason.authenticationFailed);
            expect(fixture.state.errorMessage, oldFailure);
            expect(fixture.state.password, isEmpty);
            expect(tester.widget<TextFormField>(input('login-password')).controller!.text, isEmpty);
            expect(tester.widget<PrimeButton>(submitButton).isLoading, isFalse);
            expectGuest(fixture);
            expect(fixture.api.requests.last['path'], ApiConfig.endpoints['login']);
            expect(fixture.api.requests.last['body'], {
              'email': 'fixture@example.test', 'password': 'fixture-password',
            });
          }
          expect(fixture.api.requests.length, 2);
          expect(fixture.api.revoked, isEmpty);
          await tester.pumpWidget(const SizedBox.shrink());
        } finally {
          semantics.dispose();
        }
      });
    }
  }

  for (final app in ['clinic', 'governance']) {
    for (final rejected in [false, true]) {
      testWidgets('$app visible login error changes locale without resubmission rejected=$rejected', (tester) async {
        final semantics = tester.ensureSemantics();
        try {
          final fixture = await mountLogin(tester, app: app);
          if (rejected) await enterCredentials(tester);
          await submit(tester);
          final before = fixture.state;
          final calls = fixture.api.requests.length;
          final key = rejected ? 'authentication_failed' : 'enter_credentials_to_continue';
          for (final locale in ['fr', 'es', 'en']) {
            await fixture.container.read(languageProvider.notifier).setLanguage(locale);
            await tester.pumpAndSettle();
            expectNotice(tester, resource(app, locale, key));
            expect(identical(fixture.state, before), isTrue);
            expect(fixture.api.requests.length, calls);
            expectGuest(fixture);
          }
          await tester.pumpWidget(const SizedBox.shrink());
        } finally {
          semantics.dispose();
        }
      });
    }
  }

  testWidgets('pending login blocks duplicate submission and success clears failure and password', (tester) async {
    final fixture = await mountLogin(tester);
    await submit(tester);
    await enterCredentials(tester);
    await submit(tester);
    expect(fixture.state.errorReason, LoginErrorReason.authenticationFailed);
    await enterCredentials(tester);
    final pending = Completer<ApiResponse>();
    fixture.api.pending = pending;
    await tester.ensureVisible(submitButton);
    await tester.tap(submitButton);
    await tester.pump();
    expect(fixture.state.isLoading, isTrue);
    expect(fixture.state.errorMessage, isNull);
    expect(fixture.state.errorReason, isNull);
    expect(tester.widget<TextFormField>(input('login-email')).enabled, isFalse);
    expect(tester.widget<TextFormField>(input('login-password')).enabled, isFalse);
    await fixture.controller.login();
    expect(fixture.api.requests.length, 2);
    pending.complete(ApiResponse(statusCode: 200, data: {
      'token': 'fixture-token', 'role': 'rmt', 'userId': 'fixture-user',
    }));
    await tester.pumpAndSettle();
    expect(fixture.state.isLoading, isFalse);
    expect(fixture.state.errorReason, isNull);
    expect(fixture.state.errorMessage, isNull);
    expect(fixture.state.password, isEmpty);
    expect(tester.widget<TextFormField>(input('login-password')).controller!.text, isEmpty);
    expect(fixture.container.read(authProvider).isAuthenticated, isTrue);
    expect(fixture.prefs.getString('auth_token'), 'fixture-token');
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('late response after logout cannot install a session', (tester) async {
    final semantics = tester.ensureSemantics();
    try {
      final fixture = await mountLogin(tester, locale: 'es');
      await enterCredentials(tester);
      fixture.api.pending = Completer<ApiResponse>();
      final login = fixture.controller.login();
      await fixture.container.read(authProvider.notifier).logout();
      fixture.api.pending!.complete(ApiResponse(statusCode: 200, data: {
        'token': 'late-fixture-token', 'role': 'rmt', 'userId': 'fixture-user',
      }));
      await login;
      await tester.pumpAndSettle();
      expectGuest(fixture);
      expect(fixture.api.revoked, ['late-fixture-token']);
      expectNotice(tester, resource('clinic', 'es', 'authentication_failed'));
      expect(fixture.state.password, isEmpty);
      await tester.pumpWidget(const SizedBox.shrink());
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('MFA cancellation uses existing false result without retaining password or session', (tester) async {
    final semantics = tester.ensureSemantics();
    try {
      final fixture = await mountLogin(tester, locale: 'fr');
      fixture.api.response = ApiResponse(statusCode: 200, data: {
        'status': 'mfa_required', 'purpose': 'verify',
        'challenge': List.filled(43, 'a').join(),
      });
      await enterCredentials(tester);
      final login = fixture.controller.login();
      await tester.pump();
      expect(fixture.container.read(mfaControllerProvider).pending, isTrue);
      expect(fixture.state.password, isEmpty);
      expect(fixture.state.errorReason, isNull);
      fixture.container.read(mfaControllerProvider.notifier).cancel();
      await login;
      await tester.pumpAndSettle();
      expectGuest(fixture);
      expectNotice(tester, resource('clinic', 'fr', 'authentication_failed'));
      expect(fixture.container.read(mfaControllerProvider).pending, isFalse);
      await tester.pumpWidget(const SizedBox.shrink());
    } finally {
      semantics.dispose();
    }
  });

  test('public construction and error replacement never inherit localization metadata', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(loginControllerProvider.notifier);
    await controller.login();
    final typed = container.read(loginControllerProvider);
    expect(typed.errorReason, LoginErrorReason.missingCredentials);
    expect(typed.copyWith(email: 'other').errorReason, typed.errorReason);
    expect(typed.copyWith(errorMessage: null).errorReason, typed.errorReason);
    for (final replacement in ['', 'External error', oldEmpty]) {
      final literal = typed.copyWith(errorMessage: replacement);
      expect(literal.errorMessage, replacement);
      expect(literal.errorReason, isNull);
      expect(LoginState(errorMessage: replacement).errorReason, isNull);
    }
    final cleared = typed.copyWith(clearError: true, errorMessage: 'ignored');
    expect(cleared.errorMessage, isNull);
    expect(cleared.errorReason, isNull);
    controller.onEmailChanged('changed');
    expect(container.read(loginControllerProvider).errorReason, isNull);
    await controller.login();
    controller.onPasswordChanged('changed');
    expect(container.read(loginControllerProvider).errorReason, isNull);
    controller.prefillCredentials('', '');
    await controller.login();
    expect(await controller.forgotPassword(''), isFalse);
    expect(container.read(loginControllerProvider).errorMessage, 'Please enter your email.');
    expect(container.read(loginControllerProvider).errorReason, isNull);
  });

  testWidgets('simulation failure keeps its existing literal message after a typed error', (tester) async {
    final fixture = await mountLogin(tester);
    await fixture.controller.login();
    final simulated = fixture.controller.simulateLogin('rmt');
    expect(fixture.state.errorMessage, isNull);
    expect(fixture.state.errorReason, isNull);
    await tester.pump(const Duration(milliseconds: 800));
    await simulated;
    await tester.pumpAndSettle();
    expect(fixture.state.errorReason, isNull);
    expect(fixture.state.errorMessage, startsWith('Simulation failed:'));
    expect(find.text(fixture.state.errorMessage!), findsOneWidget);
    expectGuest(fixture);
    expect(fixture.api.requests, isEmpty);
    await tester.pumpWidget(const SizedBox.shrink());
  });
  testWidgets('a synthetic notifier throw retains the separate literal catch message', (tester) async {
    final fixture = await mountLogin(tester, locale: 'fr', auth: ThrowingLoginAuth());
    await submit(tester);
    await enterCredentials(tester);
    await submit(tester);
    expect(fixture.state.errorReason, isNull);
    expect(fixture.state.errorMessage, 'A connection error occurred. Please try again.');
    expect(find.text(fixture.state.errorMessage!), findsOneWidget);
    // Existing catch semantics do not clear the password. Do not silently
    // change that separate behavior while localizing the two known failures.
    expect(fixture.state.password, 'fixture-password');
    expectGuest(fixture);
    expect(fixture.api.requests, isEmpty);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
