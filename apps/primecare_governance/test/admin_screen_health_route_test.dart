import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/models/screen_manager.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_governance/core/governance/route_registry.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/screens/admin/admin_screen_health/admin_screen_health_screen.dart' as routed;
import 'package:primecare_ui/src/screens/admin/admin_screen_health/admin_screen_health_screen_controller.dart';
import 'package:primecare_ui/src/screens/admin/admin_screen_health/sections/admin_screen_health_header_section.dart';
import 'package:primecare_ui/src/screens/admin/admin_screen_health/sections/admin_screen_health_content_summary_section.dart';
import 'package:primecare_ui/src/screens/admin/admin_screen_health/sections/admin_screen_health_primary_content_section.dart';
import 'package:primecare_ui/src/screens/admin/admin_screen_health/sections/admin_screen_health_action_bar_section.dart';

const healthPath = '/admin/screen-health';

class HealthGuestAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true);
}

// Controlled transport: exercise the real controller without live services,
// local cache fallback, session refresh, or invented authorization grants.
class HealthApi implements ApiClient {
  final requests = <Completer<ApiResponse>>[];
  final paths = <String>[];

  @override
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParameters}) {
    paths.add(path);
    final response = Completer<ApiResponse>();
    requests.add(response);
    return response.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HealthApi api;
  late ProviderContainer container;
  late GoRouter router;
  late ShellRoute shell;
  late GoRoute route;

  setUp(() {
    api = HealthApi();
    container = ProviderContainer(overrides: [
      authProvider.overrideWith(HealthGuestAuth.new),
      apiClientProvider.overrideWithValue(api),
    ]);
    router = container.read(appRouterProvider);
    shell = router.configuration.routes.whereType<ShellRoute>().single;
    route = shell.routes.whereType<GoRoute>().firstWhere((r) => r.path == healthPath);
  });

  tearDown(() {
    router.dispose();
    container.dispose();
  });

  // Uses the actual route and shell builders, but mounts only the shell body.
  // This intentionally excludes avatar networking, drawers and router redirects.
  // Guest redirect coverage belongs in auth_routing_test.dart. These fixtures
  // establish presentation behavior, NOT role authorization or API permission.
  Future<void> mount(WidgetTester tester, {Brightness brightness = Brightness.light}) async {
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: PrimeTheme(
        data: const PrimeThemeData(),
        bootstrap: false,
        child: MaterialApp(
          theme: ThemeData(brightness: brightness),
          home: Builder(builder: (context) {
            final state = GoRouterState(router.configuration,
              uri: Uri.parse('$healthPath?enable-semantics=true'),
              matchedLocation: healthPath, fullPath: healthPath,
              pathParameters: const {}, pageKey: const ValueKey(healthPath),
            );
            final child = route.builder!(context, state);
            expect(child, isA<routed.AdminScreenHealthScreen>());
            final scaffold = shell.builder!(context, state, child) as Scaffold;
            expect(scaffold.body, isA<AppShellBoundary>());
            final boundary = (scaffold.body! as AppShellBoundary).child as ManagedScreenBoundary;
            expect(boundary.screenId, healthPath);
            expect(boundary.manager.lookup(healthPath), isNotNull);
            return scaffold.body!;
          }),
        ),
      ),
    ));
  }

  testWidgets('actual health route preserves loading, success data and sync', (tester) async {
    final semantics = tester.ensureSemantics();
    addTearDown(semantics.dispose);
    await mount(tester);
    expect(find.byType(ManagedScreenBoundary), findsOneWidget);
    expect(find.byType(AppShellBoundary), findsOneWidget);
    expect(find.byKey(const ValueKey('admin_screen_health_loading')), findsOneWidget);
    final controller = container.read(admin_screen_healthControllerProvider.notifier);
    expect(controller.endpoint, healthPath);
    expect(api.paths, [controller.endpoint]);
    final data = <String, dynamic>{'fixture': 'initial health response'};
    api.requests[0].complete(ApiResponse(data: data, statusCode: 200));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('admin_screen_health_screen')), findsOneWidget);
    expect(tester.widget<AdminScreenHealthHeaderSection>(find.byType(AdminScreenHealthHeaderSection)).data, data);
    expect(tester.widget<AdminScreenHealthContentSummarySection>(find.byType(AdminScreenHealthContentSummarySection)).data, data);
    expect(tester.widget<AdminScreenHealthPrimaryContentSection>(find.byType(AdminScreenHealthPrimaryContentSection)).data, data);
    expect(tester.widget<AdminScreenHealthActionBarSection>(find.byType(AdminScreenHealthActionBarSection)).data, data);
    expect(find.bySemanticsLabel('sync-button'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.sync));
    await tester.pump();
    expect(api.paths, [healthPath, healthPath]);
    expect(find.byKey(const ValueKey('admin_screen_health_loading')), findsOneWidget);
    api.requests[1].complete(ApiResponse(data: <String, dynamic>{}, statusCode: 200));
    await tester.pumpAndSettle();
    expect(tester.widget<AdminScreenHealthHeaderSection>(find.byType(AdminScreenHealthHeaderSection)).data, isEmpty);
    await mount(tester, brightness: Brightness.dark);
    await tester.pumpAndSettle();
    expect(api.paths, hasLength(2), reason: 'Theme changes must not reload the provider.');
    expect(Theme.of(tester.element(find.byType(routed.AdminScreenHealthScreen))).brightness, Brightness.dark);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('synthetic offline fallback cannot render healthy sections', (tester) async {
    await mount(tester);
    api.requests.single.complete(ApiResponse(statusCode: 200, data: {
      'success': true,
      'status': 'offline_fallback',
      'message': 'Handled by PrimeCare Offline Parity Engine',
    }));
    await tester.pumpAndSettle();
    expect(find.text('Error: Failed to load live data'), findsOneWidget);
    expect(find.byType(AdminScreenHealthHeaderSection), findsNothing);
    await tester.tap(find.byIcon(Icons.sync));
    await tester.pump();
    api.requests.last.complete(ApiResponse(statusCode: 200, data: {'fixture': 'live'}));
    await tester.pumpAndSettle();
    expect(find.byType(AdminScreenHealthHeaderSection), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  for (final status in [401, 403, 500]) {
    testWidgets('health response $status stays an error until a successful retry', (tester) async {
      await mount(tester);
      api.requests.single.complete(ApiResponse(data: {}, statusCode: status, error: 'fixture-$status'));
      await tester.pumpAndSettle();
      expect(find.text('Error: fixture-$status'), findsOneWidget);
      expect(find.byType(AdminScreenHealthHeaderSection), findsNothing);
      await tester.tap(find.byIcon(Icons.sync));
      await tester.pump();
      expect(find.text('Error: fixture-$status'), findsNothing);
      expect(find.byKey(const ValueKey('admin_screen_health_loading')), findsOneWidget);
      api.requests.last.complete(ApiResponse(data: {}, statusCode: 200));
      await tester.pumpAndSettle();
      expect(find.byType(AdminScreenHealthHeaderSection), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

  testWidgets('repeated sync keeps newer response when older request finishes last', (tester) async {
    await mount(tester);
    await tester.tap(find.byIcon(Icons.sync));
    await tester.pump();
    api.requests[1].complete(ApiResponse(data: {'revision': 2}, statusCode: 200));
    await tester.pumpAndSettle();
    api.requests[0].complete(ApiResponse(data: {'revision': 1}, statusCode: 200));
    await tester.pumpAndSettle();
    expect(tester.widget<AdminScreenHealthHeaderSection>(find.byType(AdminScreenHealthHeaderSection)).data, {'revision': 2});
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
