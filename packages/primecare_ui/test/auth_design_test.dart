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
      jsonDecode(File('$path/${locale.languageCode}.json').readAsStringSync()) as Map<String, dynamic>;
}

Widget localized(Widget child, {GoRouter? router, String language = 'en'}) => EasyLocalization(
  supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
  path: '../../apps/primecare_clinic/assets/translations', assetLoader: const TestTranslations(), fallbackLocale: const Locale('en'),
  startLocale: Locale(language),
  useFallbackTranslations: true,
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
  for (final locale in ['en', 'fr', 'es']) {
  for (final size in [const Size(360, 800), const Size(1440, 1000), const Size(320, 900)]) {
    for (final page in AuthPage.values) {
      testWidgets('${page.name} fits ${size.width} in $locale', (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(ProviderScope(overrides: [
          authProvider.overrideWith(GuestAuth.new),
        ], child: localized(MediaQuery(data: MediaQueryData(size: size, textScaler: TextScaler.linear(size.width == 320 ? 2 : 1)), child: PrimeAuthExperience(page: page)), language: locale)));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.byType(PrimeAuthExperience), findsOneWidget);
      });
    }
  }

  }

  testWidgets('password visibility is explicit and reversible', (tester) async {
    await tester.pumpWidget(localized(Scaffold(body: PrimeAuthTextField(
      id: 'password-test', label: 'Password', password: true, onChanged: (_) {},
    ))));
    await tester.pumpAndSettle();
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

  test('all auth design resources have French and Spanish values', () {
    final en = jsonDecode(File('../../apps/primecare_clinic/assets/translations/en.json').readAsStringSync()) as Map<String, dynamic>;
    for (final locale in ['fr', 'es']) {
      final translated = jsonDecode(File('../../apps/primecare_clinic/assets/translations/$locale.json').readAsStringSync()) as Map<String, dynamic>;
      for (final key in en.keys.where((key) => key.startsWith('auth_design_'))) {
        expect(translated[key], isA<String>(), reason: '$locale: $key');
        expect((translated[key] as String).trim(), isNotEmpty);
      }
    }
  });

  testWidgets('language selection updates text, persists and restores on restart', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    Widget app() => ProviderScope(overrides: [
      authProvider.overrideWith(GuestAuth.new),
      sharedPreferencesProvider.overrideWithValue(prefs),
    ], child: localized(const LocaleRebuildWrapper(
      child: PrimeAuthExperience(page: AuthPage.language),
    )));
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Français'));
    await tester.tap(find.text('Français'));
    await tester.pumpAndSettle();
    expect(find.text('Bienvenue chez vous'), findsOneWidget);
    expect(prefs.getString('auth_preferred_language'), 'fr');

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(find.text('Bienvenue chez vous'), findsOneWidget);

    await tester.ensureVisible(find.text('Español'));
    await tester.tap(find.text('Español'));
    await tester.pumpAndSettle();
    expect(find.text('Siéntase como en casa'), findsOneWidget);
    expect(prefs.getString('auth_preferred_language'), 'es');

    await tester.ensureVisible(find.text('English'));
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(find.text('Make yourself at home'), findsOneWidget);
    expect(prefs.getString('auth_preferred_language'), 'en');
    expect(tester.takeException(), isNull);
  });
}
