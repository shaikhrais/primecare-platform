import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  group('Auth Screens Verification', () {
    testWidgets('ForgotPasswordView renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: PrimeTheme(
            data: PrimeThemeData(),
            child: MaterialApp(
              home: ForgotPasswordView(),
            ),
          ),
        ),
      );

      // Verify screen elements
      expect(find.byType(ForgotPasswordView), findsOneWidget);
      expect(find.text('Reset Password'), findsOneWidget);
      expect(find.text('SEND RECOVERY LINK'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget); // Email input
    });

    testWidgets('MfaView renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: PrimeTheme(
            data: PrimeThemeData(),
            child: MaterialApp(
              home: MfaView(),
            ),
          ),
        ),
      );

      // Verify screen elements
      expect(find.byType(MfaView), findsOneWidget);
      expect(find.text('Two-Factor Authentication'), findsOneWidget);
      expect(find.text('VERIFY CODE'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget); // Code input
    });

    testWidgets('ResetPasswordView renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: PrimeTheme(
            data: PrimeThemeData(),
            child: MaterialApp(
              home: ResetPasswordView(),
            ),
          ),
        ),
      );

      // Verify screen elements
      expect(find.byType(ResetPasswordView), findsOneWidget);
      expect(find.text('Set New Password'), findsOneWidget);
      expect(find.text('UPDATE PASSWORD'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2)); // Password and Confirm Password inputs
    });
  });
}
