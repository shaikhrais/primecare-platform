import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/src/screens/common/global_profile.dart';
import 'package:primecare_ui/src/screens/common/global_settings.dart';
import 'package:primecare_ui/src/screens/common/document_vault.dart';
import 'package:primecare_ui/src/screens/common/messaging_hub.dart';
import 'package:primecare_ui/src/screens/common/notification_center.dart';
// Important Core Imports for Mocking
import 'package:flutter_core/dashboard_providers.dart';
import 'package:flutter_core/dashboard_service.dart';
import 'package:flutter_core/dynamic_page_providers.dart';

import '../integration_test/page_objects/master_dashboard_page.dart';

void main() {
  Widget wrapWithMocks(Widget child) {
    return ProviderScope(
      overrides: [
        dashboardMetricsProvider.overrideWith(
          (ref, route) async => DashboardMetrics(kpis: [], recentActivity: []),
        ),
        dynamicPageProvider.overrideWith(
          (ref, endpointKey) async => <dynamic>[],
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
      await dashboard.verifyTitle('System Preferences');
      await dashboard.verifySubtitle('Overview and analytical breakdown for System Preferences.');
    });

    testWidgets('Verify Global Profile hydrations via POM', (tester) async {
      await tester.pumpWidget(wrapWithMocks(const GlobalProfileScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('User Institutional Profile');
      await dashboard.verifySubtitle('Overview and analytical breakdown for User Institutional Profile.');
    });

    testWidgets('Verify Document Vault hydrations via POM', (tester) async {
      await tester.pumpWidget(wrapWithMocks(const DocumentVaultScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('Secure Institutional Vault');
    });

    testWidgets('Verify Messaging Hub hydrations via POM', (tester) async {
      await tester.pumpWidget(wrapWithMocks(const MessagingHubScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('Secure Messaging Hub');
    });

    testWidgets('Verify Notification Center hydrations via POM', (tester) async {
      await tester.pumpWidget(wrapWithMocks(const NotificationCenterScreen()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      await dashboard.verifyTitle('Platform Notification Center');
    });
  });
}
