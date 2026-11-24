import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' show debugDisableShadows;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/prime_account_trigger_focus_frame.dart';
import 'package:flutter_core/theme/theme_contrast.dart';

Finder findAccountPopupItem(String label) => find.ancestor(
  of: find.text(label),
  matching: find.byWidgetPredicate((widget) => widget is PopupMenuItem<String>),
);

bool _hasFocusWithin(Element target) {
  final focused = FocusManager.instance.primaryFocus?.context;
  if (focused == target) return true;
  var within = false;
  focused?.visitAncestorElements((element) {
    within = element == target;
    return !within;
  });
  return within;
}

/// Exercises the actual focus order, without requesting focus on the target.
Future<void> verifyAccountKeyboard(
  WidgetTester tester, {
  required Finder trigger,
  required Finder frame,
  required String focusGolden,
  required String openGolden,
}) async {
  final target = tester.element(trigger);
  for (var i = 0; i < 20 && !_hasFocusWithin(target); i++) {
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
  }
  expect(_hasFocusWithin(target), isTrue);
  await tester.pumpAndSettle();
  final triggerInk = find.descendant(of: trigger, matching: find.byType(InkWell));
  expect(triggerInk, findsOneWidget);
  expect(Theme.of(tester.element(triggerInk)).focusColor, Colors.transparent);
  final focusFrame = find.descendant(
    of: trigger,
    matching: find.byType(PrimeAccountTriggerFocusFrame),
  );
  final surface =
      tester.widget<PrimeAccountTriggerFocusFrame>(focusFrame).surface;
  final outline = tester.widget<DecoratedBox>(
    find.descendant(
      of: focusFrame,
      matching: find.byKey(PrimeAccountTriggerFocusFrame.outlineKey),
    ),
  ).decoration as BoxDecoration;
  final color = (outline.border! as Border).top.color;
  expect(
    themeContrastRatio(color, surface),
    greaterThanOrEqualTo(3),
  );
  await expectLater(frame, matchesGoldenFile(focusGolden));

  final previousShadowMode = debugDisableShadows;
  debugDisableShadows = false;
  try {
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    await expectLater(frame, matchesGoldenFile(openGolden));
  } finally {
    debugDisableShadows = previousShadowMode;
  }
  final signOut = findAccountPopupItem('Sign out');
  expect(signOut, findsOneWidget);
  expect(findAccountPopupItem('Switch role'), findsNothing);
  final signOutElement = tester.element(signOut);
  for (var i = 0; i < 3 && !_hasFocusWithin(signOutElement); i++) {
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
  }
  expect(_hasFocusWithin(signOutElement), isTrue);
  final menuInk = find.descendant(of: signOut, matching: find.byType(InkWell));
  expect(menuInk, findsOneWidget);
  expect(
    Theme.of(tester.element(menuInk)).focusColor,
    Theme.of(target).focusColor,
  );

  await tester.sendKeyEvent(LogicalKeyboardKey.escape);
  await tester.pumpAndSettle();
  expect(signOut, findsNothing);
  expect(_hasFocusWithin(target), isTrue);
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
}
