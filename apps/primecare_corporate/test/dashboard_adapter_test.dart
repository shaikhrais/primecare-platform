import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/src/screens/offices/corporate/ceo_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/corporate/cto_dashboard.dart';
import 'package:primecare_ui/src/screens/offices/corporate/cfo_dashboard.dart';

import '../integration_test/page_objects/master_dashboard_page.dart';

void main() {
  setUpAll(() {
    // Force adapters to run in mock mode to retrieve resilient fake data
    DataSourceConfig.currentMode = DataSourceType.mock;
  });

  group('E2E Dashboard Adapter Hydration Validation', () {
    testWidgets('Verify CEO Dashboard hydration via DataProviders & POM', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const CeoDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('corporate.ceo.dashboard.title');
      await dashboard.verifySubtitle('corporate.ceo.dashboard.subtitle');
    });

    testWidgets('Verify CTO Dashboard hydration via DataProviders & POM', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const CtoDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('corporate.cto.dashboard.title');
      await dashboard.verifySubtitle('corporate.cto.dashboard.subtitle');
    });

    testWidgets('Verify CFO Dashboard hydration via DataProviders & POM', (tester) async {
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const CfoDashboard()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('corporate.cfo.dashboard.title');
      await dashboard.verifySubtitle('corporate.cfo.dashboard.subtitle');
    });
  });
}
