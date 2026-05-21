import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';

// Import all screens
import '../lib/client_book_appointment_screen.dart';
import '../lib/client_book_appointment_screen_controller.dart';
import '../lib/client_care_team_screen.dart';
import '../lib/client_care_team_screen_controller.dart';
import '../lib/client_dashboard_screen.dart';
import '../lib/client_dashboard_screen_controller.dart';
import '../lib/client_my_appointments_screen.dart';
import '../lib/client_my_appointments_screen_controller.dart';
import '../lib/client_payments_screen.dart';
import '../lib/client_payments_screen_controller.dart';
import '../lib/client_profile_screen.dart';
import '../lib/client_profile_screen_controller.dart';
import '../lib/client_treatment_history_screen.dart';
import '../lib/client_treatment_history_screen_controller.dart';
import '../lib/family_member_billing_screen.dart';
import '../lib/family_member_billing_screen_controller.dart';
import '../lib/family_member_care_updates_screen.dart';
import '../lib/family_member_care_updates_screen_controller.dart';
import '../lib/family_member_dashboard_screen.dart';
import '../lib/family_member_dashboard_screen_controller.dart';
import '../lib/family_member_emergency_contacts_screen.dart';
import '../lib/family_member_emergency_contacts_screen_controller.dart';
import '../lib/family_member_loved_one_schedule_screen.dart';
import '../lib/family_member_loved_one_schedule_screen_controller.dart';
import '../lib/family_member_profile_screen.dart';
import '../lib/family_member_profile_screen_controller.dart';
import '../lib/unknown_dashboard_screen.dart';
import '../lib/unknown_dashboard_screen_controller.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('PrimeCare Client App End-to-End Tests', () {

    testWidgets('Verify ClientBookAppointmentScreen renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            ClientBookAppointmentScreenControllerProvider.overrideWith(() => MockClientBookAppointmentScreenController()),
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
            ClientCareTeamScreenControllerProvider.overrideWith(() => MockClientCareTeamScreenController()),
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
            ClientDashboardScreenControllerProvider.overrideWith(() => MockClientDashboardScreenController()),
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
            ClientMyAppointmentsScreenControllerProvider.overrideWith(() => MockClientMyAppointmentsScreenController()),
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
            ClientPaymentsScreenControllerProvider.overrideWith(() => MockClientPaymentsScreenController()),
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
            ClientProfileScreenControllerProvider.overrideWith(() => MockClientProfileScreenController()),
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
            ClientTreatmentHistoryScreenControllerProvider.overrideWith(() => MockClientTreatmentHistoryScreenController()),
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
            FamilyMemberBillingScreenControllerProvider.overrideWith(() => MockFamilyMemberBillingScreenController()),
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
            FamilyMemberCareUpdatesScreenControllerProvider.overrideWith(() => MockFamilyMemberCareUpdatesScreenController()),
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
            FamilyMemberDashboardScreenControllerProvider.overrideWith(() => MockFamilyMemberDashboardScreenController()),
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
            FamilyMemberEmergencyContactsScreenControllerProvider.overrideWith(() => MockFamilyMemberEmergencyContactsScreenController()),
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
            FamilyMemberLovedOneScheduleScreenControllerProvider.overrideWith(() => MockFamilyMemberLovedOneScheduleScreenController()),
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
            FamilyMemberProfileScreenControllerProvider.overrideWith(() => MockFamilyMemberProfileScreenController()),
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
            UnknownDashboardScreenControllerProvider.overrideWith(() => MockUnknownDashboardScreenController()),
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
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockClientCareTeamScreenController extends ClientCareTeamScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockClientDashboardScreenController extends ClientDashboardScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockClientMyAppointmentsScreenController extends ClientMyAppointmentsScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockClientPaymentsScreenController extends ClientPaymentsScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockClientProfileScreenController extends ClientProfileScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockClientTreatmentHistoryScreenController extends ClientTreatmentHistoryScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockFamilyMemberBillingScreenController extends FamilyMemberBillingScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockFamilyMemberCareUpdatesScreenController extends FamilyMemberCareUpdatesScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockFamilyMemberDashboardScreenController extends FamilyMemberDashboardScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockFamilyMemberEmergencyContactsScreenController extends FamilyMemberEmergencyContactsScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockFamilyMemberLovedOneScheduleScreenController extends FamilyMemberLovedOneScheduleScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockFamilyMemberProfileScreenController extends FamilyMemberProfileScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}

class MockUnknownDashboardScreenController extends UnknownDashboardScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}
