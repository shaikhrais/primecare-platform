import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/registry/widgets/responsive_split_dashboard.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'package:flutter_core/theme/theme_config_generated.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:primecare_ui/src/application/base_primecare_app.dart';
import 'package:primecare_ui/src/components/governance_components.dart';
import 'package:primecare_ui/src/components/clinical_glass_panel.dart';
import 'package:primecare_ui/src/components/prime_components.dart' as shared;
import 'package:primecare_ui/src/components/prime_text.dart';
import 'package:primecare_ui/src/components/prime_icon.dart';
import 'package:primecare_ui/src/components/prime_icon_button.dart';
import 'package:primecare_ui/src/components/layouts/responsive_grid_layout.dart';
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
  testWidgets('shared icon actions preserve themes, target size and callbacks', (tester) async {
    for (final preset in themeCenterPresetNames) {
      final material = applyPersonalThemeData(ThemeData(), PersonalTheme(name: 'Action', preset: preset));
      var taps = 0;
      await tester.pumpWidget(MaterialApp(theme: material, home: Scaffold(body: Row(children: [
        IconButton(key: const Key('original-action'), icon: const PrimeIcon(Icons.refresh), onPressed: () {}),
        PrimeIconButton(key: const Key('shared-action'), icon: const PrimeIcon(Icons.refresh), onPressed: () { taps++; }),
        const PrimeIconButton(key: Key('disabled-action'), icon: PrimeIcon(Icons.refresh), onPressed: null),
      ]))));
      final sharedButton = find.descendant(of: find.byKey(const Key('shared-action')), matching: find.byType(IconButton));
      final disabledButton = find.descendant(of: find.byKey(const Key('disabled-action')), matching: find.byType(IconButton));
      expect(tester.getSize(sharedButton), tester.getSize(find.byKey(const Key('original-action'))), reason: preset);
      RichText rendered(Finder root) => tester.widget<RichText>(find.descendant(of: root, matching: find.byType(RichText)));
      expect(rendered(sharedButton).text.style, rendered(find.byKey(const Key('original-action'))).text.style, reason: preset);
      await tester.tap(find.byKey(const Key('shared-action')));
      await tester.pump();
      expect(taps, 1, reason: preset);
      expect(tester.widget<IconButton>(disabledButton).onPressed, isNull);
      await tester.tap(find.byKey(const Key('disabled-action')));
      await tester.pump();
      expect(taps, 1, reason: preset);
      expect(tester.takeException(), isNull, reason: preset);
    }
  });

  testWidgets('key-first migrated titles retain rendered style across palettes', (tester) async {
    for (final preset in themeCenterPresetNames) {
      final material = applyPersonalThemeData(ThemeData(), PersonalTheme(name: 'Title', preset: preset));
      final style = material.textTheme.headlineSmall!.copyWith(color: material.colorScheme.onSurface);
      await tester.pumpWidget(MaterialApp(theme: material, home: Scaffold(body: Column(children: [
        Text(key: const Key('original-title'), 'Care title', style: style),
        PrimeText(key: const Key('migrated-title'), 'Care title', style: style),
      ]))));
      RichText rendered(String key) => tester.widget<RichText>(find.descendant(
        of: find.byKey(Key(key)), matching: find.byType(RichText)));
      final original = rendered('original-title');
      final migrated = rendered('migrated-title');
      expect(migrated.text.toPlainText(), original.text.toPlainText(), reason: preset);
      expect(migrated.text.style, original.text.style, reason: preset);
      expect(migrated.textScaler, original.textScaler, reason: preset);
      expect(tester.takeException(), isNull, reason: preset);
    }
  });

  testWidgets('shared icons retain inherited and explicit theme colors across palettes', (tester) async {
    for (final preset in themeCenterPresetNames) {
      final material = applyPersonalThemeData(ThemeData(), PersonalTheme(name: 'Icon', preset: preset));
      await tester.pumpWidget(MaterialApp(theme: material, home: Scaffold(body: IconTheme(
        data: IconThemeData(color: material.colorScheme.secondary, size: 29),
        child: Row(children: [
          const PrimeIcon(Icons.star, key: Key('inherited-icon')),
          PrimeIcon(Icons.dashboard_customize_outlined, key: const Key('explicit-icon'),
            color: material.colorScheme.primary, size: 20, semanticLabel: 'Section'),
        ]),
      ))));
      await tester.pump();
      final inherited = tester.widget<RichText>(find.descendant(
        of: find.byKey(const Key('inherited-icon')), matching: find.byType(RichText)));
      expect(inherited.text.style!.color, material.colorScheme.secondary, reason: preset);
      expect(inherited.text.style!.fontSize, 29, reason: preset);
      final explicit = tester.widget<Icon>(find.descendant(
        of: find.byKey(const Key('explicit-icon')), matching: find.byType(Icon)));
      expect(explicit.color, material.colorScheme.primary, reason: preset);
      expect(explicit.size, 20);
      expect(explicit.semanticLabel, 'Section');
      expect(tester.takeException(), isNull, reason: preset);
    }
  });

  testWidgets('inherited shared text preserves enabled and disabled button styles across all palettes', (tester) async {
    for (final preset in themeCenterPresetNames) {
      final material = applyPersonalThemeData(ThemeData(),
        PersonalTheme(name: 'Migration', preset: preset, fontScale: 1.5));
      for (final disabled in [false, true]) {
        await tester.pumpWidget(MaterialApp(theme: material, home: Scaffold(body: Column(children: [
          ElevatedButton(key: const Key('reference-button'), onPressed: disabled ? null : () {},
            child: const Text('Reference label')),
          ElevatedButton(key: const Key('migrated-button'), onPressed: disabled ? null : () {},
            child: const PrimeText('Migrated label')),
        ]))));
        await tester.pumpAndSettle();
        final reference = tester.widget<RichText>(find.descendant(
          of: find.byKey(const Key('reference-button')), matching: find.byType(RichText)));
        final migrated = tester.widget<RichText>(find.descendant(
          of: find.byKey(const Key('migrated-button')), matching: find.byType(RichText)));
        expect(migrated.text.style, reference.text.style, reason: '$preset disabled=$disabled');
        expect(tester.takeException(), isNull, reason: preset);
      }
    }
  });
  testWidgets('shared buttons and data cards follow all palettes and preserve actions', (tester) async {
    const base = PrimeThemeData();
    var presses = 0;
    var ghostPresses = 0;
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Controls', preset: preset, fontScale: 1.5);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      await tester.pumpWidget(PrimeTheme(data: prime, child: MaterialApp(theme: material,
        home: Scaffold(body: SingleChildScrollView(child: Column(children: [
          const PrimeText('Inherited shared text'),
          shared.PrimeButton.primary(label: 'Primary action', onPressed: () => presses++),
          shared.PrimeButton.secondary(label: 'Secondary action', onPressed: () {}),
          shared.PrimeButton(isGhost: true, label: 'Ghost action', onPressed: () => ghostPresses++),
          shared.PrimeButton(label: 'Custom surface action', color: prime.colors.surface, onPressed: () {}),
          const shared.PrimeButton(label: 'Disabled action'),
          SizedBox(height: 200, child: shared.PrimeCareStatCard(title: 'Shared stat', value: '42',
            icon: Icons.analytics, iconColor: prime.colors.primary, deltaSuffix: '+1')),
          SizedBox(height: 220, child: DenseHighResTable(title: 'Shared table',
            headers: const ['Value'], rows: const [[Text('Record')]])),
          shared.EmergencyFab(onPressed: () {}),
        ]))))));
      await tester.pumpAndSettle();
      final inheritedText = tester.widget<RichText>(find.descendant(
        of: find.byType(PrimeText), matching: find.byType(RichText)));
      expect(inheritedText.text.style!.color, material.textTheme.bodyMedium!.color, reason: preset);
      expect(inheritedText.text.style!.fontSize, material.textTheme.bodyMedium!.fontSize, reason: preset);
      for (final label in ['Primary action', 'Secondary action', 'Ghost action', 'Custom surface action']) {
        final text = tester.widget<Text>(find.text(label));
        final background = label == 'Primary action' ? prime.colors.primary : prime.colors.surface;
        expect(themeContrastRatio(background, text.style!.color!), greaterThanOrEqualTo(4.5),
          reason: '$preset: $label');
      }
      final secondary = tester.widget<ElevatedButton>(find.ancestor(
        of: find.text('Secondary action'), matching: find.byType(ElevatedButton)));
      expect(secondary.style!.backgroundColor!.resolve({})!.a, 0, reason: preset);
      final disabled = tester.widget<ElevatedButton>(find.ancestor(
        of: find.text('Disabled action'), matching: find.byType(ElevatedButton)));
      expect(disabled.onPressed, isNull);
      expect(tester.widget<Text>(find.text('Disabled action')).style!.color,
        prime.colors.onSurface.withValues(alpha: 0.38));
      for (final type in [shared.PrimeCareStatCard, DenseHighResTable]) {
        final decorations = tester.widgetList<Container>(find.descendant(of: find.byType(type),
          matching: find.byType(Container))).map((widget) => widget.decoration).whereType<BoxDecoration>();
        expect(decorations.any((decoration) => decoration.color == prime.colors.surface), isTrue,
          reason: '$preset: $type');
      }
      final emergency = tester.widget<FloatingActionButton>(find.byType(FloatingActionButton));
      expect(emergency.backgroundColor, prime.colors.error);
      expect(emergency.foregroundColor, material.colorScheme.onError);
      final before = presses;
      await tester.ensureVisible(find.text('Primary action'));
      await tester.tap(find.text('Primary action'));
      expect(presses, before + 1);
      final ghostBefore = ghostPresses;
      await tester.ensureVisible(find.text('Ghost action'));
      await tester.tap(find.text('Ghost action'));
      expect(ghostPresses, ghostBefore + 1, reason: preset);
      expect(tester.takeException(), isNull, reason: preset);
    }
  });


  testWidgets('clinical panel follows every palette and wraps scaled mobile headings', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    const base = PrimeThemeData();
    const title = 'Clinical dashboard heading with enough detail to wrap';
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Panel', preset: preset, fontScale: 1.5);
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      await tester.pumpWidget(PrimeTheme(data: prime, child: MaterialApp(theme: material,
        home: const Scaffold(body: ClinicalGlassPanel(title: title,
          icon: Icons.health_and_safety, child: SizedBox(height: 20))))));
      await tester.pumpAndSettle();
      final heading = tester.widget<Text>(find.text(title));
      expect(heading.style!.color, prime.colors.onSurface, reason: preset);
      expect(heading.style!.fontSize, prime.typography.bodyLarge.fontSize, reason: preset);
      final decorations = tester.widgetList<Container>(find.descendant(
        of: find.byType(ClinicalGlassPanel), matching: find.byType(Container)))
        .map((widget) => widget.decoration).whereType<BoxDecoration>().toList();
      final shadow = decorations.expand((decoration) => decoration.boxShadow ?? <BoxShadow>[]).single;
      expect(shadow.color, material.colorScheme.shadow.withValues(alpha: 0.2), reason: preset);
      final gradient = decorations.map((decoration) => decoration.gradient).whereType<LinearGradient>().single;
      expect(gradient.colors.last, prime.colors.primary.withValues(alpha: 0), reason: preset);
      expect(tester.takeException(), isNull, reason: preset);
    }
  });

  test('tenant palette adapters retain readable surfaces and semantic foregrounds', () {
    for (final preset in themeCenterPresetNames) {
      final palette = ThemeConfig.getAppPalette(preset);
      final colors = PrimeColors.fromPalette(palette);
      final material = PrimeThemeData(colors: colors).toThemeData();
      expect(colors.dashboardBackground, palette.background, reason: preset);
      expect(colors.surfaceContainer, palette.surface, reason: preset);
      expect(material.brightness, ThemeData.estimateBrightnessForColor(palette.surface), reason: preset);
      for (final pair in [
        [colors.surface, colors.onSurface],
        [colors.surface, colors.onSurfaceVariant],
        [material.colorScheme.surface, material.colorScheme.onSurfaceVariant],
        [colors.sidebarBackground, colors.sidebarTextColor],
        [colors.sidebarBackground, colors.sidebarIconColor],
        [colors.sidebarSelectedTileColor, colors.sidebarSelectedTextColor],
        [colors.sidebarSelectedTileColor, colors.sidebarSelectedIconColor],
        [colors.topbarBackground, colors.topbarTextColor],
        [colors.topbarBackground, colors.topbarIconColor],
        [material.colorScheme.secondary, material.colorScheme.onSecondary],
        [material.colorScheme.tertiary, material.colorScheme.onTertiary],
        [material.colorScheme.error, material.colorScheme.onError],
      ]) {
        expect(themeContrastRatio(pair[0], pair[1]), greaterThanOrEqualTo(4.5), reason: preset);
      }
    }
  });

  test('all resolved themes retain Material brightness and semantic roles on round trip', () {
    const base = PrimeThemeData();
    for (final preset in themeCenterPresetNames) {
      final profile = PersonalTheme(name: 'Round trip', preset: preset,
        fontScale: 1.5, radius: 20).validated();
      final material = applyPersonalThemeData(base.toThemeData(), profile);
      final prime = resolvePersonalPrimeTheme(base, material, profile);
      final restored = prime.toThemeData();
      expect(restored, same(material), reason: preset);
      expect(restored.brightness, material.brightness, reason: preset);
      expect(restored.colorScheme, material.colorScheme, reason: preset);
      expect(restored.textTheme, material.textTheme, reason: preset);
      expect(restored.inputDecorationTheme, material.inputDecorationTheme, reason: preset);
      expect(prime.colors.errorContainer, material.colorScheme.errorContainer);
      expect(prime.colors.onErrorContainer, material.colorScheme.onErrorContainer);
      expect(prime.colors.secondaryContainer, material.colorScheme.secondaryContainer);
      expect(prime.colors.inverseSurface, material.colorScheme.inverseSurface);
      expect(prime.colors.inverseOnSurface, material.colorScheme.onInverseSurface);
      expect(prime.colors.surfaceContainer, material.colorScheme.surfaceContainer, reason: preset);
      expect(prime.colors.surfaceContainerLow, material.colorScheme.surfaceContainerLow, reason: preset);
      expect(prime.colors.surfaceContainerHigh, material.colorScheme.surfaceContainerHigh, reason: preset);
      expect(prime.colors.surfaceContainerLowest, material.colorScheme.surfaceContainerLowest, reason: preset);
      expect(prime.colors.surfaceContainerHighest, material.colorScheme.surfaceContainerHighest, reason: preset);
    }
  });

  test('personal adapter preserves distinct Material surface elevation roles', () {
    const base = PrimeThemeData();
    final material = ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal).copyWith(
      surface: const Color(0xff101010),
      surfaceContainerLowest: const Color(0xff202020),
      surfaceContainerLow: const Color(0xff303030),
      surfaceContainer: const Color(0xff404040),
      surfaceContainerHigh: const Color(0xff505050),
      surfaceContainerHighest: const Color(0xff606060),
    ));
    final colors = resolvePersonalPrimeTheme(base, material, PersonalTheme(name: 'Surfaces', preset: 'default')).colors;
    expect(colors.surface, material.colorScheme.surface);
    expect(colors.surfaceContainerLowest, material.colorScheme.surfaceContainerLowest);
    expect(colors.surfaceContainerLow, material.colorScheme.surfaceContainerLow);
    expect(colors.surfaceContainer, material.colorScheme.surfaceContainer);
    expect(colors.surfaceContainerHigh, material.colorScheme.surfaceContainerHigh);
    expect(colors.surfaceContainerHighest, material.colorScheme.surfaceContainerHighest);
  });

  test('base Material adapter retains configured semantic and fixed colors', () {
    const custom = Color(0xff123456);
    const colors = PrimeColors(
      inversePrimary: custom,
      secondaryContainer: custom,
      tertiaryContainer: custom,
      surfaceDim: custom,
      surfaceBright: custom,
      surfaceContainerLowest: custom,
      surfaceContainerLow: custom,
      surfaceContainerHigh: custom,
      surfaceContainerHighest: custom,
      inverseSurface: custom,
      surfaceTint: custom,
      outlineVariant: custom,
      errorContainer: custom,
      onErrorContainer: custom,
      primaryFixed: custom,
      primaryFixedDim: custom,
      onPrimaryFixed: custom,
      onPrimaryFixedVariant: custom,
      secondaryFixed: custom,
      secondaryFixedDim: custom,
      onSecondaryFixed: custom,
      onSecondaryFixedVariant: custom,
      tertiaryFixed: custom,
      tertiaryFixedDim: custom,
      onTertiaryFixed: custom,
      onTertiaryFixedVariant: custom,
      inverseOnSurface: custom,
      onSurfaceVariant: custom,
    );
    final scheme = const PrimeThemeData(colors: colors).toThemeData().colorScheme;
    expect(scheme.inversePrimary, colors.inversePrimary);
    expect(scheme.secondaryContainer, colors.secondaryContainer);
    expect(scheme.tertiaryContainer, colors.tertiaryContainer);
    expect(scheme.surfaceDim, colors.surfaceDim);
    expect(scheme.surfaceBright, colors.surfaceBright);
    expect(scheme.surfaceContainerLowest, colors.surfaceContainerLowest);
    expect(scheme.surfaceContainerLow, colors.surfaceContainerLow);
    expect(scheme.surfaceContainerHigh, colors.surfaceContainerHigh);
    expect(scheme.surfaceContainerHighest, colors.surfaceContainerHighest);
    expect(scheme.inverseSurface, colors.inverseSurface);
    expect(scheme.surfaceTint, colors.surfaceTint);
    expect(scheme.outlineVariant, colors.outlineVariant);
    expect(scheme.errorContainer, colors.errorContainer);
    expect(scheme.onErrorContainer, colors.onErrorContainer);
    expect(scheme.primaryFixed, colors.primaryFixed);
    expect(scheme.primaryFixedDim, colors.primaryFixedDim);
    expect(scheme.onPrimaryFixed, colors.onPrimaryFixed);
    expect(scheme.onPrimaryFixedVariant, colors.onPrimaryFixedVariant);
    expect(scheme.secondaryFixed, colors.secondaryFixed);
    expect(scheme.secondaryFixedDim, colors.secondaryFixedDim);
    expect(scheme.onSecondaryFixed, colors.onSecondaryFixed);
    expect(scheme.onSecondaryFixedVariant, colors.onSecondaryFixedVariant);
    expect(scheme.tertiaryFixed, colors.tertiaryFixed);
    expect(scheme.tertiaryFixedDim, colors.tertiaryFixedDim);
    expect(scheme.onTertiaryFixed, colors.onTertiaryFixed);
    expect(scheme.onTertiaryFixedVariant, colors.onTertiaryFixedVariant);
    expect(scheme.onInverseSurface, colors.inverseOnSurface);
    expect(scheme.onSurfaceVariant, colors.onSurfaceVariant);
  });

  test('copying colors preserves custom semantic and fixed tokens', () {
    const custom = Color(0xff123456);
    const original = PrimeColors(secondaryContainer: custom, tertiaryContainer: custom,
      inversePrimary: custom, inverseSurface: custom, inverseOnSurface: custom,
      surfaceDim: custom, surfaceBright: custom, surfaceTint: custom,
      primaryFixed: custom, onPrimaryFixed: custom, secondaryFixed: custom,
      onSecondaryFixed: custom, tertiaryFixed: custom, onTertiaryFixed: custom);
    final copied = original.copyWith(primary: Colors.red);
    expect(copied.primary, Colors.red);
    for (final value in [copied.secondaryContainer, copied.tertiaryContainer,
      copied.inversePrimary, copied.inverseSurface, copied.inverseOnSurface,
      copied.surfaceDim, copied.surfaceBright, copied.surfaceTint,
      copied.primaryFixed, copied.onPrimaryFixed, copied.secondaryFixed,
      copied.onSecondaryFixed, copied.tertiaryFixed, copied.onTertiaryFixed]) {
      expect(value, custom);
    }
    expect(copied.copyWith(secondaryContainer: Colors.blue).secondaryContainer, Colors.blue);
  });

  testWidgets('shared panels switch theme without dropping input and fit large mobile text', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(dashboard(PersonalTheme(name: 'Light', preset: 'default')));
    await tester.pumpAndSettle();
    final lightForeground = tester.widget<Text>(find.text('Saved appearance')).style!.color!;
    await tester.enterText(find.byKey(const Key('unfinished')), 'keep this draft');
    await tester.pumpWidget(dashboard(PersonalTheme(name: 'Dark', preset: 'dark1',
      fontScale: 1.5, radius: 20, colors: {'primary': '#ffffff'})));
    await tester.pumpAndSettle();
    expect(find.text('keep this draft'), findsOneWidget);
    final foreground = tester.widget<Text>(find.text('Saved appearance')).style!.color!;
    final material = tester.widget<MaterialApp>(find.byType(MaterialApp)).theme!;
    // A readable preset foreground must survive the custom primary override.
    expect(material.colorScheme.primary, Colors.white);
    expect(material.colorScheme.onPrimary, ThemeConfig.getAppPalette('dark1').onPrimary);
    expect(foreground, material.colorScheme.onPrimary);
    expect(foreground, isNot(lightForeground));
    final heroContainers = tester.widgetList<Container>(find.descendant(
      of: find.byType(GovDashboardHero), matching: find.byType(Container)));
    final gradients = heroContainers
        .map((container) => container.decoration)
        .whereType<BoxDecoration>()
        .map((decoration) => decoration.gradient)
        .whereType<LinearGradient>()
        .toList();
    expect(gradients, hasLength(1));
    expect(gradients.single.colors.first, material.colorScheme.primary);
    for (final stop in gradients.single.colors) {
      expect(themeContrastRatio(stop, foreground), greaterThanOrEqualTo(4.5));
    }
    final cards = tester.widgetList<Card>(find.byType(Card));
    expect(cards.length, 2);
    final input = material.inputDecorationTheme;
    expect(input.fillColor, material.colorScheme.surface);
    expect(themeContrastRatio(input.fillColor!, material.colorScheme.onSurface), greaterThanOrEqualTo(4.5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('metric badge follows configured shared semantic colors', (tester) async {
    const colors = PrimeColors(successContainer: Color(0xff103030), success: Color(0xff80ffff));
    const theme = PrimeThemeData(colors: colors);
    await tester.pumpWidget(PrimeTheme(data: theme, child: MaterialApp(theme: theme.toThemeData(),
      home: const Scaffold(body: GovMetricCard(title: 'Metric', value: '42',
        trendLabel: 'Custom status', progress: .5, icon: Icons.analytics, brandColor: Colors.teal)))));
    await tester.pumpAndSettle();
    final label = tester.widget<Text>(find.text('Custom status'));
    expect(label.style!.color, readableThemeForeground(colors.successContainer, colors.success));
    final containers = tester.widgetList<Container>(find.ancestor(of: find.text('Custom status'), matching: find.byType(Container)));
    expect(containers.map((widget) => widget.decoration).whereType<BoxDecoration>()
      .any((decoration) => decoration.color == colors.successContainer), isTrue);
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
