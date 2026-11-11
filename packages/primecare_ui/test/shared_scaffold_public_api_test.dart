import 'package:flutter/material.dart' show MaterialApp, Scaffold, TextField;
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart' show PrimeScaffold, PrimeTextField;

void main() {
  testWidgets('public shared UI entry point renders the Material scaffold adapter', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PrimeScaffold(body: PrimeTextField())));
    expect(find.byType(PrimeScaffold), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
