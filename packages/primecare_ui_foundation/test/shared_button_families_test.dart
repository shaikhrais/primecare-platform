import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';

typedef ButtonBuilder = Widget Function(VoidCallback? callback, ButtonStyle? style);

void main() {
  testWidgets('all shared default and icon buttons retain theme geometry and disabled styles', (tester) async {
    for (final brightness in Brightness.values) {
      final theme = ThemeData(brightness: brightness);
      for (final enabled in [true, false]) {
        var presses = 0;
        final VoidCallback? callback = enabled ? () { presses++; } : null;
        final originals = <ButtonBuilder>[
          (cb, style) => TextButton(onPressed: cb, style: style, child: const Text('Action')),
          (cb, style) => ElevatedButton(onPressed: cb, style: style, child: const Text('Action')),
          (cb, style) => OutlinedButton(onPressed: cb, style: style, child: const Text('Action')),
          (cb, style) => TextButton.icon(onPressed: cb, style: style, icon: const Icon(Icons.add), label: const Text('Action')),
          (cb, style) => ElevatedButton.icon(onPressed: cb, style: style, icon: const Icon(Icons.add), label: const Text('Action')),
          (cb, style) => OutlinedButton.icon(onPressed: cb, style: style, icon: const Icon(Icons.add), label: const Text('Action')),
        ];
        final shared = <ButtonBuilder>[
          (cb, style) => PrimeTextButton(onPressed: cb, style: style, child: const PrimeText('Action')),
          (cb, style) => PrimeElevatedButton(onPressed: cb, style: style, child: const PrimeText('Action')),
          (cb, style) => PrimeOutlinedButton(onPressed: cb, style: style, child: const PrimeText('Action')),
          (cb, style) => PrimeTextButton.icon(onPressed: cb, style: style, icon: const PrimeIcon(Icons.add), label: const PrimeText('Action')),
          (cb, style) => PrimeElevatedButton.icon(onPressed: cb, style: style, icon: const PrimeIcon(Icons.add), label: const PrimeText('Action')),
          (cb, style) => PrimeOutlinedButton.icon(onPressed: cb, style: style, icon: const PrimeIcon(Icons.add), label: const PrimeText('Action')),
        ];
        for (var i = 0; i < originals.length; i++) {
          await tester.pumpWidget(MaterialApp(theme: theme, home: Scaffold(body: Column(children: [
            KeyedSubtree(key: const Key('original'), child: originals[i](callback, null)),
            KeyedSubtree(key: const Key('shared'), child: shared[i](callback, null)),
          ]))));
          await tester.pumpAndSettle();
          expect(tester.getSize(find.byKey(const Key('shared'))), tester.getSize(find.byKey(const Key('original'))));
          RichText rendered(String key) => tester.widget<RichText>(find.descendant(
            of: find.byKey(Key(key)), matching: find.byType(RichText)).first);
          expect(rendered('shared').text.style, rendered('original').text.style);
          final before = presses;
          await tester.tap(find.byKey(const Key('shared')));
          await tester.pumpAndSettle();
          expect(presses, before + (enabled ? 1 : 0));
          expect(tester.takeException(), isNull, reason: '$brightness/$enabled/$i');
        }
      }
    }
  });

  test('style factories retain every supplied state and size option', () {
    const foreground = Colors.indigo;
    const background = Colors.amber;
    const disabledForeground = Colors.grey;
    const disabledBackground = Colors.black12;
    final styles = <(ButtonStyle, ButtonStyle)>[
      (TextButton.styleFrom(foregroundColor: foreground, backgroundColor: background,
        disabledForegroundColor: disabledForeground, disabledBackgroundColor: disabledBackground,
        elevation: 3, minimumSize: const Size(70, 45), padding: const EdgeInsets.all(9)),
       PrimeTextButton.styleFrom(foregroundColor: foreground, backgroundColor: background,
        disabledForegroundColor: disabledForeground, disabledBackgroundColor: disabledBackground,
        elevation: 3, minimumSize: const Size(70, 45), padding: const EdgeInsets.all(9))),
      (ElevatedButton.styleFrom(foregroundColor: foreground, backgroundColor: background,
        disabledForegroundColor: disabledForeground, disabledBackgroundColor: disabledBackground,
        elevation: 3, minimumSize: const Size(70, 45), padding: const EdgeInsets.all(9)),
       PrimeElevatedButton.styleFrom(foregroundColor: foreground, backgroundColor: background,
        disabledForegroundColor: disabledForeground, disabledBackgroundColor: disabledBackground,
        elevation: 3, minimumSize: const Size(70, 45), padding: const EdgeInsets.all(9))),
      (OutlinedButton.styleFrom(foregroundColor: foreground, backgroundColor: background,
        disabledForegroundColor: disabledForeground, disabledBackgroundColor: disabledBackground,
        elevation: 3, minimumSize: const Size(70, 45), padding: const EdgeInsets.all(9)),
       PrimeOutlinedButton.styleFrom(foregroundColor: foreground, backgroundColor: background,
        disabledForegroundColor: disabledForeground, disabledBackgroundColor: disabledBackground,
        elevation: 3, minimumSize: const Size(70, 45), padding: const EdgeInsets.all(9))),
    ];
    for (final (original, shared) in styles) {
      for (final states in [<WidgetState>{}, {WidgetState.disabled}, {WidgetState.pressed}, {WidgetState.hovered}, {WidgetState.focused}]) {
        expect(shared.foregroundColor?.resolve(states), original.foregroundColor?.resolve(states));
        expect(shared.backgroundColor?.resolve(states), original.backgroundColor?.resolve(states));
        expect(shared.overlayColor?.resolve(states), original.overlayColor?.resolve(states));
        expect(shared.elevation?.resolve(states), original.elevation?.resolve(states));
        expect(shared.minimumSize?.resolve(states), original.minimumSize?.resolve(states));
        expect(shared.padding?.resolve(states), original.padding?.resolve(states));
      }
    }
  });

  testWidgets('focus and caller-owned state controller reach the actual SDK button', (tester) async {
    final focus = FocusNode();
    final states = WidgetStatesController();
    addTearDown(focus.dispose);
    addTearDown(states.dispose);
    final style = PrimeTextButton.styleFrom(minimumSize: const Size(90, 50));
    var focused = false;
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: PrimeTextButton(
      focusNode: focus, autofocus: true, statesController: states,
      onFocusChange: (value) { focused = value; }, style: style,
      onPressed: () {}, child: const PrimeText('Focus action'),
    ))));
    await tester.pumpAndSettle();
    final delegate = tester.widget<TextButton>(find.byType(TextButton));
    expect(delegate.focusNode, same(focus));
    expect(delegate.statesController, same(states));
    expect(delegate.style, same(style));
    expect(focus.hasFocus, isTrue);
    expect(focused, isTrue);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
