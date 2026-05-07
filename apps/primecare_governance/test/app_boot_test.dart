import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_governance/main.dart';

void main() {
  testWidgets('PrimeCareApp boots and renders without structural exceptions', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: PrimeCareApp()));

    // Wait for any animations and initial navigation to finish
    await tester.pumpAndSettle();

    // The app should not throw any exceptions while rendering
    expect(tester.takeException(), isNull);
  });
}
