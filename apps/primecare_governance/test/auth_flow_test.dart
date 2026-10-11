import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'support/governance_test_app.dart';

void main() {
  setUpAll(initializeGovernanceTestApp);
  testWidgets('LoginScreen exposes the real shared credential form', (tester) async {
    await tester.pumpWidget(ProviderScope(child: governanceTestApp(const LoginScreen())));
    await tester.pumpAndSettle();
    expect(find.byType(LoginView), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('ROLE SIMULATION CENTER'), findsNothing);
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'admin@example.com');
    await tester.enterText(fields.at(1), 'example-password');
    await tester.pump();
    expect(tester.widget<TextField>(fields.at(0)).controller!.text, 'admin@example.com');
    expect(tester.widget<TextField>(fields.at(1)).controller!.text, 'example-password');
    expect(tester.widget<TextField>(fields.at(1)).obscureText, isTrue);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
