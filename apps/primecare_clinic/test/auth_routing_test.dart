import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/src/features/auth/password_recovery_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_clinic/core/routing/app_router.dart';

class GuestAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true);
}

class RestoringAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: false);
  void restoreSession() {
    state = AuthState(isInitialized: true, isAuthenticated: true,
      token: 'fixture-token', userId: 'fixture-user', role: 'rmt');
  }
  @override
  Future<void> logout() async {
    state = AuthState(isInitialized: true);
  }
}

class RoutingTranslations extends AssetLoader {
  const RoutingTranslations();
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async =>
    jsonDecode(File('$path/en.json').readAsStringSync()) as Map<String, dynamic>;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('session restoration preserves recovery route and draft', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    final auth = RestoringAuth();
    late ProviderContainer container;
    await tester.pumpWidget(ProviderScope(overrides: [authProvider.overrideWith(() => auth)],
      child: EasyLocalization(supportedLocales: const [Locale('en')],
        path: 'assets/translations', assetLoader: const RoutingTranslations(),
        child: Consumer(builder: (context, ref, _) {
          container = ProviderScope.containerOf(context);
          return MaterialApp.router(locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            routerConfig: ref.watch(appRouterProvider));
        }),
      ),
    ));
    await tester.pumpAndSettle();
    container.read(appRouterProvider).go('/forgot-password?enable-semantics=true');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'draft@example.test');
    final formState = tester.state(find.byType(PasswordRecoveryForm));
    auth.restoreSession();
    await tester.pumpAndSettle();
    final uri = container.read(appRouterProvider).routeInformationProvider.value.uri;
    expect(uri.path, '/forgot-password');
    expect(uri.queryParameters['enable-semantics'], 'true');
    expect(tester.state(find.byType(PasswordRecoveryForm)), same(formState));
    expect(tester.widget<TextField>(find.byType(TextField)).controller!.text, 'draft@example.test');
    await auth.logout();
    await tester.pumpAndSettle();
    expect(container.read(appRouterProvider).routeInformationProvider.value.uri.path, '/forgot-password');
    expect(tester.state(find.byType(PasswordRecoveryForm)), same(formState));
    await tester.pumpWidget(const SizedBox.shrink());
  });
  test('MFA and reset cannot report simulated success', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final mfa = container.read(mfaControllerProvider.notifier);
    mfa.onCodeChanged('123456');
    await mfa.verify();
    expect(container.read(mfaControllerProvider).isVerified, isFalse);
    final reset = container.read(resetPasswordControllerProvider.notifier);
    reset.onNewPasswordChanged('Example-password-123');
    reset.onConfirmPasswordChanged('Example-password-123');
    await reset.submit();
    expect(container.read(resetPasswordControllerProvider).isSuccess, isFalse);
  });
  testWidgets('clinic login renders shared form without SSO bridge', (tester) async {
    final container = ProviderContainer(overrides: [
      authProvider.overrideWith(GuestAuth.new),
    ]);
    addTearDown(container.dispose);
    final router = container.read(appRouterProvider);
    final paths = router.configuration.routes.whereType<GoRoute>().map((route) => route.path);
    expect(paths, containsAll(SharedAuthRoutes.publicPaths));
    final route = router.configuration.routes.whereType<GoRoute>()
        .singleWhere((route) => route.path == CommonRoutes.login);
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (value) {
      context = value;
      return const SizedBox.shrink();
    })));
    final state = GoRouterState(router.configuration,
      uri: Uri.parse('/login?enable-semantics=true'),
      matchedLocation: '/login',
      fullPath: '/login',
      pathParameters: const {},
      pageKey: const ValueKey('login'),
    );
    final boundary = route.builder!(context, state) as AppShellBoundary;
    expect(boundary.child, isA<LoginView>());
    final legacy = router.configuration.routes.whereType<GoRoute>()
        .singleWhere((route) => route.path == CommonRoutes.ssoRedirect);
    final location = await legacy.redirect!(context, state);
    expect(Uri.parse(location!).path, '/login');
    expect(Uri.parse(location).hasAuthority, isFalse);
  });

  test('return paths remain local and preserve encoded query values', () {
    expect(validateClinicReturnUrl('https://example.test/path'), isNull);
    expect(validateClinicReturnUrl('//example.test/path'), isNull);
    expect(validateClinicReturnUrl('/login'), isNull);
    for (final path in ['/forgot-password', '/reset-password']) {
      expect(validateClinicReturnUrl(path), isNull);
      expect(validateClinicReturnUrl('$path?enable-semantics=true'), isNull);
      expect(validateClinicReturnUrl('$path#form'), isNull);
    }
    expect(validateClinicReturnUrl('/auth/callback'), isNull);
    expect(validateClinicReturnUrl('relative/path'), isNull);
    expect(validateClinicReturnUrl('/clinic/care-plan?q=a%26b'),
      '/clinic/care-plan?q=a%26b');
  });
}
