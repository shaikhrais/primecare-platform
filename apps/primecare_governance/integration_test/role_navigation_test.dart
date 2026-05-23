// Governance - Category: test | Purpose: The roles from the simulation chips we saw in the widget tree Scroll to the chip if needed Ignore if already visible ...
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:primecare_governance/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Role navigation sweep', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    
    // The roles from the simulation chips we saw in the widget tree
    final roles = [
      'CEO', 'ADMIN', 'FINANCEDIRECTOR', 'CLINICALDIRECTOR'
    ];

    for (final role in roles) {
      final chip = find.text(role);
      
      // Scroll to the chip if needed
      try {
        await tester.ensureVisible(chip);
      } catch (e) {
        // Ignore if already visible or not found
      }
      
      if (tester.any(chip)) {
        await tester.tap(chip);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        
        // Wait on the role's screen for a bit so the user can see it
        await Future.delayed(const Duration(seconds: 2));
        
        // Return to the login screen or dashboard root
        final backButton = find.byType(BackButton);
        if (tester.any(backButton)) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        } else {
          final backIcon = find.byIcon(Icons.arrow_back);
          if (tester.any(backIcon)) {
             await tester.tap(backIcon);
             await tester.pumpAndSettle();
          } else {
             final logout = find.text('Logout');
             if (tester.any(logout)) {
               await tester.tap(logout);
               await tester.pumpAndSettle();
             } else {
               // Try generic pop if needed
               final NavigatorState navigator = tester.state(find.byType(Navigator));
               if (navigator.canPop()) {
                 navigator.pop();
                 await tester.pumpAndSettle();
               }
             }
          }
        }
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    
    // Leave the app open at the end
    await Future.delayed(const Duration(seconds: 5));
  });
}
