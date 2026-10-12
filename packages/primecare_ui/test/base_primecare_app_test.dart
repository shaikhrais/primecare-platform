import 'package:flutter_core/theme/theme_settings_provider.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' show AppShellBoundary;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/src/application/base_primecare_app.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Translations extends AssetLoader {
  const Translations();
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async => {};
}

class ThemedApp extends BaseThemedPrimeCareApp {
  final GoRouter router;
  final bool boundary;
  final ThemeMode mode;
  const ThemedApp(
    this.router, {
    this.boundary = true,
    this.mode = ThemeMode.system,
  });
  @override
  String get applicationTitle => 'Test Product';
  @override
  GoRouter routerFor(WidgetRef ref) => router;
  @override
  bool get useShellBoundary => boundary;
  @override
  ThemeMode get applicationThemeMode => mode;
}

class BrandedApp extends BasePrimeCareApp {
  final GoRouter router;
  final ThemeData branding;
  const BrandedApp(this.router, this.branding);
  @override
  String get applicationTitle => 'Branded Product';
  @override
  GoRouter routerFor(WidgetRef ref) => router;
  @override
  ThemeData get applicationTheme => branding;
}

Future<GoRouter> mount(
  WidgetTester tester,
  BasePrimeCareApp Function(GoRouter) create, {
  String language = 'en',
}) async {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => const Scaffold(body: Text('Product Route')),
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('fr')],
        path: 'test/translations',
        assetLoader: const Translations(),
        fallbackLocale: const Locale('en'),
        startLocale: Locale(language),
        child: create(router),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  testWidgets('personal theme updates Material and PrimeTheme from one shared root', (tester) async {
    final router=await mount(tester,(r)=>ThemedApp(r));
    final scope=ProviderScope.containerOf(tester.element(find.byType(ThemedApp)),listen:false);
    await scope.read(themeSettingsProvider.notifier).applyPersonalTheme(PersonalTheme(name:'My theme',preset:'dark1',fontScale:1.25,radius:16,colors:{'primary':'#ffffff'}));
    await tester.pumpAndSettle();
    final material=tester.widget<MaterialApp>(find.byType(MaterialApp));final prime=tester.widget<PrimeTheme>(find.byType(PrimeTheme));
    expect(material.theme!.colorScheme.primary,const Color(0xffffffff));expect(material.theme!.colorScheme.onPrimary,const Color(0xff000000));
    expect(prime.data.colors.primary,material.theme!.colorScheme.primary);expect(prime.data.radiusDefault,16);expect(prime.data.typography.bodyMedium.fontSize,const PrimeTypography().bodyMedium.fontSize! * 1.25);
    await tester.pumpWidget(const SizedBox());router.dispose();
  });
  testWidgets(
    'themed root retains router, title, localization and shell order',
    (tester) async {
      final router = await mount(tester, (r) => ThemedApp(r), language: 'fr');
      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.title, 'Test Product');
      expect(app.routerConfig, same(router));
      expect(app.locale, const Locale('fr'));
      expect(app.supportedLocales, const [Locale('en'), Locale('fr')]);
      expect(app.debugShowCheckedModeBanner, isFalse);
      expect(app.themeMode, ThemeMode.system);
      expect(find.text('Product Route'), findsOneWidget);
      expect(
        find.ancestor(
          of: find.byType(PrimeTheme),
          matching: find.byType(AppShellBoundary),
        ),
        findsOneWidget,
      );
      await tester.pumpWidget(const SizedBox());
      router.dispose();
    },
  );
  testWidgets('clinic style can retain theme without a shell boundary', (
    tester,
  ) async {
    final router = await mount(
      tester,
      (r) => ThemedApp(r, boundary: false, mode: ThemeMode.light),
    );
    expect(find.byType(PrimeTheme), findsOneWidget);
    expect(find.byType(AppShellBoundary), findsNothing);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );
    await tester.pumpWidget(const SizedBox());
    router.dispose();
  });
  testWidgets('corporate style retains branding without adding PrimeTheme', (
    tester,
  ) async {
    final branding = ThemeData(colorSchemeSeed: Colors.orange);
    final router = await mount(tester, (r) => BrandedApp(r, branding));
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).theme,
      same(branding),
    );
    expect(find.byType(PrimeTheme), findsNothing);
    expect(find.byType(AppShellBoundary), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    router.dispose();
  });
}
