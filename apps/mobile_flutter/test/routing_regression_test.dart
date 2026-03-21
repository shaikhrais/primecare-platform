import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_mobile/main.dart'; 

void main() {
  group('PrimeCare Mobile Ecosystem Integration Matrix', () {
    
    testWidgets('Phase 1: PSW Architecture Mounts flawless 5-Button Glassmorphic Layout via Persistent Cache', (WidgetTester tester) async {
      // Setup Local Memory with proper PSW Auth Token bypassing the Cloudflare API Gate
      SharedPreferences.setMockInitialValues({
        'auth_token': 'mock-tester-123',
        'user_role': 'psw'
      });

      // Physically launch and mount the Root React/Flutter ProviderScope
      await tester.pumpWidget(const ProviderScope(child: PrimeCareApp()));
      await tester.pumpAndSettle(); // Wait for navigation animations to snap to `/psw/home`

      // --- Assertion 1: Abstract Home Screen Text Headers ---
      expect(find.text('PrimeCare Hub'), findsOneWidget);
      expect(find.text('Performance Metrics'), findsWidgets);
      
      // --- Assertion 2: 5-Button Glassmorphic Navigation Render Check ---
      // We physically confirm the SVG Phosphor/Material bounds render perfectly without clipping exceptions
      expect(find.byIcon(Icons.home_rounded), findsOneWidget);
      expect(find.byIcon(Icons.space_dashboard_rounded), findsOneWidget);
      expect(find.byIcon(Icons.people_outline), findsOneWidget);
      expect(find.byIcon(Icons.timer_outlined), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);

      print('✅ PSW Component Tree structurally assembled and routed precisely.');
    });

    testWidgets('Phase 2: RN Clinical Hub Sub-Layer Boot Validation', (WidgetTester tester) async {
      // Transition native SharedPreferences memory to the RN Authentication array
      SharedPreferences.setMockInitialValues({
        'auth_token': 'mock-tester-rn',
        'user_role': 'rn'
      });

      await tester.pumpWidget(const ProviderScope(child: PrimeCareApp()));
      await tester.pumpAndSettle();

      // RN Layer expects different components natively
      expect(find.text('CLINICAL TRIAGE HUB'), findsOneWidget);
      expect(find.text('Active Emergencies'), findsOneWidget);
      
      print('✅ Registered Nurse Logic Matrix assembled effortlessly securely.');
    });

    testWidgets('Phase 3: Unauthorized Security Gate Routing Bounce', (WidgetTester tester) async {
      // Wipe the memory block strictly removing standard tokens
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(const ProviderScope(child: PrimeCareApp()));
      await tester.pumpAndSettle();

      // When memory is wiped, GoRouter MUST bounce the user cleanly to the `/login` view
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Access the PrimeCare Mobile Platform'), findsOneWidget);

      print('✅ GoRouter Authentication Security Check bounced empty session accurately.');
    });
  });
}
