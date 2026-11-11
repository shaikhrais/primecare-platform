import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'package:primecare_ui/src/screens/rn/rn_workflow/sections/rn_workflow_task_details_section.dart';

void main() {
  testWidgets('real section muted copy follows every theme and retains content, semantics and inherited text', (tester) async {
    const base = PrimeThemeData();
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Section copy', preset: preset);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      await tester.pumpWidget(PrimeTheme(data: prime, bootstrap: false,
        child: MaterialApp(theme: material, home: Scaffold(body: MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(1.5)),
          child: const DefaultTextStyle(style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            child: RnWorkflowTaskDetailsSection(data: {})),
        )))));
      await tester.pumpAndSettle();
      expect(find.text('Task Details Section'), findsOneWidget);
      expect(find.text('Clinical Care Operations Status.'), findsOneWidget);
      final rendered = tester.widget<RichText>(find.descendant(
        of: find.byType(PrimeStatusText), matching: find.byType(RichText)));
      expect(rendered.text.style!.color, prime.colors.onSurfaceVariant, reason: preset);
      expect(rendered.text.style!.fontSize, 17);
      expect(rendered.text.style!.fontWeight, FontWeight.w500);
      expect(rendered.textScaler.scale(17), 25.5);
      final semantics = tester.widget<Semantics>(find.byWidgetPredicate((widget) =>
        widget is Semantics && widget.properties.label == 'rn_workflow_task_details_title'));
      expect(semantics.container, isTrue);
      expect(themeContrastRatio(prime.colors.onSurfaceVariant, prime.colors.surface), greaterThanOrEqualTo(4.5), reason: preset);
      expect(tester.takeException(), isNull, reason: preset);
    }
  });
}
