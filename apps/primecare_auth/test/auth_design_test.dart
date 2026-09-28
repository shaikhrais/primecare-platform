import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/src/features/auth/auth_experience.dart';

class GuestAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true);
}

class TestTranslations extends AssetLoader {
  const TestTranslations();
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async =>
      jsonDecode(File('$path/en.json').readAsStringSync()) as Map<String, dynamic>;
}

Widget localized(Widget child, {GoRouter? router}) => EasyLocalization(
  supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
  path: 'assets/translations', assetLoader: const TestTranslations(), fallbackLocale: const Locale('en'),
  startLocale: const Locale('en'),
  child: Builder(builder: (context) => router == null
    ? MaterialApp(locale: context.locale, supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates, home: child)
    : MaterialApp.router(locale: context.locale, supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates, routerConfig: router)),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  for (final size in [const Size(360, 800), const Size(1440, 1000), const Size(320, 900)]) {
    for (final page in AuthPage.values) {
      testWidgets('${page.name} fits ${size.width}', (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(ProviderScope(overrides: [
          authProvider.overrideWith(GuestAuth.new),
        ], child: localized(MediaQuery(data: MediaQueryData(size: size, textScaler: TextScaler.linear(size.width == 320 ? 2 : 1)), child: PrimeAuthExperience(page: page)))));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.byType(PrimeAuthExperience), findsOneWidget);
      });
    }
  }

  testWidgets('password visibility is explicit and reversible', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: PrimeAuthTextField(
      id: 'password-test', label: 'Password', password: true, onChanged: (_) {},
    ))));
    expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, isTrue);
    await tester.tap(find.byType(IconButton));
    await tester.pump();
    expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, isFalse);
    await tester.tap(find.byType(IconButton));
    await tester.pump();
    expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, isTrue);
  });

  testWidgets('recovery link stays in the app and retains safe return path', (tester) async {
    final router = GoRouter(initialLocation: '/login?returnUrl=%2Fappointments&enable-semantics=true', routes: [
      GoRoute(path: '/login', builder: (_, __) => const PrimeAuthExperience(page: AuthPage.login)),
      GoRoute(path: '/forgot-password', builder: (_, __) => const Scaffold(body: Text('Recovery destination'))),
    ]);
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(overrides: [authProvider.overrideWith(GuestAuth.new)], child: localized(const SizedBox.shrink(), router: router)));
    await tester.pumpAndSettle();
    final link = find.text('Forgot password?');
    await tester.ensureVisible(link);
    await tester.tap(link);
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, '/forgot-password');
    expect(router.routeInformationProvider.value.uri.queryParameters['returnUrl'], '/appointments');
    expect(find.text('Recovery destination'), findsOneWidget);
  });
}
