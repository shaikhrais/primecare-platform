// Widget integration, not a live-backend or browser end-to-end test.
// Uses the corporate application definition, appRouterProvider, shared router,
// governance shell, presentation registrations and workspace renderer.
// A custom MaterialApp.router harness injects PrimeTheme and EasyLocalization;
// this does not mount PrimeCareCorporateApp, BasePrimeCareApp, the app runner
// or LiveScreenTextScope, or exercise the production theme-settings pipeline.
// Auth state, workspace API responses and the remote avatar are fixtures.
// These tests do not verify production authentication or server authorization.
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/models/screen_manager.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/workspace/governed_workspace_screen.dart';
import 'package:primecare_corporate/core/routing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

const dashboard = '/offices/corporate/roles/ceo/dashboard';
const overview = '/offices/corporate/roles/ceo/enterprise-overview';

class SessionFixture extends AuthNotifier {
  SessionFixture(this.auth);
  final AuthState auth;
  @override
  AuthState build() => auth;
}

class WorkspaceFixture extends Fake implements ApiClient {
  var calls = 0;
  var grantOverview = true;
  @override
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParameters}) async {
    // Unexpected requests fail rather than silently obtaining fixture success.
    if (path != '/v1/governance/workspace') throw StateError(path);
    calls++;
    return ApiResponse(statusCode: 200, data: <String, dynamic>{
      'screens': [
        {'code': 'ceo_dashboard', 'name': 'Fixture CEO dashboard', 'route': dashboard, 'sections': <dynamic>[]},
        if (grantOverview)
          {'code': 'ceo_enterprise_overview', 'name': 'Fixture enterprise overview', 'route': overview, 'sections': <dynamic>[]},
      ],
      'actions': <dynamic>[], 'inventory': <dynamic>[],
      'overview': {'activeAccounts': 1, 'activeSessions': 1, 'accountRoles': <dynamic>[], 'activity': <dynamic>[], 'metrics': <dynamic>[]},
    });
  }
}

class TranslationFixture extends AssetLoader {
  const TranslationFixture();
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async =>
      jsonDecode(File('$path/${locale.languageCode}.json').readAsStringSync()) as Map<String, dynamic>;
}

