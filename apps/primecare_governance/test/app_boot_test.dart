// Governance - Category: test | Purpose: Core implementation file for the App Boot Test platform logic.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_governance/governance/widgets/governance_dashboard.dart';
import 'package:primecare_governance/governance/services/history_provider.dart';
import 'package:primecare_governance/governance/services/governance_history_service.dart';
import 'package:primecare_governance/governance/models/governance_report.dart';
import 'package:primecare_governance/core/governance/governance_api_service.dart';
import 'package:mocktail/mocktail.dart';

class MockGovernanceHistoryService extends Mock implements GovernanceHistoryService {}
class FakeGovernanceReport extends Fake implements GovernanceReport {}
class MockGovernanceApiService extends Mock implements GovernanceApiService {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeGovernanceReport());
  });
  testWidgets('GovernanceDashboard boots and renders without structural exceptions', (
    WidgetTester tester,
  ) async {
    final mockHistoryService = MockGovernanceHistoryService();
    when(() => mockHistoryService.getHealthTrend()).thenAnswer((_) async => []);
    when(() => mockHistoryService.captureSnapshot(any())).thenAnswer((_) async {});

    final mockApiService = MockGovernanceApiService();
    when(() => mockApiService.telemetryStream).thenAnswer((_) => const Stream.empty());

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          governanceHistoryServiceProvider.overrideWithValue(mockHistoryService),
          governanceApiServiceProvider.overrideWithValue(mockApiService),
        ],
        child: const MaterialApp(
          home: GovernanceDashboard(),
        ),
      ),
    );

    // Wait for any animations and initial navigation to finish
    await tester.pumpAndSettle();

    // The app should not throw any exceptions while rendering
    expect(tester.takeException(), isNull);

    // Dispose the ProviderScope to cancel any active timers
    await tester.pumpWidget(Container());
    await tester.pump();
  });
}
