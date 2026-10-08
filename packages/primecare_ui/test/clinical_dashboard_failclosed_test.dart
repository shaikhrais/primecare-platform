import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/src/screens/clinical/clinical_director_dashboard_screen.dart';
import 'auth_design_test.dart' show localized;

Map<String, dynamic> validData() => {
  'residentsToday': 3,
  'staffOnShift': 3,
  'openShifts': 3,
  'fallsToday': 3,
  'incidentsToday': 3,
  'hospitalTransfers': 3,
  'activeOutbreaks': 3,
  'pressureUlcersCount': 3,
  'wanderingAlertsCount': 3,
  'missedRepositioningsCount': 3,
  'weightLossRiskCount': 3,
  'dehydrationAlertCount': 3,
  'sickCalls': 3,
  'agencyStaffUsage': 3,
  'expiringCertifications': 3,
  'missingADLChartingCount': 3,
  'lateIncidentReportsCount': 3,
  'overdueCarePlansCount': 3,
  'privacyBreachCount': 3,
  'activeAbuseInvestigationsCount': 3,
  'activeInfectionsCount': 3,
  'isolationCount': 3,
  'activeComplaintsCount': 3,
  'pendingFamilyCallsCount': 3,
  'staffAttendance': 4.5,
  'fallRate': 4.5,
  'overtimeHours': 4.5,
  'trainingCompletionRate': 4.5,
  'handHygieneAuditScore': 4.5,
  'satisfactionRate': 4.5,
  'profitMargin': 4.5,
  'payrollRatio': 4.5,
  'outstandingPayments': 4.5,
  'pswToResidentRatio': 'Verified',
  'ppeInventoryLevel': 'Verified',
  'outbreakStatus': 'Verified',
  'moodTrends': 'Verified',
  'highRiskResidentsList': <Map<String, dynamic>>[],
  'staffWorkloadList': <Map<String, dynamic>>[],
  'revenueByService': <Map<String, dynamic>>[],
  'revenueByTherapist': <Map<String, dynamic>>[],
  'roomUtilization': <Map<String, dynamic>>[],
  'inventoryAlerts': <Map<String, dynamic>>[],
  'redFlags': <Map<String, dynamic>>[],
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  Future<void> settle() => Future<void>.delayed(Duration.zero);
  ProviderContainer container(Future<ApiResponse> Function() loader) {
    final c = ProviderContainer(
      overrides: [
        clinicalDirectorDashboardProvider.overrideWith(
          (ref) => ClinicalDirectorDashboardController.withLoader(loader),
        ),
      ],
    );
    addTearDown(c.dispose);
    c.read(clinicalDirectorDashboardProvider);
    return c;
  }

  for (final status in [401, 403, 404, 500]) {
    test('HTTP $status is unavailable, never fabricated metrics', () async {
      final c = container(
        () async => ApiResponse(data: validData(), statusCode: status),
      );
      await settle();
      final s = c.read(clinicalDirectorDashboardProvider);
      expect(s.hasValidatedMetrics, isFalse);
      expect(s.isLoading, isFalse);
      expect(s.error, 'Clinical dashboard data is unavailable.');
      expect(s.highRiskResidentsList, isEmpty);
      expect(s.logs, isEmpty);
    });
  }
  test('network exception is sanitized and unavailable', () async {
    final c = container(() async => throw Exception('patient secret'));
    await settle();
    expect(
      c.read(clinicalDirectorDashboardProvider).error,
      'Clinical dashboard data is unavailable.',
    );
  });
  for (final bad in [
    null,
    {},
    {'data': null},
    {'data': []},
    {...validData()}..remove('activeOutbreaks'),
    {...validData(), 'residentsToday': 1.5},
    {...validData(), 'staffAttendance': double.nan},
    {
      ...validData(),
      'staffWorkloadList': [
        {'name': 'Verified'},
      ],
    },
    {
      ...validData(),
      'highRiskResidentsList': [{}],
    },
  ]) {
    test(
      'malformed or partial response stays unavailable: ${bad.runtimeType}',
      () async {
        final c = container(
          () async => ApiResponse(data: bad, statusCode: 200),
        );
        await settle();
        expect(
          c.read(clinicalDirectorDashboardProvider).hasValidatedMetrics,
          isFalse,
        );
      },
    );
  }
  test(
    'valid DTO survives retry, clears error, and hides stale data on next failure',
    () async {
      var response = ApiResponse(data: null, statusCode: 403);
      final c = container(() async => response);
      await settle();
      response = ApiResponse(data: {'data': validData()}, statusCode: 200);
      await c
          .read(clinicalDirectorDashboardProvider.notifier)
          .loadDashboardMetrics();
      var s = c.read(clinicalDirectorDashboardProvider);
      expect(s.hasValidatedMetrics, isTrue);
      expect(s.error, isNull);
      expect(s.residentsToday, 3);
      expect(s.staffAttendance, 4.5);
      expect(s.outbreakStatus, 'Verified');
      response = ApiResponse(data: null, statusCode: 401);
      await c
          .read(clinicalDirectorDashboardProvider.notifier)
          .loadDashboardMetrics();
      expect(
        c.read(clinicalDirectorDashboardProvider).hasValidatedMetrics,
        isFalse,
      );
    },
  );
  test('older success cannot overwrite latest denial', () async {
    final pending = Completer<ApiResponse>();
    var first = true;
    final c = container(() {
      if (first) {
        first = false;
        return pending.future;
      }
      return Future.value(ApiResponse(data: null, statusCode: 403));
    });
    await c
        .read(clinicalDirectorDashboardProvider.notifier)
        .loadDashboardMetrics();
    pending.complete(ApiResponse(data: validData(), statusCode: 200));
    await settle();
    expect(
      c.read(clinicalDirectorDashboardProvider).hasValidatedMetrics,
      isFalse,
    );
  });
  testWidgets('unavailable screen hides metric cards and all-clear status', (
    tester,
  ) async {
    await EasyLocalization.ensureInitialized();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          clinicalDirectorDashboardProvider.overrideWith(
            (ref) => ClinicalDirectorDashboardController.withLoader(
              () async => ApiResponse(data: null, statusCode: 403),
            ),
          ),
        ],
        child: localized(
          Consumer(
            builder: (context, ref, _) =>
                const ClinicalDirectorDashboardScreen().buildScreen(
                  context,
                  ref,
                ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('clinical-dashboard-unavailable')),
      findsOneWidget,
    );
    expect(find.text('Residents Census'), findsNothing);
    expect(find.text('Clear'), findsNothing);
    expect(find.text('Retry'), findsOneWidget);
  });
  test(
    'unimplemented actions never mutate real metrics or claim completion',
    () async {
      final actions =
          <Future<void> Function(ClinicalDirectorDashboardController)>[
            (c) => c.runComplianceScan(),
            (c) async => c.syncPosture(),
            (c) async => c.updatePolicy(),
            (c) async => c.exportLogs(),
            (c) async => c.addLog('invented completion'),
            (c) async => c.triggerEmergencyAlert(type: 'Fall', wing: 'East'),
            (c) async => c.submitIncident(
              resident: 'Fixture',
              type: 'Fall',
              severity: 'Critical',
              details: 'Fixture',
            ),
            (c) async => c.submitStaffCallOff(
              name: 'Fixture',
              shift: 'Day',
              autoSuggest: true,
            ),
            (c) async => c.submitResidentLookup(query: 'Fixture'),
            (c) async => c.resolveMissingCharting(description: 'Fixture'),
          ];
      for (final action in actions) {
        final c = container(
          () async => ApiResponse(data: validData(), statusCode: 200),
        );
        await settle();
        expect(
          c.read(clinicalDirectorDashboardProvider).hasValidatedMetrics,
          isTrue,
        );
        await action(c.read(clinicalDirectorDashboardProvider.notifier));
        final s = c.read(clinicalDirectorDashboardProvider);
        expect(s.hasValidatedMetrics, isFalse);
        expect(s.error, 'Clinical dashboard actions are unavailable.');
        expect(s.logs, isEmpty);
        expect(s.redFlags, isEmpty);
        expect(s.incidentsToday, 3);
        expect(s.staffOnShift, 3);
        expect(s.missingADLChartingCount, 3);
      }
    },
  );
  testWidgets(
    'valid DTO does not render sample telemetry, incidents, or action success',
    (tester) async {
      tester.view.physicalSize = const Size(1800, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final c = container(
        () async => ApiResponse(data: validData(), statusCode: 200),
      );
      await settle();
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: c,
          child: localized(
            Consumer(
              builder: (context, ref, _) =>
                  const ClinicalDirectorDashboardScreen().buildScreen(
                    context,
                    ref,
                  ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.text('Resident safety telemetry is unavailable.'),
        findsOneWidget,
      );
      expect(find.text('Resident Safety Level Telemetry'), findsNothing);
      expect(find.text('100% Covered'), findsNothing);
      c.read(clinicalDirectorDashboardProvider.notifier).changeTab(5);
      await tester.pumpAndSettle();
      expect(
        find.text('Care incident records are unavailable.'),
        findsOneWidget,
      );
      expect(find.textContaining('John Smith'), findsNothing);
      c.read(clinicalDirectorDashboardProvider.notifier).syncPosture();
      await tester.pumpAndSettle();
      expect(
        find.text('Clinical dashboard actions are unavailable.'),
        findsOneWidget,
      );
      expect(find.textContaining('completed'), findsNothing);
      expect(find.textContaining('successfully'), findsNothing);
    },
  );
}
