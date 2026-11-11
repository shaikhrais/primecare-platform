import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:primecare_ui/src/components/prime_linear_progress_indicator.dart';

void main() {
  testWidgets('shared progress paints the active track theme and retains value and geometry', (tester) async {
    for (final preset in themeCenterPresetNames) {
      final paletteTheme = applyPersonalThemeData(ThemeData(), PersonalTheme(name: 'Progress', preset: preset));
      final track = paletteTheme.colorScheme.tertiaryContainer;
      final foreground = paletteTheme.colorScheme.primary;
      final theme = paletteTheme.copyWith(progressIndicatorTheme:
        ProgressIndicatorThemeData(linearTrackColor: track));
      final animation = AlwaysStoppedAnimation<Color>(foreground);
      await tester.pumpWidget(MaterialApp(theme: theme, home: Scaffold(body: Center(
        child: SizedBox(width: 200, child: PrimeLinearProgressIndicator(
          value: .4, valueColor: animation, minHeight: 8)),
      ))));
      await tester.pumpAndSettle();
      // Inspect the resolved painter in the pinned Flutter 3.41.5 renderer,
      // rather than accepting a null background override as proof of theming.
      final paint = tester.widget<CustomPaint>(find.descendant(
        of: find.byType(LinearProgressIndicator), matching: find.byType(CustomPaint)));
      final dynamic painter = paint.painter!;
      expect(painter.trackColor, track, reason: preset);
      expect(painter.valueColor, foreground, reason: preset);
      expect(painter.value, .4, reason: preset);
      expect(tester.getSize(find.byType(LinearProgressIndicator)).height, 8, reason: preset);
      expect(tester.takeException(), isNull, reason: preset);
    }
  });
}
