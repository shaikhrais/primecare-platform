import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/generated_screens/live_dispatch_map.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';

void main() {
  test('live dispatch palette source remains publicly compile reachable', () {
    expect(LiveDispatchMap, isNotNull);
    expect(LiveDispatchMapController, isNotNull);
    expect(LiveDispatchMapState, isNotNull);
  });

  testWidgets('actual dispatch statuses and assignment follow every active palette',
      (tester) async {
    tester.view.physicalSize = const Size(1800, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    const base = PrimeThemeData();

    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Dispatch palette', preset: preset);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      await tester.pumpWidget(ProviderScope(
        child: PrimeTheme(
          data: prime,
          bootstrap: false,
          child: MaterialApp(
            theme: material,
            home: Consumer(
              builder: (context, ref, _) =>
                  const LiveDispatchMap().buildScreen(context, ref),
            ),
          ),
        ),
      ));
      await tester.pump();

      final delayed = find.text('Delayed 18 mins');
      final pending = find.text('2 PENDING MATCH');
      final online = find.text('Telemetry Hub Online');
      expect(delayed, findsOneWidget, reason: preset);
      expect(pending, findsOneWidget, reason: preset);
      expect(online, findsOneWidget, reason: preset);

      final warning = PrimeActionPalette.of(
          tester.element(delayed), PrimeActionTone.warning);
      final error =
          PrimeActionPalette.of(tester.element(pending), PrimeActionTone.error);
      final primary = PrimeActionPalette.of(
          tester.element(find.text('Select to Match').first),
          PrimeActionTone.primary);
      expect(tester.widget<Text>(delayed).style!.color, warning.onSurface);
      expect(tester.widget<Text>(pending).style!.color, error.onSurface);
      expect(themeContrastRatio(warning.onSurface, warning.surface),
          greaterThanOrEqualTo(4.5));
      expect(themeContrastRatio(error.onSurface, error.surface),
          greaterThanOrEqualTo(4.5));
      expect(tester.widget<Text>(online).style!.color,
          prime.colors.inverseOnSurface);

      var buttonFinder = find.ancestor(
        of: find.text('Select to Match').first,
        matching: find.byType(ElevatedButton),
      );
      var button = tester.widget<ElevatedButton>(buttonFinder);
      expect(button.style!.backgroundColor!.resolve(<WidgetState>{}),
          primary.accent);
      expect(button.style!.foregroundColor!.resolve(<WidgetState>{}),
          primary.onAccent);

      await tester.tap(buttonFinder);
      await tester.pump();
      expect(find.text('Assign Grace PSW'), findsOneWidget);
      final success = PrimeActionPalette.of(
          tester.element(find.text('Assign Grace PSW')),
          PrimeActionTone.success);
      buttonFinder = find.ancestor(
        of: find.text('Assign Grace PSW'),
        matching: find.byType(ElevatedButton),
      );
      button = tester.widget<ElevatedButton>(buttonFinder);
      expect(button.style!.backgroundColor!.resolve(<WidgetState>{}),
          success.accent);
      expect(button.style!.foregroundColor!.resolve(<WidgetState>{}),
          success.onAccent);
      expect(tester.takeException(), isNull, reason: preset);
    }
  });
}
