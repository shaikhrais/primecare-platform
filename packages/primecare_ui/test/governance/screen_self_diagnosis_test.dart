import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/governance/screen_self_diagnosis.dart';

void main() {
  group('Screen Self-Diagnosis System Tests', () {
    test('getScreenHealth returns correct status for a registered screen route', () {
      final routePath = '/offices/clinical/roles/rmt/dashboard';
      final health = getScreenHealth(routePath);

      expect(health.screenName, equals('RmtDashboardScreen'));
      expect(health.routePath, equals(routePath));
      expect(health.componentFile, contains('rmt_dashboard_screen.dart'));
      expect(health.progressPercent, equals(60));
      expect(health.isProductionReady, isFalse);
      expect(health.missingItems, isNotEmpty);
    });

    test('getScreenHealth returns fallback object for unregistered screen route', () {
      final unknownRoute = '/some/unknown/route/path';
      final health = getScreenHealth(unknownRoute);

      expect(health.screenName, equals(unknownRoute));
      expect(health.routePath, equals(unknownRoute));
      expect(health.componentFile, equals('Unknown'));
      expect(health.progressPercent, equals(0));
      expect(health.isProductionReady, isFalse);
      expect(health.missingItems, contains('File not found or registered'));
    });

    test('askScreen answers standard questions in human language', () {
      final routePath = '/offices/clinical/roles/rmt/dashboard';

      // 1. "Are you OK?"
      final okResponse = askScreen(routePath, 'Are you OK?');
      expect(okResponse, contains('Screen: RmtDashboardScreen'));
      expect(okResponse, contains('Status: Not OK'));
      expect(okResponse, contains('Progress: 60%'));
      expect(okResponse, contains('Problem:'));

      // 2. "What is missing?"
      final missingResponse = askScreen(routePath, 'What is missing?');
      expect(missingResponse, contains('I need the following elements completed:'));
      expect(missingResponse, contains('Local DB save/read transaction flows'));

      // 3. "Are you production ready?"
      final readyResponse = askScreen(routePath, 'Are you production ready?');
      expect(readyResponse, contains('No, I am not production ready.'));
      expect(readyResponse, contains('60%'));

      // 4. "Do you have API?"
      final apiResponse = askScreen(routePath, 'Do you have API?');
      expect(apiResponse, contains('Yes, my API communication layer is fully connected'));

      // 5. "Do you have DB connection?"
      final dbResponse = askScreen(routePath, 'Do you have DB connection?');
      expect(dbResponse, contains('No, my local database read/write transaction flows are missing'));

      // 6. "Do you still use mock data?"
      final mockResponse = askScreen(routePath, 'Do you still use mock data?');
      expect(mockResponse, contains('simulated data models'));
    });

    test('setDiagnosisEnabled updates the registry enabled status', () {
      final routePath = '/offices/clinical/roles/rmt/dashboard';
      
      // Toggle to false
      setDiagnosisEnabled(routePath, false);
      expect(getScreenHealth(routePath).diagnosisEnabled, isFalse);

      // Toggle to true
      setDiagnosisEnabled(routePath, true);
      expect(getScreenHealth(routePath).diagnosisEnabled, isTrue);
    });

    test('testSingleScreenReply and testAllScreenReplies runs without throwing', () {
      final routePath = '/offices/clinical/roles/rmt/dashboard';
      
      // Should not throw, should return updated ScreenHealthStatus (with fallback registry values if db is not initialized)
      final updated = testSingleScreenReply(routePath);
      expect(updated.routePath, equals(routePath));
      expect(updated.diagnosisReplyStatus, anyOf(['REPLIED_OK', 'NOT_TESTED', 'NO_REPLY', 'ERROR', 'PARTIAL_REPLY']));

      // Batch check should also run without throwing
      final allUpdated = testAllScreenReplies();
      expect(allUpdated, isNotEmpty);
    });
  });
}
