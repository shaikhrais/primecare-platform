// Governance - Category: test | Purpose: Start the app Wait for the app to finish its initial animations and rendering Verify that we haven't thrown any rende...
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:primecare_corporate/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App Smoke Test - Boot and Settle without Crashing', (WidgetTester tester) async {
    // Start the app
    app.main();
    
    // Wait for the app to finish its initial animations and rendering
    await tester.pumpAndSettle();

    // Verify that we haven't thrown any rendering or logic exceptions
    expect(tester.takeException(), isNull);

    // Optional: Add some generic UI interaction here if needed
    // Example: await tester.tap(find.byType(ElevatedButton).first);
    // await tester.pumpAndSettle();
    // expect(tester.takeException(), isNull);
  });
}
