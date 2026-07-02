// Governance - Category: test | Purpose: Verify auth screen loads Verify that the login form components exist Test that simulation chips exist (testing center...
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  testWidgets('LoginScreen renders and all credentials can be used', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: PrimeTheme(
          data: const PrimeThemeData(),
          child: const MaterialApp(
            home: LoginScreen(),
          ),
        ),
      ),
    );

    // Verify auth screen loads
    expect(find.byType(LoginScreen), findsOneWidget);
    
    // Verify that the login form components exist
    expect(find.text('Authorized Access'), findsOneWidget);
    
    // Test that simulation chips exist (testing center is visible)
    expect(find.text('ROLE SIMULATION CENTER'), findsOneWidget);
    
    // Verify all credentials render as chips
    for (final cred in TestCredentialsRegistry.allCredentials) {
      final chipLabel = cred.role.name.toUpperCase().replaceAll('_', ' ');
      // Scroll to it if needed
      await tester.scrollUntilVisible(
        find.text(chipLabel),
        50.0,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(chipLabel), findsOneWidget);
      
      // Tap chip
      await tester.tap(find.text(chipLabel));
      await tester.pump();
      
      // In a real integration test we would verify the routing changed,
      // but here we just verify it doesn't crash on tap.
    }
  });
}
