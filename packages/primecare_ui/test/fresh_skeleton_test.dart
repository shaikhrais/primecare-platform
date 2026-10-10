import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TestApp extends BasePrimecareApp {
  const TestApp({AuthTransport? transport})
    : super(
        appCode: 'test',
        title: 'Fresh PrimeCare',
        authTransport: transport,
      );
}

class FakeAuth implements AuthTransport {
  String? path;
  @override
  Future<Map<String, dynamic>> send(
    String method,
    String path, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    this.path = path;
    if (path == '/forgot-password')
      return {
        'message':
            'If an active account matches, instructions will be emailed.',
      };
    if (path == '/login')
      return {
        'userId': 'u',
        'role': 'client',
        'status': 'authenticated',
        'token': 'a' * 43,
      };
    return {'status': 'signed_out'};
  }
}

void main() {
  testWidgets('unconfigured shell exposes configuration message', (
    tester,
  ) async {
    await tester.pumpWidget(const TestApp());
    expect(find.byType(AuthScreen), findsOneWidget);
    expect(
      find.text('Configure AUTH_API_URL as an HTTPS auth service URL.'),
      findsOneWidget,
    );
  });
  testWidgets('inherited auth screen logs in and revokes session', (
    tester,
  ) async {
    final api = FakeAuth();
    await tester.pumpWidget(
      MaterialApp(
        home: AuthScreen(title: 'Auth', transport: api),
      ),
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'user@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'password',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();
    expect(api.path, '/login');
    expect(find.text('Signed in'), findsOneWidget);
    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
    expect(api.path, '/logout');
    expect(find.text('Signed in'), findsNothing);
  });
  testWidgets('recovery switches to code reset and returns to sign in', (
    tester,
  ) async {
    final api = FakeAuth();
    await tester.pumpWidget(
      MaterialApp(
        home: AuthScreen(title: 'Auth', transport: api),
      ),
    );
    await tester.tap(find.text('Forgot password?'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'user@example.com',
    );
    await tester.tap(
      find.widgetWithText(FilledButton, 'Send recovery instructions'),
    );
    await tester.pumpAndSettle();
    expect(api.path, '/forgot-password');
    expect(find.text('Reset password'), findsWidgets);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Reset code'),
      'ABCDEF123456',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'New password'),
      'new-password-12',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Reset password'));
    await tester.pumpAndSettle();
    expect(api.path, '/reset-password');
    expect(find.text('Password reset. Sign in again.'), findsOneWidget);
  });
}
