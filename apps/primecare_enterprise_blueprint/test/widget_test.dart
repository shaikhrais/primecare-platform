// Governance - Category: test | Purpose: This is a basic Flutter widget test. To perform an interaction with a widget in your test, use the WidgetTester utili...
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:primecare_enterprise_blueprint/main.dart';

class TestTranslations extends AssetLoader {
  const TestTranslations();
  @override
  Future<Map<String,dynamic>> load(String path,Locale locale) async => {};
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    await tester.pumpWidget(ProviderScope(child: EasyLocalization(
      supportedLocales: const [Locale('en')], path: 'test-translations',
      assetLoader: const TestTranslations(), child: const MyApp())));
    await tester.pumpAndSettle();

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.byTooltip('Theme Center'));
    await tester.pumpAndSettle();
    expect(find.text('Theme Center'), findsWidgets);
    expect(tester.takeException(), isNull);
    final scope = ProviderScope.containerOf(tester.element(find.byType(MyApp)), listen: false);
    await scope.read(themeSettingsProvider.notifier).applyPersonalTheme(PersonalTheme(name: 'Test', preset: 'dark1', colors: {'primary': '#ffffff'}));
    await tester.pumpAndSettle();
    expect(tester.widget<MaterialApp>(find.byType(MaterialApp)).theme!.colorScheme.primary, Colors.white);
    expect(find.text('1'), findsOneWidget);
  });
}
