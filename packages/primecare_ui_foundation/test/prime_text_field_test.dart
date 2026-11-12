import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';

void main() {
  testWidgets('PrimeTextField forwards reviewed SDK fields to the actual input',
      (tester) async {
    final controller = TextEditingController(text: 'draft');
    final focusNode = FocusNode();
    addTearDown(controller.dispose);
    addTearDown(focusNode.dispose);
    String? changed;
    String? submitted;
    const key = ValueKey('actual-field');

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PrimeTextField(
          key: key,
          controller: controller,
          focusNode: focusNode,
          decoration: const InputDecoration(labelText: 'Reviewed input'),
          keyboardType: TextInputType.emailAddress,
          maxLines: 1,
          maxLength: 40,
          autofocus: true,
          obscureText: true,
          onChanged: (value) => changed = value,
          onSubmitted: (value) => submitted = value,
        ),
      ),
    ));
    await tester.pump();

    final finder = find.byKey(key);
    expect(finder, findsOneWidget);
    final field = tester.widget<TextField>(finder);
    expect(field.controller, same(controller));
    expect(field.focusNode, same(focusNode));
    expect(field.decoration?.labelText, 'Reviewed input');
    expect(field.keyboardType, TextInputType.emailAddress);
    expect(field.maxLines, 1);
    expect(field.maxLength, 40);
    expect(field.autofocus, isTrue);
    expect(field.obscureText, isTrue);
    expect(focusNode.hasFocus, isTrue);

    await tester.enterText(finder, 'retained@example.invalid');
    expect(controller.text, 'retained@example.invalid');
    expect(changed, 'retained@example.invalid');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(submitted, 'retained@example.invalid');
  });

  testWidgets('active theme updates preserve the controller draft and disabled state',
      (tester) async {
    final controller = TextEditingController(text: 'retained draft');
    addTearDown(controller.dispose);
    Widget host(Color fill) => MaterialApp(
          theme: ThemeData(inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: fill,
          )),
          home: Scaffold(body: PrimeTextField(
            controller: controller,
            enabled: false,
          )),
        );
    await tester.pumpWidget(host(Colors.amber));
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
    await tester.pumpWidget(host(Colors.cyan));
    await tester.pumpAndSettle();
    expect(controller.text, 'retained draft');
    final input = tester.widget<InputDecorator>(find.byType(InputDecorator));
    expect(input.decoration.fillColor, Colors.cyan);
  });

  for (final reversed in [false, true]) {
    testWidgets('keyed uncontrolled drafts follow their field on reorder ($reversed)',
        (tester) async {
      const first = ValueKey('first-draft');
      const second = ValueKey('second-draft');
      Widget host(bool swap) => MaterialApp(home: Scaffold(body: Column(children:
        (swap ? [second, first] : [first, second]).map((key) => PrimeTextField(key: key)).toList(),
      )));
      await tester.pumpWidget(host(reversed));
      await tester.enterText(find.byKey(first), 'first retained draft');
      await tester.enterText(find.byKey(second), 'second retained draft');
      final firstState = tester.state<EditableTextState>(find.descendant(
        of: find.byKey(first), matching: find.byType(EditableText)));
      final secondState = tester.state<EditableTextState>(find.descendant(
        of: find.byKey(second), matching: find.byType(EditableText)));
      firstState.widget.controller.selection = const TextSelection.collapsed(offset: 5);
      await tester.pumpWidget(host(!reversed));
      await tester.pump();
      final currentFirst = tester.state<EditableTextState>(find.descendant(
        of: find.byKey(first), matching: find.byType(EditableText)));
      final currentSecond = tester.state<EditableTextState>(find.descendant(
        of: find.byKey(second), matching: find.byType(EditableText)));
      expect(currentFirst, same(firstState));
      expect(currentSecond, same(secondState));
      expect(currentFirst.widget.controller.text, 'first retained draft');
      expect(currentSecond.widget.controller.text, 'second retained draft');
      expect(currentFirst.widget.controller.selection.baseOffset, 5);
      expect(currentSecond.widget.focusNode.hasFocus, isTrue);
      expect(find.byKey(first), findsOneWidget);
      expect(find.byKey(second), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

}
