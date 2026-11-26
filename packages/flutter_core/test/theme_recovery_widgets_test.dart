import 'dart:ui' show PlatformDispatcher;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/config/resilience_config.dart';
import 'package:flutter_core/src/resilience/app_error_boundary.dart';
import 'package:flutter_core/src/resilience/system_recovery_mode.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';

void main() {
  testWidgets('recovery controls follow every theme and keep mobile retry actions', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    var resets = 0;
    for (final preset in themeCenterPresetNames) {
      final theme = applyPersonalThemeData(ThemeData(),
        PersonalTheme(name: 'Recovery', preset: preset, fontScale: 1.5));
      await tester.pumpWidget(MaterialApp(theme: theme, home: SystemRecoveryMode(
        error: StateError('Test failure'), stackTrace: StackTrace.fromString('test stack'),
        onAttemptReset: () => resets++)));
      await tester.pumpAndSettle();
      expect(tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor, theme.scaffoldBackgroundColor);
      final heading = tester.widget<Text>(find.text('System Recovery Mode'));
      expect(heading.style!.color, theme.colorScheme.onSurface);
      expect(heading.style!.fontSize, theme.textTheme.headlineSmall!.fontSize);
      final reset = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final background = reset.style!.backgroundColor!.resolve({})!;
      final foreground = tester.widget<Text>(find.text('Attempt Interface Reset')).style!.color!;
      expect(themeContrastRatio(background, foreground), greaterThanOrEqualTo(4.5));
      await tester.ensureVisible(find.text('Attempt Interface Reset'));
      final before = resets;
      await tester.tap(find.text('Attempt Interface Reset'));
      expect(resets, before + 1);
      expect(tester.takeException(), isNull, reason: preset);

      await tester.pumpWidget(MaterialApp(theme: theme,
        home: Scaffold(body: SystemOfflinePanel(onReset: () => resets++))));
      await tester.pumpAndSettle();
      final offlineHeading = tester.widget<Text>(find.text('System Unavailable'));
      expect(offlineHeading.style!.color, theme.colorScheme.onErrorContainer);
      expect(themeContrastRatio(theme.colorScheme.errorContainer, offlineHeading.style!.color!),
        greaterThanOrEqualTo(4.5));
      await tester.tap(find.text('Retry'));
      expect(resets, before + 2);
      expect(tester.takeException(), isNull, reason: preset);

      await tester.pumpWidget(MaterialApp(theme: theme, home: const SystemHealingPlaceholder()));
      await tester.pump();
      expect(tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator)).color,
        theme.colorScheme.primary);
      expect(tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor, theme.scaffoldBackgroundColor);
      expect(tester.takeException(), isNull, reason: preset);
      await tester.pumpWidget(const SizedBox());
    }
  });

  testWidgets('error boundary recovery retains inherited light and dark appearance', (tester) async {
    for (final brightness in Brightness.values) {
      final originalFlutterError = FlutterError.onError;
      final originalErrorBuilder = ErrorWidget.builder;
      final originalPlatformError = PlatformDispatcher.instance.onError;
      final originalMaxResets = ResilienceConfig.maxAutoResets;
      late Widget recovery;
      try {
        ResilienceConfig.maxAutoResets = 0;
        AppErrorBoundary.runGuarded(() async {});
        recovery = ErrorWidget.builder(FlutterErrorDetails(exception: StateError('Recovery fixture')));
      } finally {
        FlutterError.onError = originalFlutterError;
        ErrorWidget.builder = originalErrorBuilder;
        PlatformDispatcher.instance.onError = originalPlatformError;
        ResilienceConfig.maxAutoResets = originalMaxResets;
      }
      final theme = ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: brightness));
      await tester.pumpWidget(MaterialApp(theme: theme, home: recovery));
      await tester.pumpAndSettle();
      final nested = tester.widgetList<MaterialApp>(find.byType(MaterialApp)).last;
      expect(nested.theme!.brightness, brightness);
      expect(nested.theme!.colorScheme, theme.colorScheme);
      expect(find.byType(SystemRecoveryMode), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    }
  });
}
