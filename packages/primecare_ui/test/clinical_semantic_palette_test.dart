import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'package:primecare_ui/src/screens/clinical/clinical_director_dashboard_screen.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'auth_design_test.dart' show localized;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('every semantic palette follows the active theme with readable pairs', (tester) async {
    const base = PrimeThemeData();
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Clinical palette', preset: preset);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      for (final tone in PrimeActionTone.values) {
        late PrimeActionPalette palette;
        await tester.pumpWidget(PrimeTheme(data: prime, bootstrap: false,
          child: MaterialApp(theme: material, home: Builder(builder: (context) {
            palette = PrimeActionPalette.of(context, tone);
            return Container(color: palette.surface, child: Text('Status',
              style: TextStyle(color: palette.onSurface)));
          }))));
        expect(themeContrastRatio(palette.onSurface, palette.surface), greaterThanOrEqualTo(4.5), reason: '$preset/$tone');
        expect(themeContrastRatio(palette.onAccent, palette.accent), greaterThanOrEqualTo(4.5), reason: '$preset/$tone');
        expect(themeContrastRatio(palette.onBase, prime.colors.surface), greaterThanOrEqualTo(4.5), reason: '$preset/$tone');
        expect(palette.border, palette.accent.withValues(alpha: .3));
        expect(palette.accent, switch (tone) {
          PrimeActionTone.primary => prime.colors.primary,
          PrimeActionTone.success => prime.colors.success,
          PrimeActionTone.warning => prime.colors.warning,
          PrimeActionTone.error => prime.colors.error,
          PrimeActionTone.muted => prime.colors.onSurfaceVariant,
        });
        expect(tester.takeException(), isNull);
      }
    }
  });

  testWidgets('actual clinical quick-action categories update without changing their labels', (tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final controller = ClinicalDirectorDashboardController.withLoader(
      () async => ApiResponse(data: null, statusCode: 403));
    addTearDown(controller.dispose);
    const state = ClinicalDirectorDashboardState(isLoading: false, title: 'Clinical', logs: []);
    const categories = ['Emergency', 'Staffing', 'Resident', 'Compliance', 'Operations'];
    const tones = [PrimeActionTone.error, PrimeActionTone.primary, PrimeActionTone.success,
      PrimeActionTone.warning, PrimeActionTone.muted];
    const base = PrimeThemeData();
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Clinical categories', preset: preset);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      await tester.pumpWidget(PrimeTheme(data: prime, bootstrap: false,
        child: localized(Scaffold(body: SingleChildScrollView(
          child: GovQuickActionBar(controller: controller, state: state))))));
      await tester.pumpAndSettle();
      for (var i = 0; i < categories.length; i++) {
        await tester.tap(find.text(categories[i]).last);
        await tester.pumpAndSettle();
        final palette = PrimeActionPalette.of(tester.element(find.byType(GovQuickActionBar)), tones[i]);
        final chipText = tester.widgetList<Text>(find.text(categories[i]))
          .where((text) => text.style?.fontSize == 11).single;
        expect(chipText.style!.color, palette.onSurface, reason: '$preset/${categories[i]}');
        expect(tester.takeException(), isNull, reason: '$preset/${categories[i]}');
      }
    }
  });
}
