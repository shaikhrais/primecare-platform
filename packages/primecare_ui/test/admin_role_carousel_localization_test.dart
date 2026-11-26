import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/localization/admin_role_carousel_catalog.dart';
import 'package:primecare_ui/src/localization/admin_role_carousel_text.dart';
import 'package:primecare_ui/src/screens/admin/admin_role_carousel_screen.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:primecare_ui/src/localization/admin_registered_inventory_text.dart';
import 'package:primecare_ui/src/screens/admin/admin_screenshot_gallery_screen.dart';
import 'admin_reality_filter_localization_test.dart' show RealityFixtureAuth;
import 'auth_design_test.dart' show localized;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  test('all three catalogs contain the same nonempty keys and interpolation parameters', () {
    final english = adminRoleCarouselCatalog['en']!;
    final parameter = RegExp(r'\{([a-zA-Z][a-zA-Z0-9_]*)\}');
    for (final language in ['en', 'es', 'fr']) {
      final entries = adminRoleCarouselCatalog[language]!;
      expect(entries.keys.toSet(), english.keys.toSet());
      for (final entry in entries.entries) {
        expect(entry.value.trim(), isNotEmpty, reason: '$language.${entry.key}');
        expect(parameter.allMatches(entry.value).map((m) => m.group(1)).toSet(),
          parameter.allMatches(english[entry.key]!).map((m) => m.group(1)).toSet(),
          reason: '$language.${entry.key}');
      }
    }
    expect(AdminRoleCarouselText.resolve('es', 'copiedPath', args: {'file': '{name}.dart'}),
      contains('{name}.dart')); // Parameter values must not be interpreted again.
    expect(() => AdminRoleCarouselText.resolve('fr', 'reviewCount'), throwsArgumentError);
    expect(() => AdminRoleCarouselText.resolve('es', 'unknown'), throwsArgumentError);
  });

  testWidgets('carousel keeps its localized controls and submitted API query',
      (tester) async {
    final api = _CarouselFixture();
    await tester.pumpWidget(ProviderScope(
      overrides: [authProvider.overrideWith(RealityFixtureAuth.new),
        apiClientProvider.overrideWithValue(api)],
      child: PrimeTheme(data: const PrimeThemeData(),
        child: localized(const AdminRoleCarouselScreen())),
    ));
    await tester.pumpAndSettle();
    final field = find.byType(TextField).first;
    final screen = find.byType(AdminRoleCarouselScreen);
    expect(find.text('Fixture screen'), findsOneWidget);
    expect(find.text('qa'), findsAtLeastNWidgets(1));
    await tester.enterText(field, 'no-matching-record');
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    expect(api.searches, [null, 'no-matching-record']);
    expect(find.text('Fixture screen'), findsNothing);

    for (final language in ['en', 'es', 'fr']) {
      await tester.element(screen).setLocale(Locale(language));
      await tester.pumpAndSettle();
      String text(String key) => AdminRoleCarouselText.resolve(language, key);
      expect(find.text(text('title')), findsOneWidget);
      expect(tester.widget<TextField>(field).decoration!.hintText, text('search'));
      expect(tester.widget<TextField>(field).controller!.text, 'no-matching-record');
      expect(find.byTooltip(text('reload')), findsOneWidget);
      expect(find.text(AdminRegisteredInventoryText.resolve(language, 'empty')),
        findsOneWidget);
      expect(api.searches, [null, 'no-matching-record']);
    }
  });

  testWidgets('gallery renders catalog metadata without local artifacts and honors denial',
      (tester) async {
    final api = _CarouselFixture();
    await tester.pumpWidget(ProviderScope(
      overrides: [authProvider.overrideWith(RealityFixtureAuth.new),
        apiClientProvider.overrideWithValue(api)],
      child: PrimeTheme(data: const PrimeThemeData(),
        child: localized(const AdminScreenshotGalleryScreen())),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Fixture screen'), findsOneWidget);
    expect(find.text(AdminRegisteredInventoryText.resolve('en', 'galleryGap')),
      findsOneWidget);
    expect(find.text('legacy/private.png'), findsNothing);
    expect(find.byType(Image), findsNothing);
    api.denied = true;
    await tester.tap(find.byTooltip('Reload'));
    await tester.pumpAndSettle();
    expect(find.text(AdminRegisteredInventoryText.resolve('en', 'denied')),
      findsOneWidget);
    expect(find.text('Fixture screen'), findsNothing);
  });
}

class _CarouselFixture extends Fake implements ApiClient {
  final searches = <String?>[];
  bool denied = false;

  @override
  Future<ApiResponse> getForSession(String path, String token) async {
    final uri = Uri.parse(path);
    expect(uri.path, '/v1/governance/screen-health');
    expect(token, 'fixture-token');
    final search = uri.queryParameters['search'];
    searches.add(search);
    if (denied) return ApiResponse(statusCode: 403, data: const {});
    return ApiResponse(statusCode: 200, data: {
      'data': [
        if (search == null)
          {'screen': 'fixture', 'name': 'Fixture screen', 'role': 'qa',
            'route': '/fixture', 'screenshotPath': 'legacy/private.png'},
      ],
      'pagination': {'offset': 0, 'limit': 25, 'total': search == null ? 1 : 0,
        'hasMore': false},
      'source': {'evidenceType': 'registered_governance', 'catalogVersion': 1},
    });
  }
}
