import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:primecare_ui/src/components/prime_page_scaffold.dart';
import 'package:primecare_ui/src/components/prime_text.dart';

void main() {
  testWidgets('shared shell retains rendered theme and title styles for every palette', (tester) async {
    for (final preset in themeCenterPresetNames) {
      final theme = applyPersonalThemeData(ThemeData(),
        PersonalTheme(name: 'Page', preset: preset, fontScale: 1.5));
      await tester.pumpWidget(MaterialApp(theme: theme, home: Scaffold(
        appBar: AppBar(title: const PrimeText('Page title')), body: const Text('Content'))));
      await tester.pumpAndSettle();
      final colors = tester.widgetList<Material>(find.byType(Material)).map((m) => m.color).toList();
      final titleStyle = tester.widget<RichText>(find.descendant(
        of: find.text('Page title'), matching: find.byType(RichText))).text.style;
      await tester.pumpWidget(MaterialApp(theme: theme, home: const PrimePageScaffold(
        title: PrimeText('Page title'), body: Text('Content'))));
      await tester.pumpAndSettle();
      expect(tester.widgetList<Material>(find.byType(Material)).map((m) => m.color).toList(), colors,
        reason: preset);
      expect(tester.widget<RichText>(find.descendant(of: find.text('Page title'),
        matching: find.byType(RichText))).text.style, titleStyle, reason: preset);
      expect(tester.takeException(), isNull, reason: preset);
    }
  });

  testWidgets('shared page keeps drafts through theme updates and navigation back', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    Widget page(ThemeData theme) => MaterialApp(theme: theme, home: const PrimePageScaffold(
      title: PrimeText('Home'), body: TextField(key: Key('draft'))));
    await tester.pumpWidget(page(ThemeData.light()));
    await tester.enterText(find.byKey(const Key('draft')), 'Keep this draft');
    await tester.pumpWidget(page(ThemeData.dark()));
    await tester.pumpAndSettle();
    expect(find.text('Keep this draft'), findsOneWidget);
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.push<void>(MaterialPageRoute(builder: (_) => const PrimePageScaffold(
      title: PrimeText('Details'), body: Text('Details body'))));
    await tester.pumpAndSettle();
    expect(find.byType(BackButton), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Keep this draft'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