class RoutedWorkspace extends ConsumerWidget {
  const RoutedWorkspace({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    locale: context.locale,
    supportedLocales: context.supportedLocales,
    localizationsDelegates: context.localizationDelegates,
    routerConfig: ref.watch(appRouterProvider),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  Future<ProviderContainer> mount(WidgetTester tester, WorkspaceFixture api,
      ValueNotifier<PrimeThemeData> theme, {bool authenticated = true}) async {
    tester.view.physicalSize = const Size(1440, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    // The real shell requests a decorative remote avatar. Seed its image cache
    // with a 1x1 fixture so this test never needs that unrelated HTTP service.
    await tester.runAsync(() async {
      final image = await decodeImageFromList(base64Decode(
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR4nGNgYGBgAAAABQABpfZFQAAAAABJRU5ErkJggg=='));
      imageCache.putIfAbsent(
        const NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=User'),
        () => OneFrameImageStreamCompleter(Future.value(ImageInfo(image: image))),
      );
    });
    addTearDown(() { imageCache.clear(); imageCache.clearLiveImages(); });
    final container = ProviderContainer(overrides: [
      authProvider.overrideWith(() => SessionFixture(authenticated
          ? AuthState(isInitialized: true, isAuthenticated: true, userId: 'fixture-ceo',
              tenantId: 'fixture-tenant', token: 'fixture-token', role: 'ceo')
          : AuthState(isInitialized: true))),
      apiClientProvider.overrideWithValue(api),
    ]);
    addTearDown(container.dispose);
    addTearDown(theme.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(container: container,
      child: ValueListenableBuilder<PrimeThemeData>(valueListenable: theme,
        builder: (_, data, child) => PrimeTheme(data: data, bootstrap: false, child: child!),
        child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
          path: '../primecare_clinic/assets/translations',
          assetLoader: const TranslationFixture(), startLocale: const Locale('en'),
          fallbackLocale: const Locale('en'), saveLocale: false,
          child: const RoutedWorkspace(),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    return container;
  }

  Finder workspace() => find.byType(GovernedWorkspaceScreen);
  Finder workspaceScaffold() => find.descendant(of: workspace(), matching: find.byType(Scaffold)).first;

  testWidgets('corporate route with fixture auth inherits injected theme and locale', (tester) async {
    final api = WorkspaceFixture();
    final theme = ValueNotifier(const PrimeThemeData());
    final container = await mount(tester, api, theme);
    final router = container.read(appRouterProvider);
    expect(router.routeInformationProvider.value.uri.path, dashboard);
    expect(api.calls, 1);
    final context = tester.element(workspace());
    expect(AppShellBoundary.isActive(context), isTrue);
    expect(Theme.of(context), isNotNull);
    expect(Localizations.localeOf(context).languageCode, 'en');
    expect(MediaQuery.sizeOf(context).width, greaterThan(0));
    expect(context.findAncestorWidgetOfExactType<PrimeTheme>(), isNotNull);
    final boundary = context.findAncestorWidgetOfExactType<ManagedScreenBoundary>()!;
    expect(boundary.manager, same(SharedAuthRoutes.screenManager));
    expect(boundary.screenId, dashboard);

    final link = find.descendant(of: workspace(), matching: find.widgetWithText(TextButton, 'Fixture enterprise overview'));
    await tester.ensureVisible(link);
    await tester.tap(link);
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, overview);
    expect(tester.widget<GovernedWorkspaceScreen>(workspace()).route, overview);
    expect(api.calls, 2);

    // Update inherited presentation dependencies without replacing the router
    // or refetching an already-authorized workspace.
    final scaffoldElement = tester.element(workspaceScaffold());
    theme.value = PrimeThemeData(colors: PrimeColors(background: Colors.orange));
    await tester.pumpAndSettle();
    expect(tester.widget<Scaffold>(workspaceScaffold()).backgroundColor, Colors.orange);
    await tester.element(workspace()).setLocale(const Locale('fr'));
    await tester.pumpAndSettle();
    expect(find.descendant(of: workspace(), matching: find.byTooltip('Actualiser')), findsOneWidget);
    expect(tester.element(workspaceScaffold()), same(scaffoldElement));
    expect(container.read(appRouterProvider), same(router));
    expect(api.calls, 2);
    expect(tester.takeException(), isNull);
  });

  testWidgets('registered route remains forbidden when the server removes its grant', (tester) async {
    final api = WorkspaceFixture();
    final container = await mount(tester, api, ValueNotifier(const PrimeThemeData()));
    final router = container.read(appRouterProvider);
    router.go('$overview?enable-semantics=true');
    await tester.pumpAndSettle();
    expect(find.text('Fixture enterprise overview'), findsWidgets);
    api.grantOverview = false;
    await tester.tap(find.descendant(of: workspace(), matching: find.byIcon(Icons.refresh)));
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, overview);
    expect(SharedAuthRoutes.screenManager.lookup(overview), isNotNull);
    expect(find.text('Fixture enterprise overview'), findsNothing);
    expect(find.text('You do not have permission to view this page.'), findsOneWidget);
    expect(api.calls, 3);
    expect(tester.takeException(), isNull);
  });

  testWidgets('guest deep link redirects before any workspace API request', (tester) async {
    final api = WorkspaceFixture();
    final container = await mount(tester, api, ValueNotifier(const PrimeThemeData()), authenticated: false);
    final router = container.read(appRouterProvider);
    router.go('$dashboard?enable-semantics=true');
    await tester.pumpAndSettle();
    final location = router.routeInformationProvider.value.uri;
    expect(location.path, '/login');
    expect(location.queryParameters['returnUrl'], '$dashboard?enable-semantics=true');
    expect(location.queryParameters['enable-semantics'], 'true');
    expect(workspace(), findsNothing);
    expect(api.calls, 0);
    expect(tester.takeException(), isNull);
  });
}
