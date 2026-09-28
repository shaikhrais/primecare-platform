// Governance - Category: test | Purpose: Core implementation file for the App Test platform logic.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';

// Import all screens
import '../lib/features/generated_screens/client_book_appointment_screen.dart';
import '../lib/features/generated_screens/client_book_appointment_screen_controller.dart';
import '../lib/features/generated_screens/client_care_team_screen.dart';
import '../lib/features/generated_screens/client_care_team_screen_controller.dart';
import '../lib/features/generated_screens/client_dashboard_screen.dart';
import '../lib/features/generated_screens/client_dashboard_screen_controller.dart';
import '../lib/features/generated_screens/client_my_appointments_screen.dart';
import '../lib/features/generated_screens/client_my_appointments_screen_controller.dart';
import '../lib/features/generated_screens/client_payments_screen.dart';
import '../lib/features/generated_screens/client_payments_screen_controller.dart';
import '../lib/features/generated_screens/client_profile_screen.dart';
import '../lib/features/generated_screens/client_profile_screen_controller.dart';
import '../lib/features/generated_screens/client_treatment_history_screen.dart';
import '../lib/features/generated_screens/client_treatment_history_screen_controller.dart';
import '../lib/features/generated_screens/family_member_billing_screen.dart';
import '../lib/features/generated_screens/family_member_billing_screen_controller.dart';
import '../lib/features/generated_screens/family_member_care_updates_screen.dart';
import '../lib/features/generated_screens/family_member_care_updates_screen_controller.dart';
import '../lib/features/generated_screens/family_member_dashboard_screen.dart';
import '../lib/features/generated_screens/family_member_dashboard_screen_controller.dart';
import '../lib/features/generated_screens/family_member_emergency_contacts_screen.dart';
import '../lib/features/generated_screens/family_member_emergency_contacts_screen_controller.dart';
import '../lib/features/generated_screens/family_member_loved_one_schedule_screen.dart';
import '../lib/features/generated_screens/family_member_loved_one_schedule_screen_controller.dart';
import '../lib/features/generated_screens/family_member_profile_screen.dart';
import '../lib/features/generated_screens/family_member_profile_screen_controller.dart';
import '../lib/features/generated_screens/unknown_dashboard_screen.dart';
import '../lib/features/generated_screens/unknown_dashboard_screen_controller.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('PrimeCare Client App End-to-End Tests', () {

    testWidgets('Verify ClientBookAppointmentScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            clientBookAppointmentScreenControllerProvider.overrideWith(() => MockClientBookAppointmentScreenController()),
          ],
          child: const MaterialApp(
            home: ClientBookAppointmentScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify ClientCareTeamScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            clientCareTeamScreenControllerProvider.overrideWith(() => MockClientCareTeamScreenController()),
          ],
          child: const MaterialApp(
            home: ClientCareTeamScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify ClientDashboardScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            clientDashboardScreenControllerProvider.overrideWith(() => MockClientDashboardScreenController()),
          ],
          child: const MaterialApp(
            home: ClientDashboardScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify ClientMyAppointmentsScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            clientMyAppointmentsScreenControllerProvider.overrideWith(() => MockClientMyAppointmentsScreenController()),
          ],
          child: const MaterialApp(
            home: ClientMyAppointmentsScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify ClientPaymentsScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            clientPaymentsScreenControllerProvider.overrideWith(() => MockClientPaymentsScreenController()),
          ],
          child: const MaterialApp(
            home: ClientPaymentsScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify ClientProfileScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            clientProfileScreenControllerProvider.overrideWith(() => MockClientProfileScreenController()),
          ],
          child: const MaterialApp(
            home: ClientProfileScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify ClientTreatmentHistoryScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            clientTreatmentHistoryScreenControllerProvider.overrideWith(() => MockClientTreatmentHistoryScreenController()),
          ],
          child: const MaterialApp(
            home: ClientTreatmentHistoryScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify FamilyMemberBillingScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            familyMemberBillingScreenControllerProvider.overrideWith(() => MockFamilyMemberBillingScreenController()),
          ],
          child: const MaterialApp(
            home: FamilyMemberBillingScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify FamilyMemberCareUpdatesScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            familyMemberCareUpdatesScreenControllerProvider.overrideWith(() => MockFamilyMemberCareUpdatesScreenController()),
          ],
          child: const MaterialApp(
            home: FamilyMemberCareUpdatesScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify FamilyMemberDashboardScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            familyMemberDashboardScreenControllerProvider.overrideWith(() => MockFamilyMemberDashboardScreenController()),
          ],
          child: const MaterialApp(
            home: FamilyMemberDashboardScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify FamilyMemberEmergencyContactsScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            familyMemberEmergencyContactsScreenControllerProvider.overrideWith(() => MockFamilyMemberEmergencyContactsScreenController()),
          ],
          child: const MaterialApp(
            home: FamilyMemberEmergencyContactsScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify FamilyMemberLovedOneScheduleScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            familyMemberLovedOneScheduleScreenControllerProvider.overrideWith(() => MockFamilyMemberLovedOneScheduleScreenController()),
          ],
          child: const MaterialApp(
            home: FamilyMemberLovedOneScheduleScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify FamilyMemberProfileScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            familyMemberProfileScreenControllerProvider.overrideWith(() => MockFamilyMemberProfileScreenController()),
          ],
          child: const MaterialApp(
            home: FamilyMemberProfileScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Verify UnknownDashboardScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            unknownDashboardScreenControllerProvider.overrideWith(() => MockUnknownDashboardScreenController()),
          ],
          child: const MaterialApp(
            home: UnknownDashboardScreen(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });

  });
}

class MockClientBookAppointmentScreenController extends ClientBookAppointmentScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockClientCareTeamScreenController extends ClientCareTeamScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockClientDashboardScreenController extends ClientDashboardScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockClientMyAppointmentsScreenController extends ClientMyAppointmentsScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockClientPaymentsScreenController extends ClientPaymentsScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockClientProfileScreenController extends ClientProfileScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockClientTreatmentHistoryScreenController extends ClientTreatmentHistoryScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockFamilyMemberBillingScreenController extends FamilyMemberBillingScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockFamilyMemberCareUpdatesScreenController extends FamilyMemberCareUpdatesScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockFamilyMemberDashboardScreenController extends FamilyMemberDashboardScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockFamilyMemberEmergencyContactsScreenController extends FamilyMemberEmergencyContactsScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockFamilyMemberLovedOneScheduleScreenController extends FamilyMemberLovedOneScheduleScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockFamilyMemberProfileScreenController extends FamilyMemberProfileScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}

class MockUnknownDashboardScreenController extends UnknownDashboardScreenController {
  @override
  AsyncValue<Map<String, dynamic>> build() {
    return const AsyncValue.data(<String, dynamic>{
      'status': 'success',
      'items': <dynamic>[],
      'kpis': <dynamic>[],
    });
  }
}
