import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/registry/widgets/responsive_split_dashboard.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'package:primecare_ui/src/application/base_primecare_app.dart';
import 'package:primecare_ui/src/components/governance_components.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import 'fixtures/generated_theme_fixture.dart';

Widget dashboard(PersonalTheme personal) {
  const base = PrimeThemeData();
  final material = applyPersonalThemeData(base.toThemeData(), personal);
  return ProviderScope(child: PrimeTheme(data: resolvePersonalPrimeTheme(base, material, personal),
    child: MaterialApp(theme: material, home: Scaffold(body: SingleChildScrollView(child: Column(children: [
      const GovDashboardHero(title: 'Saved appearance', roleName: 'Platform administrator',
        description: 'A shared header at the selected text size.'),
      const GovMetricCard(title: 'Metric', value: '42', trendLabel: 'Stable', progress: .5,
        icon: Icons.analytics, brandColor: Colors.teal),
      QuickActionsPanel(actions: [QuickActionItem(label: 'Review', icon: Icons.search,
        color: Colors.teal, onTap: () {})]),
      const RecentActivityFeed(activities: [PortalActivityItem(title: 'Changed',
        description: 'Appearance updated', time: 'Now', icon: Icons.check, color: Colors.green)]),
      const AiInsightsCard(heading: 'Insight', suggestions: ['Review available records']),
      const TextField(key: Key('unfinished'), decoration: InputDecoration(labelText: 'Reference')),
    ]))))));
}

void main() {
  testWidgets('shared panels switch theme without dropping input and fit large mobile text', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(dashboard(PersonalTheme(name: 'Light', preset: 'default')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('unfinished')), 'keep this draft');
    await tester.pumpWidget(dashboard(PersonalTheme(name: 'Dark', preset: 'dark1',
      fontScale: 1.5, radius: 20, colors: {'primary': '#ffffff'})));
    await tester.pumpAndSettle();
    expect(find.text('keep this draft'), findsOneWidget);
    final primary = tester.widget<Text>(find.text('Saved appearance')).style!.color!;
    expect(primary, Colors.black);
    final cards = tester.widgetList<Card>(find.byType(Card));
    expect(cards.length, 2);
    final material = tester.widget<MaterialApp>(find.byType(MaterialApp)).theme!;
    final input = material.inputDecorationTheme;
    expect(input.fillColor, material.colorScheme.surface);
    expect(themeContrastRatio(input.fillColor!, material.colorScheme.onSurface), greaterThanOrEqualTo(4.5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('new generated screen uses inherited surfaces and scaled text', (tester) async {
    const base = PrimeThemeData();
    final personal = PersonalTheme(name: 'Generated', preset: 'dark1', fontScale: 1.5, radius: 20);
    final material = applyPersonalThemeData(base.toThemeData(), personal);
    await tester.pumpWidget(ProviderScope(overrides: [theme_fixtureDataProvider.overrideWith((ref) async => <String,dynamic>{})],
      child: PrimeTheme(data: resolvePersonalPrimeTheme(base, material, personal), child: MaterialApp(theme: material,
        home: Consumer(builder: (context,ref,_) => const ThemeFixtureScreen().buildScreen(context,ref))))));
    await tester.pumpAndSettle();
    expect(tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor, material.scaffoldBackgroundColor);
    final heading = tester.widget<Text>(find.text('ThemeFixtureScreen'));
    expect(heading.style!.color, material.colorScheme.onSurface);
    expect(heading.style!.fontSize, 17 * 1.5);
    expect(tester.takeException(), isNull);
  });
}
