import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/main.dart';

void main() {
  testWidgets('Core PrimeCareApp Mount Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: PrimeCareApp()));

    // Verify app builds cleanly.
    expect(find.text('Sign In'), findsOneWidget);
  });
}
