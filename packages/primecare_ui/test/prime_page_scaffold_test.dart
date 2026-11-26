import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:primecare_ui/src/components/prime_page_scaffold.dart';
import 'package:primecare_ui/src/components/prime_workspace_scaffold.dart';
import 'package:primecare_ui/src/components/prime_icon_button.dart';
import 'package:primecare_ui/src/components/prime_icon.dart';
import 'package:primecare_ui/src/components/prime_text.dart';

void main() {
  testWidgets('basic shell key identifies inner Scaffold and retains its state across theme changes', (tester) async {
    Widget page(ThemeData theme) => MaterialApp(theme: theme, home: const PrimePageScaffold(
      key: Key('wrapper'), scaffoldKey: Key('care-scaffold'),
      title: PrimeText('Care'), body: TextField(key: Key('keyed-draft'))));
    await tester.pumpWidget(page(ThemeData.light()));
    expect(tester.widget(find.byKey(const Key('wrapper'))), isA<PrimePageScaffold>());
    final state = tester.state<ScaffoldState>(find.byKey(const Key('care-scaffold')));
    await tester.enterText(find.byKey(const Key('keyed-draft')), 'Retain notes');
    await tester.pumpWidget(page(ThemeData.dark()));
    await tester.pumpAndSettle();
    expect(tester.state<ScaffoldState>(find.byKey(const Key('care-scaffold'))), same(state));
    expect(find.text('Retain notes'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shared workspace preserves keyed scaffold, header rendering and refresh', (tester) async {
    for (final preset in themeCenterPresetNames) {
      final theme = applyPersonalThemeData(ThemeData(), PersonalTheme(name: 'Workspace', preset: preset));
      var refreshes = 0;
      final actions = [PrimeIconButton(key: const Key('refresh'),
        icon: PrimeIcon(Icons.refresh, color: theme.colorScheme.primary), onPressed: () { refreshes++; })];
      final title = PrimeText('Care workspace', style: theme.textTheme.headlineSmall);
      await tester.pumpWidget(MaterialApp(theme: theme, home: Scaffold(
        key: const Key('workspace'), backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(backgroundColor: theme.colorScheme.surfaceContainer, elevation: 0,
          title: title, actions: actions), body: const Text('Care content'))));
      await tester.pumpAndSettle();
      final colors = tester.widgetList<Material>(find.byType(Material)).map((m) => m.color).toList();
      final titleStyle = tester.widget<RichText>(find.descendant(
        of: find.text('Care workspace'), matching: find.byType(RichText))).text.style;
      await tester.pumpWidget(MaterialApp(theme: theme, home: PrimeWorkspaceScaffold(
        scaffoldKey: const Key('workspace'), backgroundColor: theme.colorScheme.surface,
        headerColor: theme.colorScheme.surfaceContainer, title: title, actions: actions,
        body: const Text('Care content'))));
      await tester.pumpAndSettle();
      expect(tester.widget(find.byKey(const Key('workspace'))), isA<Scaffold>());
      expect(tester.widgetList<Material>(find.byType(Material)).map((m) => m.color).toList(), colors, reason: preset);
      expect(tester.widget<RichText>(find.descendant(of: find.text('Care workspace'),
        matching: find.byType(RichText))).text.style, titleStyle, reason: preset);
      await tester.tap(find.byKey(const Key('refresh')));
      await tester.pumpAndSettle();
      expect(refreshes, 1, reason: preset);
      expect(tester.takeException(), isNull, reason: preset);
    }
  });

  testWidgets('workspace keeps draft when active colors change and navigates back', (tester) async {
    Widget page(ThemeData theme) => MaterialApp(theme: theme, home: PrimeWorkspaceScaffold(
      scaffoldKey: const Key('workspace'), backgroundColor: theme.colorScheme.surface,
      headerColor: theme.colorScheme.surfaceContainer, title: const PrimeText('Home'), actions: null,
      body: const TextField(key: Key('workspace-draft'))));
    await tester.pumpWidget(page(ThemeData.light()));
    await tester.enterText(find.byKey(const Key('workspace-draft')), 'Keep care notes');
    await tester.pumpWidget(page(ThemeData.dark()));
    await tester.pumpAndSettle();
    expect(find.text('Keep care notes'), findsOneWidget);
    expect(tester.widget<Scaffold>(find.byKey(const Key('workspace'))).backgroundColor, ThemeData.dark().colorScheme.surface);
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.push<void>(MaterialPageRoute(builder: (context) {
      final theme = Theme.of(context);
      return PrimeWorkspaceScaffold(backgroundColor: theme.colorScheme.surface,
        headerColor: theme.colorScheme.surfaceContainer, title: const PrimeText('Details'),
        actions: null, body: const Text('Details content'));
    }));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Keep care notes'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

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
