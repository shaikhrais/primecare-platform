// Governance - Category: test | Purpose: Core implementation file for the App Test platform logic.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';

// Import all screens
import '../lib/features/generated_screens/client_book_appointment_screen.dart';
import '../lib/features/generated_screens/client_care_team_screen.dart';
import '../lib/features/generated_screens/client_dashboard_screen.dart';
import '../lib/features/generated_screens/client_my_appointments_screen.dart';
import '../lib/features/generated_screens/client_payments_screen.dart';
import '../lib/features/generated_screens/client_profile_screen.dart';
import '../lib/features/generated_screens/client_treatment_history_screen.dart';
import '../lib/features/generated_screens/family_member_billing_screen.dart';
import '../lib/features/generated_screens/family_member_care_updates_screen.dart';
import '../lib/features/generated_screens/family_member_dashboard_screen.dart';
import '../lib/features/generated_screens/family_member_dashboard_screen_controller.dart';
import '../lib/features/generated_screens/family_member_emergency_contacts_screen.dart';
import '../lib/features/generated_screens/family_member_loved_one_schedule_screen.dart';
import '../lib/features/generated_screens/family_member_profile_screen.dart';
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
            clientBookAppointmentProvider.overrideWith((ref) => MockClientBookAppointmentScreenController(ref)),
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
            clientCareTeamProvider.overrideWith((ref) => MockClientCareTeamScreenController(ref)),
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
            clientDashboardProvider.overrideWith((ref) => MockClientDashboardScreenController(ref)),
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
            clientMyAppointmentsProvider.overrideWith((ref) => MockClientMyAppointmentsScreenController(ref)),
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
            clientPaymentsProvider.overrideWith((ref) => MockClientPaymentsScreenController(ref)),
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
            clientProfileProvider.overrideWith((ref) => MockClientProfileScreenController(ref)),
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
            clientTreatmentHistoryProvider.overrideWith((ref) => MockClientTreatmentHistoryScreenController(ref)),
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
            familyMemberBillingProvider.overrideWith((ref) => MockFamilyMemberBillingScreenController(ref)),
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
            familyMemberCareUpdatesProvider.overrideWith((ref) => MockFamilyMemberCareUpdatesScreenController(ref)),
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
            familyMemberEmergencyContactsProvider.overrideWith((ref) => MockFamilyMemberEmergencyContactsScreenController(ref)),
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
            familyMemberLovedOneScheduleProvider.overrideWith((ref) => MockFamilyMemberLovedOneScheduleScreenController(ref)),
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
            familyMemberProfileProvider.overrideWith((ref) => MockFamilyMemberProfileScreenController(ref)),
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
  MockClientBookAppointmentScreenController(super.ref);

  @override
  Future<void> refreshData() async {
    state = state.copyWith(isLoading: false, hasData: true, error: null);
  }
}

class MockClientCareTeamScreenController extends ClientCareTeamScreenController {
  MockClientCareTeamScreenController(super.ref);

  @override
  Future<void> refreshData() async {
    state = state.copyWith(isLoading: false, hasData: true, error: null);
  }
}

class MockClientDashboardScreenController extends ClientDashboardScreenController {
  MockClientDashboardScreenController(super.ref);

  @override
  Future<void> refreshData() async {
    state = state.copyWith(isLoading: false, hasData: true, error: null);
  }
}

class MockClientMyAppointmentsScreenController extends ClientMyAppointmentsScreenController {
  MockClientMyAppointmentsScreenController(super.ref);

  @override
  Future<void> refreshData() async {
    state = state.copyWith(isLoading: false, hasData: true, error: null);
  }
}

class MockClientPaymentsScreenController extends ClientPaymentsScreenController {
  MockClientPaymentsScreenController(super.ref);

  @override
  Future<void> refreshData() async {
    state = state.copyWith(isLoading: false, hasData: true, error: null);
  }
}

class MockClientProfileScreenController extends ClientProfileScreenController {
  MockClientProfileScreenController(super.ref);

  @override
  Future<void> refreshData() async {
    state = state.copyWith(isLoading: false, hasData: true, error: null);
  }
}

class MockClientTreatmentHistoryScreenController extends ClientTreatmentHistoryScreenController {
  MockClientTreatmentHistoryScreenController(super.ref);

  @override
  Future<void> refreshData() async {
    state = state.copyWith(isLoading: false, hasData: true, error: null);
  }
}

class MockFamilyMemberBillingScreenController extends FamilyMemberBillingScreenController {
  MockFamilyMemberBillingScreenController(super.ref);

  @override
  Future<void> refreshData() async {
    state = state.copyWith(isLoading: false, hasData: true, error: null);
  }
}

class MockFamilyMemberCareUpdatesScreenController extends FamilyMemberCareUpdatesScreenController {
  MockFamilyMemberCareUpdatesScreenController(super.ref);

  @override
  Future<void> refreshData() async {
    state = state.copyWith(isLoading: false, hasData: true, error: null);
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
  MockFamilyMemberEmergencyContactsScreenController(super.ref);

  @override
  Future<void> refreshData() async {
    state = state.copyWith(isLoading: false, hasData: true, error: null);
  }
}

class MockFamilyMemberLovedOneScheduleScreenController extends FamilyMemberLovedOneScheduleScreenController {
  MockFamilyMemberLovedOneScheduleScreenController(super.ref);

  @override
  Future<void> refreshData() async {
    state = state.copyWith(isLoading: false, hasData: true, error: null);
  }
}

class MockFamilyMemberProfileScreenController extends FamilyMemberProfileScreenController {
  MockFamilyMemberProfileScreenController(super.ref);

  @override
  Future<void> refreshData() async {
    state = state.copyWith(isLoading: false, hasData: true, error: null);
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
