import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_action_feedback/primecare_action_feedback.dart';
void main() { testWidgets('pending action is explicitly not integrated', (tester) async { await tester.pumpWidget(MaterialApp(home: Scaffold(body: Builder(builder: (context) => TextButton(onPressed: () => ActionManifest.handle(context,'Fixture','Save'), child: const Text('Trigger')))))); await tester.tap(find.text('Trigger')); await tester.pumpAndSettle(); expect(find.text('Action "Save" is currently pending API integration.'), findsOneWidget); }); }
