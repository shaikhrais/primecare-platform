import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' show debugDisableShadows;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

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
  final signOut = find.widgetWithText(PopupMenuItem<String>, 'Sign out');
  expect(signOut, findsOneWidget);
  expect(find.widgetWithText(PopupMenuItem<String>, 'Switch role'), findsNothing);
  final signOutElement = tester.element(signOut);
  for (var i = 0; i < 3 && !_hasFocusWithin(signOutElement); i++) {
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
  }
  expect(_hasFocusWithin(signOutElement), isTrue);

  await tester.sendKeyEvent(LogicalKeyboardKey.escape);
  await tester.pumpAndSettle();
  expect(signOut, findsNothing);
  expect(_hasFocusWithin(target), isTrue);
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
}
