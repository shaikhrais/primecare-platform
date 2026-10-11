import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'support/governance_test_app.dart';

void main() {
  setUpAll(initializeGovernanceTestApp);
  testWidgets('ForgotPasswordView requests a recovery email', (tester) async {
    await tester.pumpWidget(ProviderScope(child: governanceTestApp(const ForgotPasswordView())));
    await tester.pumpAndSettle();
    expect(find.text('Forgot your password?'), findsOneWidget);
    expect(find.text('Email reset code'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    await tester.tap(find.text('Email reset code'));
    await tester.pump();
    expect(find.text('Enter a valid email address.'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
  testWidgets('MfaView truthfully reports the unavailable capability', (tester) async {
    await tester.pumpWidget(ProviderScope(child: governanceTestApp(const MfaView())));
    await tester.pumpAndSettle();
    expect(find.text('Verify it’s you'), findsOneWidget);
    expect(find.textContaining('This feature is not enabled.'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.text('VERIFY CODE'), findsNothing);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
  testWidgets('ResetPasswordView requires email, code and matching passwords', (tester) async {
    await tester.pumpWidget(ProviderScope(child: governanceTestApp(const ResetPasswordView())));
    await tester.pumpAndSettle();
    expect(find.text('Choose a new password'), findsOneWidget);
    expect(find.text('Reset password'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(4));
    final fields = find.byType(TextField);
    expect(tester.widget<TextField>(fields.at(2)).obscureText, isTrue);
    expect(tester.widget<TextField>(fields.at(3)).obscureText, isTrue);
    await tester.enterText(fields.at(0), 'admin@example.com');
    await tester.ensureVisible(find.text('Reset password'));
    await tester.tap(find.text('Reset password'));
    await tester.pump();
    expect(find.text('Enter the 12-character code from your email.'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
  testWidgets('Diagnostics panel fits a narrow screen when closed and open', (tester) async {
    tester.view.physicalSize = const Size(320, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(ProviderScope(child: governanceTestApp(const MfaView())));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Screen Health'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

}
