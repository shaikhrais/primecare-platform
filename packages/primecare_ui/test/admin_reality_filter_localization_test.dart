import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/localization/admin_reality_filter_catalog.dart';
import 'package:primecare_ui/src/localization/admin_reality_filter_text.dart';
import 'package:primecare_ui/src/screens/admin/admin_reality_check_screen.dart';
import 'auth_design_test.dart' show localized;

class RealityFixtureAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true, isAuthenticated: true,
      role: 'platform_admin', userId: 'fixture-user', tenantId: 'fixture-tenant',
      token: 'fixture-token');
}

class RealityFixtureApi extends Fake implements ApiClient {
  final queries = <String?>[];
  @override
  Future<ApiResponse> getForSession(String path, String token) async {
    final uri = Uri.parse(path);
    expect(uri.path, '/v1/governance/screen-health');
    expect(token, 'fixture-token');
    final query = uri.queryParameters['search'];
    queries.add(query);
    return ApiResponse(statusCode: 200, data: {
      'data': [
        {'screen': 'recorded', 'name': 'Recorded page', 'productionReady': false},
        if (query == null) {'screen': 'other', 'name': 'Other page'},
      ],
      'pagination': {'limit': 25, 'offset': 0, 'total': query == null ? 2 : 1,
        'hasMore': false},
      'source': {'evidenceType': 'registered_governance', 'catalogVersion': 1},
    });
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  test('filter catalogs contain matching nonempty keys and reject unknown keys', () {
    final keys = adminRealityFilterCatalog['en']!.keys.toSet();
    expect(keys.length, 35);
    for (final language in ['en', 'es', 'fr']) {
      final entries = adminRealityFilterCatalog[language]!;
      expect(entries.keys.toSet(), keys);
      for (final value in entries.values) {
        expect(value.trim(), isNotEmpty);
      }
    }
    expect(AdminRealityFilterText.resolve('de', 'search'),
      AdminRealityFilterText.resolve('en', 'search'));
    expect(() => AdminRealityFilterText.resolve('fr', 'unknown'), throwsArgumentError);
    expect(() => AdminRealityFilterText.resolve('fr', 'items'), throwsArgumentError);
    expect(AdminRealityFilterText.resolve('es', 'counter', args: {'label': '{count}', 'count': '3'}), '{count}: 3');
  });

  testWidgets('API-backed title, search and reload change locale without losing search', (tester) async {
    final api = RealityFixtureApi();
    await tester.pumpWidget(ProviderScope(
      overrides: [authProvider.overrideWith(RealityFixtureAuth.new),
        apiClientProvider.overrideWithValue(api)],
      child: PrimeTheme(data: const PrimeThemeData(),
        child: localized(const AdminRealityCheckScreen())),
    ));
    await tester.pumpAndSettle();
    final field = find.byType(TextField);
    final screen = find.byType(AdminRealityCheckScreen);
    expect(find.text('Other page'), findsOneWidget);
    await tester.enterText(field, 'Recorded');
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    expect(api.queries, [null, 'Recorded']);
    expect(find.text('Recorded page'), findsOneWidget);
    expect(find.text('Other page'), findsNothing);
    for (final language in ['en', 'es', 'fr']) {
      final requests = api.queries.length;
      await tester.element(screen).setLocale(Locale(language));
      await tester.pumpAndSettle();
      expect(api.queries.length, requests);
      expect(find.text(AdminRealityFilterText.resolve(language, 'title')), findsOneWidget);
      final input = tester.widget<TextField>(field);
      expect(input.decoration!.hintText, AdminRealityFilterText.resolve(language, 'search'));
      expect(input.controller!.text, 'Recorded');
      await tester.tap(find.byTooltip(AdminRealityFilterText.resolve(language, 'reload')));
      await tester.pumpAndSettle();
      expect(api.queries.last, 'Recorded');
      expect(find.text('Recorded page'), findsOneWidget);
      expect(find.text('Other page'), findsNothing);
      expect(tester.takeException(), isNull);
    }
  });
}
