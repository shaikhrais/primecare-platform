import 'package:flutter_test/flutter_test.dart';
import 'lib/src/governance/screen_self_diagnosis.dart';

void main() {
  test('verify_diagnosis runs all check suites', () {
    print("--- START DIAGNOSIS RUN ---");
    
    final rmtRoute = '/offices/clinical/roles/rmt/dashboard';
    print("Testing RMT Dashboard screen lookup...");
    final rmtHealth = getScreenHealth(rmtRoute);
    print("Screen Name: ${rmtHealth.screenName}");
    print("Route Path: ${rmtHealth.routePath}");
    print("File Path: ${rmtHealth.componentFile}");
    print("Interactive Objects: ${rmtHealth.totalInteractiveObjects}");
    print("Purpose Status: ${rmtHealth.screenPurposeStatus}");
    
    expect(rmtHealth.screenName, equals('RmtDashboardScreen'));
    
    final unknownRoute = '/some/unknown/route';
    print("\nTesting Unknown screen lookup...");
    final unknownHealth = getScreenHealth(unknownRoute);
    print("Screen Name: ${unknownHealth.screenName}");
    print("File Path: ${unknownHealth.componentFile}");
    expect(unknownHealth.componentFile, equals('Unknown'));
    
    print("\nTesting askScreen interface...");
    final okResp = askScreen(rmtRoute, 'Are you OK?');
    print("OK Response:\n$okResp");
    
    final missingResp = askScreen(rmtRoute, 'What is missing?');
    print("Missing Response:\n$missingResp");
    
    print("\nTesting DB loadAllScreensFromDb...");
    final allScreens = loadAllScreensFromDb();
    print("Loaded ${allScreens.length} screens dynamically from SQLite.");
    
    // Check one of our upgraded screens, e.g. CeoEnterpriseOverviewScreen (ID 706, route: /offices/corporate/roles/ceo/enterprise-overview)
    final ceoRoute = '/offices/corporate/roles/ceo/enterprise-overview';
    print("\nTesting Upgraded CEO Enterprise Overview screen...");
    final ceoHealth = getScreenHealth(ceoRoute);
    print("Screen Name: ${ceoHealth.screenName}");
    print("Interactive Objects: ${ceoHealth.totalInteractiveObjects}");
    print("Production Ready: ${ceoHealth.productionReady}");
    print("False Progress: ${ceoHealth.falseProgress}");
    print("Screen Purpose: ${ceoHealth.screenPurpose}");
    
    expect(ceoHealth.totalInteractiveObjects >= 3, isTrue);
    expect(ceoHealth.falseProgress, isFalse);
    
    print("\n--- ALL DIAGNOSIS CHECKS PASSED ---");
  });
}
