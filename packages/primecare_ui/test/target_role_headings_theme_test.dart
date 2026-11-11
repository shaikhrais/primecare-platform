import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'fixtures/target_role_headings_fixture.dart';

void main() {
  testWidgets('exact generated role headings follow the active surface foreground', (tester) async {
    const base = PrimeThemeData();
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Role headings', preset: preset);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      for (final builder in targetRoleHeadingBuilders) {
        await tester.pumpWidget(PrimeTheme(data: prime, bootstrap: false,
          child: MaterialApp(theme: material, home: Scaffold(body: Container(
            color: prime.colors.surface, child: Builder(builder: builder),
          )))));
        await tester.pumpAndSettle();
        final text = tester.widget<Text>(find.byType(Text));
        expect(text.data, startsWith('Target Role: '));
        expect(text.style!.color, prime.colors.onSurface, reason: preset);
        expect(text.style!.fontSize, 14);
        expect(text.style!.fontWeight, FontWeight.bold);
        expect(themeContrastRatio(text.style!.color!, prime.colors.surface), greaterThanOrEqualTo(4.5), reason: preset);
        expect(tester.takeException(), isNull, reason: preset);
      }
    }
  });
}
