import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';

void main() {
  testWidgets('shared primitives retain inherited typography, icon theme and scaling', (tester) async {
    for (final brightness in Brightness.values) {
      final theme = ThemeData(colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF126782), brightness: brightness));
      final textStyle = theme.textTheme.bodyLarge!.copyWith(fontSize: 19, fontWeight: FontWeight.w600);
      await tester.pumpWidget(MaterialApp(theme: theme, home: Scaffold(body: MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(1.5)),
        child: DefaultTextStyle(style: textStyle, child: IconTheme(
          data: IconThemeData(color: theme.colorScheme.secondary, size: 29),
          child: const Column(children: [
            Text('Inherited', key: Key('original-text')),
            PrimeText('Inherited', key: Key('shared-text')),
            Icon(Icons.star, key: Key('original-icon')),
            PrimeIcon(Icons.star, key: Key('shared-icon')),
          ]),
        )),
      ))));
      RichText rendered(String key) => tester.widget<RichText>(find.descendant(
        of: find.byKey(Key(key)), matching: find.byType(RichText)));
      expect(rendered('shared-text').text.style, rendered('original-text').text.style);
      expect(rendered('shared-text').text.toPlainText(), 'Inherited');
      expect(rendered('shared-text').textScaler.scale(19), 28.5);
      expect(rendered('shared-icon').text.style, rendered('original-icon').text.style);
      expect(tester.getSize(find.byKey(const Key('shared-icon'))),
        tester.getSize(find.byKey(const Key('original-icon'))));
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('null shared text style inherits enabled and disabled button colors', (tester) async {
    for (final brightness in Brightness.values) {
      final theme = ThemeData(brightness: brightness);
      await tester.pumpWidget(MaterialApp(theme: theme, home: Scaffold(body: Column(children: [
        TextButton(onPressed: () {}, child: const Text('Action', key: Key('original-enabled'))),
        TextButton(onPressed: () {}, child: const PrimeText('Action', key: Key('shared-enabled'))),
        const TextButton(onPressed: null, child: Text('Action', key: Key('original-disabled'))),
        const TextButton(onPressed: null, child: PrimeText('Action', key: Key('shared-disabled'))),
      ]))));
      RichText rendered(String key) => tester.widget<RichText>(find.descendant(
        of: find.byKey(Key(key)), matching: find.byType(RichText)));
      for (final state in ['enabled', 'disabled']) {
        expect(rendered('shared-$state').text.style, rendered('original-$state').text.style);
      }
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('caller overrides, semantics, direction and wrapping remain intact', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SizedBox(width: 100,
      child: Column(children: [
        PrimeText('A deliberately long shared label', key: Key('wrapped'),
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.end),
        PrimeIcon(Icons.arrow_back, key: Key('semantic-icon'), size: 31,
          semanticLabel: 'Go back', textDirection: TextDirection.rtl),
      ]),
    ))));
    final text = tester.widget<Text>(find.descendant(of: find.byKey(const Key('wrapped')), matching: find.byType(Text)));
    expect(text.maxLines, 2);
    expect(text.overflow, TextOverflow.ellipsis);
    expect(text.textAlign, TextAlign.end);
    expect(text.style!.fontSize, 21);
    final icon = tester.widget<Icon>(find.descendant(of: find.byKey(const Key('semantic-icon')), matching: find.byType(Icon)));
    expect(icon.textDirection, TextDirection.rtl);
    expect(icon.size, 31);
    expect(find.bySemanticsLabel('Go back'), findsOneWidget);
    expect(tester.takeException(), isNull);
    semantics.dispose();
  });
}
