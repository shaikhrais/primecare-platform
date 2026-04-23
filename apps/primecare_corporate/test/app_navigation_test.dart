
import 'package:flutter_test/flutter_test.dart';
// Important Core Imports for Mocking

import 'package:primecare_ui/primecare_ui.dart';

import '../integration_test/page_objects/master_dashboard_page.dart';

void main() {
  Widget wrapWithMocks(Widget child) {
    return ProviderScope(
      overrides: [
        dashboardMetricsProvider.overrideWith(
          (ref, route) async =>
              Success(DashboardMetrics(kpis: [], recentActivity: [])),
        ),
        dynamicPageProvider.overrideWith(
          (ref, endpointKey) async => Success(<dynamic>[]),
        ),
      ],
      child: MaterialApp(home: Scaffold(body: child)),
    );
  }

  group('E2E Global Utility Validation', () {
    testWidgets('Verify Global Settings hydrations via POM', (tester) async {
      await tester.pumpWidget(wrapWithMocks(const GlobalSettingsScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('common.globalSettings.title');
      await dashboard.verifySubtitle('common.globalSettings.subtitle');
    });

    testWidgets('Verify Global Profile hydrations via POM', (tester) async {
      await tester.pumpWidget(wrapWithMocks(const GlobalProfileScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('common.globalProfile.title');
      await dashboard.verifySubtitle('common.globalProfile.subtitle');
    });

    testWidgets('Verify Document Vault hydrations via POM', (tester) async {
      await tester.pumpWidget(wrapWithMocks(const DocumentVaultScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('common.documentVault.title');
    });

    testWidgets('Verify Messaging Hub hydrations via POM', (tester) async {
      await tester.pumpWidget(wrapWithMocks(const MessagingHubScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('common.messagingHub.title');
    });

    testWidgets('Verify Notification Center hydrations via POM', (
      tester,
    ) async {
      await tester.pumpWidget(wrapWithMocks(const NotificationCenterScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('common.notificationCenter.title');
    });
  });
}
