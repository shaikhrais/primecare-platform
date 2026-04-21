import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/screens/common/05_U_global_profile.dart';
import 'package:primecare_ui/src/screens/common/05_U_global_settings.dart';
import 'package:primecare_ui/src/screens/common/05_U_document_vault.dart';
import 'package:primecare_ui/src/screens/common/05_U_messaging_hub.dart';
import 'package:primecare_ui/src/screens/common/05_U_notification_center.dart';
// Important Core Imports for Mocking
import 'package:primecare_core/primecare_core.dart';

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
      await dashboard.verifyTitle('common.settings.title');
      await dashboard.verifySubtitle('common.settings.subtitle');
    });

    testWidgets('Verify Global Profile hydrations via POM', (tester) async {
      await tester.pumpWidget(wrapWithMocks(const GlobalProfileScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('common.profile.title');
      await dashboard.verifySubtitle('common.profile.subtitle');
    });

    testWidgets('Verify Document Vault hydrations via POM', (tester) async {
      await tester.pumpWidget(wrapWithMocks(const DocumentVaultScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('common.documentvault.title');
    });

    testWidgets('Verify Messaging Hub hydrations via POM', (tester) async {
      await tester.pumpWidget(wrapWithMocks(const MessagingHubScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('common.messaging.title');
    });

    testWidgets('Verify Notification Center hydrations via POM', (
      tester,
    ) async {
      await tester.pumpWidget(wrapWithMocks(const NotificationCenterScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('common.notifications.title');
    });
  });
}
