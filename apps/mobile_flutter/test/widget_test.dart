import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:primecare_mobile/main.dart'; // Adjust if package name differs
import 'package:primecare_mobile/features/auth/login_screen.dart';

void main() {
  group('PrimeCare Core Routing Matrix & UI Tests', () {
    
    testWidgets('App Boots and displays the Login Authentication Gate', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      // Note: We bypass ProviderScope here if we just want a shallow rendering test,
      // but since main.dart expects Riverpod, we would normally wrap it.
      // For this structural test, we just verify the widget logic exists.
      
      await tester.pumpWidget(const MaterialApp(
        home: LoginScreen(),
      ));

      // Assert that the Email and Password fields are natively generated
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      
      // Assert the High-Fidelity Login Button
      expect(find.byType(ElevatedButton), findsWidgets);
      expect(find.text('Sign In to PrimeCare'), findsOneWidget);
    });

    testWidgets('Validates Empty Field Constraints on Auth Form', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoginScreen(),
      ));

      // Tap the login button without adding text
      await tester.tap(find.text('Sign In to PrimeCare'));
      await tester.pump();

      // Ensure that form validation kicks in structurally
      expect(find.text('Please enter your email'), findsOneWidget);
    });
  });
}
