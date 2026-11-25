import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_localization/primecare_localization.dart';

void main() {
  testWidgets('rejects rendering without initialized localization', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LocalizationScaffold(
      child: Text('Unlocalized child'))));
    expect(tester.takeException(), isA<AssertionError>());
    expect(find.text('Unlocalized child'), findsNothing);
  });
}
